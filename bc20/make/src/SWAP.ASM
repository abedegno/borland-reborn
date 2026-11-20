; /* target: SWAP */
; SWAP.ASM: running a command with MAKE swapped out of memory (-S, .SWAP).
_TEXT		segment	word public 'CODE'
_TEXT		ends
_DATA		segment	word public 'DATA'
		extrn	__psp:word, _errno:word, __brklvl:dword
_DATA		ends
DGROUP		group	_DATA

		public	DOSWAP, _swapsize

_TEXT		segment
		assume	cs:_TEXT, ds:DGROUP

stub		label	byte
		mov	ax, cs  ; 570E
		cli  ; 5710
		mov	ss, ax  ; 5711
		mov	sp, stacktop-stub  ; 5713
		sti  ; 5716
		mov	ah, 4Ah  ; 5717
		mov	bx, word ptr ds:[newsize-stub]  ; 5719
		mov	es, word ptr ds:[pspseg-stub]  ; 571D
		int	21h  ; 5721
		mov	ax, cs  ; 5723
		mov	es, ax  ; 5725
		push	ds  ; 5727
		mov	word ptr ds:[savess-stub], ss  ; 5728
		mov	word ptr ds:[savesp-stub], sp  ; 572C
		mov	dx, execpath-stub  ; 5730
		mov	bx, envseg-stub  ; 5733
		mov	ax, 4B00h  ; 5736
		int	21h  ; 5739
		jb	L573F  ; 573B
		xor	ax, ax  ; 573D
L573F:
		cli  ; 573F
		mov	ss, word ptr cs:[savess-stub]  ; 5740
		mov	sp, word ptr cs:[savesp-stub]  ; 5745
		sti  ; 574A
		pop	ds  ; 574B
		mov	si, ax  ; 574C
		mov	ah, 4Ah  ; 574E
		mov	es, word ptr ds:[pspseg-stub]  ; 5750
		mov	bx, word ptr ds:[oldsize-stub]  ; 5754
		int	21h  ; 5758
		mov	dx, swapfile-stub  ; 575A
		mov	ax, 4301h  ; 575D
		xor	cx, cx  ; 5760
		int	21h  ; 5762
		mov	ax, 3D02h  ; 5764
		int	21h  ; 5767
		mov	ax, 3F00h  ; 5769
		push	ax  ; 576C
		push	word ptr ds:[handle-stub]  ; 576D
		push	cs  ; 5771
		mov	ax, stubend-stub  ; 5772
		push	ax  ; 5775
		push	word ptr ds:[swaplen+2-stub]  ; 5776
		push	word ptr ds:[swaplen-stub]  ; 577A
		call	transfer  ; 577E
		cli  ; 5781
		mov	ss, word ptr ds:[stubss-stub]  ; 5782
		mov	sp, word ptr ds:[stubsp-stub]  ; 5786
		sti  ; 578A
		db	0EAh			; jmp far ptr reload: TASM would make it near
		dw	offset reload, seg reload  ; 578B
transfer	proc	near
		push	bp  ; 5790
		mov	bp, sp  ; 5791
		push	ds  ; 5793
		push	bx  ; 5794
		push	cx  ; 5795
		push	dx  ; 5796
		mov	bx, word ptr [bp+0Ch]  ; 5797
		mov	ds, word ptr [bp+0Ah]  ; 579A
		mov	dx, word ptr [bp+8]  ; 579D
		mov	cx, 8000h  ; 57A0
L57A3:
		cmp	word ptr [bp+6], 0  ; 57A3
		jne	L57B7  ; 57A7
		cmp	word ptr [bp+4], 0  ; 57A9
		je	L57D2  ; 57AD
		cmp	word ptr [bp+4], cx  ; 57AF
		jae	L57B7  ; 57B2
		mov	cx, word ptr [bp+4]  ; 57B4
L57B7:
		mov	ax, word ptr [bp+0Eh]  ; 57B7
		int	21h  ; 57BA
		jb	L57D6  ; 57BC
		cmp	ax, cx  ; 57BE
		jb	L57D6  ; 57C0
		sub	word ptr [bp+4], ax  ; 57C2
		sbb	word ptr [bp+6], 0  ; 57C5
		mov	ax, ds  ; 57C9
		add	ax, 800h  ; 57CB
		mov	ds, ax  ; 57CE
		jmp	L57A3  ; 57D0
