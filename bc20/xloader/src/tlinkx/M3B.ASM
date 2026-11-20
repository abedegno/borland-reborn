	.286p
	locals
	public	L04C92
	public	L04CE0
	public	L04D4B
	public	L04D91
	public	L04EEF
	public	L04F12
	public	L04F7B
	public	L04F9E
	public	L05165
	public	L05188
	public	L05347
	public	S6BA_START
	public	_DATA_START
DGROUP	group	_DATA,_BSS
	extrn	S434_START:byte

S6FF	segment para public 'CODE'
	assume	cs:S6FF
	db	'VDISK', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0	;@06FF0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 93h, 0, 0, 0, 0, 0, 0, 0, 93h, 0, 0, 0FFh
	db	0FFh, 0, 0, 0, 92h, 0, 0, 0FFh, 0FFh, 0, 0, 0, 92h, 0, 0, 0, 0
	db	0, 0, 0, 93h, 0, 0, 0, 0, 0, 0, 0, 93h, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0
S6FF	ends

S707	segment para public 'CODE'
	assume	cs:S707
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'VDISK FAKE'	;@07070
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2Eh, 0FFh, 2Eh, 2Fh
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
S707	ends

S6BA	segment para public 'CODE'
	assume	cs:S6BA
S6BA_START	db	440h dup (0)	;@06BA0
S6BA	ends

_DATA	segment byte public 'DATA'
_DATA_START	db	0, '$*$*$*', 1, 0, 0, 2, 'TLINKX', 0, 13h, 13h, 'TKERNEL.EXE'	;@07151
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 'TLINKX.EXE', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'TLINKX.OVY'
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 'Error:  %s is allocated %lu KB but requires %u KB.'
	db	0Ah, 0, 'Error:  %lu KB of extended memory is available, bu', 't %u KB is required.'
	db	0Ah, 0, 'PATH=%s%s', 0, 'PATH', 0, 'Error:  Cannot locate %s in PATH.'
	db	0Ah, 0, ' HI=YES q 1', 0, 'Error:  Cannot install %s.', 0Ah, 0
	db	'Error:  Cannot load %s because %s is already in us', 65h, 2Eh
	db	0Ah, 0, 'Error:  Could not initialize %s.', 0Ah, 0, 'Error:  Could not create task because %s is alread'
	db	'y in use.', 0Ah, 0, 'Error:  Cannot create task.', 0Ah, 0, 'Internal error:  unhandled server function %04X.'
	db	0, 0Ah, 'Unexpected interrupt/exception %02X', 0, 0Ah, 'Unknown task exit code %04X'
	db	0, 'q 1 REM', 0, 'Error:  Cannot remove %s.', 0Ah, 0, ' at %04X:%04X.'
	db	0Ah, 0, 0, 0, 0, 0, 0
_DATA	ends

_BSS	segment word public 'BSS'
	db	2CEh dup (?)	;@07752
_BSS	ends

S446	segment para public 'CODE'
	assume	cs:S446
L04460	db	0FFh, 0FFh, 0FFh, 0FFh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@04460
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 'EMMXXXX0', 0, 'HUMMINGB'
	db	0, 'AIA_OS  ', 0, 0, 0, 0, 0, 0, 0, 0, 0
L0451A:	push	dx	;@0451A
	push	ds	;@0451B
	db	0E8h, 52h, 6	; call L04B71	;@0451C
	push	cs	;@0451F
	pop	ds	;@04520
	test	word ptr cs:L04460+2, 1	;@04521
	je	@@1	;@04528
	mov	ax, 0FBA1h	;@0452A
	call	@@11	;@0452D
	jb	@@4	;@04530
@@1:	test	word ptr cs:L04460+2, 2	;@04532
	je	@@2	;@04539
	mov	dx, 97h	;@0453B
	call	@@5	;@0453E
	jb	@@4	;@04541
@@2:	test	word ptr cs:L04460+2, 2	;@04543
	je	@@3	;@0454A
	mov	dx, 0A0h	;@0454C
	call	@@5	;@0454F
	jb	@@4	;@04552
@@3:	test	word ptr cs:L04460+2, 1	;@04554
	je	@@4	;@0455B
	mov	dx, 0A9h	;@0455D
	call	@@5	;@04560
	jb	@@4	;@04563
@@4:	pop	ds	;@04565
	pop	dx	;@04566
	ret	;@04567
@@5:	push	ax	;@04568
	push	bx	;@04569
	push	cx	;@0456A
	push	dx	;@0456B
	push	si	;@0456C
	xor	ax, ax	;@0456D
	mov	ah, 3Dh	;@0456F
	int	21h	;@04571
	jae	@@6	;@04573
	jmp	@@9	;@04575
@@6:	mov	bx, ax	;@04578
	mov	al, 3	;@0457A
	mov	cx, 8	;@0457C
	mov	dx, 0B2h	;@0457F
	mov	si, dx	;@04582
	mov	byte ptr [si], 82h	;@04584
	mov	ah, 44h	;@04587
	int	21h	;@04589
	mov	cx, 0	;@0458B
	mov	ax, word ptr ds:[0B2h]	;@0458E
	cmp	ax, 4149h	;@04591
	jne	@@7	;@04594
	mov	ax, word ptr ds:[0B4h]	;@04596
	cmp	ax, 4842h	;@04599
	jne	@@7	;@0459C
	mov	ax, word ptr ds:[0B6h]	;@0459E
	mov	word ptr ds:[4Bh], ax	;@045A1
	mov	ax, word ptr ds:[0B8h]	;@045A4
	mov	word ptr ds:[4Dh], ax	;@045A7
	mov	byte ptr cs:L04460, 0	;@045AA
	mov	byte ptr cs:L04460+1, 0	;@045B0
	mov	cx, 0FFFFh	;@045B6
@@7:	mov	ah, 3Eh	;@045B9
	int	21h	;@045BB
	cmp	cx, 0	;@045BD
	jne	@@8	;@045C0
	jmp	short @@9	;@045C2
@@8:	stc	;@045C4
	jmp	short @@10	;@045C5
@@9:	clc	;@045C7
@@10:	pop	si	;@045C8
	pop	dx	;@045C9
	pop	cx	;@045CA
	pop	bx	;@045CB
	pop	ax	;@045CC
	ret	;@045CD
@@11:	push	bx	;@045CE
	push	es	;@045CF
	push	di	;@045D0
	mov	word ptr ds:[0B2h], 0	;@045D1
	mov	word ptr ds:[0B4h], 0	;@045D7
	mov	bx, 82h	;@045DD
	push	cs	;@045E0
	pop	es	;@045E1
	mov	di, 0B2h	;@045E2
	int	2Fh	;@045E5
	jae	@@13	;@045E7
@@12:	clc	;@045E9
	jmp	short @@14	;@045EA
@@13:	cmp	word ptr ds:[0B2h], 4149h	;@045EC
	jne	@@12	;@045F2
	cmp	word ptr ds:[0B4h], 4842h	;@045F4
	jne	@@12	;@045FA
	mov	ax, word ptr ds:[0B6h]	;@045FC
	mov	word ptr ds:[4Bh], ax	;@045FF
	mov	ax, word ptr ds:[0B8h]	;@04602
	mov	word ptr ds:[4Dh], ax	;@04605
	mov	byte ptr cs:L04460, 0	;@04608
	mov	byte ptr cs:L04460+1, 0	;@0460E
	stc	;@04614
@@14:	pop	di	;@04615
	pop	es	;@04616
	pop	bx	;@04617
	ret	;@04618
L04619:	push	ds	;@04619
	push	es	;@0461A
	push	si	;@0461B
	push	di	;@0461C
	push	cs	;@0461D
	pop	ds	;@0461E
	db	0E8h, 69h, 5	; call L04B8B	;@0461F
	jae	@@1	;@04622
	pop	di	;@04624
	pop	si	;@04625
	pop	es	;@04626
	pop	ds	;@04627
	ret	;@04628
@@1:	db	0E8h, 93h, 4	; call L04ABF	;@04629
	mov	ax, word ptr ds:[8Dh]	;@0462C
	mov	word ptr cs:L04460+12, ax	;@0462F
	clc	;@04633
	pop	di	;@04634
	pop	si	;@04635
	pop	es	;@04636
	pop	ds	;@04637
	ret	;@04638
