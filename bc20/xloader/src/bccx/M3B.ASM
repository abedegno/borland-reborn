	.286p
	locals
	public	L05012
	public	L05060
	public	L050CB
	public	L05111
	public	L0526F
	public	L05292
	public	L052FB
	public	L0531E
	public	L054E5
	public	L05508
	public	L056C7
	public	S6F2_START
	public	_DATA_START
DGROUP	group	_DATA,_BSS
	extrn	S46C_START:byte

S737	segment para public 'CODE'
	assume	cs:S737
	db	'VDISK', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0	;@07370
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 93h, 0, 0, 0, 0, 0, 0, 0, 93h, 0, 0, 0FFh
	db	0FFh, 0, 0, 0, 92h, 0, 0, 0FFh, 0FFh, 0, 0, 0, 92h, 0, 0, 0, 0
	db	0, 0, 0, 93h, 0, 0, 0, 0, 0, 0, 0, 93h, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0
S737	ends

S73F	segment para public 'CODE'
	assume	cs:S73F
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'VDISK FAKE'	;@073F0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2Eh, 0FFh, 2Eh, 2Fh
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
S73F	ends

S6F2	segment para public 'CODE'
	assume	cs:S6F2
S6F2_START	db	440h dup (0)	;@06F20
S6F2	ends

_DATA	segment byte public 'DATA'
_DATA_START	db	0, '$*$*$*', 1, 0, 0, 2, 'BCCX', 0, 13h, 13h, 'TKERNEL.EXE', 0	;@074D1
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 'BCCX.EXE', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'BCCX.OVY'
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 'Error:  %s is allocated %lu KB but requires %u KB.'
	db	0Ah, 0, 'Error:  %lu KB of extended memory is available, bu', 't %u KB is required.'
	db	0Ah, 0, 'PATH=%s%s', 0, 'PATH', 0, 'Error:  Cannot locate %s in PATH.'
	db	0Ah, 0, '/Qx', 0, '-Qx', 0, 'Warning:  %s is already loaded; -Qx ignored.'
	db	0Ah, 0, ' STARTKILO=', 0, 'Error:  Application requires %u KB of extended mem'
	db	'ory.', 0Ah, 0, ' KILOS=', 0, ' HI=YES q 1', 0, 'Error:  Cannot install %s.'
	db	0Ah, 0, 'Error:  Cannot load %s because %s is already in us', 65h
	db	2Eh, 0Ah, 0, 'Error:  Could not initialize %s.', 0Ah, 0, 'Error:  Could not create task because %s is alread'
	db	'y in use.', 0Ah, 0, 'Error:  Cannot create task.', 0Ah, 0, 'Internal error:  unhandled server function %04X.'
	db	0, 0Ah, 'Unexpected interrupt/exception %02X', 0, 0Ah, 'Unknown task exit code %04X'
	db	0, 'q 1 REM', 0, 'Error:  Cannot remove %s.', 0Ah, 0, ' at %04X:%04X.'
	db	0Ah, 0, 0, 0, 0, 0, 0
_DATA	ends

_BSS	segment word public 'BSS'
	db	2CEh dup (?)	;@07AD2
_BSS	ends

S47E	segment para public 'CODE'
	assume	cs:S47E
L047E0	db	0FFh, 0FFh, 0FFh, 0FFh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@047E0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 'EMMXXXX0', 0, 'HUMMINGB'
	db	0, 'AIA_OS  ', 0, 0, 0, 0, 0, 0, 0, 0, 0
L0489A:	push	dx	;@0489A
	push	ds	;@0489B
	db	0E8h, 52h, 6	; call L04EF1	;@0489C
	push	cs	;@0489F
	pop	ds	;@048A0
	test	word ptr cs:L047E0+2, 1	;@048A1
	je	@@1	;@048A8
	mov	ax, 0FBA1h	;@048AA
	call	@@11	;@048AD
	jb	@@4	;@048B0
@@1:	test	word ptr cs:L047E0+2, 2	;@048B2
	je	@@2	;@048B9
	mov	dx, 97h	;@048BB
	call	@@5	;@048BE
	jb	@@4	;@048C1
@@2:	test	word ptr cs:L047E0+2, 2	;@048C3
	je	@@3	;@048CA
	mov	dx, 0A0h	;@048CC
	call	@@5	;@048CF
	jb	@@4	;@048D2
@@3:	test	word ptr cs:L047E0+2, 1	;@048D4
	je	@@4	;@048DB
	mov	dx, 0A9h	;@048DD
	call	@@5	;@048E0
	jb	@@4	;@048E3
@@4:	pop	ds	;@048E5
	pop	dx	;@048E6
	ret	;@048E7
@@5:	push	ax	;@048E8
	push	bx	;@048E9
	push	cx	;@048EA
	push	dx	;@048EB
	push	si	;@048EC
	xor	ax, ax	;@048ED
	mov	ah, 3Dh	;@048EF
	int	21h	;@048F1
	jae	@@6	;@048F3
	jmp	@@9	;@048F5
@@6:	mov	bx, ax	;@048F8
	mov	al, 3	;@048FA
	mov	cx, 8	;@048FC
	mov	dx, 0B2h	;@048FF
	mov	si, dx	;@04902
	mov	byte ptr [si], 82h	;@04904
	mov	ah, 44h	;@04907
	int	21h	;@04909
	mov	cx, 0	;@0490B
	mov	ax, word ptr ds:[0B2h]	;@0490E
	cmp	ax, 4149h	;@04911
	jne	@@7	;@04914
	mov	ax, word ptr ds:[0B4h]	;@04916
	cmp	ax, 4842h	;@04919
	jne	@@7	;@0491C
	mov	ax, word ptr ds:[0B6h]	;@0491E
	mov	word ptr ds:[4Bh], ax	;@04921
	mov	ax, word ptr ds:[0B8h]	;@04924
	mov	word ptr ds:[4Dh], ax	;@04927
	mov	byte ptr cs:L047E0, 0	;@0492A
	mov	byte ptr cs:L047E0+1, 0	;@04930
	mov	cx, 0FFFFh	;@04936
@@7:	mov	ah, 3Eh	;@04939
	int	21h	;@0493B
	cmp	cx, 0	;@0493D
	jne	@@8	;@04940
	jmp	short @@9	;@04942
@@8:	stc	;@04944
	jmp	short @@10	;@04945
@@9:	clc	;@04947
@@10:	pop	si	;@04948
	pop	dx	;@04949
	pop	cx	;@0494A
	pop	bx	;@0494B
	pop	ax	;@0494C
	ret	;@0494D
@@11:	push	bx	;@0494E
	push	es	;@0494F
	push	di	;@04950
	mov	word ptr ds:[0B2h], 0	;@04951
	mov	word ptr ds:[0B4h], 0	;@04957
	mov	bx, 82h	;@0495D
	push	cs	;@04960
	pop	es	;@04961
	mov	di, 0B2h	;@04962
	int	2Fh	;@04965
	jae	@@13	;@04967
@@12:	clc	;@04969
	jmp	short @@14	;@0496A
@@13:	cmp	word ptr ds:[0B2h], 4149h	;@0496C
	jne	@@12	;@04972
	cmp	word ptr ds:[0B4h], 4842h	;@04974
	jne	@@12	;@0497A
	mov	ax, word ptr ds:[0B6h]	;@0497C
	mov	word ptr ds:[4Bh], ax	;@0497F
	mov	ax, word ptr ds:[0B8h]	;@04982
	mov	word ptr ds:[4Dh], ax	;@04985
	mov	byte ptr cs:L047E0, 0	;@04988
	mov	byte ptr cs:L047E0+1, 0	;@0498E
	stc	;@04994
