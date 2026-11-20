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

	public	L048E0
	public	L04992
	public	L049DA
	public	L04AEF
	public	L04B40
	public	L04B8F
	public	L04D3D
	public	L050A0
	public	L054E8
	public	L0B7DD
	public	L0BA72
	extrn	L00000:byte
	extrn	L01690:near
	extrn	L02737:far
	extrn	L04394:near
	extrn	L04437:near
	extrn	L04640:near
	extrn	L04677:near
	extrn	L046D3:near
	extrn	L047F0:near
	extrn	L04FBC:near
	extrn	S589_START:byte
	extrn	S59F_START:byte
	extrn	S5AD_START:byte
	extrn	S5ED_START:byte
	extrn	S5FD_START:byte
	extrn	S8EF_START:byte
	extrn	S8F6_START:byte
	extrn	S908_START:byte
	extrn	FA0_START:byte
	extrn	L0B739:byte

S000	segment byte public 'CODE'
	assume	cs:S000
L048E0:	push	bp	;@048E0
	mov	bp, sp	;@048E1
	push	ax	;@048E3
	push	bx	;@048E4
	push	cx	;@048E5
	push	dx	;@048E6
	push	si	;@048E7
	push	ds	;@048E8
	mov	ax, word ptr [bp+6]	;@048E9
	dec	ax	;@048EC
	mov	cx, 3	;@048ED
	mul	cx	;@048F0
	mov	bx, ax	;@048F2
	mov	ax, seg S8F6_START	;@048F4
	mov	ds, ax	;@048F7
	mov	bx, word ptr [bx+1]	;@048F9
	mov	ax, seg S908_START	;@048FC
	mov	ds, ax	;@048FF
	mov	si, word ptr [bp+8]	;@04901
	add	si, 8	;@04904
	push	cx	;@04907
	push	dx	;@04908
	mov	dx, 80h	;@04909
	call	L046D3	;@0490C
	pop	dx	;@0490F
	pop	cx	;@04910
@@1:	mov	dl, byte ptr [bx]	;@04911
	or	dl, dl	;@04913
	je	@@8	;@04915
	cmp	dl, 25h	;@04917
	jne	@@7	;@0491A
	inc	bx	;@0491C
	mov	dl, byte ptr [bx]	;@0491D
	cmp	dl, 78h	;@0491F
	jne	@@2	;@04922
	mov	ax, word ptr [bp+si]	;@04924
	sub	si, 2	;@04926
	push	cx	;@04929
	mov	cx, ax	;@0492A
	call	L04677	;@0492C
	pop	cx	;@0492F
	jmp	@@6	;@04930
@@2:	cmp	dl, 64h	;@04933
	jne	@@3	;@04936
	mov	ax, word ptr [bp+si]	;@04938
	sub	si, 2	;@0493A
	push	cx	;@0493D
	mov	cx, ax	;@0493E
	call	L04640	;@04940
	pop	cx	;@04943
	jmp	@@6	;@04944
@@3:	cmp	dl, 73h	;@04947
	jne	@@6	;@0494A
	push	ds	;@0494C
	lds	dx, dword ptr [bp+si-2]	;@0494D
	push	si	;@04950
	mov	si, dx	;@04951
@@4:	mov	al, byte ptr [si]	;@04953
	or	al, al	;@04955
	je	@@5	;@04957
	cmp	al, 24h	;@04959
	je	@@5	;@0495B
	inc	si	;@0495D
	jmp	@@4	;@0495E
@@5:	mov	byte ptr [si], 24h	;@04960
	mov	ah, 9	;@04963
	int	21h	;@04965
	mov	byte ptr [si], 0	;@04967
	pop	si	;@0496A
	sub	si, 4	;@0496B
	pop	ds	;@0496E
@@6:	inc	bx	;@0496F
	jmp	@@1	;@04970
@@7:	mov	ah, 2	;@04972
	int	21h	;@04974
	inc	bx	;@04976
	jmp	@@1	;@04977
@@8:	mov	ah, 2	;@04979
	mov	dl, 0Dh	;@0497B
	int	21h	;@0497D
	mov	ah, 2	;@0497F
	mov	dl, 0Ah	;@04981
	int	21h	;@04983
	pop	ds	;@04985
	pop	si	;@04986
	pop	dx	;@04987
	pop	cx	;@04988
	pop	bx	;@04989
	pop	ax	;@0498A
	pop	bp	;@0498B
	retf	;@0498C
	db	0	;@0498D
	dd	S59F_START
L04992:	push	es	;@04992
	push	si	;@04993
	push	cx	;@04994
	push	dx	;@04995
	push	di	;@04996
	push	bp	;@04997
	mov	bp, sp	;@04998
	sub	sp, 8	;@0499A
	mov	es, word ptr ds:[90h]	;@0499D
	push	ax	;@049A1
	push	bx	;@049A2
	push	ds	;@049A3
	push	ax	;@049A4
	mov	ax, ss	;@049A5
	mov	ds, ax	;@049A7
	lea	bx, [bp-8]	;@049A9
	mov	ax, cx	;@049AC
	call	L049DA	;@049AE
	pop	ax	;@049B1
	pop	ds	;@049B2
	jb	@@1	;@049B3
	lea	si, [bp-8]	;@049B5
	mov	bx, word ptr ss:[si+2]	;@049B8
	mov	al, byte ptr ss:[si+4]	;@049BC
	mov	ah, byte ptr ss:[si+7]	;@049C0
	pop	dx	;@049C4
	pop	cx	;@049C5
	add	bx, dx	;@049C6
	adc	ax, cx	;@049C8
	clc	;@049CA
	jmp	@@2	;@049CB
@@1:	pop	bx	;@049CE
	pop	bx	;@049CF
	stc	;@049D0
@@2:	mov	sp, bp	;@049D1
	pop	bp	;@049D3
	pop	di	;@049D4
	pop	dx	;@049D5
	pop	cx	;@049D6
	pop	si	;@049D7
	pop	es	;@049D8
	ret	;@049D9
L049DA:	push	ax	;@049DA
	push	cx	;@049DB
	push	dx	;@049DC
	push	bx	;@049DD
	push	si	;@049DE
	push	di	;@049DF
	push	ds	;@049E0
	push	bp	;@049E1
	mov	bp, sp	;@049E2
	sub	sp, 4	;@049E4
	mov	word ptr [bp-2], ax	;@049E7
	mov	di, bx	;@049EA
	cmp	word ptr es:[187h], 0	;@049EC
	je	@@1	;@049F2
	xor	ax, ax	;@049F4
	mov	bx, si	;@049F6
	mov	al, 4	;@049F8
	call	L047F0	;@049FA
	mov	si, di	;@049FD
	mov	word ptr [si+2], bx	;@049FF
	mov	byte ptr [si+4], al	;@04A02
	mov	byte ptr [si+7], ah	;@04A05
	mov	ax, 1	;@04A08
	xor	bx, bx	;@04A0B
	push	cx	;@04A0D
	push	ax	;@04A0E
	push	bx	;@04A0F
	sub	bx, 1	;@04A10
	sbb	ax, 0	;@04A13
	mov	word ptr [si], bx	;@04A16
	mov	cl, byte ptr [si+6]	;@04A18
	and	cl, 0F0h	;@04A1B
	and	al, 0Fh	;@04A1E
	or	cl, al	;@04A20
	mov	byte ptr [si+6], cl	;@04A22
	pop	bx	;@04A25
	pop	ax	;@04A26
	pop	cx	;@04A27
	push	cx	;@04A28
	mov	cl, 0	;@04A29
	and	cl, 1	;@04A2B
	shl	cl, 1	;@04A2E
	shl	cl, 1	;@04A30
	shl	cl, 1	;@04A32
	shl	cl, 1	;@04A34
	shl	cl, 1	;@04A36
	shl	cl, 1	;@04A38
	and	byte ptr [si+6], 0BFh	;@04A3A
	or	byte ptr [si+6], cl	;@04A3E
	pop	cx	;@04A41
	push	cx	;@04A42
	mov	cl, 0	;@04A43
	shl	cl, 1	;@04A45
	shl	cl, 1	;@04A47
	shl	cl, 1	;@04A49
	shl	cl, 1	;@04A4B
	shl	cl, 1	;@04A4D
	shl	cl, 1	;@04A4F
	shl	cl, 1	;@04A51
	and	byte ptr [si+6], 7Fh	;@04A53
	or	byte ptr [si+6], cl	;@04A57
	pop	cx	;@04A5A
	mov	byte ptr [si+5], 0F2h	;@04A5B
	mov	ax, 0	;@04A5F
	clc	;@04A62
	jmp	@@6	;@04A63
@@1:	mov	cx, si	;@04A66
	shr	cx, 1	;@04A68
	shr	cx, 1	;@04A6A
	and	cx, 1	;@04A6C
	cmp	cx, 0	;@04A6F
	jne	@@2	;@04A72
	mov	bx, word ptr es:[41h]	;@04A74
	mov	ax, word ptr es:[43h]	;@04A79
	and	si, -8	;@04A7D
	add	bx, si	;@04A80
	adc	ax, 0	;@04A82
	jmp	@@5	;@04A85
@@2:	push	ss	;@04A88
	lea	ax, [bp-4]	;@04A89
	push	ax	;@04A8C
	mov	ax, 2	;@04A8D
	push	ax	;@04A90
	xor	ax, ax	;@04A91
	push	ax	;@04A93
	cmp	byte ptr es:[116h], 0	;@04A94
	je	@@3	;@04A9A
	mov	ax, 60h	;@04A9C
	jmp	@@4	;@04A9F
@@3:	mov	ax, 2Ah	;@04AA2
@@4:	push	ax	;@04AA5
	push	word ptr [bp-2]	;@04AA6
	push	word ptr [bp-2]	;@04AA9
	nosmart
	call	far ptr L02737	;@04AAC
	smart
	add	sp, 0Eh	;@04AB1
	push	ds	;@04AB4
	push	di	;@04AB5
	mov	ax, 8	;@04AB6
	push	ax	;@04AB9
	xor	ax, ax	;@04ABA
	push	ax	;@04ABC
	mov	ax, si	;@04ABD
	and	ax, 0FFF8h	;@04ABF
	push	ax	;@04AC2
	push	word ptr [bp-4]	;@04AC3
	push	word ptr [bp-2]	;@04AC6
	nosmart
	call	far ptr L02737	;@04AC9
	smart
	add	sp, 0Eh	;@04ACE
	jmp	@@6	;@04AD1