L04639:	push	es	;@04639
	push	ds	;@0463A
	push	si	;@0463B
	mov	word ptr ds:[53h], bx	;@0463C
	mov	word ptr ds:[55h], ax	;@04640
	mov	cx, ax	;@04643
	mov	dx, bx	;@04645
	mov	bx, word ptr ds:[95h]	;@04647
	xor	al, al	;@0464B
	mov	ah, 42h	;@0464D
	int	21h	;@0464F
	db	73h, 16h	; jae @@2	;@04651
	push	cs	;@04653
	pop	ds	;@04654
	db	0EBh, 0Ch	; jmp @@1	;@04655
	db	90h, 'seek error$'	;@04657
@@1:	db	0BAh, 0F8h, 1	; mov dx, 1F8h	;@04663
	db	0EBh, 6Dh	; jmp L046D5	;@04666
	db	90h	;@04668
@@2:	mov	cx, 24h	;@04669
	mov	dx, 67h	;@0466C
	mov	ah, 3Fh	;@0466F
	int	21h	;@04671
	db	73h, 21h	; jae @@4	;@04673
	push	cs	;@04675
	pop	ds	;@04676
	db	0EBh, 17h	; jmp @@3	;@04677
	db	90h, 'Failed reading header$'	;@04679
@@3:	db	0BAh, 1Ah, 2	; mov dx, 21Ah	;@04690
	db	0EBh, 40h	; jmp L046D5	;@04693
	db	90h	;@04695
@@4:	mov	ax, word ptr ds:[67h]	;@04696
	cmp	ax, 5A4Dh	;@04699
	db	74h, 25h	; je @@6	;@0469C
	push	cs	;@0469E
	pop	ds	;@0469F
	db	0EBh, 1Bh	; jmp @@5	;@046A0
	db	90h, 'Not an exe file signature$'	;@046A2
@@5:	db	0BAh, 43h, 2	; mov dx, 243h	;@046BD
	jmp	L046D5	;@046C0
@@6:	call	L046DE	;@046C3
	mov	ax, word ptr ds:[7Dh]	;@046C6
	add	ax, word ptr ds:[8Dh]	;@046C9
	mov	bx, word ptr ds:[7Bh]	;@046CD
	pop	si	;@046D1
	pop	ds	;@046D2
	pop	es	;@046D3
	ret	;@046D4
L046D5:	mov	ah, 9	;@046D5
	int	21h	;@046D7
	mov	ah, 4Ch	;@046D9
	int	21h	;@046DB
	hlt	;@046DD
L046DE:	call	@@4	;@046DE
	db	0E8h, 0Bh, 1	; call @@13	;@046E1
	db	0E8h, 25h, 2	; call @@24	;@046E4
	ret	;@046E7
@@1:	mov	bx, word ptr ds:[6Fh]	;@046E8
	mov	al, 4	;@046EC
	db	0E8h, 0C9h, 0Ah	; call L051BA	;@046EE
	push	ax	;@046F1
	push	bx	;@046F2
	mov	bx, word ptr ds:[6Bh]	;@046F3
	cmp	word ptr ds:[69h], 0	;@046F7
	jne	@@2	;@046FC
	mov	al, 9	;@046FE
	db	0E8h, 0B7h, 0Ah	; call L051BA	;@04700
	jmp	@@3	;@04703
@@2:	dec	bx	;@04706
	mov	al, 9	;@04707
	db	0E8h, 0AEh, 0Ah	; call L051BA	;@04709
	add	bx, word ptr ds:[69h]	;@0470C
	adc	ax, 0	;@04710
@@3:	pop	dx	;@04713
	pop	cx	;@04714
	sub	bx, dx	;@04715
	sbb	ax, cx	;@04717
	ret	;@04719
@@4:	push	es	;@0471A
	call	@@1	;@0471B
	mov	word ptr ds:[3Ch], bx	;@0471E
	mov	word ptr ds:[3Eh], ax	;@04722
	push	ax	;@04725
	push	bx	;@04726
	mov	bx, word ptr ds:[71h]	;@04727
	mov	al, 4	;@0472B
	db	0E8h, 8Ah, 0Ah	; call L051BA	;@0472D
	pop	dx	;@04730
	pop	cx	;@04731
	add	bx, dx	;@04732
	adc	ax, cx	;@04734
	add	bx, 0Fh	;@04736
	adc	ax, 0	;@04739
	push	cx	;@0473C
	mov	cl, 4	;@0473D
	db	0E8h, 69h, 0Ah	; call L051AB	;@0473F
	pop	cx	;@04742
	mov	word ptr ds:[8Fh], bx	;@04743
	add	bx, word ptr ds:[8Bh]	;@04747
	mov	cx, bx	;@0474B
	cmp	byte ptr ds:[4Ah], 0	;@0474D
	jne	@@5	;@04752
	db	0EBh, 4Bh	; jmp @@9	;@04754
	db	90h	;@04756
@@5:	mov	ax, word ptr ds:[48h]	;@04757
	cmp	ax, 0	;@0475A
	jne	@@6	;@0475D
	db	0EBh, 40h	; jmp @@9	;@0475F
	db	90h	;@04761
@@6:	sub	ax, bx	;@04762
	db	75h, 9	; jne @@7	;@04764
	mov	ax, word ptr ds:[46h]	;@04766
	db	0EBh, 6Eh	; jmp @@11	;@04769
	db	90h, 0EBh, 33h, 90h	;@0476B
@@7:	db	0A1h, 46h, 0	; mov ax, word ptr ds:[46h]	;@0476F
	mov	es, ax	;@04772
	mov	ah, 49h	;@04774
	nosmart
	nosmart
	call	far ptr L051EC	;@04776
	smart
	smart
	db	73h, 24h	; jae @@9	;@0477B
	push	cs	;@0477D
	pop	ds	;@0477E
	db	0EBh, 1Ah	; jmp @@8	;@0477F
	db	90h, 'Problem releasing memory$'	;@04781
@@8:	db	0BAh, 22h, 3	; mov dx, 322h	;@0479B
	jmp	L046D5	;@0479E
@@9:	mov	ah, 48h	;@047A1
	nosmart
	nosmart
	call	far ptr L051D2	;@047A3
	smart
	smart
	db	73h, 2Fh	; jae @@11	;@047A8
	push	cs	;@047AA
	pop	ds	;@047AB
	db	0EBh, 25h	; jmp @@10	;@047AC
	db	90h, 'Insufficient memory to load overlay$'	;@047AE
@@10:	db	0BAh, 4Fh, 3	; mov dx, 34Fh	;@047D3
	jmp	L046D5	;@047D6
@@11:	cmp	byte ptr ds:[4Ah], 0	;@047D9
	je	@@12	;@047DE
	mov	word ptr ds:[46h], ax	;@047E0
	mov	word ptr ds:[48h], cx	;@047E3
@@12:	mov	word ptr ds:[8Dh], ax	;@047E7
	mov	word ptr ds:[44h], ax	;@047EA
	pop	es	;@047ED
	ret	;@047EE
@@13:	push	ds	;@047EF
	mov	bx, word ptr ds:[53h]	;@047F0
	mov	ax, word ptr ds:[55h]	;@047F4
	push	ax	;@047F7
	push	bx	;@047F8
	mov	bx, word ptr ds:[6Fh]	;@047F9
	xor	ax, ax	;@047FD
	mov	al, 4	;@047FF
	db	0E8h, 0B6h, 9	; call L051BA	;@04801
	pop	dx	;@04804
	pop	cx	;@04805
	add	bx, dx	;@04806
	adc	ax, cx	;@04808
	mov	cx, ax	;@0480A
	mov	dx, bx	;@0480C
	xor	al, al	;@0480E
	mov	bx, word ptr ds:[95h]	;@04810
	mov	ah, 42h	;@04814
	int	21h	;@04816
	db	73h, 26h	; jae @@15	;@04818
	push	cs	;@0481A
	pop	ds	;@0481B
	db	0EBh, 1Ch	; jmp @@14	;@0481C
	db	90h, 'Cannot load kernel overlay$'	;@0481E
@@14:	db	0BAh, 0BFh, 3	; mov dx, 3BFh	;@0483A
	jmp	L046D5	;@0483D
