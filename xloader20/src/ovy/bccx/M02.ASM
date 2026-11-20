	.286p
	locals
	public	L0AB74
	extrn	L0B040:far
	extrn	L181A0:byte

Y0AB10	segment para public 'CODE'
	assume	cs:Y0AB10
	db	8Ch, 46h, 0FEh, 89h, 5Eh, 0FCh, 0EBh, 6, 0FFh, 46h, 0FCh, 0FFh	;@0AB10
	db	46h, 0F8h, 0C4h, 5Eh, 0FCh, 26h, 8Ah, 7, 0C4h, 5Eh, 0F8h, 26h
	db	3Ah, 7, 74h, 0ECh, 0C4h, 5Eh, 0FCh, 26h, 80h, 3Fh, 0, 75h, 33h
	db	0C4h, 5Eh, 0F8h, 26h, 80h, '?=u*', 0FFh, 46h, 0F8h, 0BEh, 6Ah
	db	8Dh, 0EBh, 0Ch, 0C4h, 5Eh, 0F8h, 26h, 8Ah, 7, 88h, 4, 0FFh, 46h
	db	0F8h, 46h, 0C4h, 5Eh, 0F8h, 26h, 80h, 3Fh, 0, 75h, 0EBh, 0C6h
	db	4, 0, 0B8h, 6Ah, 8Dh, 8Ch, 0DAh, 0EBh, 1Fh, 0FFh, 46h, 0F8h, 0C4h
	db	5Eh, 0F8h, 26h, 80h, 3Fh, 0, 75h
Y0AB10	ends

Y0AB70	segment para public 'CODE'
	assume	cs:Y0AB70
	db	0F4h, 0FFh, 46h, 0F8h	;@0AB70
L0AB74:	les	bx, dword ptr [bp-8]	;@0AB74
	cmp	byte ptr es:[bx], 0	;@0AB77
	je	@@1	;@0AB7B
	db	0E9h, 8Dh, 0FFh	; jmp L181A0+10605	;@0AB7D
@@1:	xor	dx, dx	;@0AB80
	mov	ax, dx	;@0AB82
	pop	si	;@0AB84
	mov	sp, bp	;@0AB85
	pop	bp	;@0AB87
	retf	4	;@0AB88
RTL_GETVECT:	push	bp	;@0AB8B
	mov	bp, sp	;@0AB8C
	mov	al, byte ptr [bp+6]	;@0AB8E
	mov	ah, 35h	;@0AB91
	int	21h	;@0AB93
	mov	ax, bx	;@0AB95
	mov	dx, es	;@0AB97
	pop	bp	;@0AB99
	retf	2	;@0AB9A
RTL_SETVECT:	push	bp	;@0AB9D
	mov	bp, sp	;@0AB9E
	push	ds	;@0ABA0
	lds	dx, dword ptr [bp+6]	;@0ABA1
	mov	al, byte ptr [bp+0Ah]	;@0ABA4
	mov	ah, 25h	;@0ABA7
	int	21h	;@0ABA9
	pop	ds	;@0ABAB
	pop	bp	;@0ABAC
	retf	6	;@0ABAD
RTL_LSEEK:	push	bp	;@0ABB0
	mov	bp, sp	;@0ABB1
	mov	al, byte ptr [bp+6]	;@0ABB3
	mov	cx, word ptr [bp+0Ah]	;@0ABB6
	mov	dx, word ptr [bp+8]	;@0ABB9
	mov	bx, word ptr [bp+0Ch]	;@0ABBC
	db	0B4h	; mov ah, 42h	;@0ABBF
Y0AB70	ends

Y0ABC0	segment para public 'CODE'
	assume	cs:Y0ABC0
	db	42h, 0CDh, 21h, 73h, 0Ah, 0A3h, 0, 0, 0BAh, 0FFh, 0FFh, 8Bh, 0C2h	;@0ABC0
	db	0EBh, 0, 5Dh, 0CAh, 8, 0