@@5:	push	es	;@04AD4
	mov	dx, ds	;@04AD5
	mov	es, dx	;@04AD7
	mov	cx, 8	;@04AD9
	call	L01690	;@04ADC
	pop	es	;@04ADF
	clc	;@04AE0
	mov	ax, 0	;@04AE1
@@6:	mov	sp, bp	;@04AE4
	pop	bp	;@04AE6
	pop	ds	;@04AE7
	pop	di	;@04AE8
	pop	si	;@04AE9
	pop	bx	;@04AEA
	pop	dx	;@04AEB
	pop	cx	;@04AEC
	pop	ax	;@04AED
	ret	;@04AEE
L04AEF:	push	ds	;@04AEF
	push	bx	;@04AF0
	push	dx	;@04AF1
	push	ax	;@04AF2
	mov	ax, seg S589_START	;@04AF3
	mov	ds, ax	;@04AF6
	pop	ax	;@04AF8
	push	cx	;@04AF9
	mov	cx, dx	;@04AFA
	call	L04992	;@04AFC
	pop	cx	;@04AFF
	jae	@@1	;@04B00
	pop	dx	;@04B02
	pop	bx	;@04B03
	pop	ds	;@04B04
	ret	;@04B05
@@1:	call	L01690	;@04B06
	mov	ax, 0	;@04B09
	pop	dx	;@04B0C
	pop	bx	;@04B0D
	pop	ds	;@04B0E
	ret	;@04B0F
	db	1Eh, 53h, 51h, 52h, 50h, 0B8h	;@04B10
	dw	seg S589_START
	db	8Eh, 0D8h, 58h, 51h, 8Bh, 0CAh, 0E8h, 71h, 0FEh, 59h, 73h, 5, 5Ah, 59h, 5Bh, 1Fh
	db	0C3h, 0E8h, 0C4h, 0CBh, 0B8h, 0, 0, 5Ah, 59h, 5Bh, 1Fh, 0C3h, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0
L04B40:	push	ax	;@04B40
	push	di	;@04B41
	mov	al, 1	;@04B42
	call	L04437	;@04B44
	mov	word ptr es:[di+6], 1Ah	;@04B47
	mov	word ptr es:[di+8], bx	;@04B4D
	call	L04394	;@04B51
	pop	di	;@04B54
	pop	ax	;@04B55
	ret	;@04B56
	db	26h, 0A1h, 8, 0, 2Eh, 0A3h, 0EFh, 4Bh, 60h, 1Eh, 6, 0FAh, 0E8h, 0E9h, 1, 26h	;@04B57
	db	0FFh, 36h, 0, 0, 26h, 0FFh, 36h, 2, 0, 9Ch, 0Eh, 68h, 0F4h, 4Bh, 26h, 8Ch
	db	16h, 0, 0, 26h, 89h, 26h, 2, 0, 26h, 83h, 3Eh, 4Dh, 0, 0, 74h, 5
	db	0EAh, 0AFh, 17h
	dw	seg FA0_START
	db	0E9h, 57h, 6
L04B8F:	pusha	;@04B8F
	push	ds	;@04B90
	push	es	;@04B91
	cli	;@04B92
	cmp	word ptr es:[4Dh], 0	;@04B93
	jne	@@1	;@04B99
	db	0E8h, 0B1h, 1	; call L04D4F	;@04B9B
@@1:	push	word ptr es:[0]	;@04B9E
	push	word ptr es:[2]	;@04BA3
	pushf	;@04BA8
	push	cs	;@04BA9
	push	4BF4h	;@04BAA
	mov	word ptr es:[0], ss	;@04BAD
	mov	word ptr es:[2], sp	;@04BB2
	smsw	ax	;@04BB7
	mov	word ptr es:[50h], ax	;@04BBA
	cmp	word ptr es:[4Dh], 0	;@04BBE
	je	@@2	;@04BC4
	call	@@4	;@04BC6
@@2:	mov	ds, word ptr es:[0Dh]	;@04BC9
	test	word ptr cs:L04C9F+1, 60h	;@04BCE
	je	@@3	;@04BD5
	mov	al, 30h	;@04BD7
	out	20h, al	;@04BD9
@@3:	lgdt	fword ptr ds:[8]	;@04BDB
	lidt	fword ptr ds:[60h]	;@04BE0
	smsw	ax	;@04BE5
	or	ax, 3	;@04BE8
	lmsw	ax	;@04BEB
	db	0EAh, 0, 0, 20h, 0	; ljmp 0x20:0	;@04BEE
	db	90h, 26h, 8Fh, 6, 2, 0, 26h, 8Fh, 6, 0, 0, 7, 1Fh, 61h, 0C3h	;@04BF3
@@4:	sub	sp, 16h	;@04C02
	mov	bp, sp	;@04C05
	mov	ax, seg S589_START	;@04C07
	mov	ds, ax	;@04C0A
	xor	dl, dl	;@04C0C
	xchg	byte ptr cs:L00000+4, dl	;@04C0E
	cmp	dl, 0	;@04C13
	je	@@5	;@04C16
	db	0E8h, 0A1h, 3	; call L04FBC	;@04C18
@@5:	db	66h, 0A1h, 44h, 1	; mov eax, dword ptr ds:[144h]	;@04C1B
	db	66h, 89h, 46h, 0	; mov dword ptr [bp], eax	;@04C1F
	db	66h, 33h, 0DBh	; xor ebx, ebx	;@04C23
	db	0BBh	;@04C26
	dw	S50A
	db	66h, 0C1h, 0E3h, 4	; shl ebx, 4	;@04C29
	db	66h, 33h, 0C0h	; xor eax, eax	;@04C2D
	mov	ax, 40Ah	;@04C30
	db	66h, 3, 0D8h	; add ebx, eax	;@04C33
	db	66h, 89h, 5Eh, 4	; mov dword ptr [bp+4], ebx	;@04C36
	db	66h, 33h, 0DBh	; xor ebx, ebx	;@04C3A
	db	0BBh	;@04C3D
	dw	S50A
	db	66h, 0C1h, 0E3h, 4	; shl ebx, 4	;@04C40
	db	66h, 33h, 0C0h	; xor eax, eax	;@04C44
	mov	ax, 410h	;@04C47
	db	66h, 3, 0D8h	; add ebx, eax	;@04C4A
	db	66h, 89h, 5Eh, 8	; mov dword ptr [bp+8], ebx	;@04C4D
	mov	word ptr [bp+0Ch], 0	;@04C51
	mov	ax, word ptr es:[183h]	;@04C56
	cmp	ax, 0	;@04C5A
	jne	@@6	;@04C5D
	push	ds	;@04C5F
	mov	ax, seg S5AD_START	;@04C60
	mov	ds, ax	;@04C63
	mov	ax, 140h	;@04C65
	mov	bx, ax	;@04C68
	and	byte ptr [bx+5], 0FDh	;@04C6A
	pop	ds	;@04C6E
@@6:	mov	word ptr [bp+0Eh], ax	;@04C6F
	xor	ax, ax	;@04C72
	mov	bx, word ptr es:[8]	;@04C74
	mov	word ptr [bp+10h], bx	;@04C79
	mov	word ptr [bp+12h], ax	;@04C7C
	mov	ax, 20h	;@04C7F
	mov	word ptr [bp+14h], ax	;@04C82
	db	66h, 33h, 0F6h	; xor esi, esi	;@04C85
	push	bp	;@04C88
	db	66h, 33h, 0EDh	; xor ebp, ebp	;@04C89
	pop	bp	;@04C8C
	mov	si, ss	;@04C8D
	db	66h, 0C1h, 0E6h, 4	; shl esi, 4	;@04C8F
	db	66h, 3, 0F5h	; add esi, ebp	;@04C93
	mov	ax, 0DE0Ch	;@04C96
	int	67h	;@04C99
L04C9B:	add	byte ptr [bx+si], al	;@04C9B
	add	byte ptr [bx+si], al	;@04C9D
L04C9F:	add	byte ptr [bx+si], al	;@04C9F
	add	byte ptr [bx+si], al	;@04CA1
	add	byte ptr [bx+si], al	;@04CA3
	add	byte ptr [bx+si], al	;@04CA5
	add	byte ptr [bx+si], al	;@04CA7
	add	byte ptr [bx+si], al	;@04CA9
L04CAB:	add	byte ptr [bx+si], al	;@04CAB
L04CAD:	add	byte ptr [bx+si], al	;@04CAD
	push	ax	;@04CAF
	push	es	;@04CB0
	push	bx	;@04CB1
	push	cx	;@04CB2
	mov	cx, 10h	;@04CB3
	mov	si, 0A1h	;@04CB6
	add	si, 2	;@04CB9
	push	es	;@04CBC
	push	cs	;@04CBD
	pop	es	;@04CBE
	mov	di, 4C9Bh	;@04CBF
	cld	;@04CC2
	rep movsb	;@04CC3
	mov	es, word ptr ds:[90h]	;@04CC5
	cmp	word ptr es:[4Dh], 0	;@04CC9
	je	@@1	;@04CCF
	mov	byte ptr cs:L04C9B, 7	;@04CD1
	mov	byte ptr cs:L04C9B+1, 7	;@04CD7
@@1:	pop	es	;@04CDD
	call	L04D28	;@04CDE
	test	word ptr cs:L04C9F+1, 10h	;@04CE1
	je	@@2	;@04CE8
	mov	ax, 4310h	;@04CEA
	int	2Fh	;@04CED
	mov	word ptr cs:L04CAB, bx	;@04CEF
	mov	word ptr cs:L04CAD, es	;@04CF4
@@2:	pop	cx	;@04CF9
	pop	bx	;@04CFA
	pop	es	;@04CFB
	pop	ax	;@04CFC
	ret	;@04CFD
L04CFE	db	20h, 0, 0, 0, 30h, 0, 0FFh, 0FFh	;@04CFE
L04D06:	push	ds	;@04D06
	push	es	;@04D07
	push	cx	;@04D08
	push	si	;@04D09
	push	di	;@04D0A
	lds	si, dword ptr cs:L04CFE	;@04D0B
	les	di, dword ptr cs:L04CFE+4	;@04D10
	mov	cx, 4	;@04D15
	cld	;@04D18
	repe cmpsw	;@04D19
	jcxz	@@1	;@04D1B
	stc	;@04D1D
	jmp	short @@2	;@04D1E