L57D2:
		xor	ax, ax  ; 57D2
		jmp	short L57D9  ; 57D4
L57D6:
		mov	ax, 1  ; 57D6
L57D9:
		pop	dx  ; 57D9
		pop	cx  ; 57DA
		pop	bx  ; 57DB
		pop	ds  ; 57DC
		pop	bp  ; 57DD
		ret	0Ch  ; 57DE
transfer	endp

handle		dw	0
envseg		dw	0
tailptr		dd	0
fcb1ptr		dd	0
fcb2ptr		dd	0
oldsize		dw	0
newsize		dw	0
swaplen		dd	0
fcb1		db	37 dup (0)
fcb2		db	37 dup (0)
savess		dw	0
savesp		dw	0
pspseg		dw	0
swapfile	db	80 dup (0)
execpath	db	80 dup (0)
tail		db	129 dup (0)
stubss		dw	0
stubsp		dw	0
		db	64 dup (0)
stacktop	label	word
stubseg		dw	0
saveds		dw	0
swapname	db	'SWAP000.$$$',0
imagelen	dd	0
mainsp		dw	0
mainss		dw	0
stubentry	dd	0
dostab		dw	0002h, 010Ch, 0B02h, 00ECh, 0A02h, 00F8h, 0003h, 012Ah, 0, 0024h
stubend		label	byte

linear	proc	near
		push	bp  ; 59DE
		mov	bp, sp  ; 59DF
		push	cx  ; 59E1
		mov	cx, 4  ; 59E2
		mov	ax, word ptr [bp+6]  ; 59E5
		xor	dx, dx  ; 59E8
L59EA:
		shl	ax, 1  ; 59EA
		rcl	dx, 1  ; 59EC
		loop	L59EA  ; 59EE
		add	ax, word ptr [bp+4]  ; 59F0
		adc	dx, 0  ; 59F3
		pop	cx  ; 59F6
		pop	bp  ; 59F7
		ret	4  ; 59F8
linear	endp
DOSWAP:
DOSWAP	proc	near
		push	bp  ; 59FB
		mov	bp, sp  ; 59FC
		push	ds  ; 59FE
		push	es  ; 59FF
		push	di  ; 5A00
		push	si  ; 5A01
		cld  ; 5A02
		push	ds  ; 5A03
		mov	ah, 1Ah  ; 5A04
		mov	ds, word ptr __psp  ; 5A06
		mov	dx, 80h  ; 5A0A
		int	21h  ; 5A0D
		mov	si, cs  ; 5A0F
		mov	ds, si  ; 5A11
		mov	bx, offset swapname  ; 5A13
		mov	dx, bx  ; 5A16
		mov	cx, 1Fh  ; 5A18
L5A1B:
		mov	ah, 4Eh  ; 5A1B
		int	21h  ; 5A1D
		jb	L5A35  ; 5A1F
		cmp	byte ptr [bx+6], 39h  ; 5A21
		je	L5A2C  ; 5A25
		inc	byte ptr [bx+6]  ; 5A27
		jmp	L5A1B  ; 5A2A
L5A2C:
		mov	byte ptr [bx+6], 30h  ; 5A2C
		inc	byte ptr [bx+5]  ; 5A30
		jmp	L5A1B  ; 5A33
L5A35:
		mov	es, si  ; 5A35
		mov	di, offset swapfile  ; 5A37
		mov	ah, 19h  ; 5A3A
		int	21h  ; 5A3C
		add	al, 41h  ; 5A3E
		stosb		; 5A40
		mov	al, 3Ah  ; 5A41
		stosb		; 5A43
		mov	al, 5Ch  ; 5A44
		stosb		; 5A46
		mov	ah, 47h  ; 5A47
		xor	dl, dl  ; 5A49
		mov	si, di  ; 5A4B
		int	21h  ; 5A4D
		mov	cx, 50h  ; 5A4F
		xor	al, al  ; 5A52
		repne scasb		; 5A54
		dec	di  ; 5A56
		cmp	byte ptr [si], 0  ; 5A57
		je	L5A5F  ; 5A5A
		mov	al, 5Ch  ; 5A5C
		stosb		; 5A5E