@@15:	mov	ax, word ptr ds:[8Dh]	;@04840
	mov	ds, ax	;@04843
	mov	bx, word ptr cs:L04460+60	;@04845
	mov	ax, word ptr cs:L04460+62	;@0484A
	mov	word ptr cs:L04460+56, bx	;@0484E
	mov	word ptr cs:L04460+58, ax	;@04853
@@16:	mov	bx, word ptr cs:L04460+56	;@04857
	mov	ax, word ptr cs:L04460+58	;@0485C
	push	ax	;@04860
	push	bx	;@04861
	mov	bx, 2000h	;@04862
	xor	ax, ax	;@04865
	pop	dx	;@04867
	pop	cx	;@04868
	cmp	cx, ax	;@04869
	jne	@@17	;@0486B
	cmp	dx, bx	;@0486D
	jae	@@18	;@0486F
	mov	bx, dx	;@04871
	jmp	short @@18	;@04873
@@17:	ja	@@18	;@04875
	mov	ax, cx	;@04877
	mov	bx, dx	;@04879
@@18:	xor	cx, cx	;@0487B
	mov	cx, bx	;@0487D
	mov	bx, word ptr cs:L04460+149	;@0487F
	xor	dx, dx	;@04884
	mov	ah, 3Fh	;@04886
	int	21h	;@04888
	db	73h, 26h	; jae @@20	;@0488A
	push	cs	;@0488C
	pop	ds	;@0488D
	db	0EBh, 1Ch	; jmp @@19	;@0488E
	db	90h, 'Cannot read kernel overlay$'	;@04890
@@19:	db	0BAh, 31h, 4	; mov dx, 431h	;@048AC
	jmp	L046D5	;@048AF
@@20:	cmp	ax, cx	;@048B2
	db	74h, 28h	; je @@22	;@048B4
	push	cs	;@048B6
	pop	ds	;@048B7
	db	0EBh, 1Eh	; jmp @@21	;@048B8
	db	90h, 'Error reading kernel overlay$'	;@048BA
@@21:	db	0BAh, 5Bh, 4	; mov dx, 45Bh	;@048D8
	jmp	L046D5	;@048DB
@@22:	mov	bx, cx	;@048DE
	xor	ax, ax	;@048E0
	push	ax	;@048E2
	push	bx	;@048E3
	mov	ax, ds	;@048E4
	add	ax, 200h	;@048E6
	mov	ds, ax	;@048E9
	mov	bx, word ptr cs:L04460+56	;@048EB
	mov	ax, word ptr cs:L04460+58	;@048F0
	pop	dx	;@048F4
	pop	cx	;@048F5
	sub	bx, dx	;@048F6
	sbb	ax, cx	;@048F8
	mov	word ptr cs:L04460+56, bx	;@048FA
	mov	word ptr cs:L04460+58, ax	;@048FF
	or	ax, bx	;@04903
	je	@@23	;@04905
	jmp	@@16	;@04907
@@23:	pop	ds	;@0490A
	ret	;@0490B
@@24:	mov	bx, word ptr ds:[53h]	;@0490C
	mov	ax, word ptr ds:[55h]	;@04910
	push	ax	;@04913
	push	bx	;@04914
	xor	ax, ax	;@04915
	mov	bx, word ptr ds:[7Fh]	;@04917
	pop	dx	;@0491B
	pop	cx	;@0491C
	add	bx, dx	;@0491D
	adc	ax, cx	;@0491F
	mov	cx, ax	;@04921
	mov	dx, bx	;@04923
	mov	bx, word ptr ds:[95h]	;@04925
	xor	ax, ax	;@04929
	mov	ah, 42h	;@0492B
	int	21h	;@0492D
@@25:	mov	dx, word ptr ds:[6Dh]	;@0492F
	cmp	dx, 0	;@04933
	jne	@@26	;@04936
	ret	;@04938
@@26:	xor	cx, cx	;@04939
	mov	cx, 1	;@0493B
	cmp	dx, cx	;@0493E
	jge	@@27	;@04940
	mov	cx, dx	;@04942
@@27:	sub	word ptr ds:[6Dh], cx	;@04944
	shl	cx, 1	;@04948
	shl	cx, 1	;@0494A
	mov	dx, 40h	;@0494C
	mov	bx, word ptr ds:[95h]	;@0494F
	mov	ah, 3Fh	;@04953
	int	21h	;@04955
	db	73h, 29h	; jae @@29	;@04957
	push	cs	;@04959
	pop	ds	;@0495A
	db	0EBh, 1Fh	; jmp @@28	;@0495B
	db	90h, 'Error reading relocation data$'	;@0495D
@@28:	db	0BAh, 0FEh, 4	; mov dx, 4FEh	;@0497C
	jmp	L046D5	;@0497F
@@29:	cmp	ax, cx	;@04982
	db	7Dh, 29h	; jge @@31	;@04984
	push	cs	;@04986
	pop	ds	;@04987
	db	0EBh, 1Fh	; jmp @@30	;@04988
	db	90h, 'Error reading relocation data$'	;@0498A
@@30:	db	0BAh, 2Bh, 5	; mov dx, 52Bh	;@049A9
	jmp	L046D5	;@049AC
@@31:	shr	cx, 1	;@049AF
	shr	cx, 1	;@049B1
	xor	bx, bx	;@049B3
	mov	dx, word ptr ds:[44h]	;@049B5
@@32:	db	8Bh, 0B7h, 40h, 0	; mov si, word ptr [bx+40h]	;@049B9
	db	8Bh, 87h, 42h, 0	; mov ax, word ptr [bx+42h]	;@049BD
	add	ax, dx	;@049C1
	mov	es, ax	;@049C3
	add	word ptr es:[si], dx	;@049C5
	add	bx, 4	;@049C8
	sub	cx, 1	;@049CB
	jne	@@32	;@049CE
	jmp	@@25	;@049D0
L049D3:	push	ds	;@049D3
	push	es	;@049D4
	push	si	;@049D5
	push	cs	;@049D6
	pop	ds	;@049D7
	cmp	word ptr ds:[95h], -1	;@049D8
	jne	@@1	;@049DD
	call	L04B9A	;@049DF
@@1:	nosmart	;@049E2
	call	far ptr L04CE0
	smart
	mov	si, ax	;@049E7
	mov	es, dx	;@049E9
	cmp	byte ptr es:[si+35h], 0	;@049EB
	jne	@@2	;@049F0
	call	@@4	;@049F2
	db	0E8h, 0D9h, 1	; call L04BD1	;@049F5
	jmp	@@3	;@049F8
@@2:	mov	ax, word ptr ds:[95h]	;@049FB
	mov	word ptr es:[si+1Bh], ax	;@049FE
	mov	bx, word ptr ds:[5Bh]	;@04A02
	mov	ax, word ptr ds:[5Dh]	;@04A06
	mov	word ptr es:[si+1Dh], bx	;@04A09
	mov	word ptr es:[si+1Fh], ax	;@04A0D
	mov	word ptr ds:[95h], 0FFFFh	;@04A11
@@3:	pop	si	;@04A17
	pop	es	;@04A18
	pop	ds	;@04A19
	ret	;@04A1A
@@4:	mov	bx, word ptr ds:[5Bh]	;@04A1B
	mov	ax, word ptr ds:[5Dh]	;@04A1F
	mov	byte ptr cs:L04460+74, 1	;@04A22
	call	L04639	;@04A28
	mov	byte ptr cs:L04460+74, 0	;@04A2B
	mov	word ptr ds:[4Fh], bx	;@04A31
	mov	word ptr ds:[51h], ax	;@04A35
	mov	word ptr es:[si+13h], bx	;@04A38
	mov	word ptr es:[si+15h], ax	;@04A3C
	mov	ax, word ptr cs:L04460+141	;@04A40
	mov	word ptr es:[si+17h], ax	;@04A44
	mov	word ptr cs:L04460+14, ax	;@04A48
	mov	ax, word ptr cs:L04460+143	;@04A4C
	mov	word ptr es:[si+19h], ax	;@04A50
	ret	;@04A54
L04A55:	mov	dx, 14h	;@04A55
	mov	cx, 24h	;@04A58
	mov	bx, word ptr ds:[95h]	;@04A5B
	mov	ah, 3Fh	;@04A5F
	int	21h	;@04A61
	jae	@@1	;@04A63
	jmp	@@7	;@04A65