@@1:	clc	;@04D20
@@2:	pop	di	;@04D21
	pop	si	;@04D22
	pop	cx	;@04D23
	pop	es	;@04D24
	pop	ds	;@04D25
	ret	;@04D26
L04D27	db	0	;@04D27
L04D28:	call	L04D06	;@04D28
	jae	@@1	;@04D2B
	mov	byte ptr cs:L04D27, 1	;@04D2D
	jmp	@@2	;@04D33
@@1:	mov	byte ptr cs:L04D27, 0	;@04D36
@@2:	ret	;@04D3C
L04D3D:	cmp	byte ptr cs:L04D27, 0	;@04D3D
	jne	@@1	;@04D43
	db	0E8h, 0DEh, 0	; call L04E26	;@04D45
	jmp	@@2	;@04D48
@@1:	call	L04D4F	;@04D4B
@@2:	ret	;@04D4E
L04D4F:	push	ax	;@04D4F
	push	bx	;@04D50
	push	cx	;@04D51
	push	dx	;@04D52
	call	L04D06	;@04D53
	jae	@@1	;@04D56
	db	0E9h, 0A7h, 0	; jmp @@15	;@04D58
@@1:	mov	al, byte ptr cs:L04C9B	;@04D5B
	cmp	al, 2	;@04D5F
	jne	@@2	;@04D61
	mov	al, 0	;@04D63
	mov	ah, 0DFh	;@04D65
	db	0E8h, 61h, 1	; call L04ECB	;@04D67
	db	0E9h, 80h, 0	; jmp @@12	;@04D6A
@@2:	cmp	al, 1	;@04D6D
	jne	@@3	;@04D6F
	mov	al, 1	;@04D71
	mov	ah, 0DFh	;@04D73
	db	0E8h, 53h, 1	; call L04ECB	;@04D75
	db	0EBh, 73h	; jmp @@12	;@04D78
	db	90h	;@04D7A
@@3:	cmp	al, 3	;@04D7B
	jne	@@7	;@04D7D
	in	al, 92h	;@04D7F
	jmp	short @@4	;@04D81
@@4:	jmp	short @@5	;@04D83
@@5:	jmp	short @@6	;@04D85
@@6:	or	al, 2	;@04D87
	out	92h, al	;@04D89
	db	0EBh, 60h	; jmp @@12	;@04D8B
	db	90h	;@04D8D
@@7:	cmp	al, 4	;@04D8E
	jne	@@8	;@04D90
	mov	al, 0	;@04D92
	out	0F2h, al	;@04D94
	db	0EBh, 55h	; jmp @@12	;@04D96
	db	90h	;@04D98
@@8:	cmp	al, 5	;@04D99
	db	75h, 19h	; jne @@9	;@04D9B
	mov	ah, 4	;@04D9D
	call	dword ptr cs:L04CAB	;@04D9F
	mov	ah, 3	;@04DA4
	call	dword ptr cs:L04CAB	;@04DA6
	cmp	ax, 1	;@04DAB
	db	74h, 52h	; je @@15	;@04DAE
	db	0EBh, 55h	; jmp @@16	;@04DB0
	db	90h, 0EBh, 38h, 90h	;@04DB2
@@9:	db	3Ch, 6	; cmp al, 6	;@04DB6
	jne	@@10	;@04DB8
	db	0E8h, 4Ah, 1	; call L04F07	;@04DBA
	mov	al, 0B9h	;@04DBD
	out	64h, al	;@04DBF
	db	0E8h, 43h, 1	; call L04F07	;@04DC1
	mov	al, 0A9h	;@04DC4
	out	64h, al	;@04DC6
	db	0E8h, 3Ch, 1	; call L04F07	;@04DC8
	mov	al, 0AEh	;@04DCB
	out	64h, al	;@04DCD
	db	0E8h, 35h, 1	; call L04F07	;@04DCF
	db	0EBh, 19h	; jmp @@12	;@04DD2
	db	90h	;@04DD4
@@10:	cmp	al, 7	;@04DD5
	db	75h, 6	; jne @@11	;@04DD7
	db	0EBh, 27h	; jmp @@15	;@04DD9
	db	90h, 0EBh, 0Fh, 90h	;@04DDB
@@11:	db	52h	; push dx	;@04DDF
	mov	dx, 90h	;@04DE0
	call	L046D3	;@04DE3
	pop	dx	;@04DE6
	mov	al, 1	;@04DE7
	mov	ah, 4Ch	;@04DE9
	int	21h	;@04DEB
@@12:	xor	bx, bx	;@04DED
@@13:	call	L04D06	;@04DEF
	db	72h, 0Eh	; jb @@15	;@04DF2
	dec	bx	;@04DF4
	cmp	bx, 0	;@04DF5
	db	75h, 6	; jne @@14	;@04DF8
	db	0EBh, 0Bh	; jmp @@16	;@04DFA
	db	90h, 0EBh, 3, 90h	;@04DFC
@@14:	db	0EBh, 0EDh	; jmp @@13	;@04E00
@@15:	pop	dx	;@04E02
	pop	cx	;@04E03
	pop	bx	;@04E04
	pop	ax	;@04E05
	ret	;@04E06
@@16:	sub	sp, 4	;@04E07
	push	bp	;@04E0A
	mov	bp, sp	;@04E0B
	mov	word ptr [bp+4], 0	;@04E0D
	mov	word ptr [bp+2], 2	;@04E12
	pop	bp	;@04E17
	nosmart
	nosmart
	call	far ptr L048E0	;@04E18
	smart
	smart
	add	sp, 4	;@04E1D
	mov	al, 1	;@04E20
	mov	ah, 4Ch	;@04E22
	int	21h	;@04E24
L04E26:	push	ax	;@04E26
	push	bx	;@04E27
	push	cx	;@04E28
	push	dx	;@04E29
	mov	al, byte ptr cs:L04C9B+1	;@04E2A
	cmp	al, 2	;@04E2E
	jne	@@1	;@04E30
	mov	al, 0	;@04E32
	mov	ah, 0DDh	;@04E34
	db	0E8h, 92h, 0	; call L04ECB	;@04E36
	db	0EBh, 76h	; jmp @@12	;@04E39
	db	90h	;@04E3B
@@1:	cmp	al, 1	;@04E3C
	jne	@@2	;@04E3E
	mov	al, 1	;@04E40
	mov	ah, 0DDh	;@04E42
	db	0E8h, 84h, 0	; call L04ECB	;@04E44
	db	0EBh, 68h	; jmp @@12	;@04E47
	db	90h	;@04E49
@@2:	cmp	al, 3	;@04E4A
	jne	@@6	;@04E4C
	in	al, 92h	;@04E4E
	jmp	short @@3	;@04E50
@@3:	jmp	short @@4	;@04E52
@@4:	jmp	short @@5	;@04E54
@@5:	and	al, 0FDh	;@04E56
	out	92h, al	;@04E58
	db	0EBh, 55h	; jmp @@12	;@04E5A
	db	90h	;@04E5C
@@6:	cmp	al, 4	;@04E5D
	jne	@@7	;@04E5F
	db	0EBh, 4Eh	; jmp @@12	;@04E61
	db	90h	;@04E63
@@7:	cmp	al, 5	;@04E64
	jne	@@9	;@04E66
	mov	ah, 4	;@04E68
	call	dword ptr cs:L04CAB	;@04E6A
	cmp	bl, 80h	;@04E6F
	jb	@@8	;@04E72
	db	0EBh, 50h	; jmp @@15	;@04E74
	db	90h	;@04E76
@@8:	db	0EBh, 38h	; jmp @@12	;@04E77
	db	90h	;@04E79
@@9:	cmp	al, 6	;@04E7A
	jne	@@10	;@04E7C
	db	0E8h, 86h, 0	; call L04F07	;@04E7E
	mov	al, 0B1h	;@04E81
	out	64h, al	;@04E83
	db	0E8h, 7Fh, 0	; call L04F07	;@04E85
	mov	al, 0A9h	;@04E88
	out	64h, al	;@04E8A
	db	0E8h, 78h, 0	; call L04F07	;@04E8C
	mov	al, 0AEh	;@04E8F
	out	64h, al	;@04E91
	db	0E8h, 71h, 0	; call L04F07	;@04E93
	db	0EBh, 19h	; jmp @@12	;@04E96
	db	90h	;@04E98
@@10:	cmp	al, 7	;@04E99
	db	75h, 6	; jne @@11	;@04E9B
	db	0EBh, 27h	; jmp @@15	;@04E9D
	db	90h, 0EBh, 0Fh, 90h	;@04E9F
@@11:	db	52h	; push dx	;@04EA3
	mov	dx, 0B6h	;@04EA4
	call	L046D3	;@04EA7
	pop	dx	;@04EAA
	mov	al, 1	;@04EAB
	mov	ah, 4Ch	;@04EAD
	int	21h	;@04EAF
@@12:	xor	bx, bx	;@04EB1
@@13:	call	L04D06	;@04EB3
	db	73h, 0Eh	; jae @@15	;@04EB6
	dec	bx	;@04EB8
	cmp	bx, 0	;@04EB9
	db	75h, 6	; jne @@14	;@04EBC
	db	0EBh, 6	; jmp @@15	;@04EBE
	db	90h, 0EBh, 3, 90h	;@04EC0
@@14:	db	0EBh, 0EDh	; jmp @@13	;@04EC4
@@15:	pop	dx	;@04EC6
	pop	cx	;@04EC7
	pop	bx	;@04EC8
	pop	ax	;@04EC9
	ret	;@04ECA
L04ECB:	push	ax	;@04ECB
	push	bx	;@04ECC
	mov	bx, ax	;@04ECD
	call	L04F07	;@04ECF
	jne	@@10	;@04ED2
	jmp	short @@1	;@04ED4
@@1:	jmp	short @@2	;@04ED6
@@2:	jmp	short @@3	;@04ED8
@@3:	jmp	short @@4	;@04EDA
@@4:	jmp	short @@5	;@04EDC
@@5:	jmp	short @@6	;@04EDE
@@6:	mov	al, 0D1h	;@04EE0
	out	64h, al	;@04EE2
	call	L04F07	;@04EE4
	jne	@@10	;@04EE7
	jmp	short @@7	;@04EE9