@@14:	pop	di	;@04995
	pop	es	;@04996
	pop	bx	;@04997
	ret	;@04998
L04999:	push	ds	;@04999
	push	es	;@0499A
	push	si	;@0499B
	push	di	;@0499C
	push	cs	;@0499D
	pop	ds	;@0499E
	db	0E8h, 69h, 5	; call L04F0B	;@0499F
	jae	@@1	;@049A2
	pop	di	;@049A4
	pop	si	;@049A5
	pop	es	;@049A6
	pop	ds	;@049A7
	ret	;@049A8
@@1:	db	0E8h, 93h, 4	; call L04E3F	;@049A9
	mov	ax, word ptr ds:[8Dh]	;@049AC
	mov	word ptr cs:L047E0+12, ax	;@049AF
	clc	;@049B3
	pop	di	;@049B4
	pop	si	;@049B5
	pop	es	;@049B6
	pop	ds	;@049B7
	ret	;@049B8
L049B9:	push	es	;@049B9
	push	ds	;@049BA
	push	si	;@049BB
	mov	word ptr ds:[53h], bx	;@049BC
	mov	word ptr ds:[55h], ax	;@049C0
	mov	cx, ax	;@049C3
	mov	dx, bx	;@049C5
	mov	bx, word ptr ds:[95h]	;@049C7
	xor	al, al	;@049CB
	mov	ah, 42h	;@049CD
	int	21h	;@049CF
	db	73h, 16h	; jae @@2	;@049D1
	push	cs	;@049D3
	pop	ds	;@049D4
	db	0EBh, 0Ch	; jmp @@1	;@049D5
	db	90h, 'seek error$'	;@049D7
@@1:	db	0BAh, 0F8h, 1	; mov dx, 1F8h	;@049E3
	db	0EBh, 6Dh	; jmp L04A55	;@049E6
	db	90h	;@049E8
@@2:	mov	cx, 24h	;@049E9
	mov	dx, 67h	;@049EC
	mov	ah, 3Fh	;@049EF
	int	21h	;@049F1
	db	73h, 21h	; jae @@4	;@049F3
	push	cs	;@049F5
	pop	ds	;@049F6
	db	0EBh, 17h	; jmp @@3	;@049F7
	db	90h, 'Failed reading header$'	;@049F9
@@3:	db	0BAh, 1Ah, 2	; mov dx, 21Ah	;@04A10
	db	0EBh, 40h	; jmp L04A55	;@04A13
	db	90h	;@04A15
@@4:	mov	ax, word ptr ds:[67h]	;@04A16
	cmp	ax, 5A4Dh	;@04A19
	db	74h, 25h	; je @@6	;@04A1C
	push	cs	;@04A1E
	pop	ds	;@04A1F
	db	0EBh, 1Bh	; jmp @@5	;@04A20
	db	90h, 'Not an exe file signature$'	;@04A22
@@5:	db	0BAh, 43h, 2	; mov dx, 243h	;@04A3D
	jmp	L04A55	;@04A40
@@6:	call	L04A5E	;@04A43
	mov	ax, word ptr ds:[7Dh]	;@04A46
	add	ax, word ptr ds:[8Dh]	;@04A49
	mov	bx, word ptr ds:[7Bh]	;@04A4D
	pop	si	;@04A51
	pop	ds	;@04A52
	pop	es	;@04A53
	ret	;@04A54
L04A55:	mov	ah, 9	;@04A55
	int	21h	;@04A57
	mov	ah, 4Ch	;@04A59
	int	21h	;@04A5B
	hlt	;@04A5D
L04A5E:	call	@@4	;@04A5E
	db	0E8h, 0Bh, 1	; call @@13	;@04A61
	db	0E8h, 25h, 2	; call @@24	;@04A64
	ret	;@04A67
@@1:	mov	bx, word ptr ds:[6Fh]	;@04A68
	mov	al, 4	;@04A6C
	db	0E8h, 0C9h, 0Ah	; call L0553A	;@04A6E
	push	ax	;@04A71
	push	bx	;@04A72
	mov	bx, word ptr ds:[6Bh]	;@04A73
	cmp	word ptr ds:[69h], 0	;@04A77
	jne	@@2	;@04A7C
	mov	al, 9	;@04A7E
	db	0E8h, 0B7h, 0Ah	; call L0553A	;@04A80
	jmp	@@3	;@04A83
@@2:	dec	bx	;@04A86
	mov	al, 9	;@04A87
	db	0E8h, 0AEh, 0Ah	; call L0553A	;@04A89
	add	bx, word ptr ds:[69h]	;@04A8C
	adc	ax, 0	;@04A90
@@3:	pop	dx	;@04A93
	pop	cx	;@04A94
	sub	bx, dx	;@04A95
	sbb	ax, cx	;@04A97
	ret	;@04A99
@@4:	push	es	;@04A9A
	call	@@1	;@04A9B
	mov	word ptr ds:[3Ch], bx	;@04A9E
	mov	word ptr ds:[3Eh], ax	;@04AA2
	push	ax	;@04AA5
	push	bx	;@04AA6
	mov	bx, word ptr ds:[71h]	;@04AA7
	mov	al, 4	;@04AAB
	db	0E8h, 8Ah, 0Ah	; call L0553A	;@04AAD
	pop	dx	;@04AB0
	pop	cx	;@04AB1
	add	bx, dx	;@04AB2
	adc	ax, cx	;@04AB4
	add	bx, 0Fh	;@04AB6
	adc	ax, 0	;@04AB9
	push	cx	;@04ABC
	mov	cl, 4	;@04ABD
	db	0E8h, 69h, 0Ah	; call L0552B	;@04ABF
	pop	cx	;@04AC2
	mov	word ptr ds:[8Fh], bx	;@04AC3
	add	bx, word ptr ds:[8Bh]	;@04AC7
	mov	cx, bx	;@04ACB
	cmp	byte ptr ds:[4Ah], 0	;@04ACD
	jne	@@5	;@04AD2
	db	0EBh, 4Bh	; jmp @@9	;@04AD4
	db	90h	;@04AD6
@@5:	mov	ax, word ptr ds:[48h]	;@04AD7
	cmp	ax, 0	;@04ADA
	jne	@@6	;@04ADD
	db	0EBh, 40h	; jmp @@9	;@04ADF
	db	90h	;@04AE1
@@6:	sub	ax, bx	;@04AE2
	db	75h, 9	; jne @@7	;@04AE4
	mov	ax, word ptr ds:[46h]	;@04AE6
	db	0EBh, 6Eh	; jmp @@11	;@04AE9
	db	90h, 0EBh, 33h, 90h	;@04AEB
@@7:	db	0A1h, 46h, 0	; mov ax, word ptr ds:[46h]	;@04AEF
	mov	es, ax	;@04AF2
	mov	ah, 49h	;@04AF4
	nosmart
	nosmart
	call	far ptr L0556C	;@04AF6
	smart
	smart
	db	73h, 24h	; jae @@9	;@04AFB
	push	cs	;@04AFD
	pop	ds	;@04AFE
	db	0EBh, 1Ah	; jmp @@8	;@04AFF
	db	90h, 'Problem releasing memory$'	;@04B01