@@1:	mov	bx, dx	;@04A68
	mov	ax, word ptr [bx]	;@04A6A
	cmp	ax, 5A4Dh	;@04A6C
	je	@@2	;@04A6F
	jmp	@@7	;@04A71
@@2:	mov	bx, word ptr ds:[1Ch]	;@04A74
	cmp	bx, 20h	;@04A78
	jg	@@3	;@04A7B
	jmp	@@7	;@04A7D
@@3:	sub	bx, 20h	;@04A80
	mov	al, 4	;@04A83
	db	0E8h, 32h, 7	; call L051BA	;@04A85
	mov	cx, ax	;@04A88
	mov	dx, bx	;@04A8A
	xor	al, al	;@04A8C
	mov	bx, word ptr ds:[95h]	;@04A8E
	mov	ah, 42h	;@04A92
	int	21h	;@04A94
	jae	@@4	;@04A96
	jmp	@@7	;@04A98
@@4:	mov	cx, 10h	;@04A9B
	mov	dx, 57h	;@04A9E
	mov	ah, 3Fh	;@04AA1
	int	21h	;@04AA3
	jae	@@5	;@04AA5
	jmp	@@7	;@04AA7
@@5:	cmp	word ptr ds:[57h], 4941h	;@04AAA
	je	@@6	;@04AB0
	jmp	@@7	;@04AB2
@@6:	mov	ax, 0	;@04AB5
	jmp	@@8	;@04AB8
@@7:	mov	ax, 0FFFFh	;@04ABB
@@8:	ret	;@04ABE
L04ABF:	mov	word ptr ds:[8Bh], 0	;@04ABF
	mov	bx, word ptr ds:[5Fh]	;@04AC5
	mov	ax, word ptr ds:[61h]	;@04AC9
	call	L04639	;@04ACC
	xor	bx, bx	;@04ACF
	mov	word ptr ds:[4Bh], bx	;@04AD1
	mov	word ptr ds:[4Dh], ax	;@04AD5
	mov	byte ptr ds:[0], 0	;@04AD8
	ret	;@04ADD
L04ADE:	push	es	;@04ADE
	mov	ah, 62h	;@04ADF
	int	21h	;@04AE1
	mov	es, bx	;@04AE3
	mov	ax, word ptr es:[2Ch]	;@04AE5
	mov	es, ax	;@04AE9
	xor	di, di	;@04AEB
	xor	al, al	;@04AED
@@1:	mov	cx, 0FFFFh	;@04AEF
	repne scasb	;@04AF2
	cmp	al, byte ptr es:[di]	;@04AF4
	je	@@2	;@04AF7
	jmp	@@1	;@04AF9
@@2:	add	di, 3	;@04AFB
	mov	ax, es	;@04AFE
	mov	bx, di	;@04B00
	pop	es	;@04B02
	ret	;@04B03
L04B04:	call	L04ADE	;@04B04
	mov	word ptr ds:[91h], bx	;@04B07
	mov	word ptr ds:[93h], ax	;@04B0B
	call	@@1	;@04B0E
	ret	;@04B11
@@1:	mov	bx, word ptr ds:[91h]	;@04B12
	mov	ax, word ptr ds:[93h]	;@04B16
	push	ds	;@04B19
	mov	ds, ax	;@04B1A
	mov	dx, bx	;@04B1C
	xor	al, al	;@04B1E
	mov	ah, 3Dh	;@04B20
	int	21h	;@04B22
	pop	ds	;@04B24
	jae	@@2	;@04B25
	mov	ax, 0FFFFh	;@04B27
	jmp	@@8	;@04B2A
@@2:	mov	word ptr ds:[95h], ax	;@04B2D
	mov	bx, ax	;@04B30
	call	L04A55	;@04B32
	cmp	ax, 0FFFFh	;@04B35
	jne	@@3	;@04B38
	jmp	@@6	;@04B3A
@@3:	mov	bx, word ptr ds:[5Bh]	;@04B3D
	mov	ax, word ptr ds:[5Dh]	;@04B41
	cmp	ax, 0FFFFh	;@04B44
	jne	@@4	;@04B47
	jmp	@@6	;@04B49
@@4:	mov	bx, word ptr ds:[5Fh]	;@04B4C
	mov	ax, word ptr ds:[61h]	;@04B50
	cmp	ax, 0FFFFh	;@04B53
	jne	@@5	;@04B56
	jmp	@@6	;@04B58
@@5:	jmp	@@7	;@04B5B
@@6:	mov	bx, word ptr ds:[95h]	;@04B5E
	mov	ah, 3Eh	;@04B62
	int	21h	;@04B64
	mov	ax, 0FFFFh	;@04B66
	jmp	@@8	;@04B69
@@7:	mov	ax, word ptr ds:[95h]	;@04B6C
@@8:	pop	es	;@04B6F
	ret	;@04B70
L04B71:	push	ax	;@04B71
	push	bx	;@04B72
	push	cx	;@04B73
	push	dx	;@04B74
	mov	cx, 4149h	;@04B75
	mov	dx, 413Fh	;@04B78
	mov	ah, 2Bh	;@04B7B
	int	21h	;@04B7D
	cmp	al, 0FFh	;@04B7F
	jne	@@1	;@04B81
	jmp	@@1	;@04B83
@@1:	pop	dx	;@04B86
	pop	cx	;@04B87
	pop	bx	;@04B88
	pop	ax	;@04B89
	ret	;@04B8A
L04B8B:	call	L04B71	;@04B8B
	call	L04B04	;@04B8E
	cmp	ax, 0FFFFh	;@04B91
	je	@@1	;@04B94
	clc	;@04B96
	ret	;@04B97
@@1:	stc	;@04B98
	ret	;@04B99
L04B9A:	mov	bx, word ptr ds:[91h]	;@04B9A
	mov	ax, word ptr ds:[93h]	;@04B9E
	push	ds	;@04BA1
	mov	ds, ax	;@04BA2
	mov	dx, bx	;@04BA4
	xor	al, al	;@04BA6
	mov	ah, 3Dh	;@04BA8
	int	21h	;@04BAA
	db	73h, 1Eh	; jae @@2	;@04BAC
	push	cs	;@04BAE
	pop	ds	;@04BAF
	db	0EBh, 14h	; jmp @@1	;@04BB0
	db	90h, 'Cannot open kernel$'	;@04BB2
@@1:	db	0BAh, 53h, 7	; mov dx, 753h	;@04BC6
	jmp	L046D5	;@04BC9
@@2:	pop	ds	;@04BCC
	mov	word ptr ds:[95h], ax	;@04BCD
	ret	;@04BD0
L04BD1:	mov	bx, word ptr ds:[95h]	;@04BD1
	cmp	bx, -1	;@04BD5
	db	74h, 2Ah	; je @@3	;@04BD8
	mov	ah, 3Eh	;@04BDA
	int	21h	;@04BDC
	db	73h, 1Eh	; jae @@2	;@04BDE
	push	cs	;@04BE0
	pop	ds	;@04BE1
	db	0EBh, 14h	; jmp @@1	;@04BE2
	db	90h, 'Error closing file$'	;@04BE4
@@1:	db	0BAh, 85h, 7	; mov dx, 785h	;@04BF8
	jmp	L046D5	;@04BFB
@@2:	mov	word ptr ds:[95h], 0FFFFh	;@04BFE
@@3:	ret	;@04C04
	db	'VQP', 0FCh, 83h, 0F9h, 0, 7Eh, 12h, 8Ah, 4, '<ar', 6, '<zw', 2	;@04C05
	db	2Ch, 20h, 88h, 4, 46h, 49h, 0EBh, 0E9h, 'XY^', 0C3h
L04C24:	push	cs	;@04C24
	pop	ds	;@04C25
	db	0EBh, 2Dh	; jmp @@1	;@04C26
	db	90h, 'OS/x86: Cannot find operating system kernel$'	;@04C28
@@1:	db	0BAh, 0C9h, 7	; mov dx, 7C9h	;@04C55
	jmp	L046D5	;@04C58
	db	55h, 8Bh, 0ECh, 8Bh, 46h, 6, 2Eh, 0A3h, 2, 0, 5Dh, 0CBh, 55h, 8Bh	;@04C5B
	db	0ECh, 8Bh, 46h, 6, 2Eh, 0A3h, 2, 0, 2Eh, 0C6h, 6, 0, 0, 0FFh, 2Eh
	db	0C6h, 6, 1, 0, 0FFh, 0E8h, 9Ah, 0F8h, 2Eh, 80h, 3Eh, 0, 0, 0, 75h
	db	5, 0B8h, 1, 0, 0EBh, 3, 0B8h, 0, 0, 5Dh, 0CBh
