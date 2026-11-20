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

	public	L04FBC
	public	S589_START
	public	S59F_START
	public	S5AD_START
	public	S5ED_START
	public	S5FD_START
	public	S8EF_START
	public	S8F6_START
	public	S908_START
	public	L09CF0
	public	L09D20
	public	S9F3_START
	extrn	L00000:byte

S000	segment byte public 'CODE'
	assume	cs:S000
	db	9Ch, 0FAh, 0B0h, 11h, 0E6h, 20h, 0EBh, 0, 0EBh, 0, 0EBh, 0, 8Ah, 0C7h, 0E6h, 21h	;@04F13
	db	0EBh, 0, 0EBh, 0, 0EBh, 0, 0B0h, 4, 0E6h, 21h, 0EBh, 0, 0EBh, 0, 0EBh, 0
	db	0B0h, 1, 0E6h, 21h, 0EBh, 0, 0EBh, 0, 0EBh, 0, 0B0h, 11h, 0E6h, 0A0h, 0EBh, 0
	db	0EBh, 0, 0EBh, 0, 8Ah, 0C3h, 0E6h, 0A1h, 0EBh, 0, 0EBh, 0, 0EBh, 0, 0B0h, 2
	db	0E6h, 0A1h, 0EBh, 0, 0EBh, 0, 0EBh, 0, 0B0h, 1, 0E6h, 0A1h, 0EBh, 0, 0EBh, 0
	db	0EBh, 0, 9Dh, 0C3h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 52h, 1Eh, 6
	db	33h, 0C0h, 8Eh, 0D8h, 81h, 3Eh, 9Eh, 1
	dw	seg L00000
	db	74h, 6, 0B8h, 1, 0, 0EBh, 0Bh, 90h, 2Eh, 0C5h, 16h, 0, 0, 0B8h, 67h, 25h
	db	0CDh, 21h, 0B8h
	dw	S5FD
	db	8Eh, 0C0h, 26h, 83h, 3Eh, 4Dh, 0, 0, 75h, 5, 33h, 0C0h, 0EBh, 18h, 90h, 0B8h
	dw	S589
	db	8Eh, 0D8h, 8Bh, 16h, 40h, 1, 0B4h, 45h, 0CDh, 67h, 8Bh, 16h, 42h, 1, 0B4h, 45h
	db	0CDh, 67h, 33h, 0C0h, 7, 1Fh, 5Ah, 0C3h
L04FBC:	push	ax	;@04FBC
	push	bx	;@04FBD
	push	cx	;@04FBE
	push	dx	;@04FBF
	push	es	;@04FC0
	push	ds	;@04FC1
	push	di	;@04FC2
	push	bp	;@04FC3
	sub	sp, 40h	;@04FC4
	mov	bp, sp	;@04FC7
	mov	ax, S589	;@04FC9
	mov	ds, ax	;@04FCC
	mov	bx, 10h	;@04FCE
	mov	cx, word ptr ds:[14Ah]	;@04FD1
	shr	cx, 8	;@04FD5
	xor	di, di	;@04FD8
@@1:	mov	ax, 0DE06h	;@04FDA
	int	67h	;@04FDD
	or	dx, 7	;@04FDF
	db	66h, 89h, 13h	; mov dword ptr [bp+di], edx	;@04FE2
	add	di, 4	;@04FE5
	inc	cx	;@04FE8
	dec	bx	;@04FE9
	cmp	bx, 0	;@04FEA
	jne	@@1	;@04FED
	mov	dx, word ptr ds:[140h]	;@04FEF
	mov	ah, 47h	;@04FF3
	int	67h	;@04FF5
	mov	di, cx	;@04FF7
	sub	di, 10h	;@04FF9
	shl	di, 2	;@04FFC
	add	di, 1000h	;@04FFF
	mov	es, word ptr ds:[14Ah]	;@05003
	push	cx	;@05007
	push	bx	;@05008
	mov	dx, word ptr ds:[140h]	;@05009
	mov	bx, 0	;@0500D
	mov	al, 0	;@05010
	mov	ah, 44h	;@05012
	int	67h	;@05014
	pop	bx	;@05016
	pop	cx	;@05017
	push	ss	;@05018
	pop	ds	;@05019
	mov	si, bp	;@0501A
	cld	;@0501C
	mov	cx, 20h	;@0501D
	rep movsw	;@05020
	mov	ax, S589	;@05022
	mov	ds, ax	;@05025
	mov	dx, word ptr ds:[140h]	;@05027
	mov	ah, 48h	;@0502B
	int	67h	;@0502D
	mov	byte ptr cs:L00000+4, 0	;@0502F
	add	sp, 40h	;@05035
	pop	bp	;@05038
	pop	di	;@05039
	pop	ds	;@0503A
	pop	es	;@0503B
	pop	dx	;@0503C
	pop	cx	;@0503D
	pop	bx	;@0503E
	pop	ax	;@0503F
	ret	;@05040
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@05041
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'VDISK', 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2Eh, 0FFh, 2Eh, 2Fh, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
S000	ends

S9CF	segment para public 'CODE'
	assume	cs:S9CF
L09CF0:	push	ax	;@09CF0
	push	cx	;@09CF1
	push	ds	;@09CF2
	push	si	;@09CF3
	push	es	;@09CF4
	push	di	;@09CF5
	mov	ax, SBB9	;@09CF6
	mov	ds, ax	;@09CF9
	mov	cx, word ptr ds:[0Eh]	;@09CFB
	jcxz	@@3	;@09CFF
	mov	si, 10h	;@09D01
@@1:	cmp	word ptr [si+7], dx	;@09D04
	jne	@@2	;@09D07
	cmp	word ptr [si+9], bx	;@09D09
	jne	@@2	;@09D0C
	mov	cx, 10h	;@09D0E
	cld	;@09D11
	rep movsb	;@09D12
	stc	;@09D14
	db	0EBh, 9	; jmp L09D20	;@09D15
	db	90h	;@09D17