@@8:	db	0BAh, 22h, 3	; mov dx, 322h	;@04B1B
	jmp	L04A55	;@04B1E
@@9:	mov	ah, 48h	;@04B21
	nosmart
	nosmart
	call	far ptr L05552	;@04B23
	smart
	smart
	db	73h, 2Fh	; jae @@11	;@04B28
	push	cs	;@04B2A
	pop	ds	;@04B2B
	db	0EBh, 25h	; jmp @@10	;@04B2C
	db	90h, 'Insufficient memory to load overlay$'	;@04B2E
@@10:	db	0BAh, 4Fh, 3	; mov dx, 34Fh	;@04B53
	jmp	L04A55	;@04B56
@@11:	cmp	byte ptr ds:[4Ah], 0	;@04B59
	je	@@12	;@04B5E
	mov	word ptr ds:[46h], ax	;@04B60
	mov	word ptr ds:[48h], cx	;@04B63
@@12:	mov	word ptr ds:[8Dh], ax	;@04B67
	mov	word ptr ds:[44h], ax	;@04B6A
	pop	es	;@04B6D
	ret	;@04B6E
@@13:	push	ds	;@04B6F
	mov	bx, word ptr ds:[53h]	;@04B70
	mov	ax, word ptr ds:[55h]	;@04B74
	push	ax	;@04B77
	push	bx	;@04B78
	mov	bx, word ptr ds:[6Fh]	;@04B79
	xor	ax, ax	;@04B7D
	mov	al, 4	;@04B7F
	db	0E8h, 0B6h, 9	; call L0553A	;@04B81
	pop	dx	;@04B84
	pop	cx	;@04B85
	add	bx, dx	;@04B86
	adc	ax, cx	;@04B88
	mov	cx, ax	;@04B8A
	mov	dx, bx	;@04B8C
	xor	al, al	;@04B8E
	mov	bx, word ptr ds:[95h]	;@04B90
	mov	ah, 42h	;@04B94
	int	21h	;@04B96
	db	73h, 26h	; jae @@15	;@04B98
	push	cs	;@04B9A
	pop	ds	;@04B9B
	db	0EBh, 1Ch	; jmp @@14	;@04B9C
	db	90h, 'Cannot load kernel overlay$'	;@04B9E
@@14:	db	0BAh, 0BFh, 3	; mov dx, 3BFh	;@04BBA
	jmp	L04A55	;@04BBD
@@15:	mov	ax, word ptr ds:[8Dh]	;@04BC0
	mov	ds, ax	;@04BC3
	mov	bx, word ptr cs:L047E0+60	;@04BC5
	mov	ax, word ptr cs:L047E0+62	;@04BCA
	mov	word ptr cs:L047E0+56, bx	;@04BCE
	mov	word ptr cs:L047E0+58, ax	;@04BD3
@@16:	mov	bx, word ptr cs:L047E0+56	;@04BD7
	mov	ax, word ptr cs:L047E0+58	;@04BDC
	push	ax	;@04BE0
	push	bx	;@04BE1
	mov	bx, 2000h	;@04BE2
	xor	ax, ax	;@04BE5
	pop	dx	;@04BE7
	pop	cx	;@04BE8
	cmp	cx, ax	;@04BE9
	jne	@@17	;@04BEB
	cmp	dx, bx	;@04BED
	jae	@@18	;@04BEF
	mov	bx, dx	;@04BF1
	jmp	short @@18	;@04BF3
@@17:	ja	@@18	;@04BF5
	mov	ax, cx	;@04BF7
	mov	bx, dx	;@04BF9
@@18:	xor	cx, cx	;@04BFB
	mov	cx, bx	;@04BFD
	mov	bx, word ptr cs:L047E0+149	;@04BFF
	xor	dx, dx	;@04C04
	mov	ah, 3Fh	;@04C06
	int	21h	;@04C08
	db	73h, 26h	; jae @@20	;@04C0A
	push	cs	;@04C0C
	pop	ds	;@04C0D
	db	0EBh, 1Ch	; jmp @@19	;@04C0E
	db	90h, 'Cannot read kernel overlay$'	;@04C10
@@19:	db	0BAh, 31h, 4	; mov dx, 431h	;@04C2C
	jmp	L04A55	;@04C2F
@@20:	cmp	ax, cx	;@04C32
	db	74h, 28h	; je @@22	;@04C34
	push	cs	;@04C36
	pop	ds	;@04C37
	db	0EBh, 1Eh	; jmp @@21	;@04C38
	db	90h, 'Error reading kernel overlay$'	;@04C3A
@@21:	db	0BAh, 5Bh, 4	; mov dx, 45Bh	;@04C58
	jmp	L04A55	;@04C5B
@@22:	mov	bx, cx	;@04C5E
	xor	ax, ax	;@04C60
	push	ax	;@04C62
	push	bx	;@04C63
	mov	ax, ds	;@04C64
	add	ax, 200h	;@04C66
	mov	ds, ax	;@04C69
	mov	bx, word ptr cs:L047E0+56	;@04C6B
	mov	ax, word ptr cs:L047E0+58	;@04C70
	pop	dx	;@04C74
	pop	cx	;@04C75
	sub	bx, dx	;@04C76
	sbb	ax, cx	;@04C78
	mov	word ptr cs:L047E0+56, bx	;@04C7A
	mov	word ptr cs:L047E0+58, ax	;@04C7F
	or	ax, bx	;@04C83
	je	@@23	;@04C85
	jmp	@@16	;@04C87
@@23:	pop	ds	;@04C8A
	ret	;@04C8B
@@24:	mov	bx, word ptr ds:[53h]	;@04C8C
	mov	ax, word ptr ds:[55h]	;@04C90
	push	ax	;@04C93
	push	bx	;@04C94
	xor	ax, ax	;@04C95
	mov	bx, word ptr ds:[7Fh]	;@04C97
	pop	dx	;@04C9B
	pop	cx	;@04C9C
	add	bx, dx	;@04C9D
	adc	ax, cx	;@04C9F
	mov	cx, ax	;@04CA1
	mov	dx, bx	;@04CA3
	mov	bx, word ptr ds:[95h]	;@04CA5
	xor	ax, ax	;@04CA9
	mov	ah, 42h	;@04CAB
	int	21h	;@04CAD
@@25:	mov	dx, word ptr ds:[6Dh]	;@04CAF
	cmp	dx, 0	;@04CB3
	jne	@@26	;@04CB6
	ret	;@04CB8
@@26:	xor	cx, cx	;@04CB9
	mov	cx, 1	;@04CBB
	cmp	dx, cx	;@04CBE
	jge	@@27	;@04CC0
	mov	cx, dx	;@04CC2
@@27:	sub	word ptr ds:[6Dh], cx	;@04CC4
	shl	cx, 1	;@04CC8
	shl	cx, 1	;@04CCA
	mov	dx, 40h	;@04CCC
	mov	bx, word ptr ds:[95h]	;@04CCF
	mov	ah, 3Fh	;@04CD3
	int	21h	;@04CD5
	db	73h, 29h	; jae @@29	;@04CD7
	push	cs	;@04CD9
	pop	ds	;@04CDA
	db	0EBh, 1Fh	; jmp @@28	;@04CDB
	db	90h, 'Error reading relocation data$'	;@04CDD
@@28:	db	0BAh, 0FEh, 4	; mov dx, 4FEh	;@04CFC
	jmp	L04A55	;@04CFF