RTL_OPEN:	push	bp	;@0ABD3
	mov	bp, sp	;@0ABD4
	push	si	;@0ABD6
	mov	al, byte ptr [bp+6]	;@0ABD7
	push	ds	;@0ABDA
	lds	dx, dword ptr [bp+8]	;@0ABDB
	mov	ah, 3Dh	;@0ABDE
	int	21h	;@0ABE0
	pop	ds	;@0ABE2
	jae	@@1	;@0ABE3
	mov	word ptr ds:[0], ax	;@0ABE5
	mov	ax, 0FFFFh	;@0ABE8
	jmp	short @@1	;@0ABEB
@@1:	pop	si	;@0ABED
	pop	bp	;@0ABEE
	db	0CAh	; retf 6	;@0ABEF
Y0ABC0	ends

Y0ABF0	segment para public 'CODE'
	assume	cs:Y0ABF0
	db	6, 0	;@0ABF0
RTL_READ:	push	bp	;@0ABF2
	mov	bp, sp	;@0ABF3
	mov	cx, word ptr [bp+6]	;@0ABF5
	mov	bx, word ptr [bp+0Ch]	;@0ABF8
	mov	ah, 3Fh	;@0ABFB
	push	ds	;@0ABFD
	lds	dx, dword ptr [bp+8]	;@0ABFE
	int	21h	;@0AC01
	pop	ds	;@0AC03
	jb	@@1	;@0AC04
	jmp	short @@2	;@0AC06
@@1:	mov	word ptr ds:[0], ax	;@0AC08
	mov	ax, 0FFFFh	;@0AC0B
@@2:	pop	bp	;@0AC0E
	retf	8	;@0AC0F
RTL_STRCHR:	push	bp	;@0AC12
	mov	bp, sp	;@0AC13
	push	si	;@0AC15
	push	ds	;@0AC16
	lds	si, dword ptr [bp+8]	;@0AC17
	mov	bl, byte ptr [bp+6]	;@0AC1A
@@1:	lodsw	;@0AC1D
	cmp	al, bl	;@0AC1E
	je	@@3	;@0AC20
	or	al, al	;@0AC22
	je	@@2	;@0AC24
	cmp	ah, bl	;@0AC26
	je	@@4	;@0AC28
	or	ah, ah	;@0AC2A
	jne	@@1	;@0AC2C
@@2:	pop	ds	;@0AC2E
	xor	dx, dx	;@0AC2F
	mov	ax, dx	;@0AC31
	jmp	short @@5	;@0AC33
@@3:	dec	si	;@0AC35
@@4:	mov	dx, ds	;@0AC36
	mov	ax, si	;@0AC38
	dec	ax	;@0AC3A
	pop	ds	;@0AC3B
@@5:	pop	si	;@0AC3C
	pop	bp	;@0AC3D
	retf	6	;@0AC3E
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 4, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 9Ah	;@0AC41
	db	4, 0, 5Fh, 2, 0C4h, 5Eh, 8, 3, 0D8h, 4Bh, 8Ch, 46h, 0FEh, 89h
	db	5Eh, 0FCh, 0EBh, 15h, 0C4h, 5Eh, 0FCh, 26h, 8Ah, 7, 3Ah, 46h, 6
	db	75h, 7, 8Bh, 56h, 0FEh, 8Bh, 0C3h, 0EBh, 21h, 0FFh, 4Eh, 0FCh
	db	8Bh, 46h, 0FCh, 3Bh, 46h, 8, 77h, 0E3h, 0C4h, 5Eh, 0FCh
Y0ABF0	ends

Y0AC80	segment para public 'CODE'
	assume	cs:Y0AC80
	db	26h, 8Ah, 7, 3Ah, 46h, 6, 75h, 7, 8Bh, 56h, 0FEh, 8Bh, 0C3h, 0EBh	;@0AC80
	db	4, 33h, 0D2h, 8Bh, 0C2h, 8Bh, 0E5h, 5Dh, 0CAh, 6, 0