L04C92:	cmp	byte ptr cs:L04460, 0	;@04C92
	je	@@1	;@04C98
	call	L0451A	;@04C9A
	cmp	byte ptr cs:L04460, 0	;@04C9D
	je	@@1	;@04CA3
	call	L04619	;@04CA5
	jae	@@1	;@04CA8
	mov	ax, 0Bh	;@04CAA
	retf	;@04CAD
@@1:	cmp	byte ptr cs:L04460+1, 0	;@04CAE
	jne	@@2	;@04CB4
	call	@@3	;@04CB6
	mov	ax, 0	;@04CB9
	retf	;@04CBC
@@2:	call	L049D3	;@04CBD
	call	@@3	;@04CC0
	mov	ax, 0	;@04CC3
	jmp	dword ptr cs:L04460+75	;@04CC6
@@3:	mov	bx, S446	;@04CCB
	mov	cx, S446	;@04CCE
	mov	si, 0D72h	;@04CD1
	mov	di, 0D8Ch	;@04CD4
	mov	ax, 0FFFFh	;@04CD7
	call	dword ptr cs:L04460+75	;@04CDA
	ret	;@04CDF
L04CE0:	cmp	byte ptr cs:L04460, 0	;@04CE0
	je	@@1	;@04CE6
	call	L0451A	;@04CE8
	cmp	byte ptr cs:L04460, 0	;@04CEB
	je	@@1	;@04CF1
	call	L04619	;@04CF3
	jae	@@1	;@04CF6
	xor	dx, dx	;@04CF8
	xor	ax, ax	;@04CFA
	retf	;@04CFC
@@1:	mov	ax, 19h	;@04CFD
	jmp	dword ptr cs:L04460+75	;@04D00
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 0Ah, 0F8h, 2Eh, 80h, 3Eh	;@04D05
	db	0, 0, 0, 74h, 8, 0E8h, 0FEh, 0F8h, 73h, 3, 0E8h, 4, 0FFh, 0B8h
	db	1, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h
	db	0E8h, 0E7h, 0F7h, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 8, 0E8h, 0DBh, 0F8h
	db	73h, 3, 0E8h, 0E1h, 0FEh, 0B8h, 2, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
L04D4B:	cmp	byte ptr cs:L04460, 0	;@04D4B
	je	@@1	;@04D51
	call	L0451A	;@04D53
	cmp	byte ptr cs:L04460, 0	;@04D56
	je	@@1	;@04D5C
	call	L04619	;@04D5E
	jae	@@1	;@04D61
	call	L04C24	;@04D63
@@1:	mov	ax, 3	;@04D66
	jmp	dword ptr cs:L04460+75	;@04D69
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 0A1h, 0F7h, 2Eh, 80h, 3Eh	;@04D6E
	db	0, 0, 0, 74h, 8, 0E8h, 95h, 0F8h, 73h, 3, 0E8h, 9Bh, 0FEh, 0B8h
	db	4, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
L04D91:	cmp	byte ptr cs:L04460, 0	;@04D91
	je	@@1	;@04D97
	call	L0451A	;@04D99
	cmp	byte ptr cs:L04460, 0	;@04D9C
	je	@@1	;@04DA2
	call	L04619	;@04DA4
	jae	@@1	;@04DA7
	call	L04C24	;@04DA9
@@1:	mov	ax, 5	;@04DAC
	jmp	dword ptr cs:L04460+75	;@04DAF
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 5Bh, 0F7h, 2Eh, 80h, 3Eh	;@04DB4
	db	0, 0, 0, 74h, 8, 0E8h, 4Fh, 0F8h, 73h, 3, 0E8h, 55h, 0FEh, 0B8h
	db	6, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h
	db	0E8h, 38h, 0F7h, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 8, 0E8h, 2Ch, 0F8h
	db	73h, 3, 0E8h, 32h, 0FEh, 0B8h, 8, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh
	db	80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 15h, 0F7h, 2Eh, 80h, 3Eh, 0
	db	0, 0, 74h, 8, 0E8h, 9, 0F8h, 73h, 3, 0E8h, 0Fh, 0FEh, 0B8h, 9
	db	0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h
	db	0F2h, 0F6h, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 8, 0E8h, 0E6h, 0F7h, 73h
	db	3, 0E8h, 0ECh, 0FDh, 0B8h, 0Ah, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh
	db	80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 0CFh, 0F6h, 2Eh, 80h, 3Eh, 0
	db	0, 0, 74h, 8, 0E8h, 0C3h, 0F7h, 73h, 3, 0E8h, 0C9h, 0FDh, 0B8h
	db	0Bh, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h
	db	0E8h, 0ACh, 0F6h, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 8, 0E8h, 0A0h, 0F7h
	db	73h, 3, 0E8h, 0A6h, 0FDh, 0B8h, 0Ch, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 89h, 0F6h, 2Eh, 80h, 3Eh
	db	0, 0, 0, 74h, 8, 0E8h, 7Dh, 0F7h, 73h, 3, 0E8h, 83h, 0FDh, 0B8h
	db	0Dh, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h
	db	0E8h, 66h, 0F6h, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 8, 0E8h, 5Ah, 0F7h
	db	73h, 3, 0E8h, 60h, 0FDh, 0B8h, 0Eh, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 43h, 0F6h, 2Eh, 80h, 3Eh
	db	0, 0, 0, 74h, 8, 0E8h, 37h, 0F7h, 73h, 3, 0E8h, 3Dh, 0FDh, 0B8h
	db	0Fh, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
L04EEF:	cmp	byte ptr cs:L04460, 0	;@04EEF
	je	@@1	;@04EF5
	call	L0451A	;@04EF7
	cmp	byte ptr cs:L04460, 0	;@04EFA
	je	@@1	;@04F00
	call	L04619	;@04F02
	jae	@@1	;@04F05
	call	L04C24	;@04F07
@@1:	mov	ax, 10h	;@04F0A
	jmp	dword ptr cs:L04460+75	;@04F0D
L04F12:	cmp	byte ptr cs:L04460, 0	;@04F12
	je	@@1	;@04F18
	call	L0451A	;@04F1A
	cmp	byte ptr cs:L04460, 0	;@04F1D
	je	@@1	;@04F23
	call	L04619	;@04F25
	jae	@@1	;@04F28
	call	L04C24	;@04F2A
@@1:	mov	ax, 11h	;@04F2D
	jmp	dword ptr cs:L04460+75	;@04F30
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 0DAh, 0F5h, 2Eh, 80h, 3Eh	;@04F35
	db	0, 0, 0, 74h, 8, 0E8h, 0CEh, 0F6h, 73h, 3, 0E8h, 0D4h, 0FCh, 0B8h
	db	12h, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h
	db	0E8h, 0B7h, 0F5h, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 8, 0E8h, 0ABh, 0F6h
	db	73h, 3, 0E8h, 0B1h, 0FCh, 0B8h, 13h, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
L04F7B:	cmp	byte ptr cs:L04460, 0	;@04F7B
	je	@@1	;@04F81
	call	L0451A	;@04F83
	cmp	byte ptr cs:L04460, 0	;@04F86
	je	@@1	;@04F8C
	call	L04619	;@04F8E
	jae	@@1	;@04F91
	call	L04C24	;@04F93
@@1:	mov	ax, 14h	;@04F96
	jmp	dword ptr cs:L04460+75	;@04F99
L04F9E:	cmp	byte ptr cs:L04460, 0	;@04F9E
	je	@@1	;@04FA4
	call	L0451A	;@04FA6
	cmp	byte ptr cs:L04460, 0	;@04FA9
	je	@@1	;@04FAF
	call	L04619	;@04FB1
	jae	@@1	;@04FB4
	call	L04C24	;@04FB6