@@29:	cmp	ax, cx	;@04D02
	db	7Dh, 29h	; jge @@31	;@04D04
	push	cs	;@04D06
	pop	ds	;@04D07
	db	0EBh, 1Fh	; jmp @@30	;@04D08
	db	90h, 'Error reading relocation data$'	;@04D0A
@@30:	db	0BAh, 2Bh, 5	; mov dx, 52Bh	;@04D29
	jmp	L04A55	;@04D2C
@@31:	shr	cx, 1	;@04D2F
	shr	cx, 1	;@04D31
	xor	bx, bx	;@04D33
	mov	dx, word ptr ds:[44h]	;@04D35
@@32:	db	8Bh, 0B7h, 40h, 0	; mov si, word ptr [bx+40h]	;@04D39
	db	8Bh, 87h, 42h, 0	; mov ax, word ptr [bx+42h]	;@04D3D
	add	ax, dx	;@04D41
	mov	es, ax	;@04D43
	add	word ptr es:[si], dx	;@04D45
	add	bx, 4	;@04D48
	sub	cx, 1	;@04D4B
	jne	@@32	;@04D4E
	jmp	@@25	;@04D50
L04D53:	push	ds	;@04D53
	push	es	;@04D54
	push	si	;@04D55
	push	cs	;@04D56
	pop	ds	;@04D57
	cmp	word ptr ds:[95h], -1	;@04D58
	jne	@@1	;@04D5D
	call	L04F1A	;@04D5F
@@1:	nosmart	;@04D62
	call	far ptr L05060
	smart
	mov	si, ax	;@04D67
	mov	es, dx	;@04D69
	cmp	byte ptr es:[si+35h], 0	;@04D6B
	jne	@@2	;@04D70
	call	@@4	;@04D72
	db	0E8h, 0D9h, 1	; call L04F51	;@04D75
	jmp	@@3	;@04D78
@@2:	mov	ax, word ptr ds:[95h]	;@04D7B
	mov	word ptr es:[si+1Bh], ax	;@04D7E
	mov	bx, word ptr ds:[5Bh]	;@04D82
	mov	ax, word ptr ds:[5Dh]	;@04D86
	mov	word ptr es:[si+1Dh], bx	;@04D89
	mov	word ptr es:[si+1Fh], ax	;@04D8D
	mov	word ptr ds:[95h], 0FFFFh	;@04D91
@@3:	pop	si	;@04D97
	pop	es	;@04D98
	pop	ds	;@04D99
	ret	;@04D9A
@@4:	mov	bx, word ptr ds:[5Bh]	;@04D9B
	mov	ax, word ptr ds:[5Dh]	;@04D9F
	mov	byte ptr cs:L047E0+74, 1	;@04DA2
	call	L049B9	;@04DA8
	mov	byte ptr cs:L047E0+74, 0	;@04DAB
	mov	word ptr ds:[4Fh], bx	;@04DB1
	mov	word ptr ds:[51h], ax	;@04DB5
	mov	word ptr es:[si+13h], bx	;@04DB8
	mov	word ptr es:[si+15h], ax	;@04DBC
	mov	ax, word ptr cs:L047E0+141	;@04DC0
	mov	word ptr es:[si+17h], ax	;@04DC4
	mov	word ptr cs:L047E0+14, ax	;@04DC8
	mov	ax, word ptr cs:L047E0+143	;@04DCC
	mov	word ptr es:[si+19h], ax	;@04DD0
	ret	;@04DD4
L04DD5:	mov	dx, 14h	;@04DD5
	mov	cx, 24h	;@04DD8
	mov	bx, word ptr ds:[95h]	;@04DDB
	mov	ah, 3Fh	;@04DDF
	int	21h	;@04DE1
	jae	@@1	;@04DE3
	jmp	@@7	;@04DE5
@@1:	mov	bx, dx	;@04DE8
	mov	ax, word ptr [bx]	;@04DEA
	cmp	ax, 5A4Dh	;@04DEC
	je	@@2	;@04DEF
	jmp	@@7	;@04DF1
@@2:	mov	bx, word ptr ds:[1Ch]	;@04DF4
	cmp	bx, 20h	;@04DF8
	jg	@@3	;@04DFB
	jmp	@@7	;@04DFD
@@3:	sub	bx, 20h	;@04E00
	mov	al, 4	;@04E03
	db	0E8h, 32h, 7	; call L0553A	;@04E05
	mov	cx, ax	;@04E08
	mov	dx, bx	;@04E0A
	xor	al, al	;@04E0C
	mov	bx, word ptr ds:[95h]	;@04E0E
	mov	ah, 42h	;@04E12
	int	21h	;@04E14
	jae	@@4	;@04E16
	jmp	@@7	;@04E18
@@4:	mov	cx, 10h	;@04E1B
	mov	dx, 57h	;@04E1E
	mov	ah, 3Fh	;@04E21
	int	21h	;@04E23
	jae	@@5	;@04E25
	jmp	@@7	;@04E27
@@5:	cmp	word ptr ds:[57h], 4941h	;@04E2A
	je	@@6	;@04E30
	jmp	@@7	;@04E32
@@6:	mov	ax, 0	;@04E35
	jmp	@@8	;@04E38
@@7:	mov	ax, 0FFFFh	;@04E3B
@@8:	ret	;@04E3E
L04E3F:	mov	word ptr ds:[8Bh], 0	;@04E3F
	mov	bx, word ptr ds:[5Fh]	;@04E45
	mov	ax, word ptr ds:[61h]	;@04E49
	call	L049B9	;@04E4C
	xor	bx, bx	;@04E4F
	mov	word ptr ds:[4Bh], bx	;@04E51
	mov	word ptr ds:[4Dh], ax	;@04E55
	mov	byte ptr ds:[0], 0	;@04E58
	ret	;@04E5D
L04E5E:	push	es	;@04E5E
	mov	ah, 62h	;@04E5F
	int	21h	;@04E61
	mov	es, bx	;@04E63
	mov	ax, word ptr es:[2Ch]	;@04E65
	mov	es, ax	;@04E69
	xor	di, di	;@04E6B
	xor	al, al	;@04E6D
@@1:	mov	cx, 0FFFFh	;@04E6F
	repne scasb	;@04E72
	cmp	al, byte ptr es:[di]	;@04E74
	je	@@2	;@04E77
	jmp	@@1	;@04E79
@@2:	add	di, 3	;@04E7B
	mov	ax, es	;@04E7E
	mov	bx, di	;@04E80
	pop	es	;@04E82
	ret	;@04E83
L04E84:	call	L04E5E	;@04E84
	mov	word ptr ds:[91h], bx	;@04E87
	mov	word ptr ds:[93h], ax	;@04E8B
	call	@@1	;@04E8E
	ret	;@04E91
@@1:	mov	bx, word ptr ds:[91h]	;@04E92
	mov	ax, word ptr ds:[93h]	;@04E96
	push	ds	;@04E99
	mov	ds, ax	;@04E9A
	mov	dx, bx	;@04E9C
	xor	al, al	;@04E9E
	mov	ah, 3Dh	;@04EA0
	int	21h	;@04EA2
	pop	ds	;@04EA4
	jae	@@2	;@04EA5
	mov	ax, 0FFFFh	;@04EA7
	jmp	@@8	;@04EAA
@@2:	mov	word ptr ds:[95h], ax	;@04EAD
	mov	bx, ax	;@04EB0
	call	L04DD5	;@04EB2
	cmp	ax, 0FFFFh	;@04EB5
	jne	@@3	;@04EB8
	jmp	@@6	;@04EBA