COMPARE_NAME:	push	bp	;@0AC99
	mov	bp, sp	;@0AC9A
	push	si	;@0AC9C
	push	di	;@0AC9D
	cld	;@0AC9E
	push	ds	;@0AC9F
	les	di, dword ptr [bp+6]	;@0ACA0
	lds	si, dword ptr [bp+0Ah]	;@0ACA3
@@1:	lodsb	;@0ACA6
	scasb	;@0ACA7
	jne	@@2	;@0ACA8
	or	al, al	;@0ACAA
	jne	@@1	;@0ACAC
@@2:	db	26h, 2Ah	; sub al, byte ptr es:[di-1]	;@0ACAE
Y0AC80	ends

Y0ACB0	segment para public 'CODE'
	assume	cs:Y0ACB0
	db	45h, 0FFh, 98h, 1Fh, '_^]', 0CAh, 8, 0	;@0ACB0
STRING_COMPARE:	push	bp	;@0ACBA
	mov	bp, sp	;@0ACBB
	dec	sp	;@0ACBD
	dec	sp	;@0ACBE
	db	0EBh, 36h	; jmp short L0ACF7	;@0ACBF
	db	0C4h, 5Eh, 0Ah, 26h, 8Ah, 7, 98h, 50h, 9Ah, 0Fh, 0, 6Fh, 2, 88h	;@0ACC1
	db	46h
Y0ACB0	ends

Y0ACD0	segment para public 'CODE'
	assume	cs:Y0ACD0
	db	0FEh, 0C4h, 5Eh, 6, 26h, 8Ah, 7, 98h, 50h, 9Ah, 0Fh, 0, 6Fh, 2	;@0ACD0
	db	88h, 46h, 0FFh, 8Ah, 46h, 0FEh, 3Ah, 46h, 0FFh, 7Ch, 20h, 8Ah
	db	46h, 0FEh, 3Ah, 46h, 0FFh, 7Fh
Y0ACD0	ends

Y0ACF0	segment para public 'CODE'
	assume	cs:Y0ACF0
	db	26h, 0FFh, 46h, 0Ah, 0FFh, 46h, 6	;@0ACF0
L0ACF7:	les	bx, dword ptr [bp+0Ah]	;@0ACF7
	cmp	byte ptr es:[bx], 0	;@0ACFA
	db	75h, 0C1h	; jne L181A0+11041	;@0ACFE
	les	bx, dword ptr [bp+6]	;@0AD00
	cmp	byte ptr es:[bx], 0	;@0AD03
	jle	@@1	;@0AD07
	mov	ax, 0FFFFh	;@0AD09
	db	0EBh, 10h	; jmp short L0AD1E	;@0AD0C
@@1:	db	0C4h, 5Eh	; les bx, dword ptr [bp+6]	;@0AD0E
Y0ACF0	ends

Y0AD10	segment para public 'CODE'
	assume	cs:Y0AD10
	db	6, 26h, 80h, 3Fh, 0, 7Dh, 5, 0B8h, 1, 0, 0EBh, 2, 33h, 0C0h	;@0AD10
L0AD1E:	mov	sp, bp	;@0AD1E
	pop	bp	;@0AD20
	retf	8	;@0AD21
STRING_LENGTH:	push	bp	;@0AD24
	mov	bp, sp	;@0AD25
	push	si	;@0AD27
	push	di	;@0AD28
	les	di, dword ptr [bp+6]	;@0AD29
	mov	al, 0	;@0AD2C
	mov	cx, 0FFFFh	;@0AD2E
	cld	;@0AD31
	repne scasb	;@0AD32
	mov	ax, cx	;@0AD34
	not	ax	;@0AD36
	dec	ax	;@0AD38
	pop	di	;@0AD39
	pop	si	;@0AD3A
	pop	bp	;@0AD3B
	retf	4	;@0AD3C
	db	55h, 8Bh, 0ECh, 8Ah, 46h, 6, 0B4h, 0, 8Bh, 0D8h, 0F6h, 87h, 0A1h	;@0AD3F
	db	5Bh, 4, 74h, 0Ah, 8Ah, 46h, 6, 0B4h, 0, 5, 20h, 0, 0EBh, 5, 8Ah
	db	46h, 6, 0B4h, 0, 5Dh, 0CAh, 2, 0, 55h, 8Bh, 0ECh, 8Ah, 46h, 6
	db	0B4h, 0, 8Bh, 0D8h, 0F6h, 87h, 0A1h, 5Bh, 8, 74h, 0Ah, 8Ah, 46h
	db	6, 0B4h, 0, 5, 0E0h, 0FFh, 0EBh, 5, 8Ah, 46h, 6, 0B4h, 0, 5Dh
	db	0CAh, 2, 0