@@1:	mov	ax, 15h	;@04FB9
	jmp	dword ptr cs:L04460+75	;@04FBC
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 4Eh, 0F5h, 2Eh, 80h, 3Eh	;@04FC1
	db	0, 0, 0, 74h, 8, 0E8h, 42h, 0F6h, 73h, 3, 0E8h, 48h, 0FCh, 0B8h
	db	16h, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h
	db	0E8h, 2Bh, 0F5h, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 8, 0E8h, 1Fh, 0F6h
	db	73h, 3, 0E8h, 25h, 0FCh, 0B8h, 17h, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 8, 0F5h, 2Eh, 80h, 3Eh
	db	0, 0, 0, 74h, 8, 0E8h, 0FCh, 0F5h, 73h, 3, 0E8h, 2, 0FCh, 0B8h
	db	1Ah, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h
	db	0E8h, 0E5h, 0F4h, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 8, 0E8h, 0D9h, 0F5h
	db	73h, 3, 0E8h, 0DFh, 0FBh, 0B8h, 1Bh, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 0C2h, 0F4h, 2Eh, 80h, 3Eh
	db	0, 0, 0, 74h, 8, 0E8h, 0B6h, 0F5h, 73h, 3, 0E8h, 0BCh, 0FBh, 0B8h
	db	1Ch, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h
	db	0E8h, 9Fh, 0F4h, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 8, 0E8h, 93h, 0F5h
	db	73h, 3, 0E8h, 99h, 0FBh, 0B8h, 1Dh, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 7Ch, 0F4h, 2Eh, 80h, 3Eh
	db	0, 0, 0, 74h, 8, 0E8h, 70h, 0F5h, 73h, 3, 0E8h, 76h, 0FBh, 0B8h
	db	1Eh, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h
	db	0E8h, 59h, 0F4h, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 8, 0E8h, 4Dh, 0F5h
	db	73h, 3, 0E8h, 53h, 0FBh, 0B8h, 1Fh, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 36h, 0F4h, 2Eh, 80h, 3Eh
	db	0, 0, 0, 74h, 8, 0E8h, 2Ah, 0F5h, 73h, 3, 0E8h, 30h, 0FBh, 0B8h
	db	20h, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h
	db	0E8h, 13h, 0F4h, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 8, 0E8h, 7, 0F5h
	db	73h, 3, 0E8h, 0Dh, 0FBh, 0B8h, 21h, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 0F0h, 0F3h, 2Eh, 80h, 3Eh
	db	0, 0, 0, 74h, 8, 0E8h, 0E4h, 0F4h, 73h, 3, 0E8h, 0EAh, 0FAh, 0B8h
	db	22h, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h
	db	0E8h, 0CDh, 0F3h, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 8, 0E8h, 0C1h, 0F4h
	db	73h, 3, 0E8h, 0C7h, 0FAh, 0B8h, 23h, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
L05165:	cmp	byte ptr cs:L04460, 0	;@05165
	je	@@1	;@0516B
	call	L0451A	;@0516D
	cmp	byte ptr cs:L04460, 0	;@05170
	je	@@1	;@05176
	call	L04619	;@05178
	jae	@@1	;@0517B
	call	L04C24	;@0517D
@@1:	mov	ax, 24h	;@05180
	jmp	dword ptr cs:L04460+75	;@05183
L05188:	cmp	byte ptr cs:L04460, 0	;@05188
	je	@@1	;@0518E
	call	L0451A	;@05190
	cmp	byte ptr cs:L04460, 0	;@05193
	je	@@1	;@05199
	call	L04619	;@0519B
	jae	@@1	;@0519E
	call	L04C24	;@051A0
@@1:	mov	ax, 25h	;@051A3
	jmp	dword ptr cs:L04460+75	;@051A6
L051AB:	mov	ch, cl	;@051AB
	shr	bx, cl	;@051AD
	mov	cl, 10h	;@051AF
	sub	cl, ch	;@051B1
	shl	ax, cl	;@051B3
	or	bx, ax	;@051B5
	xor	ax, ax	;@051B7
	ret	;@051B9
L051BA:	push	cx	;@051BA
	mov	cl, al	;@051BB
	mov	ch, al	;@051BD
	mov	ax, bx	;@051BF
	shl	bx, cl	;@051C1
	mov	cl, 10h	;@051C3
	sub	cl, ch	;@051C5
	shr	ax, cl	;@051C7
	pop	cx	;@051C9
	ret	;@051CA
L051CB	db	7 dup (0)	;@051CB
L051D2:	cmp	word ptr cs:L051CB+5, 0	;@051D2
	jne	@@1	;@051D8
	cmp	bx, 10h	;@051DA
	jne	@@1	;@051DD
	inc	word ptr cs:L051CB+5	;@051DF
	mov	ax, seg S434_START	;@051E4
	clc	;@051E7
	retf	;@051E8
@@1:	int	21h	;@051E9
	retf	;@051EB
L051EC:	mov	ax, es	;@051EC
	db	3Dh	;@051EE
	dw	seg S434_START
	db	0B4h, 49h	; mov ah, 49h	;@051F1
	jne	@@1	;@051F3
	retf	;@051F5
@@1:	int	21h	;@051F6
	retf	;@051F8
S446	ends

S51F	segment byte public 'CODE'
	assume	cs:S51F
L051F9	dw	S6FF	;@051F9
	dw	DGROUP
	db	45h, 4Dh, 4Dh, 58h, 58h, 58h, 58h, 30h, 0, 55h, 8Bh, 0ECh, 81h, 0ECh, 2, 1
	db	1Eh, 2Eh, 8Eh, 1Eh, 9, 0, 56h, 57h, 0F6h, 6, 18h, 0, 1, 74h, 10h, 0F6h
	db	6, 18h, 0, 2, 75h, 3, 0EBh, 6Fh, 90h, 0A1h, 16h, 0, 0E9h, 85h, 0, 1Eh
	db	0Eh, 1Fh, 0BAh, 0Dh, 0, 0B8h, 0, 3Dh, 0CDh, 21h, 1Fh, 8Bh, 0D8h, 72h, 22h, 0B8h
	db	0, 44h, 0CDh, 21h, 72h, 17h, 0F7h, 0C2h, 80h, 0, 74h, 11h, 0B8h, 7, 44h, 0CDh
	db	21h, 72h, 0Ah, 50h, 0B4h, 3Eh, 0CDh, 21h, 58h, 3Ch, 0FFh, 74h, 7, 0B4h, 3Eh, 0CDh
	db	21h, 0EBh, 4Ah, 90h, 0B8h, 67h, 35h, 0CDh, 21h, 8Ch, 0C0h, 0Bh, 0C3h, 74h, 0F2h, 0B4h
	db	40h, 0CDh, 67h, 0Ah, 0E4h, 75h, 0EAh, 0C6h, 6, 18h, 0, 1, 0B4h, 46h, 0CDh, 67h
	db	0Ah, 0E4h, 75h, 0DDh, 3Ch, 32h, 72h, 0D9h, 0A2h, 19h, 0, 0B4h, 41h, 0CDh, 67h, 0Ah
	db	0E4h, 75h, 0CEh, 89h, 1Eh, 10h, 0, 0B4h, 42h, 0CDh, 67h, 0Ah, 0E4h, 75h, 0Eh, 89h
	db	1Eh, 16h, 0, 0C7h, 6, 12h, 0, 0FFh, 0FFh, 8Bh, 0C3h, 0EBh, 7, 33h, 0C0h, 0C6h
	db	6, 18h, 0, 0, 5Fh, 5Eh, 1Fh, 8Bh, 0E5h, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 2Eh
	db	8Eh, 1Eh, 9, 0, 0F6h, 6, 18h, 0, 1, 75h, 3, 0EBh, 4Bh, 90h, 0F6h, 6
	db	18h, 0, 2, 74h, 5, 33h, 0C0h, 0EBh, 42h, 90h, 80h, 0Eh, 18h, 0, 2, 8Bh
	db	46h, 8, 0A3h, 14h, 0, 8Bh, 5Eh, 6, 89h, 1Eh, 16h, 0, 8Bh, 56h, 0Ah, 0Bh
	db	0D2h, 75h, 0Dh, 0B4h, 43h, 0CDh, 67h, 0Ah, 0E4h, 75h, 1Dh, 80h, 0Eh, 18h, 0, 4
	db	89h, 16h, 12h, 0, 0B4h, 47h, 0CDh, 67h, 0Ah, 0E4h, 75h, 0Ch, 8Bh, 16h, 12h, 0
	db	0B4h, 48h, 0CDh, 67h, 8Ah, 0C4h, 0EBh, 3, 0B8h, 0FFh, 0FFh, 1Fh, 5Dh, 0CAh, 6, 0
	db	55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh, 1Eh, 9, 0, 0F6h, 6, 18h, 0, 4, 74h, 17h
	db	8Bh, 16h, 12h, 0, 0Bh, 0D2h, 78h, 0Fh, 0B4h, 45h, 0CDh, 67h, 0C7h, 6, 12h, 0
	db	0FFh, 0FFh, 0C6h, 6, 18h, 0, 0, 1Fh, 5Dh, 0CBh