@@3:	mov	bx, word ptr ds:[5Bh]	;@04EBD
	mov	ax, word ptr ds:[5Dh]	;@04EC1
	cmp	ax, 0FFFFh	;@04EC4
	jne	@@4	;@04EC7
	jmp	@@6	;@04EC9
@@4:	mov	bx, word ptr ds:[5Fh]	;@04ECC
	mov	ax, word ptr ds:[61h]	;@04ED0
	cmp	ax, 0FFFFh	;@04ED3
	jne	@@5	;@04ED6
	jmp	@@6	;@04ED8
@@5:	jmp	@@7	;@04EDB
@@6:	mov	bx, word ptr ds:[95h]	;@04EDE
	mov	ah, 3Eh	;@04EE2
	int	21h	;@04EE4
	mov	ax, 0FFFFh	;@04EE6
	jmp	@@8	;@04EE9
@@7:	mov	ax, word ptr ds:[95h]	;@04EEC
@@8:	pop	es	;@04EEF
	ret	;@04EF0
L04EF1:	push	ax	;@04EF1
	push	bx	;@04EF2
	push	cx	;@04EF3
	push	dx	;@04EF4
	mov	cx, 4149h	;@04EF5
	mov	dx, 413Fh	;@04EF8
	mov	ah, 2Bh	;@04EFB
	int	21h	;@04EFD
	cmp	al, 0FFh	;@04EFF
	jne	@@1	;@04F01
	jmp	@@1	;@04F03
@@1:	pop	dx	;@04F06
	pop	cx	;@04F07
	pop	bx	;@04F08
	pop	ax	;@04F09
	ret	;@04F0A
L04F0B:	call	L04EF1	;@04F0B
	call	L04E84	;@04F0E
	cmp	ax, 0FFFFh	;@04F11
	je	@@1	;@04F14
	clc	;@04F16
	ret	;@04F17
@@1:	stc	;@04F18
	ret	;@04F19
L04F1A:	mov	bx, word ptr ds:[91h]	;@04F1A
	mov	ax, word ptr ds:[93h]	;@04F1E
	push	ds	;@04F21
	mov	ds, ax	;@04F22
	mov	dx, bx	;@04F24
	xor	al, al	;@04F26
	mov	ah, 3Dh	;@04F28
	int	21h	;@04F2A
	db	73h, 1Eh	; jae @@2	;@04F2C
	push	cs	;@04F2E
	pop	ds	;@04F2F
	db	0EBh, 14h	; jmp @@1	;@04F30
	db	90h, 'Cannot open kernel$'	;@04F32
@@1:	db	0BAh, 53h, 7	; mov dx, 753h	;@04F46
	jmp	L04A55	;@04F49
@@2:	pop	ds	;@04F4C
	mov	word ptr ds:[95h], ax	;@04F4D
	ret	;@04F50
L04F51:	mov	bx, word ptr ds:[95h]	;@04F51
	cmp	bx, -1	;@04F55
	db	74h, 2Ah	; je @@3	;@04F58
	mov	ah, 3Eh	;@04F5A
	int	21h	;@04F5C
	db	73h, 1Eh	; jae @@2	;@04F5E
	push	cs	;@04F60
	pop	ds	;@04F61
	db	0EBh, 14h	; jmp @@1	;@04F62
	db	90h, 'Error closing file$'	;@04F64
@@1:	db	0BAh, 85h, 7	; mov dx, 785h	;@04F78
	jmp	L04A55	;@04F7B
@@2:	mov	word ptr ds:[95h], 0FFFFh	;@04F7E
@@3:	ret	;@04F84
	db	'VQP', 0FCh, 83h, 0F9h, 0, 7Eh, 12h, 8Ah, 4, '<ar', 6, '<zw', 2	;@04F85
	db	2Ch, 20h, 88h, 4, 46h, 49h, 0EBh, 0E9h, 'XY^', 0C3h
L04FA4:	push	cs	;@04FA4
	pop	ds	;@04FA5
	db	0EBh, 2Dh	; jmp @@1	;@04FA6
	db	90h, 'OS/x86: Cannot find operating system kernel$'	;@04FA8
@@1:	db	0BAh, 0C9h, 7	; mov dx, 7C9h	;@04FD5
	jmp	L04A55	;@04FD8
	db	55h, 8Bh, 0ECh, 8Bh, 46h, 6, 2Eh, 0A3h, 2, 0, 5Dh, 0CBh, 55h, 8Bh	;@04FDB
	db	0ECh, 8Bh, 46h, 6, 2Eh, 0A3h, 2, 0, 2Eh, 0C6h, 6, 0, 0, 0FFh, 2Eh
	db	0C6h, 6, 1, 0, 0FFh, 0E8h, 9Ah, 0F8h, 2Eh, 80h, 3Eh, 0, 0, 0, 75h
	db	5, 0B8h, 1, 0, 0EBh, 3, 0B8h, 0, 0, 5Dh, 0CBh
L05012:	cmp	byte ptr cs:L047E0, 0	;@05012
	je	@@1	;@05018
	call	L0489A	;@0501A
	cmp	byte ptr cs:L047E0, 0	;@0501D
	je	@@1	;@05023
	call	L04999	;@05025
	jae	@@1	;@05028
	mov	ax, 0Bh	;@0502A
	retf	;@0502D
@@1:	cmp	byte ptr cs:L047E0+1, 0	;@0502E
	jne	@@2	;@05034
	call	@@3	;@05036
	mov	ax, 0	;@05039
	retf	;@0503C
@@2:	call	L04D53	;@0503D
	call	@@3	;@05040
	mov	ax, 0	;@05043
	jmp	dword ptr cs:L047E0+75	;@05046
@@3:	mov	bx, S47E	;@0504B
	mov	cx, S47E	;@0504E
	mov	si, 0D72h	;@05051
	mov	di, 0D8Ch	;@05054
	mov	ax, 0FFFFh	;@05057
	call	dword ptr cs:L047E0+75	;@0505A
	ret	;@0505F
L05060:	cmp	byte ptr cs:L047E0, 0	;@05060
	je	@@1	;@05066
	call	L0489A	;@05068
	cmp	byte ptr cs:L047E0, 0	;@0506B
	je	@@1	;@05071
	call	L04999	;@05073
	jae	@@1	;@05076
	xor	dx, dx	;@05078
	xor	ax, ax	;@0507A
	retf	;@0507C
@@1:	mov	ax, 19h	;@0507D
	jmp	dword ptr cs:L047E0+75	;@05080
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 0Ah, 0F8h, 2Eh, 80h, 3Eh	;@05085
	db	0, 0, 0, 74h, 8, 0E8h, 0FEh, 0F8h, 73h, 3, 0E8h, 4, 0FFh, 0B8h
	db	1, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h
	db	0E8h, 0E7h, 0F7h, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 8, 0E8h, 0DBh, 0F8h
	db	73h, 3, 0E8h, 0E1h, 0FEh, 0B8h, 2, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
L050CB:	cmp	byte ptr cs:L047E0, 0	;@050CB
	je	@@1	;@050D1
	call	L0489A	;@050D3
	cmp	byte ptr cs:L047E0, 0	;@050D6
	je	@@1	;@050DC
	call	L04999	;@050DE
	jae	@@1	;@050E1
	call	L04FA4	;@050E3