@@2:	add	si, 10h	;@09D18
	loop	@@1	;@09D1B
@@3:	clc	;@09D1D
	db	0EBh, 0	; jmp short L09D20	;@09D1E
S9CF	ends

S589	segment para public 'CODE'
	assume	cs:S589
S589_START	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0	;@05890
	db	0, 10h, 93h, 0, 0, 0FFh, 0FFh, 0, 0, 0, 93h, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'MICROSOFT', 0, 'VDISK', 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '!!PARAM-BLOCK!!'
	db	4, 2, 2, 2, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 10h, 0, 0
	db	1, 0, 0, 0, 1, 0, 1, 0, 4, 0, 0, 0, 40h, 0, 0, 50h, 0, 0, 60h
	db	0, 0, 70h, 0, 0, 0, 0, 0, 0D0h, 0, 0, 0, 0, 0, 0, 2, 0, 0, 40h
	db	0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 40h, 0, 0, 0, 0, 3Ch
	db	0, 0, 0, 0, 0, 0, 10h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 70h, 0, 0, 0
	db	0, 0, 0, 0, 0, 0
S589	ends

S59F	segment para public 'CODE'
	assume	cs:S59F
S59F_START	db	'Sorry, cannot move kernel high on FMR system', 0Dh, 0Ah, 24h	;@059F0
	db	0, 0, 0FFh, 0FFh, 'Opening trace file..$. file already open', 0Dh
	db	0Ah, '$CREATE error $ ', 0Dh, 0Ah, '$. [ok]', 0Dh, 0Ah, 24h, 0
	db	0, 0, 0, 0, 0, 0, 'System: $', 0, 0, 0, 0, 0, 0, 0, 'Unknown A20 Enable method requested'
	db	0Dh, 0Ah, '$Unknown A20 Disable method requested', 0Dh, 0Ah, 24h
	db	0, 0, 0
S59F	ends

S5AD	segment para public 'CODE'
	assume	cs:S5AD
S5AD_START	db	0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 3, 0, 0, 0, 92h, 0, 0, 0FFh, 0FFh	;@05AD0
	db	0, 0, 0, 92h, 0, 0, 0, 0, 0, 0, 0, 90h, 0, 0, 0FFh, 0FFh, 0, 0
	db	0, 9Ah, 0, 0, 1Fh, 2Fh, 0, 0, 0, 92h, 0, 0, 0FFh, 0FFh, 0, 0, 0
	db	92h, 0, 0, 0, 0, 0, 0, 0, 92h, 0, 0, 0FEh, 0FFh, 0, 4, 0, 0F2h
	db	0, 0, 0FFh, 0FFh, 0, 0, 0, 92h, 0, 0, 0, 0, 0, 0, 0, 0F2h, 0, 0
	db	0FFh, 0FFh, 0, 0, 0, 0FAh, 0, 0, 0FFh, 7, 0, 0, 0, 92h, 0, 0, 0FFh
	db	0FFh, 0, 0, 0, 92h, 0, 0, 0, 40h, 0, 80h, 0Bh, 0F2h, 0, 0, 0, 40h
	db	0, 0, 0Bh, 0F2h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0, 0
	db	0, 9Ah, 0, 0, 0, 0, 0, 0, 0, 92h, 0, 0, 0FFh, 0FFh, 0, 0, 0, 92h
	db	0, 0, 0FFh, 0FFh, 0, 0, 0, 0FAh, 0, 0, 0, 0, 20h, 0, 0, 0E4h, 0
	db	0, 0, 40h, 0, 0, 0Bh, 0F2h, 0, 0, 0, 40h, 0, 80h, 0Bh, 0F2h, 0
	db	0, 0FFh, 0FFh, 0, 0, 0Fh, 0F2h, 0, 0, 0FFh, 0FFh, 0, 0, 7, 0F2h
	db	0, 0, 0FFh, 3, 0, 0, 0, 92h, 0, 0, 0FFh, 7, 0, 0, 0, 92h, 0, 0
	db	0FFh, 0FFh, 0, 0, 0, 92h, 0, 0, 0FFh, 0FFh, 0, 0, 0, 92h, 0, 0
	db	0, 0, 0, 0, 0, 92h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0
	db	0, 0, 9Ah, 0, 0, 0FFh, 0FFh, 0, 0, 0, 9Ah, 0, 0, 0FFh, 0FFh, 0
	db	0, 0, 92h, 0, 0, 0FFh, 0FFh, 0, 0, 0, 9Ah, 0, 0, 0FFh, 0FFh, 0
	db	0, 0, 92h, 0, 0, 0FFh, 0FFh, 0, 0, 0, 9Ah, 0, 0, 0FFh, 0FFh, 0
	db	0, 0, 92h, 0, 0, 0FFh, 0FFh, 0, 0, 0, 92h, 0, 0, 0FFh, 0FFh, 0
	db	0, 0, 89h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0
S5AD	ends

S5ED	segment para public 'CODE'
	assume	cs:S5ED
S5ED_START	db	100h dup (0)	;@05ED0
S5ED	ends

S5FD	segment para public 'CODE'
	assume	cs:S5FD
S5FD_START	db	2F20h dup (0)	;@05FD0
S5FD	ends

S8EF	segment para public 'CODE'
	assume	cs:S8EF
S8EF_START	db	70h dup (0)	;@08EF0
S8EF	ends

S8F6	segment para public 'CODE'
	assume	cs:S8F6