@@7:	jmp	short @@8	;@04EEB
@@8:	jmp	short @@9	;@04EED
@@9:	mov	al, ah	;@04EEF
	out	60h, al	;@04EF1
	call	L04F07	;@04EF3
	jne	@@10	;@04EF6
	cmp	bl, 1	;@04EF8
	jne	@@10	;@04EFB
	mov	al, 0FFh	;@04EFD
	out	64h, al	;@04EFF
	call	L04F07	;@04F01
@@10:	pop	bx	;@04F04
	pop	ax	;@04F05
	ret	;@04F06
L04F07:	push	cx	;@04F07
	mov	cx, 2710h	;@04F08
@@1:	in	al, 64h	;@04F0B
	test	al, 2	;@04F0D
	loopne	@@1	;@04F0F
	pop	cx	;@04F11
	ret	;@04F12
S000	ends

S50A	segment para public 'CODE'
	assume	cs:S50A
L050A0:	push	dx	;@050A0
	mov	ch, cl	;@050A1
	shl	ax, cl	;@050A3
	mov	dx, bx	;@050A5
	shl	bx, cl	;@050A7
	mov	cl, 10h	;@050A9
	sub	cl, ch	;@050AB
	shr	dx, cl	;@050AD
	or	ax, dx	;@050AF
	pop	dx	;@050B1
	ret	;@050B2
L050B3:	push	dx	;@050B3
	mov	ch, cl	;@050B4
	shr	bx, cl	;@050B6
	mov	dx, ax	;@050B8
	shr	ax, cl	;@050BA
	mov	cl, 10h	;@050BC
	sub	cl, ch	;@050BE
	shl	dx, cl	;@050C0
	or	bx, dx	;@050C2
	pop	dx	;@050C4
	ret	;@050C5
L050C6	db	12h dup (0)	;@050C6
L050D8:	push	ax	;@050D8
	push	bx	;@050D9
	push	si	;@050DA
	push	di	;@050DB
	push	ds	;@050DC
	xor	ax, ax	;@050DD
	mov	bx, es	;@050DF
	mov	word ptr es:[11h], bx	;@050E1
	mov	word ptr es:[13h], ax	;@050E6
	db	0BBh	;@050EA
	dw	seg S5ED_START
	db	26h, 89h, 1Eh, 29h, 0	; mov word ptr es:[29h], bx	;@050ED
	mov	word ptr es:[2Bh], ax	;@050F2
	mov	bx, seg L050A0	;@050F6
	mov	word ptr es:[19h], bx	;@050F9
	mov	word ptr es:[1Bh], ax	;@050FE
	db	0BBh	;@05102
	dw	seg S8EF_START
	db	26h, 89h, 1Eh, 15h, 0	; mov word ptr es:[15h], bx	;@05105
	mov	word ptr es:[17h], ax	;@0510A
	db	0BBh	;@0510E
	dw	seg S5AD_START
	db	26h, 89h, 1Eh, 0Dh, 0	; mov word ptr es:[0Dh], bx	;@05111
	mov	word ptr es:[0Fh], ax	;@05116
	push	cx	;@0511A
	mov	cl, 4	;@0511B
	call	L050A0	;@0511D
	pop	cx	;@05120
	mov	word ptr es:[41h], bx	;@05121
	mov	word ptr es:[43h], ax	;@05126
	xor	ax, ax	;@0512A
	mov	bx, word ptr ds:[0B8h]	;@0512C
	push	cx	;@05130
	mov	cl, 4	;@05131
	call	L050A0	;@05133
	pop	cx	;@05136
	push	ax	;@05137
	push	bx	;@05138
	mov	bx, word ptr cs:L050C6	;@05139
	mov	ax, word ptr cs:L050C6+2	;@0513E
	cmp	ax, 0	;@05142
	jne	@@1	;@05145
	cmp	bx, 0	;@05147
	jne	@@1	;@0514A
	add	sp, 4	;@0514C
	jmp	short @@2	;@0514F
@@1:	pop	dx	;@05151
	pop	cx	;@05152
	sub	bx, dx	;@05153
	sbb	ax, cx	;@05155
	push	cx	;@05157
	mov	cl, 4	;@05158
	call	L050B3	;@0515A
	pop	cx	;@0515D
@@2:	push	ax	;@0515E
	push	bx	;@0515F
	add	bx, word ptr cs:L050C6+4	;@05160
	adc	ax, 0	;@05165
	mov	word ptr es:[21h], bx	;@05168
	mov	word ptr es:[23h], ax	;@0516D
	pop	bx	;@05171
	pop	ax	;@05172
	push	ax	;@05173
	push	bx	;@05174
	add	bx, word ptr cs:L050C6+6	;@05175
	adc	ax, 0	;@0517A
	mov	word ptr es:[25h], bx	;@0517D
	mov	word ptr es:[27h], ax	;@05182
	pop	bx	;@05186
	pop	ax	;@05187
	push	ax	;@05188
	push	bx	;@05189
	add	bx, word ptr cs:L050C6+8	;@0518A
	adc	ax, 0	;@0518F
	mov	word ptr es:[2Dh], bx	;@05192
	mov	word ptr es:[2Fh], ax	;@05197
	pop	bx	;@0519B
	pop	ax	;@0519C
	push	ax	;@0519D
	push	bx	;@0519E
	add	bx, word ptr cs:L050C6+12	;@0519F
	adc	ax, 0	;@051A4
	mov	word ptr es:[31h], bx	;@051A7
	mov	word ptr es:[33h], ax	;@051AC
	pop	bx	;@051B0
	pop	ax	;@051B1
	push	ax	;@051B2
	push	bx	;@051B3
	add	bx, word ptr cs:L050C6+14	;@051B4
	adc	ax, 0	;@051B9
	mov	word ptr es:[39h], bx	;@051BC
	mov	word ptr es:[3Bh], ax	;@051C1
	pop	bx	;@051C5
	pop	ax	;@051C6
	add	bx, word ptr cs:L050C6+10	;@051C7
	adc	ax, 0	;@051CC
	mov	word ptr es:[3Dh], bx	;@051CF
	mov	word ptr es:[3Fh], ax	;@051D4
	mov	ax, word ptr cs:L050C6+16	;@051D8
	mov	word ptr es:[8], ax	;@051DC
	pop	ds	;@051E0
	pop	di	;@051E1
	pop	si	;@051E2
	pop	bx	;@051E3
	pop	ax	;@051E4
	ret	;@051E5
L051E6	db	33h, 0C0h, 33h, 0DBh, 33h, 0C9h, 33h, 0D2h, 33h, 0F6h, 33h, 0FFh, 33h, 0EDh, 0B8h	;@051E6
	dw	seg L050A0
	db	8Eh, 0D8h, 0F7h, 6, 2Fh, 4, 60h, 0, 74h, 4, 0B0h, 30h, 0E6h, 20h, 26h, 8Eh
	db	1Eh, 0Dh, 0, 0BBh, 8, 0, 0Fh, 1, 17h, 0BBh, 60h, 0, 0Fh, 1, 1Fh, 0Fh
	db	1, 0E0h, 26h, 0A3h, 50h, 0, 0Dh, 1, 0, 0Fh, 1, 0F0h, 0EAh, 0, 0, 20h
	db	0
L05228:	call	L050D8	;@05228
	call	@@2	;@0522B
	ret	;@0522E
@@1:	push	cx	;@0522F
	mov	cl, 4	;@05230
	call	L050A0	;@05232
	pop	cx	;@05235
	mov	word ptr [si+2], bx	;@05236
	mov	byte ptr [si+4], al	;@05239
	mov	byte ptr [si+7], ah	;@0523C
	mov	ax, cx	;@0523F
	mov	bx, dx	;@05241
	push	cx	;@05243
	push	ax	;@05244
	push	bx	;@05245
	sub	bx, 1	;@05246
	sbb	ax, 0	;@05249
	mov	word ptr [si], bx	;@0524C
	mov	cl, byte ptr [si+6]	;@0524E
	and	cl, 0F0h	;@05251
	and	al, 0Fh	;@05254
	or	cl, al	;@05256
	mov	byte ptr [si+6], cl	;@05258
	pop	bx	;@0525B
	pop	ax	;@0525C
	pop	cx	;@0525D
	push	cx	;@0525E
	mov	cl, 0	;@0525F
	shl	cl, 7	;@05261
	and	byte ptr [si+6], 7Fh	;@05264
	or	byte ptr [si+6], cl	;@05268
	pop	cx	;@0526B
	ret	;@0526C