@@1:	mov	ax, 3	;@050E6
	jmp	dword ptr cs:L047E0+75	;@050E9
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 0A1h, 0F7h, 2Eh, 80h, 3Eh	;@050EE
	db	0, 0, 0, 74h, 8, 0E8h, 95h, 0F8h, 73h, 3, 0E8h, 9Bh, 0FEh, 0B8h
	db	4, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
L05111:	cmp	byte ptr cs:L047E0, 0	;@05111
	je	@@1	;@05117
	call	L0489A	;@05119
	cmp	byte ptr cs:L047E0, 0	;@0511C
	je	@@1	;@05122
	call	L04999	;@05124
	jae	@@1	;@05127
	call	L04FA4	;@05129
@@1:	mov	ax, 5	;@0512C
	jmp	dword ptr cs:L047E0+75	;@0512F
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 5Bh, 0F7h, 2Eh, 80h, 3Eh	;@05134
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
L0526F:	cmp	byte ptr cs:L047E0, 0	;@0526F
	je	@@1	;@05275
	call	L0489A	;@05277
	cmp	byte ptr cs:L047E0, 0	;@0527A
	je	@@1	;@05280
	call	L04999	;@05282
	jae	@@1	;@05285
	call	L04FA4	;@05287
@@1:	mov	ax, 10h	;@0528A
	jmp	dword ptr cs:L047E0+75	;@0528D
L05292:	cmp	byte ptr cs:L047E0, 0	;@05292
	je	@@1	;@05298
	call	L0489A	;@0529A
	cmp	byte ptr cs:L047E0, 0	;@0529D
	je	@@1	;@052A3
	call	L04999	;@052A5
	jae	@@1	;@052A8
	call	L04FA4	;@052AA
@@1:	mov	ax, 11h	;@052AD
	jmp	dword ptr cs:L047E0+75	;@052B0
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 0DAh, 0F5h, 2Eh, 80h, 3Eh	;@052B5
	db	0, 0, 0, 74h, 8, 0E8h, 0CEh, 0F6h, 73h, 3, 0E8h, 0D4h, 0FCh, 0B8h
	db	12h, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h
	db	0E8h, 0B7h, 0F5h, 2Eh, 80h, 3Eh, 0, 0, 0, 74h, 8, 0E8h, 0ABh, 0F6h
	db	73h, 3, 0E8h, 0B1h, 0FCh, 0B8h, 13h, 0, 2Eh, 0FFh, 2Eh, 4Bh, 0
L052FB:	cmp	byte ptr cs:L047E0, 0	;@052FB
	je	@@1	;@05301
	call	L0489A	;@05303
	cmp	byte ptr cs:L047E0, 0	;@05306
	je	@@1	;@0530C
	call	L04999	;@0530E
	jae	@@1	;@05311
	call	L04FA4	;@05313
@@1:	mov	ax, 14h	;@05316
	jmp	dword ptr cs:L047E0+75	;@05319
L0531E:	cmp	byte ptr cs:L047E0, 0	;@0531E
	je	@@1	;@05324
	call	L0489A	;@05326
	cmp	byte ptr cs:L047E0, 0	;@05329
	je	@@1	;@0532F
	call	L04999	;@05331
	jae	@@1	;@05334
	call	L04FA4	;@05336
@@1:	mov	ax, 15h	;@05339
	jmp	dword ptr cs:L047E0+75	;@0533C
	db	2Eh, 80h, 3Eh, 0, 0, 0, 74h, 13h, 0E8h, 4Eh, 0F5h, 2Eh, 80h, 3Eh	;@05341
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
L054E5:	cmp	byte ptr cs:L047E0, 0	;@054E5
	je	@@1	;@054EB
	call	L0489A	;@054ED
	cmp	byte ptr cs:L047E0, 0	;@054F0
	je	@@1	;@054F6
	call	L04999	;@054F8
	jae	@@1	;@054FB
	call	L04FA4	;@054FD
@@1:	mov	ax, 24h	;@05500
	jmp	dword ptr cs:L047E0+75	;@05503
L05508:	cmp	byte ptr cs:L047E0, 0	;@05508
	je	@@1	;@0550E
	call	L0489A	;@05510
	cmp	byte ptr cs:L047E0, 0	;@05513
	je	@@1	;@05519
	call	L04999	;@0551B
	jae	@@1	;@0551E
	call	L04FA4	;@05520
@@1:	mov	ax, 25h	;@05523
	jmp	dword ptr cs:L047E0+75	;@05526
L0552B:	mov	ch, cl	;@0552B
	shr	bx, cl	;@0552D
	mov	cl, 10h	;@0552F
	sub	cl, ch	;@05531
	shl	ax, cl	;@05533
	or	bx, ax	;@05535
	xor	ax, ax	;@05537
	ret	;@05539
L0553A:	push	cx	;@0553A
	mov	cl, al	;@0553B
	mov	ch, al	;@0553D
	mov	ax, bx	;@0553F
	shl	bx, cl	;@05541
	mov	cl, 10h	;@05543
	sub	cl, ch	;@05545
	shr	ax, cl	;@05547
	pop	cx	;@05549
	ret	;@0554A
L0554B	db	7 dup (0)	;@0554B
L05552:	cmp	word ptr cs:L0554B+5, 0	;@05552
	jne	@@1	;@05558
	cmp	bx, 10h	;@0555A
	jne	@@1	;@0555D
	inc	word ptr cs:L0554B+5	;@0555F
	mov	ax, seg S46C_START	;@05564
	clc	;@05567
	retf	;@05568
@@1:	int	21h	;@05569
	retf	;@0556B
L0556C:	mov	ax, es	;@0556C
	cmp	ax, seg S46C_START	;@0556E
	mov	ah, 49h	;@05571
	jne	@@1	;@05573
	retf	;@05575
@@1:	int	21h	;@05576
	retf	;@05578
S47E	ends

S557	segment byte public 'CODE'
	assume	cs:S557
L05579	dw	S737	;@05579
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
L056C7:	push	bp	;@056C7
	mov	bp, sp	;@056C8
	sub	sp, 22h	;@056CA
	push	ds	;@056CD
	mov	ds, word ptr cs:L05579	;@056CE
	push	si	;@056D3
	push	di	;@056D4
	test	byte ptr ds:[22h], 1	;@056D5
	je	@@1	;@056DA
	test	byte ptr ds:[22h], 2	;@056DC
	je	@@2	;@056E1
	db	0E9h, 0F5h, 1	; jmp @@19	;@056E3
@@1:	mov	byte ptr ds:[22h], 1	;@056E6
@@2:	mov	word ptr ds:[1Ah], 0	;@056EB
	mov	word ptr ds:[1Ch], 10h	;@056F1
	mov	word ptr ds:[1Eh], 0	;@056F7
	mov	word ptr ds:[20h], 10h	;@056FD
	push	sp	;@05703
	pop	ax	;@05704
	cmp	ax, sp	;@05705
	jne	@@3	;@05707
	mov	ah, 30h	;@05709
	int	21h	;@0570B
	cmp	al, 0Ah	;@0570D
	jb	@@4	;@0570F
@@3:	db	0E9h, 0D8h, 1	; jmp @@20	;@05711
@@4:	xchg	al, ah	;@05714
	mov	word ptr [bp-22h], ax	;@05716
	mov	ax, 0F000h	;@05719
	mov	es, ax	;@0571C
	mov	al, byte ptr es:[0FFFEh]	;@0571E
	cmp	al, 0FCh	;@05722
	ja	@@3	;@05724
	cmp	al, 0FBh	;@05726
	je	@@3	;@05728
	cmp	al, 0F9h	;@0572A
	je	@@3	;@0572C
	cmp	word ptr [bp-22h], 31h	;@0572E
	jae	@@6	;@05732