L5A5F:
		mov	si, offset swapname  ; 5A5F
		mov	cx, 0Ch  ; 5A62
		rep movsb		; 5A65
		mov	dx, offset swapfile  ; 5A67
		mov	ah, 3Ch  ; 5A6A
		xor	cx, cx  ; 5A6C
		int	21h  ; 5A6E
		pop	ds  ; 5A70
		jae	L5A7D  ; 5A71
		mov	word ptr cs:handle, 0FFFFh  ; 5A73
		jmp	L5CDA  ; 5A7A
L5A7D:
		mov	word ptr cs:handle, ax  ; 5A7D
		mov	word ptr cs:mainss, ss  ; 5A81
		mov	word ptr cs:mainsp, sp  ; 5A86
		mov	ax, word ptr __psp  ; 5A8B
		mov	word ptr cs:pspseg, ax  ; 5A8E
		add	ax, 6  ; 5A92
		mov	word ptr cs:stubseg, ax  ; 5A95
		mov	word ptr cs:stubss, ss  ; 5A99
		mov	word ptr cs:stubsp, sp  ; 5A9E
		mov	ah, 30h  ; 5AA3
		int	21h  ; 5AA5
		mov	bx, offset dostab  ; 5AA7
L5AAA:
		cmp	ax, word ptr cs:[bx]  ; 5AAA
		je	L5AB8  ; 5AAD
		add	bx, 4  ; 5AAF
		cmp	word ptr cs:[bx], 0  ; 5AB2
		jne	L5AAA  ; 5AB6
L5AB8:
		mov	bx, word ptr cs:[bx+2]  ; 5AB8
		xor	ax, ax  ; 5ABC
		mov	es, ax  ; 5ABE
		mov	es, word ptr es:[0C3h]  ; 5AC0
		mov	es, word ptr es:[bx]  ; 5AC5
		jmp	short L5AD4  ; 5AC8
L5ACA:
		mov	ax, es  ; 5ACA
		add	ax, word ptr es:[3]  ; 5ACC
		inc	ax  ; 5AD1
		mov	es, ax  ; 5AD2
L5AD4:
		mov	ax, word ptr es:[1]  ; 5AD4
		cmp	ax, word ptr __psp  ; 5AD8
		je	L5AEC  ; 5ADC
		cmp	byte ptr es:[0], 5Ah  ; 5ADE
		jne	L5ACA  ; 5AE4
		mov	ax, 7  ; 5AE6
		jmp	L5CDA  ; 5AE9
L5AEC:
		mov	ax, es  ; 5AEC
		inc	ax  ; 5AEE
		cmp	ax, word ptr __psp  ; 5AEF
		jne	L5ACA  ; 5AF3
		mov	ax, word ptr es:[3]  ; 5AF5
		mov	word ptr cs:oldsize, ax  ; 5AF9
		mov	ax, 6  ; 5AFD
		mov	bx, stacktop-stub+15  ; 5B00
		mov	cl, 4  ; 5B03
		shr	bx, cl  ; 5B05
		add	ax, bx  ; 5B07
		mov	word ptr cs:newsize, ax  ; 5B09
		push	ss  ; 5B0D
		mov	ax, sp  ; 5B0E
		push	ax  ; 5B10
		call	linear  ; 5B11
		mov	cx, dx  ; 5B14
		mov	bx, ax  ; 5B16
		push	word ptr word ptr __brklvl+2  ; 5B18
		push	word ptr word ptr __brklvl  ; 5B1C
		call	linear  ; 5B20
		sub	ax, bx  ; 5B23
		sbb	dx, cx  ; 5B25
		mov	word ptr cs:imagelen+2, dx  ; 5B27
		mov	word ptr cs:imagelen, ax  ; 5B2C
		push	ds  ; 5B30
		lds	si, dword ptr [bp+8]  ; 5B31
		mov	ax, cs  ; 5B34
		mov	es, ax  ; 5B36
		mov	di, offset execpath  ; 5B38