@@2:	push	ds	;@0526D
	push	si	;@0526E
	push	ax	;@0526F
	push	bx	;@05270
	push	cx	;@05271
	push	dx	;@05272
	push	di	;@05273
	mov	bx, word ptr es:[0Dh]	;@05274
	mov	ax, word ptr es:[0Fh]	;@05279
	mov	ds, bx	;@0527D
	mov	si, 8	;@0527F
	mov	bx, word ptr es:[0Dh]	;@05282
	mov	ax, word ptr es:[0Fh]	;@05287
	mov	dx, 400h	;@0528B
	xor	cx, cx	;@0528E
	call	@@1	;@05290
	mov	si, 60h	;@05293
	mov	bx, word ptr es:[21h]	;@05296
	mov	ax, word ptr es:[23h]	;@0529B
	mov	dx, 800h	;@0529F
	xor	cx, cx	;@052A2
	call	@@1	;@052A4
	mov	si, 0D0h	;@052A7
	mov	bx, word ptr es:[0Dh]	;@052AA
	mov	ax, word ptr es:[0Fh]	;@052AF
	mov	dx, 400h	;@052B3
	xor	cx, cx	;@052B6
	call	@@1	;@052B8
	mov	si, 0D8h	;@052BB
	mov	bx, word ptr es:[21h]	;@052BE
	mov	ax, word ptr es:[23h]	;@052C3
	mov	dx, 800h	;@052C7
	xor	cx, cx	;@052CA
	call	@@1	;@052CC
	mov	si, 20h	;@052CF
	mov	bx, word ptr es:[31h]	;@052D2
	mov	ax, word ptr es:[33h]	;@052D7
	mov	dx, 0	;@052DB
	mov	cx, 1	;@052DE
	call	@@1	;@052E1
	mov	bx, word ptr es:[39h]	;@052E4
	mov	ax, word ptr es:[3Bh]	;@052E9
	sub	bx, word ptr es:[31h]	;@052ED
	sbb	ax, word ptr es:[33h]	;@052F2
	push	cx	;@052F7
	mov	cl, 4	;@052F8
	call	L050A0	;@052FA
	pop	cx	;@052FD
	mov	di, bx	;@052FE
	mov	si, 48h	;@05300
	mov	bx, word ptr es:[31h]	;@05303
	mov	ax, word ptr es:[33h]	;@05308
	mov	dx, di	;@0530C
	xor	cx, cx	;@0530E
	call	@@1	;@05310
	mov	si, 88h	;@05313
	mov	bx, word ptr es:[31h]	;@05316
	mov	ax, word ptr es:[33h]	;@0531B
	mov	dx, di	;@0531F
	xor	cx, cx	;@05321
	call	@@1	;@05323
	mov	si, 0A0h	;@05326
	mov	bx, word ptr es:[31h]	;@05329
	mov	ax, word ptr es:[33h]	;@0532E
	mov	dx, di	;@05332
	xor	cx, cx	;@05334
	call	@@1	;@05336
	mov	si, 80h	;@05339
	mov	bx, word ptr es:[31h]	;@0533C
	mov	ax, word ptr es:[33h]	;@05341
	mov	dx, 0	;@05345
	mov	cx, 1	;@05348
	call	@@1	;@0534B
	mov	si, 90h	;@0534E
	mov	bx, word ptr es:[29h]	;@05351
	mov	ax, word ptr es:[2Bh]	;@05356
	mov	dx, 0	;@0535A
	mov	cx, 1	;@0535D
	call	@@1	;@05360
	mov	si, 68h	;@05363
	mov	bx, word ptr es:[15h]	;@05366
	mov	ax, word ptr es:[17h]	;@0536B
	mov	dx, 0	;@0536F
	mov	cx, 1	;@05372
	call	@@1	;@05375
	mov	bx, word ptr es:[2Dh]	;@05378
	mov	ax, word ptr es:[2Fh]	;@0537D
	sub	bx, word ptr es:[25h]	;@05381
	sbb	ax, word ptr es:[27h]	;@05386
	push	cx	;@0538B
	mov	cl, 4	;@0538C
	call	L050A0	;@0538E
	pop	cx	;@05391
	mov	di, bx	;@05392
	mov	si, 38h	;@05394
	mov	bx, word ptr es:[25h]	;@05397
	mov	ax, word ptr es:[27h]	;@0539C
	mov	dx, di	;@053A0
	xor	cx, cx	;@053A2
	call	@@1	;@053A4
	mov	si, 28h	;@053A7
	mov	bx, word ptr es:[11h]	;@053AA
	mov	ax, word ptr es:[13h]	;@053AF
	mov	dx, 2F20h	;@053B3
	xor	cx, cx	;@053B6
	call	@@1	;@053B8
	mov	si, 10h	;@053BB
	mov	bx, word ptr es:[11h]	;@053BE
	mov	ax, word ptr es:[13h]	;@053C3
	mov	dx, 0	;@053C7
	mov	cx, 1	;@053CA
	call	@@1	;@053CD
	mov	bx, word ptr es:[3Dh]	;@053D0
	mov	ax, word ptr es:[3Fh]	;@053D5
	sub	bx, word ptr es:[2Dh]	;@053D9
	sbb	ax, word ptr es:[2Fh]	;@053DE
	push	cx	;@053E3
	mov	cl, 4	;@053E4
	call	L050A0	;@053E6
	pop	cx	;@053E9
	mov	di, bx	;@053EA
	mov	si, 100h	;@053EC
	mov	bx, word ptr es:[2Dh]	;@053EF
	mov	ax, word ptr es:[2Fh]	;@053F4
	mov	dx, di	;@053F8
	xor	cx, cx	;@053FA
	call	@@1	;@053FC
	mov	si, 108h	;@053FF
	mov	bx, word ptr es:[2Dh]	;@05402
	mov	ax, word ptr es:[2Fh]	;@05407
	mov	dx, di	;@0540B
	xor	cx, cx	;@0540D
	call	@@1	;@0540F
	mov	si, 110h	;@05412
	mov	bx, word ptr es:[2Dh]	;@05415
	mov	ax, word ptr es:[2Fh]	;@0541A
	mov	dx, di	;@0541E
	xor	cx, cx	;@05420
	call	@@1	;@05422
	mov	si, 58h	;@05425
	mov	bx, word ptr es:[2Dh]	;@05428
	mov	ax, word ptr es:[2Fh]	;@0542D
	mov	dx, di	;@05431
	xor	cx, cx	;@05433
	call	@@1	;@05435
	mov	si, 118h	;@05438
	mov	bx, word ptr es:[19h]	;@0543B
	mov	ax, word ptr es:[1Bh]	;@05440
	mov	dx, 0	;@05444
	mov	cx, 1	;@05447
	call	@@1	;@0544A
	mov	si, 120h	;@0544D
	mov	bx, word ptr es:[19h]	;@05450
	mov	ax, word ptr es:[1Bh]	;@05455
	mov	dx, 0	;@05459
	mov	cx, 1	;@0545C
	call	@@1	;@0545F
	mov	word ptr cs:L054AA, 3FFh	;@05462
	mov	bx, word ptr es:[0Dh]	;@05469
	mov	ax, word ptr es:[0Fh]	;@0546E
	push	cx	;@05472
	mov	cl, 4	;@05473
	call	L050A0	;@05475
	pop	cx	;@05478
	mov	word ptr cs:L054AA+2, bx	;@05479
	mov	word ptr cs:L054AA+4, ax	;@0547E
	mov	word ptr cs:L054AA+6, 7FFh	;@05482
	mov	bx, word ptr es:[21h]	;@05489
	mov	ax, word ptr es:[23h]	;@0548E
	push	cx	;@05492
	mov	cl, 4	;@05493
	call	L050A0	;@05495
	pop	cx	;@05498
	mov	word ptr cs:L054AA+8, bx	;@05499
	mov	word ptr cs:L054AA+10, ax	;@0549E
	pop	di	;@054A2
	pop	dx	;@054A3
	pop	cx	;@054A4
	pop	bx	;@054A5
	pop	ax	;@054A6
	pop	si	;@054A7
	pop	ds	;@054A8
	ret	;@054A9
L054AA	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0, 0, 0, 0, 0	;@054AA
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0
L054E8:	push	ax	;@054E8
	push	bx	;@054E9
	push	cx	;@054EA
	push	si	;@054EB
	push	di	;@054EC
	mov	cx, 10h	;@054ED
	add	si, 2	;@054F0
	push	es	;@054F3
	push	cs	;@054F4
	pop	es	;@054F5
	mov	di, 42Ah	;@054F6
	cld	;@054F9
	rep movsb	;@054FA
	pop	es	;@054FC
	mov	word ptr cs:L054AA+48, bx	;@054FD
	mov	ax, 47Dh	;@05502
	mov	word ptr es:[0Bh], ax	;@05505
	mov	ax, word ptr ds:[0B4h]	;@05509
	mov	word ptr cs:L051E6+62, ax	;@0550C
	mov	word ptr es:[8], ax	;@05510
	call	L05228	;@05514
	pop	di	;@05517
	pop	si	;@05518
	pop	cx	;@05519
	pop	bx	;@0551A
	pop	ax	;@0551B
	retf	;@0551C
	db	0B8h, 10h, 0, 8Eh, 0D8h, 8Eh, 0C0h, 0B8h, 68h, 0, 8Eh, 0D0h, 0BCh, 64h, 0, 26h	;@0551D
	db	0Fh, 0, 0Eh, 35h, 2, 26h, 0Fh, 0, 6, 37h, 2, 0Fh, 1, 0E3h, 26h, 89h
	db	1Eh, 52h, 0, 26h, 0A1h, 50h, 0, 25h, 6, 0, 83h, 0E3h, 0F9h, 0Bh, 0D8h, 0Fh
	db	1, 0F3h, 0E8h, 1Fh, 0, 2Eh, 0A1h, 3Ah, 4, 8Eh, 0D8h, 8Eh, 0C0h, 2Eh, 0F7h, 6
	db	2Dh, 4, 6, 0, 74h, 3, 0E8h, 0F4h, 2, 26h, 8Eh, 16h, 0, 0, 26h, 8Bh
	db	26h, 2, 0, 0CFh, 2Eh, 0F7h, 6, 2Dh, 4, 2, 0, 74h, 3, 0E8h, 0CCh, 2
	db	2Eh, 0F7h, 6, 2Dh, 4, 4, 0, 74h, 3, 0E8h, 0DCh, 2, 2Eh, 0A0h, 2Ch, 4
	db	3Ch, 4, 75h, 6, 0EBh, 39h, 90h, 0EBh, 36h, 90h, 3Ch, 1, 75h, 6, 0E9h, 8Dh
	db	1, 0EBh, 2Ch, 90h, 3Ch, 2, 75h, 6, 0E9h, 27h, 1, 0EBh, 22h, 90h, 3Ch, 3
	db	75h, 6, 0E9h, 0B6h, 1, 0EBh, 18h, 90h, 3Ch, 5, 75h, 6, 0E9h, 0EAh, 1, 0EBh
	db	0Eh, 90h, 3Ch, 7, 75h, 6, 0E9h, 0D9h, 0, 0EBh, 4, 90h, 0E9h, 5Fh, 1, 0B8h
	db	10h, 0, 8Eh, 0D8h, 8Eh, 0C0h, 8Eh, 0E0h, 8Eh, 0E8h, 0BBh, 3Dh, 2, 0Fh, 1, 0Fh
	db	0Fh, 1, 6, 6Fh, 1, 83h, 3Eh, 4Dh, 0, 0, 74h, 3, 0EBh, 41h, 90h, 2Eh
	db	0F7h, 6, 2Fh, 4, 60h, 0, 74h, 0Ch, 0BAh, 0B0h, 31h, 0B0h, 1, 0EEh, 0EBh, 0
	db	0EBh, 0, 0EBh, 0, 66h, 0Fh, 20h, 0C0h, 24h, 0F6h, 66h, 0Fh, 22h, 0C0h, 0EAh
	dd	L05610