@@5:	jmp	@@9	;@05734
@@6:	mov	ax, 4300h	;@05737
	int	2Fh	;@0573A
	cmp	al, 80h	;@0573C
	jne	@@5	;@0573E
	mov	ax, 4310h	;@05740
	int	2Fh	;@05743
	mov	word ptr ds:[23h], bx	;@05745
	mov	word ptr ds:[25h], es	;@05749
	xor	ax, ax	;@0574D
	call	dword ptr ds:[23h]	;@0574F
	cmp	ah, 2	;@05753
	jb	@@9	;@05756
	mov	ah, 8	;@05758
	call	dword ptr ds:[23h]	;@0575A
	or	ax, ax	;@0575E
	je	@@8	;@05760
	mov	si, ax	;@05762
	xchg	ax, dx	;@05764
	mov	ah, 9	;@05765
	call	dword ptr ds:[23h]	;@05767
	or	ax, ax	;@0576B
	je	@@8	;@0576D
	mov	word ptr ds:[27h], dx	;@0576F
	mov	ah, 0Ch	;@05773
	call	dword ptr ds:[23h]	;@05775
	or	ax, ax	;@05779
	je	@@7	;@0577B
	mov	word ptr ds:[1Ah], bx	;@0577D
	mov	word ptr ds:[1Ch], dx	;@05781
	mov	ax, 400h	;@05785
	mul	si	;@05788
	add	ax, word ptr ds:[1Ah]	;@0578A
	adc	dx, word ptr ds:[1Ch]	;@0578E
	mov	word ptr ds:[1Eh], ax	;@05792
	mov	word ptr ds:[20h], dx	;@05795
@@7:	mov	ah, 0Dh	;@05799
	mov	dx, word ptr ds:[27h]	;@0579B
	call	dword ptr ds:[23h]	;@0579F
	mov	ah, 0Ah	;@057A3
	mov	dx, word ptr ds:[27h]	;@057A5
	call	dword ptr ds:[23h]	;@057A9
	mov	word ptr ds:[27h], 0	;@057AD
@@8:	db	0E9h, 25h, 1	; jmp @@19	;@057B3
@@9:	push	ds	;@057B6
	push	cs	;@057B7
	pop	ds	;@057B8
	mov	dx, 0Dh	;@057B9
	mov	ax, 3D00h	;@057BC
	int	21h	;@057BF
	pop	ds	;@057C1
	mov	bx, ax	;@057C2
	jb	@@11	;@057C4
	mov	ax, 4400h	;@057C6
	int	21h	;@057C9
	jb	@@10	;@057CB
	test	dx, 80h	;@057CD
	je	@@10	;@057D1
	mov	ax, 4407h	;@057D3
	int	21h	;@057D6
	jb	@@10	;@057D8
	push	ax	;@057DA
	mov	ah, 3Eh	;@057DB
	int	21h	;@057DD
	pop	ax	;@057DF
	cmp	al, 0FFh	;@057E0
	je	@@12	;@057E2
@@10:	mov	ah, 3Eh	;@057E4
	int	21h	;@057E6
@@11:	jmp	@@13	;@057E8
@@12:	mov	ax, 3567h	;@057EB
	int	21h	;@057EE
	mov	ax, es	;@057F0
	or	ax, bx	;@057F2
	je	@@13	;@057F4
	mov	ax, 0DE00h	;@057F6
	int	67h	;@057F9
	shl	ax, 1	;@057FB
	jb	@@13	;@057FD
	mov	bx, 1	;@057FF
	mov	ah, 43h	;@05802
	int	67h	;@05804
	shl	ax, 1	;@05806
	jb	@@13	;@05808
	push	dx	;@0580A
	mov	ah, 42h	;@0580B
	int	67h	;@0580D
	pop	dx	;@0580F
	push	bx	;@05810
	mov	ah, 45h	;@05811
	int	67h	;@05813
	pop	bx	;@05815
	inc	bx	;@05816
	mov	ax, 4000h	;@05817
	mul	bx	;@0581A
	mov	bx, 0	;@0581C
	mov	cx, 100h	;@0581F
	mov	word ptr ds:[20h], cx	;@05822
	sub	bx, ax	;@05826
	sbb	cx, dx	;@05828
	mov	word ptr ds:[1Ah], bx	;@0582A
	mov	word ptr ds:[1Ch], cx	;@0582E
	db	0E9h, 0BAh, 0	; jmp @@21	;@05832
@@13:	mov	ah, 88h	;@05835
	int	15h	;@05837
	or	ax, ax	;@05839
	jne	@@15	;@0583B
@@14:	db	0E9h, 0ACh, 0	; jmp @@20	;@0583D
@@15:	mov	dx, 400h	;@05840
	mul	dx	;@05843
	add	dl, 10h	;@05845
	mov	word ptr ds:[1Eh], ax	;@05848
	mov	word ptr ds:[20h], dx	;@0584B
	mov	cx, word ptr ds:[23h]	;@0584F
	or	cx, word ptr ds:[25h]	;@05853
	jcxz	@@16	;@05857
	mov	byte ptr ds:[1Ch], 11h	;@05859
	mov	word ptr ds:[1Ah], 0	;@0585E
@@16:	mov	ax, ss	;@05864
	mov	dx, 10h	;@05866
	mul	dx	;@05869
	lea	bx, [bp-20h]	;@0586B
	xor	cx, cx	;@0586E
	add	bx, ax	;@05870
	adc	cx, dx	;@05872
	mov	ax, 0	;@05874
	mov	dx, 10h	;@05877
	mov	si, 20h	;@0587A
	xor	di, di	;@0587D
	db	0E8h, 0A0h, 1	; call @@22	;@0587F
	jb	@@14	;@05882
	lea	di, [bp-1Dh]	;@05884
	push	ss	;@05887
	pop	es	;@05888
	db	8Dh, 36h, 0, 0	; lea si, ds:[0]	;@05889
	db	0B9h, 5, 0	; mov cx, 5	;@0588D
	cld	;@05890
	repe cmpsb	;@05891
	jne	@@17	;@05893
	mov	ax, word ptr [bp-15h]	;@05895
	mul	word ptr [bp-0Dh]	;@05898
	add	dl, 10h	;@0589B
	mov	word ptr ds:[1Ah], ax	;@0589E
	mov	byte ptr ds:[1Ch], dl	;@058A1
@@17:	xor	ax, ax	;@058A5
	mov	es, ax	;@058A7
	mov	es, word ptr es:[66h]	;@058A9
	mov	di, 12h	;@058AE
	db	8Dh, 36h, 0, 0	; lea si, ds:[0]	;@058B1
	db	0B9h, 5, 0	; mov cx, 5	;@058B5
	cld	;@058B8
	repe cmpsb	;@058B9
	jne	@@19	;@058BB
	mov	ax, word ptr es:[2Ch]	;@058BD
	mov	dl, byte ptr es:[2Eh]	;@058C1
	cmp	dl, byte ptr ds:[1Ch]	;@058C6
	jb	@@19	;@058CA
	ja	@@18	;@058CC
	cmp	ax, word ptr ds:[1Ah]	;@058CE
	jbe	@@19	;@058D2