L05347:	push	bp	;@05347
	mov	bp, sp	;@05348
	sub	sp, 22h	;@0534A
	push	ds	;@0534D
	mov	ds, word ptr cs:L051F9	;@0534E
	push	si	;@05353
	push	di	;@05354
	test	byte ptr ds:[22h], 1	;@05355
	je	@@1	;@0535A
	test	byte ptr ds:[22h], 2	;@0535C
	je	@@2	;@05361
	db	0E9h, 0F5h, 1	; jmp @@19	;@05363
@@1:	mov	byte ptr ds:[22h], 1	;@05366
@@2:	mov	word ptr ds:[1Ah], 0	;@0536B
	mov	word ptr ds:[1Ch], 10h	;@05371
	mov	word ptr ds:[1Eh], 0	;@05377
	mov	word ptr ds:[20h], 10h	;@0537D
	push	sp	;@05383
	pop	ax	;@05384
	cmp	ax, sp	;@05385
	jne	@@3	;@05387
	mov	ah, 30h	;@05389
	int	21h	;@0538B
	cmp	al, 0Ah	;@0538D
	jb	@@4	;@0538F
@@3:	db	0E9h, 0D8h, 1	; jmp @@20	;@05391
@@4:	xchg	al, ah	;@05394
	mov	word ptr [bp-22h], ax	;@05396
	mov	ax, 0F000h	;@05399
	mov	es, ax	;@0539C
	mov	al, byte ptr es:[0FFFEh]	;@0539E
	cmp	al, 0FCh	;@053A2
	ja	@@3	;@053A4
	cmp	al, 0FBh	;@053A6
	je	@@3	;@053A8
	cmp	al, 0F9h	;@053AA
	je	@@3	;@053AC
	cmp	word ptr [bp-22h], 31h	;@053AE
	jae	@@6	;@053B2
@@5:	jmp	@@9	;@053B4
@@6:	mov	ax, 4300h	;@053B7
	int	2Fh	;@053BA
	cmp	al, 80h	;@053BC
	jne	@@5	;@053BE
	mov	ax, 4310h	;@053C0
	int	2Fh	;@053C3
	mov	word ptr ds:[23h], bx	;@053C5
	mov	word ptr ds:[25h], es	;@053C9
	xor	ax, ax	;@053CD
	call	dword ptr ds:[23h]	;@053CF
	cmp	ah, 2	;@053D3
	jb	@@9	;@053D6
	mov	ah, 8	;@053D8
	call	dword ptr ds:[23h]	;@053DA
	or	ax, ax	;@053DE
	je	@@8	;@053E0
	mov	si, ax	;@053E2
	xchg	ax, dx	;@053E4
	mov	ah, 9	;@053E5
	call	dword ptr ds:[23h]	;@053E7
	or	ax, ax	;@053EB
	je	@@8	;@053ED
	mov	word ptr ds:[27h], dx	;@053EF
	mov	ah, 0Ch	;@053F3
	call	dword ptr ds:[23h]	;@053F5
	or	ax, ax	;@053F9
	je	@@7	;@053FB
	mov	word ptr ds:[1Ah], bx	;@053FD
	mov	word ptr ds:[1Ch], dx	;@05401
	mov	ax, 400h	;@05405
	mul	si	;@05408
	add	ax, word ptr ds:[1Ah]	;@0540A
	adc	dx, word ptr ds:[1Ch]	;@0540E
	mov	word ptr ds:[1Eh], ax	;@05412
	mov	word ptr ds:[20h], dx	;@05415
@@7:	mov	ah, 0Dh	;@05419
	mov	dx, word ptr ds:[27h]	;@0541B
	call	dword ptr ds:[23h]	;@0541F
	mov	ah, 0Ah	;@05423
	mov	dx, word ptr ds:[27h]	;@05425
	call	dword ptr ds:[23h]	;@05429
	mov	word ptr ds:[27h], 0	;@0542D
@@8:	db	0E9h, 25h, 1	; jmp @@19	;@05433
@@9:	push	ds	;@05436
	push	cs	;@05437
	pop	ds	;@05438
	mov	dx, 0Dh	;@05439
	mov	ax, 3D00h	;@0543C
	int	21h	;@0543F
	pop	ds	;@05441
	mov	bx, ax	;@05442
	jb	@@11	;@05444
	mov	ax, 4400h	;@05446
	int	21h	;@05449
	jb	@@10	;@0544B
	test	dx, 80h	;@0544D
	je	@@10	;@05451
	mov	ax, 4407h	;@05453
	int	21h	;@05456
	jb	@@10	;@05458
	push	ax	;@0545A
	mov	ah, 3Eh	;@0545B
	int	21h	;@0545D
	pop	ax	;@0545F
	cmp	al, 0FFh	;@05460
	je	@@12	;@05462
@@10:	mov	ah, 3Eh	;@05464
	int	21h	;@05466
@@11:	jmp	@@13	;@05468
@@12:	mov	ax, 3567h	;@0546B
	int	21h	;@0546E
	mov	ax, es	;@05470
	or	ax, bx	;@05472
	je	@@13	;@05474
	mov	ax, 0DE00h	;@05476
	int	67h	;@05479
	shl	ax, 1	;@0547B
	jb	@@13	;@0547D
	mov	bx, 1	;@0547F
	mov	ah, 43h	;@05482
	int	67h	;@05484
	shl	ax, 1	;@05486
	jb	@@13	;@05488
	push	dx	;@0548A
	mov	ah, 42h	;@0548B
	int	67h	;@0548D
	pop	dx	;@0548F
	push	bx	;@05490
	mov	ah, 45h	;@05491
	int	67h	;@05493
	pop	bx	;@05495
	inc	bx	;@05496
	mov	ax, 4000h	;@05497
	mul	bx	;@0549A
	mov	bx, 0	;@0549C
	mov	cx, 100h	;@0549F
	mov	word ptr ds:[20h], cx	;@054A2
	sub	bx, ax	;@054A6
	sbb	cx, dx	;@054A8
	mov	word ptr ds:[1Ah], bx	;@054AA
	mov	word ptr ds:[1Ch], cx	;@054AE
	db	0E9h, 0BAh, 0	; jmp @@21	;@054B2
@@13:	mov	ah, 88h	;@054B5
	int	15h	;@054B7
	or	ax, ax	;@054B9
	jne	@@15	;@054BB
@@14:	db	0E9h, 0ACh, 0	; jmp @@20	;@054BD
@@15:	mov	dx, 400h	;@054C0
	mul	dx	;@054C3
	add	dl, 10h	;@054C5
	mov	word ptr ds:[1Eh], ax	;@054C8
	mov	word ptr ds:[20h], dx	;@054CB
	mov	cx, word ptr ds:[23h]	;@054CF
	or	cx, word ptr ds:[25h]	;@054D3
	jcxz	@@16	;@054D7
	mov	byte ptr ds:[1Ch], 11h	;@054D9
	mov	word ptr ds:[1Ah], 0	;@054DE
@@16:	mov	ax, ss	;@054E4
	mov	dx, 10h	;@054E6
	mul	dx	;@054E9
	lea	bx, [bp-20h]	;@054EB
	xor	cx, cx	;@054EE
	add	bx, ax	;@054F0
	adc	cx, dx	;@054F2
	mov	ax, 0	;@054F4
	mov	dx, 10h	;@054F7
	mov	si, 20h	;@054FA
	xor	di, di	;@054FD
	db	0E8h, 0A0h, 1	; call @@22	;@054FF
	jb	@@14	;@05502
	lea	di, [bp-1Dh]	;@05504
	push	ss	;@05507
	pop	es	;@05508
	db	8Dh, 36h, 0, 0	; lea si, ds:[0]	;@05509
	db	0B9h, 5, 0	; mov cx, 5	;@0550D
	cld	;@05510
	repe cmpsb	;@05511
	jne	@@17	;@05513
	mov	ax, word ptr [bp-15h]	;@05515
	mul	word ptr [bp-0Dh]	;@05518
	add	dl, 10h	;@0551B
	mov	word ptr ds:[1Ah], ax	;@0551E
	mov	byte ptr ds:[1Ch], dl	;@05521