S8F6_START	db	2, 0, 0, 0, 17h, 0, 0, 29h, 0, 1, 48h, 0, 2, 62h, 0, 2, 7Eh, 0	;@08F60
	db	2, 0A1h, 0, 1, 0C8h, 0, 2, 0DFh, 0, 2, 0FEh, 0, 2, 10h, 1, 2, 3Ch
	db	1, 2, 57h, 1, 0, 7Eh, 1, 0, 93h, 1, 0, 0AFh, 1, 0, 0DCh, 1, 0
	db	0EDh, 1, 0, 0FCh, 1, 0, 34h, 2, 0, 53h, 2, 1, 72h, 2, 2, 9Bh, 2
	db	2, 0B5h, 2, 2, 0D2h, 2, 0, 0E8h, 2, 2, 0FDh, 2, 2, 1Ah, 3, 2, 39h
	db	3, 2, 56h, 3, 2, 73h, 3, 2, 88h, 3, 2, 0B1h, 3, 2, 0D3h, 3, 2
	db	0F5h, 3, 2, 9, 4, 2, 22h, 4, 2, 4Ch, 4, 2, 66h, 4, 2, 93h, 4, 2
	db	0BAh, 4, 2, 0E5h, 4, 2, 10h, 5, 2, 34h, 5, 2, 49h, 5, 2, 67h, 5
	db	2, 90h, 5, 2, 0BEh, 5, 2, 0D9h, 5, 2, 0, 6, 2, 1Fh, 6, 2, 49h
	db	6, 2, 73h, 6, 2, 97h, 6, 2, 0BAh, 6, 2, 0E1h, 6, 2, 0, 7, 2, 1Dh
	db	7, 2, 4Ah, 7, 2, 6Eh, 7, 2, 7Eh, 7, 2, 0A2h, 7, 2, 0C5h, 7, 2
	db	0EBh, 7, 2, 8, 8, 2, 2Eh, 8, 2, 3Ch, 8, 2, 4Eh, 8, 2, 6Eh, 8, 2
	db	8Fh, 8, 2, 0B0h, 8, 2, 0CDh, 8, 2, 0F7h, 8, 2, 1Ch, 9, 2, 40h
	db	9, 2, 68h, 9, 2, 88h, 9, 2, 0A4h, 9, 2, 0B9h, 9, 2, 0D5h, 9, 2
	db	0E6h, 9, 2, 0F8h, 9, 2, 0Dh, 0Ah, 2, 24h, 0Ah, 2, 37h, 0Ah, 2
	db	5Eh, 0Ah, 2, 89h, 0Ah, 2, 0D3h, 0Ah, 2, 0FDh, 0Ah, 2, 29h, 0Bh
	db	0, 73h, 0Bh, 1, 0A3h, 0Bh, 2, 0EFh, 0Bh, 1, 27h, 0Ch, 2, 44h, 0Ch
	db	0, 0, 0
S8F6	ends

S908	segment para public 'CODE'
	assume	cs:S908
S908_START	db	'Paging must be enabled', 0, 'Cannot enable A20', 0, '%s parameter obsolete, ignored'	;@09080
	db	0, 'Unrecognized monitor type', 0, 'Need value for %s parameter'
	db	0, 'Hex value too big for %s parameter', 0, 'Decimal value too big for %s parameter'
	db	0, 'Unable to open file %s', 0, 'Invalid value for %s parameter'
	db	0, 'Bad parameter: %s', 0, 'Invalid character in value for %s parameter'
	db	0, 'No GDT selectors available', 0, 'Ambiguous abbreviation -- choices are:'
	db	0, 'Kernel not installed', 0, 'Failed to initialize kernel', 0
	db	'Error processing parameters, no action taken', 0, 'Kernel installed'
	db	0, 'Kernel removed', 0, 'Kernel already installed -- please remove and rein'
	db	'stall', 0, 'Trace buffer already allocated', 0, 'Application accesses vector %x'
	db	0, 'Environment too large to copy; truncated', 0, 'Failed to get base packet'
	db	0, 'Packet contains bad data: %x', 0, 'Packet is invalid: %x'
	db	0, 'Received test packet', 0, 'Base received bad DOS packet', 0
	db	'Error in copy (base to packet)', 0, 'Error in copy (base to base)'
	db	0, 'Hummingboard queue not empty', 0, 'Base queue not empty', 0
	db	'Error while unlocking communication area', 0, 'Communication resources exhausted'
	db	0, 'Comm data buffer is too large: %x', 0, 'Packet not expected'
	db	0, 'Nested interrupt failure', 0, 'Detected spurious debug exception at %x%x'
	db	0, 'IRET not inside interrupt', 0, 'Application requested an unsupported service'
	db	0, 'Unsupported DOS function requested: %x', 0, 'Unsupported service requested: %x%xat %x%x'
	db	0, 'FCB I/O function has record size above 4kb', 0, 'Protected mode SETVEC not supported'
	db	0, 'Cannot access vector', 0, 'Unsupported diskette call: %x'
	db	0, 'Function is only supported for V86 tasks', 0, 'Attempted diskette I/O of more than 8 sectors'
	db	0, 'Error reading program file', 0, 'Data length error reading program file'
	db	0, 'No local descriptors available', 0, 'No memory available for environment block'
	db	0, 'Base of 1st segment must be at least 100h', 0, 'Insufficient memory to load program'
	db	0, 'True segment required before alias', 0, 'Error reading segment table of program'
	db	0, 'program contains USE32 segment', 0, 'Protection violation: %x%x%x'
	db	0, 'This release does not support protected mode', 0, 'IOCTL call with data size above 4kb'
	db	0, 'Bad file format', 0, 'Control task initialization failure'
	db	0, 'Signal task initialization failure', 0, 'V86 memory blocks have been corrupted'
	db	0, 'Unable to create system heap', 0, 'System linear address space exhausted'
	db	0, 'Bad base call', 0, 'Ran out of memory', 0, 'Unable to release memory blocks'
	db	0, 'Local descriptor table too large', 0, 'Maximum number of tasks exceeded'
	db	0, 'Cannot access BIOS table: %x', 0, 'Cannot read vector %x (from address %x%x)'
	db	0, 'Unable to find alias for selector %x', 0, 'Bad segment in relocation entry: %x'
	db	0, 'Reloc entry %x %x points to bad key: %x', 0, 'Invalid extended memory request'
	db	0, 'Unable to allocate selector', 0, 'Failed to start task', 0
	db	'Attempted base/base compare', 0, 'Bad selector: %x', 0, 'Move out of range'
	db	0, 'Error in remote call', 0, 'Kernel cannot continue', 0, 'No packet was sent'
	db	0, 'System heap blocks have been corrupted', 0, 'Freeing an already freed system heap block'
	db	0, 'Cannot remove kernel. Another program has been ins', 'talled on vector chain.'
	db	0, 'Table is not mapped to the base processor', 0, 'No memory available from VCPI (QEMM/386max)'
	db	0, 'Unknown machine - Please run TKINST to customize T', 'KERNEL for your system.'
	db	0, 'No extended memory available, using real memory', 0, 'Numeric co-processor unreliable because it is rese'
	db	't during real mode switch', 0, 'Machine is running incompatible expanded memory ma'
	db	'nager', 0, 'Cannot determine memory size', 0, 'Cannot recover from exception'
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
S908	ends