L05610:	nop	;@05610
	db	66h, 2Eh, 0Fh, 1, 1Eh, 16h, 4	; lidt fword ptr cs:L054AA+12	;@05611
	db	0B8h	;@05618
	dw	seg S8EF_START
	mov	ss, ax	;@0561B
	nop	;@0561D
	test	word ptr cs:L054AA+37, 60h	;@0561E
	je	@@1	;@05625
	xor	al, al	;@05627
	out	20h, al	;@05629
@@1:	ret	;@0562B
	db	0B8h, 8, 0, 8Eh, 0D8h, 66h, 0FFh, 36h, 30h, 0, 66h, 0FFh, 36h, 34h, 0, 0C7h	;@0562C
	db	6, 30h, 0, 0FFh, 0FFh, 0C7h, 6, 32h, 0, 0, 0, 0C7h, 6, 34h, 0, 0
	db	92h, 0C7h, 6, 36h, 0, 8Fh, 0, 0B8h, 30h, 0, 8Eh, 0D8h, 8Bh, 0C4h, 66h, 33h
	db	0E4h, 8Bh, 0E0h, 6Ah, 0, 6Ah, 0, 6Ah, 0, 68h
	dw	seg S5AD_START
	db	6Ah, 0, 68h
	dw	seg S5FD_START
	db	6Ah, 0, 68h
	dw	seg S8EF_START
	db	6Ah, 0, 50h, 6Ah, 2, 68h, 2, 30h, 6Ah, 0, 68h
	dw	seg L050A0
	db	6Ah, 0, 68h, 0EFh, 5, 0Fh, 6, 0B8h, 0Ch, 0DEh, 66h, 26h, 0FFh, 1Eh, 49h, 0
	db	66h, 8Fh, 6, 34h, 0, 66h, 8Fh, 6, 30h, 0, 0B8h
	dw	seg S5FD_START
	db	8Eh, 0D8h, 0C3h, 0E4h, 35h, 0EBh, 0, 0EBh, 0, 0EBh, 0, 24h, 7Fh, 0E6h, 35h, 68h
	dw	seg L050A0
	db	68h, 2Ah, 6, 0B8h, 98h, 0, 8Eh, 0D8h, 0B8h
	dw	seg S8EF_START
	db	0A3h, 6, 4, 89h, 26h, 4, 4, 0FAh, 0E6h, 50h, 0B0h, 0, 0E6h, 0F0h, 0F4h, 0EBh
	db	0FDh, 0FBh, 0E6h, 52h, 90h, 0C3h, 60h, 0B8h, 20h, 1, 8Eh, 0D8h, 8Eh, 0C0h, 89h, 26h
	db	3Ch, 4, 0B8h, 98h, 0, 8Eh, 0D8h, 0A1h, 0FEh, 3, 26h, 0A3h, 3Eh, 4, 0B8h
	dw	seg L050A0
	db	0A3h, 69h, 4, 0C7h, 6, 67h, 4, 72h, 6, 0B0h, 8Fh, 0E6h, 70h, 0EBh, 0, 0EBh
	db	0, 0EBh, 0, 0B0h, 0Ah, 0E6h, 71h, 0EBh, 0, 0EBh, 0, 0EBh, 0, 0BBh, 20h, 4
	db	2Eh, 0Fh, 1, 1Fh, 0CCh, 0F4h, 0EBh, 0FDh, 0FAh, 0FCh, 0B8h
	dw	seg S8EF_START
	db	8Eh, 0D0h, 2Eh, 8Bh, 26h, 3Ch, 4, 33h, 0C0h, 8Eh, 0D8h, 2Eh, 0A1h, 3Eh, 4, 0A3h
	db	0FEh, 3, 61h, 0C3h, 9Ch, 68h
	dw	seg L050A0
	db	68h, 0C5h, 6, 60h, 6Ah, 0, 6Ah, 0, 0B8h, 98h, 0, 8Eh, 0D8h, 0B8h
	dw	seg S8EF_START
	db	0A3h, 69h, 4, 89h, 26h, 67h, 4, 0B0h, 8Fh, 0E6h, 70h, 0EBh, 0, 0EBh, 0, 0EBh
	db	0, 0B0h, 9, 0E6h, 71h, 0EBh, 0, 0EBh, 0, 0EBh, 0, 0BBh, 20h, 4, 2Eh, 0Fh
	db	1, 1Fh, 0CCh, 0F4h, 0EBh, 0FDh, 0FAh, 0FCh, 0C3h, 9Ch, 68h
	dw	seg L050A0
	db	68h, 3, 7, 50h, 6Ah, 0, 60h, 6Ah, 0, 0B8h, 98h, 0, 8Eh, 0D8h, 0B8h
	dw	seg S8EF_START
	db	0A3h, 69h, 4, 89h, 26h, 67h, 4, 0B0h, 8Fh, 0E6h, 70h, 0EBh, 0, 0EBh, 0, 0EBh
	db	0, 0B0h, 9, 0E6h, 71h, 0EBh, 0, 0EBh, 0, 0EBh, 0, 0BBh, 20h, 4, 2Eh, 0Fh
	db	1, 1Fh, 0CCh, 0F4h, 0EBh, 0FDh, 0FAh, 0FCh, 0C3h, 0FAh, 0B0h, 8Fh, 0E6h, 70h, 0EBh, 0
	db	0EBh, 0, 0EBh, 0, 0B8h, 0C0h, 0, 8Eh, 0D8h, 0B8h, 0C8h, 0, 8Eh, 0C0h, 8Bh, 3Eh
	db	0F1h, 0FFh, 0B8h, 20h, 1, 8Eh, 0D8h, 26h, 8Bh, 5, 0A3h, 40h, 4, 26h, 8Bh, 45h
	db	2, 0A3h, 42h, 4, 26h, 8Bh, 45h, 4, 0A3h, 44h, 4, 0B8h, 0C0h, 0, 8Eh, 0D8h
	db	26h, 0C6h, 5, 0EAh, 26h, 0C7h, 45h, 1, 6Eh, 7, 0B8h
	dw	seg L050A0
	db	26h, 89h, 45h, 3, 0A1h, 0, 80h, 0A1h, 0, 0E0h, 0A1h, 0, 80h, 0A1h, 0, 0E0h
	db	0B8h, 20h, 1, 8Eh, 0D8h, 89h, 26h, 3Ch, 4, 0BBh, 20h, 4, 2Eh, 0Fh, 1, 1Fh
	db	0CCh, 0F4h, 0EBh, 0FDh, 0FAh, 0B8h
	dw	seg S8EF_START
	db	8Eh, 0D0h, 2Eh, 8Bh, 26h, 3Ch, 4, 0B8h, 0, 0F0h, 8Eh, 0D8h, 0B8h, 0, 70h, 8Eh
	db	0C0h, 8Bh, 3Eh, 0F1h, 0FFh, 2Eh, 0A1h, 44h, 4, 26h, 89h, 45h, 4, 2Eh, 0A1h, 42h
	db	4, 26h, 89h, 45h, 2, 2Eh, 0A1h, 40h, 4, 26h, 89h, 5, 0B0h, 0Fh, 0E6h, 70h
	db	0EBh, 0, 0EBh, 0, 0EBh, 0, 0C3h, 53h, 1Eh, 0BBh, 20h, 1, 8Eh, 0DBh, 0E8h, 32h
	db	0, 89h, 1Eh, 46h, 4, 1Fh, 5Bh, 0C3h, 53h, 2Eh, 8Bh, 1Eh, 46h, 4, 0E8h, 0Bh
	db	0, 5Bh, 0C3h, 53h, 0BBh, 0FFh, 0FFh, 0E8h, 2, 0, 5Bh, 0C3h, 50h, 8Ah, 0C7h, 0E6h
	db	21h, 0EBh, 0, 0EBh, 0, 0EBh, 0, 8Ah, 0C3h, 0E6h, 0A1h, 0EBh, 0, 0EBh, 0, 0EBh
	db	0, 58h, 0C3h, 50h, 0E4h, 21h, 8Ah, 0F8h, 0E4h, 0A1h, 8Ah, 0D8h, 58h, 0C3h
S50A	ends

S9FA	segment byte public 'CODE'
	assume	cs:S9FA
L0B74F:	push	ds	;@0B74F
	mov	ax, seg S589_START	;@0B750
	mov	ds, ax	;@0B753
	mov	ax, 0DE0Ah	;@0B755
	int	67h	;@0B758
	mov	word ptr ds:[154h], bx	;@0B75A
	mov	word ptr ds:[156h], cx	;@0B75E
	db	66h, 0A1h, 44h, 1	; mov eax, dword ptr ds:[144h]	;@0B762
	db	66h, 2Eh, 0A3h, 99h, 17h	; mov dword ptr cs:L0B739, eax	;@0B766
	pop	ds	;@0B76B
	mov	bx, seg L050A0	;@0B76C
	db	66h, 0C1h, 0E3h, 4	; shl ebx, 4	;@0B76F
	db	66h, 81h, 0C3h, 0Ah, 4, 0, 0	; add ebx, 40Ah	;@0B773
	db	66h, 2Eh, 89h, 1Eh, 9Dh, 17h	; mov dword ptr cs:L0B739+4, ebx	;@0B77A
	db	66h, 33h, 0DBh	; xor ebx, ebx	;@0B780
	mov	bx, seg L050A0	;@0B783
	db	66h, 0C1h, 0E3h, 4	; shl ebx, 4	;@0B786
	db	66h, 81h, 0C3h, 10h, 4, 0, 0	; add ebx, 410h	;@0B78A
	db	66h, 2Eh, 89h, 1Eh, 0A1h, 17h	; mov dword ptr cs:L0B739+8, ebx	;@0B791
	mov	word ptr cs:L0B739+12, 0	;@0B797
	mov	word ptr cs:L0B739+14, 140h	;@0B79E
	mov	ax, seg S589_START	;@0B7A5
	mov	ds, ax	;@0B7A8
	mov	ax, word ptr ds:[0B4h]	;@0B7AA
	mov	word ptr cs:L0B739+16, ax	;@0B7AD
	mov	word ptr cs:L0B739+18, 0	;@0B7B1
	mov	ax, 20h	;@0B7B8
	mov	word ptr cs:L0B739+20, ax	;@0B7BB
	db	66h, 33h, 0F6h	; xor esi, esi	;@0B7BF
	mov	si, cs	;@0B7C2
	db	66h, 0C1h, 0E6h, 4	; shl esi, 4	;@0B7C4
	db	66h, 81h, 0C6h, 99h, 17h, 0, 0	; add esi, 1799h	;@0B7C8
	mov	ax, 0DE0Ch	;@0B7CF
	int	67h	;@0B7D2
	inc	bp	;@0B7D4
	dec	bp	;@0B7D5
	dec	bp	;@0B7D6
	pop	ax	;@0B7D7
	pop	ax	;@0B7D8
	pop	ax	;@0B7D9
	pop	ax	;@0B7DA
	xor	byte ptr [bx+si], al	;@0B7DB