@@17:	xor	ax, ax	;@05525
	mov	es, ax	;@05527
	mov	es, word ptr es:[66h]	;@05529
	mov	di, 12h	;@0552E
	db	8Dh, 36h, 0, 0	; lea si, ds:[0]	;@05531
	db	0B9h, 5, 0	; mov cx, 5	;@05535
	cld	;@05538
	repe cmpsb	;@05539
	jne	@@19	;@0553B
	mov	ax, word ptr es:[2Ch]	;@0553D
	mov	dl, byte ptr es:[2Eh]	;@05541
	cmp	dl, byte ptr ds:[1Ch]	;@05546
	jb	@@19	;@0554A
	ja	@@18	;@0554C
	cmp	ax, word ptr ds:[1Ah]	;@0554E
	jbe	@@19	;@05552
@@18:	mov	word ptr ds:[1Ah], ax	;@05554
	mov	byte ptr ds:[1Ch], dl	;@05557
@@19:	mov	ax, word ptr ds:[1Eh]	;@0555B
	mov	dx, word ptr ds:[20h]	;@0555E
	sub	ax, word ptr ds:[1Ah]	;@05562
	sbb	dx, word ptr ds:[1Ch]	;@05566
	jmp	short @@21	;@0556A
@@20:	xor	ax, ax	;@0556C
	cwd	;@0556E
@@21:	pop	di	;@0556F
	pop	si	;@05570
	pop	ds	;@05571
	mov	sp, bp	;@05572
	pop	bp	;@05574
	retf	;@05575
	db	55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh, 1Eh, 9, 0, 56h, 57h, 0F6h, 6, 22h, 0, 1	;@05576
	db	75h, 3, 0E9h, 0B9h, 0, 0F6h, 6, 22h, 0, 2, 74h, 5, 33h, 0C0h, 0E9h, 0B0h
	db	0, 80h, 0Eh, 22h, 0, 2, 8Bh, 46h, 0Ah, 8Bh, 56h, 0Ch, 8Bh, 76h, 6, 8Bh
	db	7Eh, 8, 8Bh, 1Eh, 23h, 0, 0Bh, 1Eh, 25h, 0, 74h, 43h, 8Bh, 0C6h, 8Bh, 0D7h
	db	5, 0FFh, 3, 83h, 0D2h, 0, 0BBh, 0, 4, 0F7h, 0F3h, 92h, 0B4h, 9, 0FFh, 1Eh
	db	23h, 0, 0Bh, 0C0h, 74h, 26h, 89h, 16h, 27h, 0, 0B4h, 0Ch, 0FFh, 1Eh, 23h, 0
	db	0Bh, 0C0h, 74h, 18h, 89h, 1Eh, 1Ah, 0, 89h, 16h, 1Ch, 0, 89h, 1Eh, 29h, 0
	db	89h, 16h, 2Bh, 0, 8Bh, 0C3h, 3, 0C6h, 13h, 0D7h, 0EBh, 47h, 0EBh, 50h, 90h, 0A3h
	db	1Ah, 0, 89h, 16h, 1Ch, 0, 33h, 0DBh, 8Eh, 0C3h, 1Eh, 0BBh
	dw	S707
	db	8Eh, 0DBh, 26h, 8Bh, 1Eh, 64h, 0, 89h, 1Eh, 2Fh, 0, 26h, 8Bh, 1Eh, 66h, 0
	db	89h, 1Eh, 31h, 0, 26h, 0C7h, 6, 64h, 0, 3Fh, 0, 26h, 0C7h, 6, 66h, 0
	dw	S707
	db	0A3h, 3Ah, 0, 88h, 16h, 3Ch, 0, 3, 0C6h, 13h, 0D7h, 0A3h, 2Ch, 0, 88h, 16h
	db	2Eh, 0, 1Fh, 0A3h, 1Eh, 0, 89h, 16h, 20h, 0, 33h, 0C0h, 0EBh, 3, 0B8h, 0FFh
	db	0FFh, 5Fh, 5Eh, 1Fh, 5Dh, 0CAh, 8, 0, 55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh, 1Eh, 9
	db	0, 80h, 3Eh, 22h, 0, 0, 74h, 41h, 83h, 3Eh, 27h, 0, 0, 74h, 16h, 0B4h
	db	0Dh, 8Bh, 16h, 27h, 0, 0FFh, 1Eh, 23h, 0, 0B4h, 0Ah, 8Bh, 16h, 27h, 0, 0FFh
	db	1Eh, 23h, 0, 0EBh, 24h, 33h, 0C0h, 8Eh, 0C0h, 26h, 0A1h, 66h, 0, 3Dh
	dw	S707
	db	75h, 17h, 1Eh, 8Eh, 0D8h, 0A1h, 2Fh, 0, 26h, 0A3h, 64h, 0, 0A1h, 31h, 0, 26h
	db	0A3h, 66h, 0, 1Fh, 0C6h, 6, 22h, 0, 0, 1Fh, 5Dh, 0CBh
@@22:	push	ds	;@056A2
	push	es	;@056A3
	add	si, 1	;@056A4
	adc	di, 0	;@056A7
	and	si, -2	;@056AA
	cld	;@056AD
	mov	ds, word ptr cs:L051F9	;@056AE
	cmp	word ptr ds:[27h], 0	;@056B3
	db	74h, 6Ah	; je @@27	;@056B8
	mov	word ptr ds:[2Dh], si	;@056BA
	mov	word ptr ds:[2Fh], di	;@056BE
	cmp	dl, 10h	;@056C2
	jb	@@23	;@056C5
	mov	si, word ptr ds:[27h]	;@056C7
	mov	word ptr ds:[31h], si	;@056CB
	sub	ax, word ptr ds:[29h]	;@056CF
	sbb	dx, word ptr ds:[2Bh]	;@056D3
	jmp	@@24	;@056D7
@@23:	mov	word ptr ds:[31h], 0	;@056DA
	ror	dx, 4	;@056E0
@@24:	mov	word ptr ds:[33h], ax	;@056E3
	mov	word ptr ds:[35h], dx	;@056E6
	cmp	cl, 10h	;@056EA
	jb	@@25	;@056ED
	mov	si, word ptr ds:[27h]	;@056EF
	mov	word ptr ds:[37h], si	;@056F3
	sub	bx, word ptr ds:[29h]	;@056F7
	sbb	cx, word ptr ds:[2Bh]	;@056FB
	jmp	@@26	;@056FF
@@25:	mov	word ptr ds:[37h], 0	;@05702
	ror	cx, 4	;@05708
@@26:	mov	word ptr ds:[39h], bx	;@0570B
	mov	word ptr ds:[3Bh], cx	;@0570F
	mov	ah, 0Bh	;@05713
	db	8Dh, 36h, 2Dh, 0	; lea si, ds:[2Dh]	;@05715
	db	0FFh, 1Eh, 23h, 0	; call dword ptr ds:[23h]	;@05719
	or	ax, ax	;@0571D
	db	75h, 29h	; jne @@29	;@0571F
	stc	;@05721
	db	0EBh, 21h	; jmp short @@28	;@05722
@@27:	shr	di, 1	;@05724
	rcr	si, 1	;@05726
	mov	word ptr ds:[3Fh], ax	;@05728
	mov	byte ptr ds:[41h], dl	;@0572B
	mov	word ptr ds:[47h], bx	;@0572F
	mov	byte ptr ds:[49h], cl	;@05733
	mov	cx, si	;@05737
	db	8Dh, 36h, 2Dh, 0	; lea si, ds:[2Dh]	;@05739
	db	1Eh	; push ds	;@0573D
	pop	es	;@0573E
	mov	ah, 87h	;@0573F
	int	15h	;@05741
	jae	@@29	;@05743
@@28:	sbb	ax, ax	;@05745
	stc	;@05747
	jmp	short @@30	;@05748
@@29:	xor	ax, ax	;@0574A
@@30:	pop	es	;@0574C
	pop	ds	;@0574D
	ret	;@0574E
	db	0	;@0574F
S51F	ends
	end