S9D2	segment para stack 'CODE'
	assume	cs:S9D2
L09D20:	pop	di	;@09D20
	pop	es	;@09D21
	pop	si	;@09D22
	pop	ds	;@09D23
	pop	cx	;@09D24
	pop	ax	;@09D25
	retf	;@09D26
	db	200h dup (0)	;@09D27
S9D2	ends

S9F3	segment para public 'CODE'
	assume	cs:S9F3
S9F3_START	db	'Protected Mode Driver  version $2$9$.$0$7$.$3$:$4$', ';$ ', 0Ah	;@09F30
	db	0Dh, '$Copyright (c) 1991 Borland International', 0Ah, 0Dh, 24h
	db	20h, 0Ah, 0Dh, 24h, 0, 0, 0, 0, 0, 0, 0, 0, 0
S9F3	ends

SBB9	segment para public 'CODE'
	assume	cs:SBB9
	db	'!!MACHINE_DB!!y', 1, 2, 2, 4, 0, 0, 0, 0, 41h, 0B0h, 7Dh, 1, 0	;@0BB90
	db	0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0FCh, 2, 0EBh, 1, 0, 0, 0, 0
	db	0, 2, 2, 4, 0, 0, 0, 0, 63h, 0A3h, 0Fh, 2, 0, 0, 0, 0, 0, 2, 2
	db	2, 0, 0, 0, 0, '3rR', 3, 0, 0, 0, 0, 0, 3, 3, 2, 0, 0, 0, 0, 18h
	db	56h, 67h, 3, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 40h, 0A6h, 2Ah
	db	4, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 37h, 0D8h, 7Eh, 4, 0, 0
	db	0, 0, 0, 2, 2, 2, 6, 0, 0, 0, 0BAh, 0B2h, 0DEh, 6, 0, 0, 0, 0
	db	0, 3, 3, 4, 0, 0, 0, 0, 0D7h, 0DDh, 0A2h, 8, 0, 0, 0, 0, 0, 2
	db	2, 2, 0, 0, 0, 0, 0C1h, 57h, 3Eh, 0Ah, 0, 0, 0, 0, 0, 2, 2, 4
	db	0, 0, 0, 0, 0F1h, 97h, 0EDh, 0Bh, 0, 0, 0, 0, 0, 2, 2, 2, 4, 0
	db	0, 0, 0ABh, 0C4h, 0CFh, 0Eh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0
	db	0E5h, 39h, 7Ch, 0Fh, 0, 0, 0, 0, 0, 2, 2, 1, 4, 0, 0, 0, 59h, 0F0h
	db	1Dh, 10h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 14h, 9Dh, 5Ah, 10h
	db	0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 26h, 5Bh, 0B8h, 12h, 0, 0
	db	0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 'XNX', 13h, 0, 0, 0, 0, 0, 2, 2
	db	4, 0, 0, 0, 0, 0B8h, 0AEh, 0BEh, 13h, 0, 0, 0, 0, 0, 2, 2, 2, 0
	db	0, 0, 0, 84h, 98h, 0EAh, 13h, 0, 0, 0, 0, 0, 2, 2, 1, 6, 0, 0
	db	0, 1, 1Dh, 9Ch, 16h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 9Bh, 45h
	db	52h, 18h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0D4h, 0C7h, 0FEh
	db	18h, 0, 0, 0, 0, 0, 2, 2, 2, 6, 0, 0, 0, 0C8h, 0CEh, 0FFh, 19h
	db	0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0E2h, 11h, 17h, 1Ah, 0, 0
	db	0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0A5h, 50h, 49h, 1Bh, 0, 0, 0, 0
	db	0, 3, 3, 4, 0, 0, 0, 0, 9Fh, 67h, 2, 1Dh, 0, 0, 0, 0, 0, 2, 2
	db	2, 0, 0, 0, 0, 77h, 0FBh, 0A6h, 1Dh, 0, 0, 0, 0, 0, 2, 2, 2, 6
	db	0, 0, 0, 4Fh, 0FBh, 4Bh, 1Fh, 0, 0, 0, 0, 0, 2, 2, 1, 0, 0, 0
	db	0, 1Eh, 87h, 5Ch, 1Fh, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 17h
	db	0C3h, 5Dh, 1Fh, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 4Ch, 0E7h
	db	0B8h, 1Fh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0CAh, 2, 11h, 20h
	db	0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, '+oc ', 0, 0, 0, 0, 0, 2, 2
	db	2, 0, 0, 0, 0, 2Eh, 5, 67h, 20h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0
	db	0, 0, 60h, 6Dh, 0A1h, 20h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0
	db	5Ch, 0D1h, 0C6h, 20h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 19h
	db	35h, 0F0h, 20h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0D9h, 69h
	db	90h, 22h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 1Ah, 2, 19h, 25h
	db	0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 52h, 3Ah, 0B3h, 25h, 0, 0
	db	0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 'Q2#&', 0, 0, 0, 0, 0, 2, 2, 4, 0
	db	0, 0, 0, 7, 0CDh, 69h, 26h, 0, 0, 0, 0, 0, 6, 6, 1, 0, 0, 0, 0
	db	9, 0D5h, 94h, 27h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 48h, 0B6h
	db	66h, 29h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0AAh, 0DFh, 83h
	db	2Ah, 0, 0, 0, 0, 0, 1, 1, 4, 0, 0, 0, 0, 29h, 9Fh, 99h, 2Bh, 0
	db	0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 9Ah, 0EFh, 0DCh, 2Ch, 0, 0, 0
	db	0, 0, 2, 2, 2, 0, 0, 0, 0, 0F9h, 12h, 0FAh, 2Ch, 0, 0, 0, 0, 0
	db	2, 2, 2, 0, 0, 0, 0, 0Ch, 0D6h, 92h, 2Dh, 0, 0, 0, 0, 0, 2, 2
	db	1, 0, 0, 0, 0, 0B9h, 7Fh, 0A7h, 2Dh, 0, 0, 0, 0, 0, 2, 2, 2, 6
	db	0, 0, 0, 64h, 2Ch, 0C9h, 2Dh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0
	db	0, 0A1h, 0ECh, 0D9h, 2Dh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 'TS*.'
	db	0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 'ENR/', 0, 0, 0, 0, 0, 2, 2
	db	4, 0, 0, 0, 0, 48h, 84h, 56h, 2Fh, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0
	db	0, 0, 8, 0D8h, 94h, 2Fh, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0E4h
	db	5Fh, 0E6h, 32h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 46h, 0AAh
	db	0D4h, 34h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 46h, 0B0h, 0D4h
	db	34h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 44h, 7Dh, 83h, 37h, 0
	db	0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 12h, 37h, 0ADh, 39h, 0, 0, 0
	db	0, 0, 2, 2, 2, 0, 0, 0, 0, 1Ch, 0D3h, 86h, 3Ah, 0, 0, 0, 0, 0
	db	2, 2, 2, 2, 0, 0, 0, 24h, 8, 21h, 3Bh, 0, 0, 0, 0, 0, 2, 2, 4
	db	0, 0, 0, 0, 0EDh, 55h, 0BCh, 3Ch, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0
	db	0, 0, 95h, 8Eh, 0EBh, 3Ch, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0
	db	1Bh, '@C=', 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 30h, 0A4h, 86h
	db	3Fh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 6Eh, 10h, 0BFh, 3Fh, 0
	db	0, 0, 0, 0, 2, 2, 1, 0, 0, 0, 0, 56h, 46h, 1Ch, 40h, 0, 0, 0, 0
	db	0, 2, 2, 1, 6, 0, 0, 0, 0C1h, '7:@', 0, 0, 0, 0, 0, 2, 2, 1, 6
	db	0, 0, 0, 0CCh, 0F4h, 94h, 43h, 0, 0, 0, 0, 0, 2, 2, 1, 0, 0, 0
	db	0, 0D7h, 0D2h, 0A3h, 43h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 74h
	db	0F4h, 0DEh, 43h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 6Eh, 0CBh
	db	0Fh, 44h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 27h, 0D6h, 0DFh
	db	44h, 0, 0, 0, 0, 0, 2, 2, 2, 6, 0, 0, 0, 'pVfE', 0, 0, 0, 0, 0
	db	2, 2, 2, 0, 0, 0, 0, 33h, 2Dh, 85h, 45h, 0, 0, 0, 0, 0, 2, 2, 4
	db	0, 0, 0, 0, 7, 0EAh, 0BDh, 49h, 0, 0, 0, 0, 0, 2, 2, 2, 6, 0, 0
	db	0, 0, 2, 0B4h, 4Ch, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 51h, 2Ah
	db	0A4h, 4Fh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 63h, 0DFh, 11h
	db	51h, 0, 0, 0, 0, 0, 3, 3, 4, 0, 0, 0, 0, 9, 'SSQ', 0, 0, 0, 0
	db	0, 2, 2, 4, 0, 0, 0, 0, 0FAh, 6Ch, 94h, 51h, 0, 0, 0, 0, 0, 2
	db	2, 4, 0, 0, 0, 0, 25h, 0DEh, 87h, 53h, 0, 0, 0, 0, 0, 2, 2, 4
	db	0, 0, 0, 0, 0B6h, 0FFh, 8, 55h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0
	db	0, 0BDh, 0Eh, 0E8h, 55h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, '@UEV'
	db	0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0A3h, 36h, 86h, 57h, 0, 0
	db	0, 0, 0, 3, 3, 4, 0, 0, 0, 0, 3Ch, 66h, 87h, 57h, 0, 0, 0, 0, 0
	db	2, 2, 4, 0, 0, 0, 0, 75h, 0D2h, 0E3h, 59h, 0, 0, 0, 0, 0, 2, 2
	db	2, 0, 0, 0, 0, 0A1h, 98h, 0Bh, 5Ah, 0, 0, 0, 0, 0, 2, 2, 2, 0
	db	0, 0, 0, 79h, 8Eh, 0D3h, 5Bh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0
	db	0, 8Fh, 9Ah, 0D1h, 5Eh, 0, 0, 0, 0, 0, 2, 2, 2, 6, 0, 0, 0, 90h
	db	19h, 38h, 5Fh, 0, 0, 0, 0, 0, 2, 2, 1, 0, 0, 0, 0, 0B2h, 3Dh, 0F2h
	db	5Fh, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 3Ah, 0B7h, 59h, 60h, 0
	db	0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0A7h, 0B3h, 0C8h, 60h, 0, 0, 0
	db	0, 0, 2, 2, 2, 4, 0, 0, 0, 0F4h, 12h, 38h, 61h, 0, 0, 0, 0, 0
	db	2, 2, 2, 0, 0, 0, 0, 80h, 0D7h, 20h, 64h, 0, 0, 0, 0, 0, 2, 2
	db	4, 0, 0, 0, 0, 0CCh, 16h, 92h, 66h, 0, 0, 0, 0, 0, 2, 2, 2, 0
	db	0, 0, 0, 97h, 0C9h, 9Fh, 66h, 0, 0, 0, 0, 0, 2, 2, 1, 0, 0, 0
	db	0, 0B4h, 0BEh, 0F8h, 66h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 8Ch
	db	'Y6g', 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 74h, 80h, 0C7h, 68h
	db	0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0Ah, 77h, 1Bh, 6Ah, 0, 0, 0
	db	0, 0, 2, 2, 4, 0, 0, 0, 0, 'wD9j', 0, 0, 0, 0, 0, 2, 2, 4, 0, 0
	db	0, 0, 71h, 0D6h, 47h, 6Ah, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0
	db	84h, 36h, 0EAh, 6Bh, 0, 0, 0, 0, 0, 2, 2, 1, 0, 0, 0, 0, 9Ah, '52l'
	db	0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0F6h, 0FDh, 0C6h, 6Fh, 0, 0
	db	0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 99h, 0E3h, 0DBh, 6Fh, 0, 0, 0, 0
	db	0, 2, 2, 4, 0, 0, 0, 0, 0F8h, 28h, 0FDh, 6Fh, 0, 0, 0, 0, 0, 2
	db	2, 4, 0, 0, 0, 0, 0F8h, 2Bh, 0FDh, 6Fh, 0, 0, 0, 0, 0, 2, 2, 4
	db	0, 0, 0, 0, 0F8h, 2Dh, 0FDh, 6Fh, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0
	db	0, 0, 0F1h, 0E2h, 10h, 70h, 0, 0, 0, 0, 0, 2, 2, 2, 6, 0, 0, 0
	db	0FEh, 81h, 4Ah, 70h, 0, 0, 0, 0, 0, 1, 1, 4, 0, 0, 0, 0, 0E0h
	db	7Eh, 0F6h, 72h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 'g~!u', 0
	db	0, 0, 0, 0, 2, 2, 1, 0, 0, 0, 0, 74h, 4Ah, 80h, 75h, 0, 0, 0, 0
	db	0, 2, 2, 2, 0, 0, 0, 0, 0C9h, 0C0h, 0E8h, 76h, 0, 0, 0, 0, 0, 2
	db	2, 4, 0, 0, 0, 0, 7Dh, 0E9h, 0BFh, 78h, 0, 0, 0, 0, 0, 2, 2, 2
	db	0, 0, 0, 0, 6, '%Pz', 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 'ILPz'
	db	0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 4Eh, 93h, 61h, 7Ah, 0, 0, 0
	db	0, 0, 3, 3, 2, 0, 0, 0, 0, 98h, 0EEh, 0D2h, 7Ah, 0, 0, 0, 0, 0
	db	2, 2, 4, 0, 0, 0, 0, 0Ch, 'AH{', 0, 0, 0, 0, 0, 2, 2, 4, 0, 0
	db	0, 0, 1Ch, 1Ch, 6Ah, 7Dh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 40h
	db	0BFh, 2, 7Fh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0FBh, 64h, 3Dh
	db	80h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 57h, 31h, 0C9h, 80h, 0
	db	0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0ADh, 0F7h, 2Bh, 81h, 0, 0, 0
	db	0, 0, 2, 2, 4, 0, 0, 0, 0, 1Eh, 9Bh, 60h, 81h, 0, 0, 0, 0, 0, 2
	db	2, 4, 0, 0, 0, 0, 0Ah, 0AAh, 0DDh, 82h, 0, 0, 0, 0, 0, 2, 2, 4
	db	0, 0, 0, 0, 0A8h, 0Bh, 0ECh, 82h, 0, 0, 0, 0, 0, 3, 3, 2, 0, 0
	db	0, 0, 0A1h, 2Eh, 72h, 83h, 0, 0, 0, 0, 0, 3, 3, 4, 0, 0, 0, 0
	db	84h, 70h, 22h, 84h, 0, 0, 0, 0, 0, 1, 1, 4, 0, 0, 0, 0, 69h, 4Ch
	db	0C9h, 84h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0C0h, 0, 0D7h, 84h
	db	0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 5Ah, 0A7h, 99h, 85h, 0, 0
	db	0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 'PZ&', 88h, 0, 0, 0, 0, 0, 2, 2
	db	2, 0, 0, 0, 0, 0DEh, 38h, 0CEh, 88h, 0, 0, 0, 0, 0, 2, 2, 4, 0
	db	0, 0, 0, 5Bh, 35h, 1Dh, 89h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0
	db	1Dh, 71h, 5Fh, 89h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0CEh, 34h
	db	0FEh, 89h, 0, 0, 0, 0, 0, 1, 1, 3, 0, 0, 0, 0, 73h, 7Fh, 5Bh, 8Bh
	db	0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 73h, 7Fh, 5Ch, 8Bh, 0, 0, 0
	db	0, 0, 2, 2, 4, 0, 0, 0, 0, 0B0h, 6Ch, 0B1h, 8Dh, 0, 0, 0, 0, 0
	db	2, 2, 4, 0, 0, 0, 0, 4Ch, 8, 52h, 8Eh, 0, 0, 0, 0, 0, 2, 2, 4
	db	0, 0, 0, 0, 5Fh, 32h, 97h, 8Fh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0
	db	0, 86h, 0F6h, 0E8h, 8Fh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 2Fh
	db	66h, 0C1h, 90h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 61h, 4Ch, 19h
	db	92h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0F7h, 5, 0FFh, 92h, 0
	db	0, 0, 0, 0, 2, 2, 2, 6, 0, 0, 0, 4Ah, 0BBh, 6Eh, 93h, 0, 0, 0
	db	0, 0, 2, 2, 4, 0, 0, 0, 0, 0C3h, 0DDh, 8Dh, 93h, 0, 0, 0, 0, 0
	db	2, 2, 2, 0, 0, 0, 0, 17h, 0A1h, 0E3h, 94h, 0, 0, 0, 0, 0, 2, 2
	db	2, 0, 0, 0, 0, 0Eh, 1Ch, 0FEh, 95h, 0, 0, 0, 0, 0, 2, 2, 4, 0
	db	0, 0, 0, '>n/', 97h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 1Ch, 3Ah
	db	86h, 97h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 82h, 0E9h, 60h, 98h
	db	0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 76h, 12h, 38h, 9Ah, 0, 0, 0
	db	0, 0, 2, 2, 4, 0, 0, 0, 0, 0F0h, 0FDh, 0, 9Bh, 0, 0, 0, 0, 0, 2
	db	2, 2, 0, 0, 0, 0, 0E7h, 7Bh, 49h, 9Bh, 0, 0, 0, 0, 0, 2, 2, 2
	db	0, 0, 0, 0, 0E1h, 0CAh, 6, 9Ch, 0, 0, 0, 0, 0, 1, 1, 4, 0, 0, 0
	db	0, 0B0h, 39h, 0ECh, 9Dh, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 7Bh
	db	90h, 0EAh, 9Fh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 31h, 0D1h
	db	0BEh, 0A0h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0AEh, 61h, 0DEh
	db	0A0h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 95h, 0Ah, 0E7h, 0A2h
	db	0, 0, 0, 0, 0, 3, 3, 4, 0, 0, 0, 0, 0EAh, 0EAh, 0B6h, 0A3h, 0
	db	0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0Fh, 0Ch, 8Dh, 0A5h, 0, 0, 0
	db	0, 0, 2, 2, 1, 0, 0, 0, 0, 0BCh, 25h, 8Eh, 0A6h, 0, 0, 0, 0, 0
	db	2, 2, 4, 0, 0, 0, 0, 81h, 67h, 0C7h, 0A6h, 0, 0, 0, 0, 0, 2, 2
	db	2, 0, 0, 0, 0, 5Ch, 15h, 0F3h, 0A6h, 0, 0, 0, 0, 0, 2, 2, 4, 0
	db	0, 0, 0, '(iN', 0A7h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 2Bh
	db	0DEh, 6Dh, 0A8h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 79h, 0C8h
	db	1, 0AAh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 1Bh, 94h, 0A6h, 0AAh
	db	0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0E4h, 0D8h, 0C7h, 0AAh, 0
	db	0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 93h, 6Dh, 59h, 0ABh, 0, 0, 0
	db	0, 0, 2, 2, 4, 0, 0, 0, 0, 0D2h, 2Eh, 55h, 0ACh, 0, 0, 0, 0, 0
	db	2, 2, 1, 0, 0, 0, 0, 6Eh, 0F3h, 0BAh, 0ADh, 0, 0, 0, 0, 0, 2, 2
	db	4, 0, 0, 0, 0, 97h, 50h, 5Fh, 0AEh, 0, 0, 0, 0, 0, 2, 2, 2, 0
	db	0, 0, 0, 88h, 60h, 0CBh, 0AEh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0
	db	0, 0B9h, 41h, 0DFh, 0B0h, 0, 0, 0, 0, 0, 3, 3, 4, 0, 0, 0, 0, 3Bh
	db	91h, 4Fh, 0B3h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0E7h, 4Bh
	db	1Fh, 0B4h, 0, 0, 0, 0, 0, 3, 3, 4, 0, 0, 0, 0, 96h, 7Ch, 0D0h
	db	0B4h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0EFh, 18h, 3Bh, 0B5h
	db	0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0ADh, 29h, 0EFh, 0B5h, 0, 0
	db	0, 0, 0, 2, 2, 1, 6, 0, 0, 0, 0BCh, 9Ah, 2, 0B7h, 0, 0, 0, 0, 0
	db	2, 2, 2, 0, 0, 0, 0, 55h, 0CCh, 7Ch, 0B7h, 0, 0, 0, 0, 0, 2, 2
	db	2, 0, 0, 0, 0, 17h, 6, 0A2h, 0B8h, 0, 0, 0, 0, 0, 2, 2, 2, 4, 0
	db	0, 0, 2, 63h, 47h, 0B9h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0AAh
	db	0F2h, 9Ah, 0B9h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 22h, 75h
	db	8Ch, 0BAh, 0, 0, 0, 0, 0, 2, 2, 1, 6, 0, 0, 0, 0CFh, 0B2h, 0DBh
	db	0BDh, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 7Eh, 0F8h, 8Bh, 0BEh
	db	0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0A6h, 0A9h, 0A5h, 0BFh, 0
	db	0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0FFh, 61h, 0B5h, 0BFh, 0, 0, 0
	db	0, 0, 2, 2, 4, 0, 0, 0, 0, 4Dh, 0E8h, 0Fh, 0C0h, 0, 0, 0, 0, 0
	db	2, 2, 4, 0, 0, 0, 0, 0E4h, 80h, 98h, 0C0h, 0, 0, 0, 0, 0, 2, 2
	db	4, 0, 0, 0, 0, 6, 97h, 0E8h, 0C0h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0
	db	0, 0, 47h, 80h, 77h, 0C1h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0
	db	0F1h, 4Bh, 15h, 0C2h, 0, 0, 0, 0, 0, 3, 3, 4, 0, 0, 0, 0, 0B2h
	db	0E4h, 0A4h, 0C2h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 6Bh, 6Bh
	db	0C5h, 0C2h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0A6h, 7Bh, 0D6h
	db	0C2h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0BBh, 0CCh, 1Ah, 0C3h
	db	0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0F7h, 0A2h, 0B9h, 0C3h, 0
	db	0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0F9h, 0E9h, 1, 0C4h, 0, 0, 0
	db	0, 0, 2, 2, 2, 0, 0, 0, 0, 8Ch, 3Ah, 8Ah, 0C5h, 0, 0, 0, 0, 0
	db	2, 2, 2, 0, 0, 0, 0, 0E7h, 0A6h, 0AEh, 0C6h, 0, 0, 0, 0, 0, 2
	db	2, 2, 0, 0, 0, 0, 0E7h, 0A3h, 7, 0C7h, 0, 0, 0, 0, 0, 2, 2, 4
	db	0, 0, 0, 0, 55h, 5, 3Eh, 0C8h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0
	db	0, 51h, 0B0h, 87h, 0C8h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, '(iK'
	db	0C9h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 9, 64h, 63h, 0CAh, 0
	db	0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0B0h, 53h, 6Ch, 0CAh, 0, 0, 0
	db	0, 0, 2, 2, 4, 0, 0, 0, 0, 'Dsx', 0CAh, 0, 0, 0, 0, 0, 2, 2, 4
	db	0, 0, 0, 0, 5, 0EFh, 0D3h, 0CBh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0
	db	0, 0, 77h, 0F8h, 39h, 0CDh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0
	db	19h, 74h, 6Dh, 0CDh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, ',6j'
	db	0CEh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0ABh, 49h, 0C1h, 0D0h
	db	0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 49h, 3, 42h, 0D2h, 0, 0, 0
	db	0, 0, 2, 2, 2, 0, 0, 0, 0, 0B2h, 40h, 7Eh, 0D2h, 0, 0, 0, 0, 0
	db	2, 2, 4, 0, 0, 0, 0, 88h, 8Bh, 0BCh, 0D2h, 0, 0, 0, 0, 0, 2, 2
	db	2, 0, 0, 0, 0, 55h, 0BDh, 0CBh, 0D2h, 0, 0, 0, 0, 0, 2, 2, 2, 0
	db	0, 0, 0, 0Dh, 0C2h, 18h, 0D3h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0
	db	0, 'e(H', 0D4h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 99h, 30h, 97h
	db	0D4h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0CEh, 0E8h, 90h, 0D5h
	db	0, 0, 0, 0, 0, 2, 2, 1, 6, 0, 0, 0, 4, 24h, 44h, 0D6h, 0, 0, 0
	db	0, 0, 2, 2, 4, 0, 0, 0, 0, 0C8h, 6Bh, 8Eh, 0D7h, 0, 0, 0, 0, 0
	db	2, 2, 2, 0, 0, 0, 0, 2, 32h, 4Dh, 0DCh, 0, 0, 0, 0, 0, 2, 2, 2
	db	0, 0, 0, 0, 0F0h, 34h, 13h, 0DEh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0
	db	0, 0, 0C4h, 0C1h, 0A6h, 0DFh, 0, 0, 0, 0, 0, 2, 2, 1, 0, 0, 0
	db	0, 0B2h, 9Ah, 0C2h, 0DFh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 9Fh
	db	0F9h, 0E5h, 0DFh, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0B9h, 80h
	db	0, 0E0h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0E3h, 23h, 0EEh, 0E1h
	db	0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0B3h, 8Ah, 2Fh, 0E2h, 0, 0
	db	0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0B0h, 81h, 50h, 0E4h, 0, 0, 0, 0
	db	0, 2, 2, 2, 6, 0, 0, 0, 49h, 95h, 0B5h, 0E4h, 0, 0, 0, 0, 0, 1
	db	1, 3, 0, 0, 0, 0, 1Fh, 1Dh, 5, 0E5h, 0, 0, 0, 0, 0, 2, 2, 4, 0
	db	0, 0, 0, 'vZ*', 0E5h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, '#$B'
	db	0E5h, 0, 0, 0, 0, 0, 2, 2, 1, 0, 0, 0, 0, 0E7h, 0D7h, 0F3h, 0E5h
	db	0, 0, 0, 0, 0, 2, 2, 2, 4, 0, 0, 0, 3Dh, 8Ah, 8Ah, 0E6h, 0, 0
	db	0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 2Bh, 5Ch, 8Dh, 0E8h, 0, 0, 0, 0
	db	0, 2, 2, 4, 0, 0, 0, 0, 26h, 0CEh, 0D6h, 0E8h, 0, 0, 0, 0, 0, 2
	db	2, 1, 6, 0, 0, 0, '97*', 0E9h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0
	db	0, 0A4h, 2Ah, 0Ah, 0EAh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 44h
	db	1Bh, 0A7h, 0EAh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0C4h, 2Ah
	db	0A7h, 0EAh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0F7h, 0ABh, 0B9h
	db	0EAh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0EEh, 22h, 0C6h, 0EAh
	db	0, 0, 0, 0, 0, 2, 2, 2, 6, 0, 0, 0, 0D8h, 59h, 36h, 0EBh, 0, 0
	db	0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 9Fh, 0AAh, 0E1h, 0EBh, 0, 0, 0, 0
	db	0, 2, 2, 4, 0, 0, 0, 0, 'Tw ', 0EFh, 0, 0, 0, 0, 0, 2, 2, 4, 0
	db	0, 0, 0, 0C7h, 40h, 7Eh, 0F0h, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0
	db	0, 0C8h, 4, 0ECh, 0F1h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 'hd/'
	db	0F2h, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 74h, 17h, 0F4h, 0F4h
	db	0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0BFh, 79h, 0FFh, 0F6h, 0, 0
	db	0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0C0h, 54h, 0EDh, 0F9h, 0, 0, 0, 0
	db	0, 2, 2, 2, 0, 0, 0, 0, 0BAh, 5Bh, 1Ah, 0FAh, 0, 0, 0, 0, 0, 2
	db	2, 4, 0, 0, 0, 0, 4Bh, 46h, 83h, 0FBh, 0, 0, 0, 0, 0, 2, 2, 4
	db	0, 0, 0, 0, 40h, 76h, 86h, 0FBh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0
	db	0, 0, 87h, 0ECh, 67h, 0FCh, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0
	db	0FDh, 5Dh, 3Fh, 0FDh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 2Ch
	db	0F5h, 6Eh, 0FDh, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 6Eh, 0E1h
	db	84h, 0FDh, 0, 0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 0AEh, 63h, 96h
	db	0FDh, 0, 0, 0, 0, 0, 2, 2, 1, 6, 0, 0, 0, 7Fh, 0D5h, 3, 0FFh, 0
	db	0, 0, 0, 0, 2, 2, 4, 0, 0, 0, 0, 62h, 0F7h, 5Eh, 0FFh, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0
SBB9	ends
	end