@@18:	mov	word ptr ds:[1Ah], ax	;@058D4
	mov	byte ptr ds:[1Ch], dl	;@058D7
@@19:	mov	ax, word ptr ds:[1Eh]	;@058DB
	mov	dx, word ptr ds:[20h]	;@058DE
	sub	ax, word ptr ds:[1Ah]	;@058E2
	sbb	dx, word ptr ds:[1Ch]	;@058E6
	jmp	short @@21	;@058EA
@@20:	xor	ax, ax	;@058EC
	cwd	;@058EE
@@21:	pop	di	;@058EF
	pop	si	;@058F0
	pop	ds	;@058F1
	mov	sp, bp	;@058F2
	pop	bp	;@058F4
	retf	;@058F5
	db	55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh, 1Eh, 9, 0, 56h, 57h, 0F6h, 6, 22h, 0, 1	;@058F6
	db	75h, 3, 0E9h, 0B9h, 0, 0F6h, 6, 22h, 0, 2, 74h, 5, 33h, 0C0h, 0E9h, 0B0h
	db	0, 80h, 0Eh, 22h, 0, 2, 8Bh, 46h, 0Ah, 8Bh, 56h, 0Ch, 8Bh, 76h, 6, 8Bh
	db	7Eh, 8, 8Bh, 1Eh, 23h, 0, 0Bh, 1Eh, 25h, 0, 74h, 43h, 8Bh, 0C6h, 8Bh, 0D7h
	db	5, 0FFh, 3, 83h, 0D2h, 0, 0BBh, 0, 4, 0F7h, 0F3h, 92h, 0B4h, 9, 0FFh, 1Eh
	db	23h, 0, 0Bh, 0C0h, 74h, 26h, 89h, 16h, 27h, 0, 0B4h, 0Ch, 0FFh, 1Eh, 23h, 0
	db	0Bh, 0C0h, 74h, 18h, 89h, 1Eh, 1Ah, 0, 89h, 16h, 1Ch, 0, 89h, 1Eh, 29h, 0
	db	89h, 16h, 2Bh, 0, 8Bh, 0C3h, 3, 0C6h, 13h, 0D7h, 0EBh, 47h, 0EBh, 50h, 90h, 0A3h
	db	1Ah, 0, 89h, 16h, 1Ch, 0, 33h, 0DBh, 8Eh, 0C3h, 1Eh, 0BBh
	dw	S73F
	db	8Eh, 0DBh, 26h, 8Bh, 1Eh, 64h, 0, 89h, 1Eh, 2Fh, 0, 26h, 8Bh, 1Eh, 66h, 0
	db	89h, 1Eh, 31h, 0, 26h, 0C7h, 6, 64h, 0, 3Fh, 0, 26h, 0C7h, 6, 66h, 0
	dw	S73F
	db	0A3h, 3Ah, 0, 88h, 16h, 3Ch, 0, 3, 0C6h, 13h, 0D7h, 0A3h, 2Ch, 0, 88h, 16h
	db	2Eh, 0, 1Fh, 0A3h, 1Eh, 0, 89h, 16h, 20h, 0, 33h, 0C0h, 0EBh, 3, 0B8h, 0FFh
	db	0FFh, 5Fh, 5Eh, 1Fh, 5Dh, 0CAh, 8, 0, 55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh, 1Eh, 9
	db	0, 80h, 3Eh, 22h, 0, 0, 74h, 41h, 83h, 3Eh, 27h, 0, 0, 74h, 16h, 0B4h
	db	0Dh, 8Bh, 16h, 27h, 0, 0FFh, 1Eh, 23h, 0, 0B4h, 0Ah, 8Bh, 16h, 27h, 0, 0FFh
	db	1Eh, 23h, 0, 0EBh, 24h, 33h, 0C0h, 8Eh, 0C0h, 26h, 0A1h, 66h, 0, 3Dh
	dw	S73F
	db	75h, 17h, 1Eh, 8Eh, 0D8h, 0A1h, 2Fh, 0, 26h, 0A3h, 64h, 0, 0A1h, 31h, 0, 26h
	db	0A3h, 66h, 0, 1Fh, 0C6h, 6, 22h, 0, 0, 1Fh, 5Dh, 0CBh
@@22:	push	ds	;@05A22
	push	es	;@05A23
	add	si, 1	;@05A24
	adc	di, 0	;@05A27
	and	si, -2	;@05A2A
	cld	;@05A2D
	mov	ds, word ptr cs:L05579	;@05A2E
	cmp	word ptr ds:[27h], 0	;@05A33
	db	74h, 6Ah	; je @@27	;@05A38
	mov	word ptr ds:[2Dh], si	;@05A3A
	mov	word ptr ds:[2Fh], di	;@05A3E
	cmp	dl, 10h	;@05A42
	jb	@@23	;@05A45
	mov	si, word ptr ds:[27h]	;@05A47
	mov	word ptr ds:[31h], si	;@05A4B
	sub	ax, word ptr ds:[29h]	;@05A4F
	sbb	dx, word ptr ds:[2Bh]	;@05A53
	jmp	@@24	;@05A57
@@23:	mov	word ptr ds:[31h], 0	;@05A5A
	ror	dx, 4	;@05A60
@@24:	mov	word ptr ds:[33h], ax	;@05A63
	mov	word ptr ds:[35h], dx	;@05A66
	cmp	cl, 10h	;@05A6A
	jb	@@25	;@05A6D
	mov	si, word ptr ds:[27h]	;@05A6F
	mov	word ptr ds:[37h], si	;@05A73
	sub	bx, word ptr ds:[29h]	;@05A77
	sbb	cx, word ptr ds:[2Bh]	;@05A7B
	jmp	@@26	;@05A7F
@@25:	mov	word ptr ds:[37h], 0	;@05A82
	ror	cx, 4	;@05A88
@@26:	mov	word ptr ds:[39h], bx	;@05A8B
	mov	word ptr ds:[3Bh], cx	;@05A8F
	mov	ah, 0Bh	;@05A93
	db	8Dh, 36h, 2Dh, 0	; lea si, ds:[2Dh]	;@05A95
	db	0FFh, 1Eh, 23h, 0	; call dword ptr ds:[23h]	;@05A99
	or	ax, ax	;@05A9D
	db	75h, 29h	; jne @@29	;@05A9F
	stc	;@05AA1
	db	0EBh, 21h	; jmp short @@28	;@05AA2
@@27:	shr	di, 1	;@05AA4
	rcr	si, 1	;@05AA6
	mov	word ptr ds:[3Fh], ax	;@05AA8
	mov	byte ptr ds:[41h], dl	;@05AAB
	mov	word ptr ds:[47h], bx	;@05AAF
	mov	byte ptr ds:[49h], cl	;@05AB3
	mov	cx, si	;@05AB7
	db	8Dh, 36h, 2Dh, 0	; lea si, ds:[2Dh]	;@05AB9
	db	1Eh	; push ds	;@05ABD
	pop	es	;@05ABE
	mov	ah, 87h	;@05ABF
	int	15h	;@05AC1
	jae	@@29	;@05AC3
@@28:	sbb	ax, ax	;@05AC5
	stc	;@05AC7
	jmp	short @@30	;@05AC8
@@29:	xor	ax, ax	;@05ACA
@@30:	pop	es	;@05ACC
	pop	ds	;@05ACD
	ret	;@05ACE
	db	0	;@05ACF
S557	ends
	end