L5B3B:
		cmp	byte ptr [si], 0  ; 5B3B
		je	L5B43  ; 5B3E
		movsb		; 5B40
		jmp	L5B3B  ; 5B41
L5B43:
		movsb		; 5B43
		lds	si, dword ptr [bp+4]  ; 5B44
		mov	di, offset tail+1  ; 5B47
		mov	cx, di  ; 5B4A
		mov	bx, cx  ; 5B4C
		mov	al, 20h  ; 5B4E
		stosb		; 5B50
L5B51:
		cmp	byte ptr [si], 0  ; 5B51
		je	L5B59  ; 5B54
		movsb		; 5B56
		jmp	L5B51  ; 5B57
L5B59:
		mov	al, 0Dh  ; 5B59
		stosb		; 5B5B
		xchg	di, cx  ; 5B5C
		sub	cx, di  ; 5B5E
		dec	cx  ; 5B60
		mov	byte ptr es:[bx-1], cl  ; 5B61
		mov	cx, 25h  ; 5B65
		mov	bx, cs  ; 5B68
		mov	es, bx  ; 5B6A
		mov	di, offset fcb1  ; 5B6C
		xor	ax, ax  ; 5B6F
		rep stosw		; 5B71
		mov	ds, bx  ; 5B73
		mov	si, offset tail  ; 5B75
		inc	si  ; 5B78
		mov	di, offset fcb1  ; 5B79
		mov	ax, 2901h  ; 5B7C
		int	21h  ; 5B7F
		mov	es, bx  ; 5B81
		mov	di, offset fcb2  ; 5B83
		mov	ax, 2901h  ; 5B86
		int	21h  ; 5B89
		pop	ds  ; 5B8B
		mov	word ptr cs:saveds, ds  ; 5B8C
		mov	es, word ptr __psp  ; 5B91
		mov	ax, word ptr es:[2Ch]  ; 5B95
		mov	word ptr cs:envseg, ax  ; 5B99
		mov	ax, word ptr cs:stubseg  ; 5B9D
		mov	word ptr cs:tailptr+2, ax  ; 5BA1
		mov	word ptr cs:tailptr, tail-stub  ; 5BA5
		mov	word ptr cs:fcb1ptr+2, ax  ; 5BAC
		mov	word ptr cs:fcb1ptr, fcb1-stub  ; 5BB0
		mov	word ptr cs:fcb2ptr+2, ax  ; 5BB7
		mov	word ptr cs:fcb2ptr, fcb2-stub  ; 5BBB
		push	word ptr cs:stubseg  ; 5BC2
		mov	di, stubend-stub  ; 5BC7
		push	di  ; 5BCA
		call	linear  ; 5BCB
		mov	cx, dx  ; 5BCE
		mov	bx, ax  ; 5BD0
		push	ss  ; 5BD2
		xor	ax, ax  ; 5BD3
		push	ax  ; 5BD5
		call	linear  ; 5BD6
		sub	ax, bx  ; 5BD9
		sbb	dx, cx  ; 5BDB
		mov	word ptr cs:swaplen+2, dx  ; 5BDD
		mov	word ptr cs:swaplen, ax  ; 5BE2
		mov	bx, 4000h  ; 5BE6
		push	bx  ; 5BE9
		push	word ptr cs:handle  ; 5BEA
		push	word ptr cs:stubseg  ; 5BEF
		push	di  ; 5BF4
		push	dx  ; 5BF5
		push	ax  ; 5BF6
		call	transfer  ; 5BF7
		cmp	ax, 0  ; 5BFA
		je	L5C02  ; 5BFD
		jmp	L5CDA  ; 5BFF
L5C02:
		mov	bx, 4000h  ; 5C02
		push	bx  ; 5C05
		push	word ptr cs:handle  ; 5C06
		push	word ptr cs:stubseg  ; 5C0B
		xor	ax, ax  ; 5C10
		push	ax  ; 5C12
		push	ax  ; 5C13
		push	di  ; 5C14
		call	transfer  ; 5C15
		cmp	ax, 0  ; 5C18
		je	L5C20  ; 5C1B
		jmp	L5CDA  ; 5C1D