L0B7DD:	push	si	;@0B7DD
	push	di	;@0B7DE
	push	ds	;@0B7DF
	push	es	;@0B7E0
	push	bp	;@0B7E1
	mov	bp, sp	;@0B7E2
	sub	sp, 2	;@0B7E4
	mov	ax, seg S589_START	;@0B7E7
	mov	ds, ax	;@0B7EA
	mov	ah, 43h	;@0B7EC
	mov	bx, 1	;@0B7EE
	int	67h	;@0B7F1
	mov	cx, dx	;@0B7F3
	mov	ax, 0DE02h	;@0B7F5
	int	67h	;@0B7F8
	xchg	cx, dx	;@0B7FA
	mov	ah, 45h	;@0B7FC
	int	67h	;@0B7FE
	xchg	dx, cx	;@0B800
	db	66h, 81h, 0C2h, 0, 10h, 0, 0	; add edx, 1000h	;@0B802
	db	66h, 0C1h, 0EAh, 16h	; shr edx, 16h	;@0B809
	inc	dx	;@0B80D
	inc	dx	;@0B80E
	cmp	dx, 4	;@0B80F
	jbe	@@1	;@0B812
	mov	dx, 4	;@0B814
@@1:	mov	word ptr [bp-2], dx	;@0B817
	inc	dx	;@0B81A
	shr	dx, 2	;@0B81B
	inc	dx	;@0B81E
	mov	ax, 4300h	;@0B81F
	mov	bx, dx	;@0B822
	push	bx	;@0B824
	int	67h	;@0B825
	pop	cx	;@0B827
	cmp	ah, 0	;@0B828
	je	@@2	;@0B82B
	sub	sp, 4	;@0B82D
	push	bp	;@0B830
	mov	bp, sp	;@0B831
	mov	word ptr [bp+4], 0	;@0B833
	mov	word ptr [bp+2], 59h	;@0B838
	pop	bp	;@0B83D
	call	far ptr L048E0	;@0B83E
	add	sp, 4	;@0B843
	sub	sp, 4	;@0B846
	push	bp	;@0B849
	mov	bp, sp	;@0B84A
	mov	word ptr [bp+4], 0	;@0B84C
	mov	word ptr [bp+2], 53h	;@0B851
	pop	bp	;@0B856
	call	far ptr L048E0	;@0B857
	add	sp, 4	;@0B85C
	mov	al, 1	;@0B85F
	mov	ah, 4Ch	;@0B861
	int	21h	;@0B863
@@2:	mov	word ptr ds:[140h], dx	;@0B865
	xor	al, al	;@0B869
	xor	bx, bx	;@0B86B
@@3:	cmp	cx, 0	;@0B86D
	jbe	@@4	;@0B870
	mov	ah, 44h	;@0B872
	int	67h	;@0B874
	inc	al	;@0B876
	inc	bx	;@0B878
	dec	cx	;@0B879
	jmp	@@3	;@0B87A
@@4:	mov	ah, 41h	;@0B87C
	int	67h	;@0B87E
	mov	es, bx	;@0B880
	xor	di, di	;@0B882
	db	66h, 33h, 0C0h	; xor eax, eax	;@0B884
	mov	cx, 400h	;@0B887
	cld	;@0B88A
	db	66h, 0F3h, 0ABh	; rep stosd	;@0B88B
	mov	cx, es	;@0B88E
	mov	cl, ch	;@0B890
	xor	ch, ch	;@0B892
	mov	ax, 0DE06h	;@0B894
	int	67h	;@0B897
	and	dx, 0F000h	;@0B899
	db	66h, 89h, 16h, 44h, 1	; mov dword ptr ds:[144h], edx	;@0B89D
	inc	cx	;@0B8A2
	mov	si, 0	;@0B8A3
@@5:	cmp	word ptr [bp-2], 0	;@0B8A6
	jbe	@@6	;@0B8AA
	mov	ax, 0DE06h	;@0B8AC
	int	67h	;@0B8AF
	and	dx, 0F000h	;@0B8B1
	or	dx, 7	;@0B8B5
	db	66h, 26h, 89h, 14h	; mov dword ptr es:[si], edx	;@0B8B8
	add	si, 4	;@0B8BC
	dec	word ptr [bp-2]	;@0B8BF
	inc	cx	;@0B8C2
	jmp	@@5	;@0B8C3
@@6:	mov	di, 1000h	;@0B8C5
	mov	word ptr ds:[14Ah], es	;@0B8C8
	mov	word ptr ds:[148h], di	;@0B8CC
	mov	ax, seg S5AD_START	;@0B8D0
	mov	ds, ax	;@0B8D3
L0B8D5:	mov	si, 128h	;@0B8D5
	mov	ax, 0DE01h	;@0B8D8
	int	67h	;@0B8DB
	mov	ax, seg S5FD_START	;@0B8DD
	mov	es, ax	;@0B8E0
	db	66h, 26h, 89h, 1Eh, 49h, 0	; mov dword ptr es:[49h], ebx	;@0B8E2
	mov	ax, seg S589_START	;@0B8E8
	mov	ds, ax	;@0B8EB
	mov	word ptr ds:[14Ch], di	;@0B8ED
	db	66h, 0A1h, 44h, 1	; mov eax, dword ptr ds:[144h]	;@0B8F1
	db	66h, 26h, 0A3h, 6Bh, 1	; mov dword ptr es:[16Bh], eax	;@0B8F5
	call	L0B950	;@0B8FA
	push	ax	;@0B8FD
	push	dx	;@0B8FE
	push	cx	;@0B8FF
L0B900:	push	bx	;@0B900
	mov	dx, word ptr ds:[142h]	;@0B901
	mov	bx, 0FFFFh	;@0B905
	mov	al, 0	;@0B908
	mov	ah, 44h	;@0B90A
	int	67h	;@0B90C
	pop	bx	;@0B90E
	pop	cx	;@0B90F
	push	cx	;@0B910
	push	bx	;@0B911
	mov	dx, word ptr ds:[142h]	;@0B912
	mov	bx, 0FFFFh	;@0B916
	mov	al, 1	;@0B919
	mov	ah, 44h	;@0B91B
	int	67h	;@0B91D
	pop	bx	;@0B91F
	pop	cx	;@0B920
	push	cx	;@0B921
	push	bx	;@0B922
	mov	dx, word ptr ds:[142h]	;@0B923
	mov	bx, 0FFFFh	;@0B927
	mov	al, 2	;@0B92A
	mov	ah, 44h	;@0B92C
	int	67h	;@0B92E
	pop	bx	;@0B930
	pop	cx	;@0B931
	push	cx	;@0B932
	push	bx	;@0B933
	mov	dx, word ptr ds:[142h]	;@0B934
	mov	bx, 0FFFFh	;@0B938
	mov	al, 3	;@0B93B
	mov	ah, 44h	;@0B93D
	int	67h	;@0B93F
	pop	bx	;@0B941
	pop	cx	;@0B942
	pop	dx	;@0B943
	pop	ax	;@0B944
	call	L0BB60	;@0B945
	mov	sp, bp	;@0B948
	pop	bp	;@0B94A
	pop	es	;@0B94B
	pop	ds	;@0B94C
	pop	di	;@0B94D
	pop	si	;@0B94E
	retf	;@0B94F
L0B950:	push	es	;@0B950
	push	bp	;@0B951
	mov	bp, sp	;@0B952
	sub	sp, 0Ah	;@0B954
	db	66h, 33h, 0C0h	; xor eax, eax	;@0B957
	db	66h, 89h, 46h, 0F8h	; mov dword ptr [bp-8], eax	;@0B95A
	mov	ax, seg S589_START	;@0B95E
	mov	ds, ax	;@0B961
	db	66h, 33h, 0DBh	; xor ebx, ebx	;@0B963
	mov	bx, di	;@0B966
	sub	bx, word ptr ds:[148h]	;@0B968
	db	66h, 0C1h, 0E3h, 0Ah	; shl ebx, 0Ah	;@0B96C
	db	66h, 89h, 5Eh, 0FCh	; mov dword ptr [bp-4], ebx	;@0B970
	db	66h, 8Bh, 1Eh, 0FCh, 0	; mov ebx, dword ptr ds:[0FCh]	;@0B974
	db	66h, 0C1h, 0EBh, 0Eh	; shr ebx, 0Eh	;@0B979
	db	66h, 8Bh, 0CBh	; mov ecx, ebx	;@0B97D
	mov	ah, 42h	;@0B980
	int	67h	;@0B982
	or	cx, cx	;@0B984
	jne	@@1	;@0B986
	mov	cx, bx	;@0B988
@@1:	cmp	bx, cx	;@0B98A
	jge	@@2	;@0B98C
	mov	cx, bx	;@0B98E
@@2:	or	cx, cx	;@0B990
	jne	@@4	;@0B992
@@3:	sub	sp, 4	;@0B994
	push	bp	;@0B997
	mov	bp, sp	;@0B998
	mov	word ptr [bp+4], 0	;@0B99A
	mov	word ptr [bp+2], 59h	;@0B99F
	pop	bp	;@0B9A4
	call	far ptr L048E0	;@0B9A5
	add	sp, 4	;@0B9AA
	sub	sp, 4	;@0B9AD
	push	bp	;@0B9B0
	mov	bp, sp	;@0B9B1
	mov	word ptr [bp+4], 0	;@0B9B3
	mov	word ptr [bp+2], 53h	;@0B9B8
	pop	bp	;@0B9BD
	call	far ptr L048E0	;@0B9BE
	add	sp, 4	;@0B9C3
	mov	al, 1	;@0B9C6
	mov	ah, 4Ch	;@0B9C8
	int	21h	;@0B9CA