DELETE_FILE:	push	bp	;@0AD87
	mov	bp, sp	;@0AD88
	push	si	;@0AD8A
	mov	ax, 41h	;@0AD8B
	push	ax	;@0AD8E
	db	0FFh	; push word ptr [bp+8]	;@0AD8F
Y0AD10	ends

Y0AD90	segment para public 'CODE'
	assume	cs:Y0AD90
	db	76h, 8, 0FFh, 76h, 6, 33h, 0C0h, 50h, 9Ah, 0Dh, 0, 3Fh, 1, 8Bh	;@0AD90
	db	0F0h, 83h, 0FEh, 0FFh, 74h, 2, 33h, 0F6h, 8Bh, 0C6h, 5Eh, 5Dh
	db	0CAh, 4, 0
RTL_WRITE:	push	bp	;@0ADAD
	mov	bp, sp	;@0ADAE
Y0AD90	ends

Y0ADB0	segment para public 'CODE'
	assume	cs:Y0ADB0
	db	8Bh, 4Eh, 6, 8Bh, 5Eh, 0Ch, 0B4h, 40h, 1Eh, 0C5h, 56h, 8, 0CDh	;@0ADB0
	db	21h, 1Fh, 72h, 2, 0EBh, 6, 0A3h, 0, 0, 0B8h, 0FFh, 0FFh, 5Dh, 0CAh
	db	8, 0
_RTL_DPRINTF:	push	bp	;@0ADCD
	mov	bp, sp	;@0ADCE
	sub	sp, 4	;@0ADD0
	mov	bx, ss	;@0ADD3
	mov	es, bx	;@0ADD5
	lea	bx, [bp+0Ah]	;@0ADD7
	mov	word ptr [bp-2], es	;@0ADDA
	mov	word ptr [bp-4], bx	;@0ADDD
	push	word ptr [bp+8]	;@0ADE0
	push	word ptr [bp+6]	;@0ADE3
	push	word ptr [bp-2]	;@0ADE6
	push	bx	;@0ADE9
	db	9Ah, 33h, 0, 9Fh, 2	; lcall 0x29f, 0x33	;@0ADEA
	mov	sp, bp	;@0ADEF
	pop	bp	;@0ADF1
	retf	;@0ADF2
RTL_DVPRINTF:	push	bp	;@0ADF3
	mov	bp, sp	;@0ADF4
	sub	sp, 1Ah	;@0ADF6
	push	si	;@0ADF9
	db	0E9h, 43h, 2	; jmp L0B040	;@0ADFA
	db	0C4h, 5Eh, 0Ah, 26h, 80h, '?%t', 1Dh, 26h, 80h, 3Fh, 0Ah, 75h	;@0ADFD
	db	7, 0BAh, 0Dh, 0, 0B4h, 2, 0CDh, 21h, 0C4h, 5Eh, 0Ah, 26h, 8Ah
	db	7, 98h, 8Bh, 0D0h, 0B4h, 2, 0CDh, 21h
Y0ADB0	ends

Y0AE20	segment para public 'CODE'
	assume	cs:Y0AE20
	db	0E9h, 1Ah, 2, 33h, 0F6h, 0FFh, 46h, 0Ah, 8Ch, 0D3h, 8Eh, 0C3h	;@0AE20
	db	8Dh, 5Eh, 0FAh, 8Ch
Y0AE20	ends
	end