L5C20:
		mov	bx, 4000h  ; 5C20
		push	bx  ; 5C23
		push	word ptr cs:handle  ; 5C24
		push	word ptr cs:mainss  ; 5C29
		push	word ptr cs:mainsp  ; 5C2E
		push	word ptr cs:imagelen+2  ; 5C33
		push	word ptr cs:imagelen  ; 5C38
		call	transfer  ; 5C3D
		cmp	ax, 0  ; 5C40
		je	L5C48  ; 5C43
		jmp	L5CDA  ; 5C45
L5C48:
		mov	ah, 3Eh  ; 5C48
		mov	bx, word ptr cs:handle  ; 5C4A
		int	21h  ; 5C4F
		jae	L5C56  ; 5C51
		jmp	L5CDA  ; 5C53
L5C56:
		mov	ax, cs  ; 5C56
		mov	ds, ax  ; 5C58
		mov	dx, offset swapfile  ; 5C5A
		mov	ax, 4301h  ; 5C5D
		mov	cx, 1  ; 5C60
		int	21h  ; 5C63
		mov	ax, cs  ; 5C65
		mov	ds, ax  ; 5C67
		mov	si, offset stub  ; 5C69
		mov	es, word ptr cs:stubseg  ; 5C6C
		xor	di, di  ; 5C71
		mov	cx, stubend-stub  ; 5C73
		rep movsb		; 5C76
		mov	word ptr cs:stubentry, 0  ; 5C78
		mov	ax, word ptr cs:stubseg  ; 5C7F
		mov	ds, ax  ; 5C83
		mov	word ptr cs:stubentry+2, ax  ; 5C85
		jmp	dword ptr cs:stubentry  ; 5C89
reload:
		mov	ax, 3F00h  ; 5C8E
		push	ax  ; 5C91
		push	word ptr cs:handle  ; 5C92
		push	word ptr cs:stubseg  ; 5C97
		xor	ax, ax  ; 5C9C
		push	ax  ; 5C9E
		push	ax  ; 5C9F
		mov	ax, stubend-stub  ; 5CA0
		push	ax  ; 5CA3
		call	transfer  ; 5CA4
		mov	ax, 3F00h  ; 5CA7
		push	ax  ; 5CAA
		push	word ptr cs:handle  ; 5CAB
		push	word ptr cs:mainss  ; 5CB0
		push	word ptr cs:mainsp  ; 5CB5
		push	word ptr cs:imagelen+2  ; 5CBA
		push	word ptr cs:imagelen  ; 5CBF
		call	transfer  ; 5CC4
		cli  ; 5CC7
		mov	ss, word ptr cs:mainss  ; 5CC8
		mov	sp, word ptr cs:mainsp  ; 5CCD
		sti  ; 5CD2
		mov	ax, si  ; 5CD3
		mov	ds, word ptr cs:saveds  ; 5CD5
L5CDA:
		mov	word ptr _errno, ax  ; 5CDA
		mov	ah, 3Eh  ; 5CDD
		mov	bx, word ptr cs:handle  ; 5CDF
		int	21h  ; 5CE4
		push	ds  ; 5CE6
		mov	ax, cs  ; 5CE7
		mov	ds, ax  ; 5CE9
		mov	dx, offset swapfile  ; 5CEB
		mov	ah, 41h  ; 5CEE
		int	21h  ; 5CF0
		pop	ds  ; 5CF2
		cmp	word ptr _errno, 0  ; 5CF3
		je	L5CFF  ; 5CF8
		mov	ax, 0FFFFh  ; 5CFA
		jmp	short L5D01  ; 5CFD
L5CFF:
		xor	ax, ax  ; 5CFF
L5D01:
		pop	si  ; 5D01
		pop	di  ; 5D02
		pop	es  ; 5D03
		pop	ds  ; 5D04
		pop	bp  ; 5D05
		ret	8  ; 5D06
DOSWAP	endp

_swapsize	dw	300h
_TEXT		ends
		end