@@4:	mov	bx, cx	;@0B9CC
	mov	ah, 43h	;@0B9CE
	int	67h	;@0B9D0
	cmp	ah, 0	;@0B9D2
	jne	@@3	;@0B9D5
	mov	word ptr ds:[142h], dx	;@0B9D7
	mov	es, word ptr ds:[14Ah]	;@0B9DB
	mov	ax, es	;@0B9DF
	add	ah, 8	;@0B9E1
	mov	byte ptr [bp-0Ah], ah	;@0B9E4
	mov	word ptr ds:[152h], cx	;@0B9E7
	db	66h, 0C1h, 0E1h, 0Eh	; shl ecx, 0Eh	;@0B9EB
	db	66h, 89h, 4Eh, 0F8h	; mov dword ptr [bp-8], ecx	;@0B9EF
	xor	cx, cx	;@0B9F3
	xor	si, si	;@0B9F5
	push	cx	;@0B9F7
	push	bx	;@0B9F8
	mov	dx, word ptr ds:[140h]	;@0B9F9
	mov	bx, cx	;@0B9FD
	mov	al, 0	;@0B9FF
	mov	ah, 44h	;@0BA01
	int	67h	;@0BA03
	pop	bx	;@0BA05
	pop	cx	;@0BA06
@@5:	cmp	si, word ptr ds:[152h]	;@0BA07
	jae	@@8	;@0BA0B
	push	ax	;@0BA0D
	push	cx	;@0BA0E
	push	bx	;@0BA0F
	mov	dx, word ptr ds:[142h]	;@0BA10
	mov	bx, si	;@0BA14
	mov	al, 2	;@0BA16
	mov	ah, 44h	;@0BA18
	int	67h	;@0BA1A
	pop	bx	;@0BA1C
	pop	cx	;@0BA1D
	pop	ax	;@0BA1E
	xor	bx, bx	;@0BA1F
@@6:	push	cx	;@0BA21
	xor	cx, cx	;@0BA22
	mov	cl, byte ptr [bp-0Ah]	;@0BA24
	add	cx, bx	;@0BA27
	push	ax	;@0BA29
	mov	ax, 0DE06h	;@0BA2A
	int	67h	;@0BA2D
	and	dx, 0F000h	;@0BA2F
	pop	ax	;@0BA33
	pop	cx	;@0BA34
	or	dx, 7	;@0BA35
	db	66h, 26h, 89h, 15h	; mov dword ptr es:[di], edx	;@0BA38
	add	di, 4	;@0BA3C
	cmp	di, 3FFFh	;@0BA3F
	jbe	@@7	;@0BA43
	inc	cx	;@0BA45
	push	cx	;@0BA46
	push	bx	;@0BA47
	mov	dx, word ptr ds:[140h]	;@0BA48
	mov	bx, cx	;@0BA4C
	mov	al, 0	;@0BA4E
	mov	ah, 44h	;@0BA50
	int	67h	;@0BA52
	pop	bx	;@0BA54
	pop	cx	;@0BA55
	xor	di, di	;@0BA56
@@7:	inc	bx	;@0BA58
	cmp	bx, 4	;@0BA59
	jl	@@6	;@0BA5C
	inc	si	;@0BA5E
	jmp	@@5	;@0BA5F
@@8:	mov	bx, word ptr [bp-4]	;@0BA61
	mov	ax, word ptr [bp-2]	;@0BA64
	mov	cx, word ptr [bp-6]	;@0BA67
	mov	dx, word ptr [bp-8]	;@0BA6A
	mov	sp, bp	;@0BA6D
	pop	bp	;@0BA6F
	pop	es	;@0BA70
	ret	;@0BA71
L0BA72:	push	ax	;@0BA72
	push	bx	;@0BA73
	push	cx	;@0BA74
	push	dx	;@0BA75
	push	si	;@0BA76
	push	di	;@0BA77
	push	ds	;@0BA78
	push	es	;@0BA79
	push	bp	;@0BA7A
	mov	bp, sp	;@0BA7B
	sub	sp, 2	;@0BA7D
	mov	ax, seg S589_START	;@0BA80
	mov	ds, ax	;@0BA83
	mov	es, word ptr ds:[14Ah]	;@0BA85
	db	66h, 0A1h, 0BAh, 0	; mov eax, dword ptr ds:[0BAh]	;@0BA89
	db	66h, 0C1h, 0E0h, 3	; shl eax, 3	;@0BA8D
	mov	bx, word ptr ds:[0B8h]	;@0BA91
	mov	word ptr [bp-2], bx	;@0BA95
	db	66h, 33h, 0C9h	; xor ecx, ecx	;@0BA98
	db	66h, 33h, 0D2h	; xor edx, edx	;@0BA9B
@@1:	db	66h, 0Bh, 0C0h	; or eax, eax	;@0BA9E
	je	@@4	;@0BAA1
	push	ax	;@0BAA3
	push	cx	;@0BAA4
	push	bx	;@0BAA5
	mov	dx, word ptr ds:[142h]	;@0BAA6
	mov	bx, cx	;@0BAAA
	mov	al, 0	;@0BAAC
	mov	ah, 44h	;@0BAAE
	int	67h	;@0BAB0
	pop	bx	;@0BAB2
	pop	cx	;@0BAB3
	inc	cx	;@0BAB4
	push	cx	;@0BAB5
	push	bx	;@0BAB6
	mov	dx, word ptr ds:[142h]	;@0BAB7
	mov	bx, cx	;@0BABB
	mov	al, 1	;@0BABD
	mov	ah, 44h	;@0BABF
	int	67h	;@0BAC1
	pop	bx	;@0BAC3
	pop	cx	;@0BAC4
	inc	cx	;@0BAC5
	push	cx	;@0BAC6
	push	bx	;@0BAC7
	mov	dx, word ptr ds:[142h]	;@0BAC8
	mov	bx, cx	;@0BACC
	mov	al, 2	;@0BACE
	mov	ah, 44h	;@0BAD0
	int	67h	;@0BAD2
	pop	bx	;@0BAD4
	pop	cx	;@0BAD5
	inc	cx	;@0BAD6
	push	cx	;@0BAD7
	push	bx	;@0BAD8
	mov	dx, word ptr ds:[142h]	;@0BAD9
	mov	bx, cx	;@0BADD
	mov	al, 3	;@0BADF
	mov	ah, 44h	;@0BAE1
	int	67h	;@0BAE3
	pop	bx	;@0BAE5
	pop	cx	;@0BAE6
	inc	cx	;@0BAE7
	pop	ax	;@0BAE8
	push	cx	;@0BAE9
	mov	dx, 8000h	;@0BAEA
	db	66h, 3Bh, 0C2h	; cmp eax, edx	;@0BAED
	jbe	@@2	;@0BAF0
	mov	cx, dx	;@0BAF2
	jmp	@@3	;@0BAF4
@@2:	mov	cx, ax	;@0BAF7
@@3:	db	66h, 2Bh, 0C1h	; sub eax, ecx	;@0BAF9
	push	ds	;@0BAFC
	mov	ds, word ptr [bp-2]	;@0BAFD
	xor	si, si	;@0BB00
	xor	di, di	;@0BB02
	cld	;@0BB04
	rep movsw	;@0BB05
	add	word ptr [bp-2], 1000h	;@0BB07
	pop	ds	;@0BB0C
	pop	cx	;@0BB0D
	jmp	@@1	;@0BB0E
@@4:	push	cx	;@0BB10
	push	bx	;@0BB11
	mov	dx, word ptr ds:[142h]	;@0BB12
	mov	bx, 0FFFFh	;@0BB16
	mov	al, 0	;@0BB19
	mov	ah, 44h	;@0BB1B
	int	67h	;@0BB1D
	pop	bx	;@0BB1F
	pop	cx	;@0BB20
	push	cx	;@0BB21
	push	bx	;@0BB22
	mov	dx, word ptr ds:[142h]	;@0BB23
	mov	bx, 0FFFFh	;@0BB27
	mov	al, 1	;@0BB2A
	mov	ah, 44h	;@0BB2C
	int	67h	;@0BB2E
	pop	bx	;@0BB30
	pop	cx	;@0BB31
	push	cx	;@0BB32
	push	bx	;@0BB33
	mov	dx, word ptr ds:[142h]	;@0BB34
	mov	bx, 0FFFFh	;@0BB38
	mov	al, 2	;@0BB3B
	mov	ah, 44h	;@0BB3D
	int	67h	;@0BB3F
	pop	bx	;@0BB41
	pop	cx	;@0BB42
	push	cx	;@0BB43
	push	bx	;@0BB44
	mov	dx, word ptr ds:[142h]	;@0BB45
	mov	bx, 0FFFFh	;@0BB49
	mov	al, 3	;@0BB4C
	mov	ah, 44h	;@0BB4E
	int	67h	;@0BB50
	pop	bx	;@0BB52
	pop	cx	;@0BB53
	mov	sp, bp	;@0BB54
	pop	bp	;@0BB56
	pop	es	;@0BB57
	pop	ds	;@0BB58
	pop	di	;@0BB59
	pop	si	;@0BB5A
	pop	dx	;@0BB5B
	pop	cx	;@0BB5C
	pop	bx	;@0BB5D
	pop	ax	;@0BB5E
	retf	;@0BB5F
L0BB60:	push	ax	;@0BB60
	push	ds	;@0BB61
	push	es	;@0BB62
	push	bx	;@0BB63
	push	dx	;@0BB64
	pushf	;@0BB65
	cli	;@0BB66
	mov	ax, 3567h	;@0BB67
	int	21h	;@0BB6A
	mov	ax, seg L00000	;@0BB6C
	mov	ds, ax	;@0BB6F
	mov	word ptr ds:[0], bx	;@0BB71
	mov	word ptr ds:[2], es	;@0BB75
	mov	ax, seg L00000	;@0BB79
	mov	ds, ax	;@0BB7C
	mov	dx, 12h	;@0BB7E
	mov	ax, 2567h	;@0BB81
	int	21h	;@0BB84
	popf	;@0BB86
	pop	dx	;@0BB87
	pop	bx	;@0BB88
	pop	es	;@0BB89
	pop	ds	;@0BB8A
	pop	ax	;@0BB8B
	ret	;@0BB8C
	db	0, 0, 0	;@0BB8D
S9FA	ends
	end
