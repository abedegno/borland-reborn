; CREF.ASM: reading TASM's .XRF files into the symbol and module tables and driving the
; reports (cref).


	public	L00720, L00732, L00749, L00902, L00AA5, L00AB2, L00ACD, cref
	extrn	L0002A:far
	extrn	L00031:far
	extrn	L000D3:far
	extrn	L000F5:far
	extrn	L000FD:far
	extrn	L00104:far
	extrn	L00108:far
	extrn	L0010F:far
	extrn	L00113:far
	extrn	L00122:far
	extrn	L00144:far
	extrn	L00171:far
	extrn	L00637:near
	extrn	L00646:near
	extrn	L0065B:near
	extrn	L0065D:near
	extrn	L00673:near
	extrn	L006C7:near
	extrn	L006E6:near
DATA	segment word public 'DATA'
	extrn	s_Copyright_c_1988:byte
	extrn	v_0002:byte
	extrn	v_068E:byte
	extrn	v_0690:byte
	extrn	v_0696:byte
	extrn	v_0AE6:byte
	extrn	v_0AE8:byte
	extrn	v_0AEA:byte
	extrn	v_0AEC:byte
	extrn	v_0AEE:byte
	extrn	v_0AF0:byte
	extrn	v_0AF2:byte
	extrn	v_0AF4:byte
	extrn	v_0AF6:byte
	extrn	v_0AF8:byte
	extrn	v_0AFC:byte
	extrn	v_0AFE:byte
	extrn	v_0B00:byte
	extrn	v_0B02:byte
	extrn	v_0B06:byte
	extrn	v_0B08:byte
	extrn	v_0B0A:byte
	extrn	v_0B0C:byte
	extrn	v_0B10:byte
	extrn	v_0B12:byte
	extrn	v_0B14:byte
	extrn	v_0B16:byte
	extrn	v_0B1A:byte
	extrn	v_0B1C:byte
	extrn	v_0B1E:byte
	extrn	v_0B20:byte
	extrn	v_0B24:byte
	extrn	v_0B26:byte
DATA	ends

CODE	segment word public 'CODE'
	assume	cs:CODE,ds:DATA
L00720:	mov	word ptr v_0AE6, ax
	mov	es, ax
	mov	word ptr es:[0], 0
	mov	word ptr es:[2], cx
	retf
L00732:	xor	ax, ax
	mov	cx, word ptr v_0AE6
L00738:	jcxz	L00748
	mov	es, cx
	add	ax, word ptr es:[2]
	mov	cx, word ptr es:[0]
	jmp	short L00738
L00748:	retf
L00749:	push	bx
	push	dx
	push	es
	push	ds
L0074D:	mov	bx, 0AE6h
L00750:	mov	dx, word ptr [bx]
	and	dx, dx
	je	L00768
	mov	es, dx
	cmp	word ptr es:[2], ax
	je	L00779
	jae	L00783
	mov	ds, dx
	mov	bx, 0
	jmp	short L00750
L00768:	pop	ds
	push	ds
	call	L00ABA
	jae	L0074D
	mov	byte ptr v_0696, 1
	mov	sp, word ptr v_068E
	retf
L00779:	mov	ax, word ptr es:[0]
	mov	word ptr [bx], ax
	mov	ax, es
	jmp	short L0079F
L00783:	add	dx, ax
	mov	word ptr [bx], dx
	mov	ds, dx
	mov	bx, word ptr es:[0]
	mov	word ptr ds:[0], bx
	mov	bx, word ptr es:[2]
	sub	bx, ax
	mov	word ptr v_0002, bx
	mov	ax, es
L0079F:	pop	ds
	pop	es
	pop	dx
	pop	bx
	retf
L007A4:	push	ax
	push	bx
	push	cx
	push	dx
	push	es
	add	dx, ax
	mov	bx, 0AE6h
L007AE:	mov	cx, word ptr [bx]
L007B0:	mov	es, cx
	jcxz	L007E5
	cmp	dx, cx
	jb	L007E5
	je	L007D7
	add	cx, word ptr es:[2]
	cmp	cx, ax
	je	L007CC
	mov	cx, es
	mov	ds, cx
	mov	bx, 0
	jmp	short L007AE
L007CC:	mov	ax, es
	mov	cx, word ptr es:[0]
	mov	word ptr [bx], cx
	jmp	short L007B0
L007D7:	add	dx, word ptr es:[2]
	mov	cx, word ptr es:[0]
	mov	word ptr [bx], cx
	jmp	short L007B0
L007E5:	mov	word ptr [bx], ax
	sub	dx, ax
	mov	ds, ax
	mov	word ptr v_0002, dx
	mov	word ptr ds:[0], es
	push	ss
	pop	ds
	pop	es
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	retf
	add	ax, cx
	sub	dx, cx
	jmp	short L007A4
L00801:	push	bx
	push	dx
	call	L00ABA
	pop	dx
	pop	bx
	jae	L00816
	mov	byte ptr v_0696, 1
	mov	sp, word ptr v_068E
	retf
L00814:	push	es
	push	cx
L00816:	mov	cx, word ptr v_0AE6
L0081A:	jcxz	L00801
	mov	es, cx
	cmp	cx, bx
	jae	L00839
	cmp	word ptr es:[2], ax
	jae	L0089C
	add	cx, word ptr es:[2]
	cmp	cx, bx
	je	L0087A
L00832:	mov	cx, word ptr es:[0]
	jmp	short L0081A
L00839:	sub	cx, dx
	cmp	cx, bx
	je	L00848
	cmp	word ptr es:[2], ax
	jae	L0089C
	jmp	short L00832
L00848:	mov	cx, dx
	add	cx, word ptr es:[2]
	cmp	cx, ax
	jb	L00832
	pop	cx
	mov	es, bx
	push	word ptr es:[0]
	push	word ptr es:[2]
	push	ax
	mov	ax, bx
	push	cs
	call	L007A4
	pop	ax
	push	cs
	call	L00902
	mov	es, ax
	pop	word ptr es:[2]
	pop	word ptr es:[0]
	pop	es
	retf
L0087A:	push	ax
	mov	ax, word ptr es:[2]
	add	ax, dx
	push	es
	mov	cx, word ptr es:[0]
	mov	es, cx
	sub	cx, dx
	cmp	cx, bx
	jne	L00894
	add	ax, word ptr es:[2]
L00894:	pop	es
	mov	cx, ax
	pop	ax
	cmp	cx, ax
	jb	L00832
L0089C:	pop	cx
	push	si
	push	di
	mov	di, es
	mov	es, bx
	push	word ptr es:[0]
	push	word ptr es:[2]
	push	ax
	mov	ax, bx
	push	cs
	call	L007A4
	pop	ax
	push	cx
	push	ds
	mov	es, di
	mov	ds, bx
	mov	cx, dx
	shl	cx, 1
	shl	cx, 1
	shl	cx, 1
	sub	cx, 2
	mov	si, 4
	mov	di, si
	cld
	rep movsw
	pop	ds
	pop	cx
	push	cs
	call	L00902
	mov	es, ax
	pop	word ptr es:[2]
	pop	word ptr es:[0]
	pop	di
	pop	si
	pop	es
	retf
	xor	ax, ax
	mov	cx, word ptr v_0AE6
L008EA:	jcxz	L00900
	mov	es, cx
	cmp	ax, word ptr es:[2]
	jae	L008F9
	mov	ax, word ptr es:[2]
L008F9:	mov	cx, word ptr es:[0]
	jmp	short L008EA
L00900:	retf
	nop
L00902:	push	bx
	push	dx
	push	es
	push	ds
L00906:	mov	bx, 0AE6h
L00909:	mov	dx, word ptr [bx]
	and	dx, dx
	je	L00921
	mov	es, dx
	cmp	word ptr es:[2], ax
	je	L00932
	jae	L0093E
	mov	ds, dx
	mov	bx, 0
	jmp	short L00909
L00921:	pop	ds
	push	ds
	call	L00ABA
	jae	L00906
	mov	byte ptr v_0696, 1
	mov	sp, word ptr v_068E
	retf
L00932:	mov	cx, ax
L00934:	mov	ax, word ptr es:[0]
	mov	word ptr [bx], ax
	mov	ax, es
	jmp	short L00965
L0093E:	cmp	word ptr es:[2], cx
	je	L00934
	jae	L00949
	mov	cx, ax
L00949:	add	dx, cx
	mov	word ptr [bx], dx
	mov	ds, dx
	mov	bx, word ptr es:[0]
	mov	word ptr ds:[0], bx
	mov	bx, word ptr es:[2]
	sub	bx, cx
	mov	word ptr v_0002, bx
	mov	ax, es
L00965:	pop	ds
	pop	es
	pop	dx
	pop	bx
	retf
L0096A:	mov	word ptr v_0AF0, 0
	mov	ax, bx
	mov	cl, 0FFh
L00974:	inc	cl
	shl	ax, 1
	jae	L00974
	mov	ax, 0FFFFh
	shr	ax, cl
	mov	word ptr v_0AEE, ax
	shl	word ptr v_0AEE, 1
	inc	ax
	mov	word ptr v_0AEA, ax
	mov	word ptr v_0AEC, ax
	shr	ax, 1
	shr	ax, 1
	shr	ax, 1
	nosmart
	call	far ptr L00749
	smart
	mov	word ptr v_0AE8, ax
	mov	cx, word ptr v_0AEA
	mov	es, ax
	xor	bx, bx
	xor	ax, ax
L009A5:	mov	word ptr es:[bx], ax
	add	bx, 2
	loop	L009A5
	ret
L009AE:	mov	dx, word ptr v_0AF0
	and	dx, dx
	je	L009C6
	mov	ax, word ptr v_0AF2
	nosmart
	call	far ptr L007A4
	smart
	mov	word ptr v_0AF0, 0
	clc
	ret
L009C6:	stc
	ret
L009C8:	mov	bx, si
	lodsb
	mov	ch, al
	xor	bp, bp
	and	al, al
	je	L00A03
	mov	cl, 5
	test	byte ptr v_0690, 1
	jne	L009F9
	mov	ax, ss
	mov	es, ax
	mov	di, si
L009E2:	lodsb
	cmp	al, 61h
	jb	L009ED
	cmp	al, 7Bh
	jae	L009ED
	sub	al, 20h
L009ED:	stosb
	cbw
	rol	bp, cl
	xor	bp, ax
	dec	ch
	jne	L009E2
	jmp	short L00A03
L009F9:	lodsb
	cbw
	rol	bp, cl
	xor	bp, ax
	dec	ch
	jne	L009F9
L00A03:	mov	si, bx
	shl	bp, 1
L00A07:	mov	es, word ptr v_0AE8
	and	bp, word ptr v_0AEE
	mov	cx, word ptr es:[bp]
	jcxz	L00A4C
	push	bp
	mov	es, cx
	mov	cl, byte ptr [si]
	cmp	cl, byte ptr es:[0]
	jne	L00A46
	mov	ax, si
	inc	si
	xor	ch, ch
	mov	di, 1
	shr	cx, 1
	jb	L00A33
	repe cmpsw
	jne	L00A44
	jmp	short L00A3A
L00A33:	repe cmpsw
	jne	L00A44
	cmpsb
	jne	L00A44
L00A3A:	pop	bp
	mov	es, word ptr v_0AE8
	mov	es, word ptr es:[bp]
	ret
L00A44:	mov	si, ax
L00A46:	pop	bp
	add	bp, 6
	jmp	short L00A07
L00A4C:	mov	al, byte ptr [si]
	xor	ah, ah
	add	ax, 10h
	mov	cl, 4
	shr	ax, cl
	mov	dx, ax
	cmp	word ptr v_0AF0, ax
	jae	L00A6E
	mov	cx, 800h
	nosmart
	call	far ptr L00902
	smart
	mov	word ptr v_0AF2, ax
	mov	word ptr v_0AF0, cx
L00A6E:	mov	ax, word ptr v_0AF2
	add	word ptr v_0AF2, dx
	sub	word ptr v_0AF0, dx
	mov	word ptr es:[bp], ax
	mov	es, ax
	mov	di, 0
	mov	cl, byte ptr [si]
	xor	ch, ch
	inc	cx
	shr	cx, 1
	rep movsw
	rcl	cx, 1
	rep movsb
	dec	word ptr v_0AEC
	je	L00A96
	ret
L00A96:	mov	byte ptr v_0696, 4
	mov	sp, word ptr v_068E
	stc
	retf
L00AA1:	mov	si, 0
	ret
L00AA5:	push	bx
	nosmart
	call	far ptr L0002A
	smart
	call	L00637
	pop	bx
	jmp	L0096A
L00AB2:	nosmart
	call	far ptr L000D3
	smart
	jmp	L00646
L00ABA:	push	ax
	push	cx
	push	si
	push	di
	push	bp
	call	L009AE
	jae	L00AC7
	call	L0065B
L00AC7:	pop	bp
	pop	di
	pop	si
	pop	cx
	pop	ax
	ret
L00ACD:	jmp	L00673
cref:	nosmart
	call	far ptr L00031
	smart
	mov	bx, 0AF4h
	mov	ax, 100h
	call	L00FE5
	mov	bx, 0AFEh
	mov	ax, 100h
	call	L00FE5
	mov	bx, 0B08h
	mov	ax, 200h
	call	L00FE5
	mov	bx, 0B12h
	mov	ax, 80h
	call	L00FE5
	mov	bx, 0B1Ch
	mov	ax, offset s_Copyright_c_1988
	call	L00FE5
	call	L00B15
	test	byte ptr v_0690, 2
	je	L00B0F
	call	L00CB7
L00B0F:	nosmart
	call	far ptr L000F5
	smart
	ret
L00B15:	mov	si, 0B6Bh
	call	L0065D
	nosmart
	call	far ptr L000FD
	smart
	call	L00D30
	nosmart
	call	far ptr L00104
	smart
	ret
	push	ax
	push	es
	mov	es, word ptr v_0B00
	mov	ax, word ptr es:[si]
	cmp	ax, word ptr es:[di]
	je	L00B66
	push	si
	push	di
	push	cx
	push	ds
	mov	es, word ptr es:[di]
	call	L00AA1
	mov	ds, ax
	push	si
	call	L00AA1
	pop	di
	mov	ah, byte ptr es:[di]
	mov	cl, ah
	inc	di
	lodsb
	xor	ch, ch
	cmp	cl, al
	jb	L00B57
	mov	cl, al
L00B57:	repe cmpsb
	pop	ds
	pop	cx
	pop	di
	pop	si
	pop	es
	je	L00B62
	pop	ax
	ret
L00B62:	cmp	al, ah
	pop	ax
	ret
L00B66:	cmp	si, di
	pop	es
	pop	ax
	ret
	call	L006C7
	jb	L00B8D
	mov	bx, word ptr v_0AFC
	mov	word ptr ds:[0C26h], bx
L00B78:	call	L006E6
	jb	L00B8D
	cmp	al, 4
	jae	L00B8D
	xor	ah, ah
	shl	ax, 1
	mov	bx, ax
	call	word ptr [bx+370h]
	jmp	short L00B78
L00B8D:	ret
	call	L009C8
	mov	ax, es
L00B93:	les	di, dword ptr v_0AF4
	mov	bx, di
	add	bx, 2
	jb	L00BBB
	cmp	bx, -10h
	jae	L00BBB
	cmp	word ptr v_0AF8, bx
	jae	L00BC6
	mov	bx, 0AF4h
	push	ax
	push	cx
	mov	cx, 40h
	mov	ax, 2
	call	L0100B
	pop	cx
	pop	ax
	jmp	short L00B93
L00BBB:	mov	byte ptr v_0696, 5
	stc
	mov	sp, word ptr v_068E
	retf
L00BC6:	mov	word ptr v_0AF4, bx
	mov	bx, word ptr v_0AFC
	inc	word ptr v_0AFC
	mov	word ptr es:[di], ax
	ret
	add	cx, si
	lodsb
	jmp	short L00BE3
	add	cx, si
	lodsb
	and	al, al
	jne	L00BE3
	ret
L00BE3:	push	cx
	push	ax
	call	L009C8
	pop	dx
	pop	cx
	mov	ax, es
L00BEC:	les	di, dword ptr v_0AFE
	mov	bx, di
	add	bx, 7
	jb	L00C14
	cmp	bx, -10h
	jae	L00C14
	cmp	word ptr v_0B02, bx
	jae	L00C1F
	mov	bx, 0AFEh
	push	ax
	push	cx
	mov	cx, 200h
	mov	ax, 7
	call	L0100B
	pop	cx
	pop	ax
	jmp	short L00BEC
L00C14:	mov	byte ptr v_0696, 5
	stc
	mov	sp, word ptr v_068E
	retf
L00C1F:	mov	word ptr v_0AFE, bx
	mov	bx, word ptr v_0B06
	inc	word ptr v_0B06
	mov	byte ptr es:[di+2], dl
	mov	word ptr es:[di], ax
	mov	bx, word ptr v_0B10
	mov	word ptr es:[di+3], bx
	push	di
	push	es
L00C3C:	cmp	si, cx
	jae	L00CA0
L00C40:	les	di, dword ptr v_0B08
	mov	bx, di
	add	bx, 5
	jb	L00C68
	cmp	bx, -10h
	jae	L00C68
	cmp	word ptr v_0B0C, bx
	jae	L00C73
	mov	bx, 0B08h
	push	ax
	push	cx
	mov	cx, 200h
	mov	ax, 5
	call	L0100B
	pop	cx
	pop	ax
	jmp	short L00C40
L00C68:	mov	byte ptr v_0696, 5
	stc
	mov	sp, word ptr v_068E
	retf
L00C73:	mov	word ptr v_0B08, bx
	mov	bx, word ptr v_0B10
	inc	word ptr v_0B10
	lodsb
	mov	byte ptr es:[di+4], al
	lodsb
	xor	ah, ah
	and	al, al
	jns	L00C90
	and	al, 7Fh
	mov	ah, al
	lodsb
L00C90:	add	ax, word ptr ds:[0C26h]
	dec	ax
	mov	word ptr es:[di], ax
	lodsw
	mov	word ptr es:[di+2], ax
	lodsw
	jmp	short L00C3C
L00CA0:	pop	es
	pop	di
	mov	bx, word ptr v_0B10
	sub	bx, word ptr es:[di+3]
	mov	word ptr es:[di+5], bx
	ret
	call	L009C8
	mov	word ptr ds:[0C28h], es
	ret
L00CB7:	or	byte ptr v_0690, 1
	mov	word ptr ds:[0C26h], 0
	mov	si, 0CC8h
	jmp	L0065D
	call	L006C7
	jb	L00D2F
	xor	ax, ax
	mov	word ptr v_0AF4, ax
	mov	word ptr v_0AFC, ax
	xor	ax, ax
	mov	word ptr v_0AFE, ax
	mov	word ptr v_0B06, ax
	xor	ax, ax
	mov	word ptr v_0B08, ax
	mov	word ptr v_0B10, ax
	xor	ax, ax
	mov	word ptr v_0B12, ax
	mov	word ptr v_0B1A, ax
	xor	ax, ax
	mov	word ptr v_0B1C, ax
	mov	word ptr v_0B24, ax
	mov	word ptr ds:[0C28h], 0
L00CFB:	call	L006E6
	jb	L00D10
	cmp	al, 4
	jae	L00CFB
	xor	ah, ah
	shl	ax, 1
	mov	bx, ax
	call	word ptr [bx+378h]
	jmp	short L00CFB
L00D10:	mov	dx, 0B26h
	mov	byte ptr v_0B26, 0
	mov	ax, word ptr ds:[0C28h]
	and	ax, ax
	je	L00D22
	call	L00F22
L00D22:	nosmart
	call	far ptr L00108
	smart
	call	L00D30
	nosmart
	call	far ptr L0010F
	smart
L00D2F:	ret
L00D30:	xor	ax, ax
	mov	word ptr v_0B12, ax
	mov	word ptr v_0B1A, ax
	mov	bx, word ptr v_0B06
	mov	cx, bx
	mov	es, word ptr v_0B00
	xor	di, di
	mov	ax, di
	and	cx, cx
	jne	L00D4B
	ret
L00D4B:	les	di, dword ptr v_0B12
	mov	bx, di
	add	bx, 2
	jb	L00D73
	cmp	bx, -10h
	jae	L00D73
	cmp	word ptr v_0B16, bx
	jae	L00D7E
	mov	bx, 0B12h
	push	ax
	push	cx
	mov	cx, 40h
	mov	ax, 2
	call	L0100B
	pop	cx
	pop	ax
	jmp	short L00D4B
L00D73:	mov	byte ptr v_0696, 5
	stc
	mov	sp, word ptr v_068E
	retf
L00D7E:	mov	word ptr v_0B12, bx
	mov	bx, word ptr v_0B1A
	inc	word ptr v_0B1A
	mov	word ptr es:[di], ax
	add	ax, 7
	loop	L00D4B
	mov	es, word ptr v_0B14
	mov	di, word ptr v_0B12
	mov	bp, 0B29h
	call	L00F40
	mov	bx, word ptr v_0B1A
	mov	cx, bx
	mov	es, word ptr v_0B14
	xor	di, di
L00DAC:	push	cx
	push	di
	mov	di, word ptr es:[di]
	mov	si, di
	mov	es, word ptr v_0B00
	xor	ax, ax
	mov	word ptr v_0B1C, ax
	mov	word ptr v_0B24, ax
L00DBF:	mov	cx, word ptr es:[di+5]
	mov	bx, word ptr es:[di+3]
	mov	es, word ptr v_0B0A
	xor	di, di
	add	di, bx
	shl	bx, 1
	shl	bx, 1
	add	di, bx
	jcxz	L00E20
	mov	ax, di
L00DD9:	les	di, dword ptr v_0B1C
	mov	bx, di
	add	bx, 2
	jb	L00E01
	cmp	bx, -10h
	jae	L00E01
	cmp	word ptr v_0B20, bx
	jae	L00E0C
	mov	bx, 0B1Ch
	push	ax
	push	cx
	mov	cx, 40h
	mov	ax, 2
	call	L0100B
	pop	cx
	pop	ax
	jmp	short L00DD9
L00E01:	mov	byte ptr v_0696, 5
	stc
	mov	sp, word ptr v_068E
	retf
L00E0C:	mov	word ptr v_0B1C, bx
	mov	bx, word ptr v_0B24
	inc	word ptr v_0B24
	mov	word ptr es:[di], ax
	add	ax, 5
	loop	L00DD9
L00E20:	pop	di
	pop	cx
	add	di, 2
	dec	cx
	push	cx
	push	di
	je	L00E3D
	mov	es, word ptr v_0B14
	mov	di, word ptr es:[di]
	mov	es, word ptr v_0B00
	mov	dx, word ptr es:[si]
	cmp	dx, word ptr es:[di]
	je	L00DBF
L00E3D:	mov	es, word ptr v_0B00
	mov	di, si
	call	L00E54
	pop	di
	pop	cx
	mov	es, word ptr v_0B14
	and	cx, cx
	je	L00E53
	jmp	L00DAC
L00E53:	ret
L00E54:	mov	ax, word ptr es:[di]
	call	L00F22
	nosmart
	call	far ptr L00113
	smart
	mov	es, word ptr v_0B1E
	mov	di, word ptr v_0B1C
	mov	bp, 0F09h
	call	L00F40
	mov	bx, word ptr v_0B24
	mov	cx, bx
	mov	es, word ptr v_0B1E
	xor	di, di
L00E79:	mov	si, di
	xor	dl, dl
L00E7D:	push	di
	mov	di, word ptr es:[di]
	mov	es, word ptr v_0B0A
	or	dl, byte ptr es:[di+4]
	pop	di
	mov	es, word ptr v_0B1E
	add	di, 2
	dec	cx
	je	L00EAE
	push	di
	push	si
	mov	di, word ptr es:[di]
	mov	si, word ptr es:[si]
	mov	es, word ptr v_0B0A
	mov	ax, word ptr es:[si]
	cmp	ax, word ptr es:[di]
	mov	es, word ptr v_0B1E
	pop	si
	pop	di
	je	L00E7D
L00EAE:	push	cx
	push	si
	push	di
	mov	di, word ptr es:[si]
	mov	es, word ptr v_0B0A
	mov	bx, word ptr es:[di]
	mov	es, word ptr v_0AF6
	xor	di, di
	shl	bx, 1
	add	di, bx
	mov	ax, word ptr es:[di]
	push	dx
	call	L00F22
	pop	ax
	nosmart
	call	far ptr L00122
	smart
	pop	di
	pop	si
	mov	es, word ptr v_0B1E
L00ED8:	cmp	si, di
	je	L00EFD
	push	si
	push	di
	mov	di, word ptr es:[si]
	mov	es, word ptr v_0B0A
	mov	dx, word ptr es:[di+2]
	mov	al, byte ptr es:[di+4]
	nosmart
	call	far ptr L00144
	smart
	pop	di
	pop	si
	add	si, 2
	mov	es, word ptr v_0B1E
	jmp	short L00ED8
L00EFD:	pop	cx
	jcxz	L00F03
	jmp	L00E79
L00F03:	nosmart
	call	far ptr L00171
	smart
	ret
	push	ax
	push	es
	mov	es, word ptr v_0B0A
	mov	ax, word ptr es:[si]
	cmp	ax, word ptr es:[di]
	jne	L00F1F
	mov	ax, word ptr es:[si+2]
	cmp	ax, word ptr es:[di+2]
L00F1F:	pop	es
	pop	ax
	ret
L00F22:	mov	ds, ax
	call	L00AA1
	mov	ax, ss
	mov	es, ax
	mov	di, 0B26h
	lodsb
	mov	cl, al
	xor	ch, ch
	rep movsb
	xor	al, al
	stosb
	mov	ax, ss
	mov	ds, ax
	mov	dx, 0B26h
	ret
L00F40:	mov	cx, di
	cmp	cx, 2
	jbe	L00FC0
	mov	dx, cx
	shr	dx, 1
	and	dx, -2
L00F4E:	mov	ax, dx
	mov	bx, ax
L00F52:	shl	bx, 1
	cmp	bx, cx
	ja	L00F84
	mov	si, word ptr es:[bx-2]
	je	L00F6A
	mov	di, word ptr es:[bx]
	call	bp
	jae	L00F6A
	add	bx, 2
	mov	si, di
L00F6A:	mov	di, si
	mov	si, ax
	mov	si, word ptr es:[si-2]
	call	bp
	jae	L00F84
	mov	word ptr es:[bx-2], si
	mov	si, ax
	mov	word ptr es:[si-2], di
	mov	ax, bx
	jmp	short L00F52
L00F84:	sub	dx, 2
	jne	L00F4E
	mov	dx, cx
	sub	dx, 2
L00F8E:	xor	bx, bx
	mov	ax, word ptr es:[bx]
	mov	di, dx
	push	word ptr es:[di]
	mov	word ptr es:[di], ax
	sub	dx, 2
L00F9E:	mov	ax, bx
	inc	bx
	shl	bx, 1
	cmp	bx, dx
	ja	L00FC1
	mov	si, word ptr es:[bx]
	je	L00FB9
	mov	di, word ptr es:[bx+2]
	call	bp
	jae	L00FB9
	mov	si, di
	add	bx, 2
L00FB9:	mov	di, ax
	mov	word ptr es:[di], si
	jmp	short L00F9E
L00FC0:	ret
L00FC1:	pop	di
L00FC2:	and	ax, ax
	je	L00FDB
	mov	bx, ax
	shr	bx, 1
	dec	bx
	and	bx, -2
	mov	si, word ptr es:[bx]
	call	bp
	jae	L00FDB
	xchg	ax, bx
	mov	word ptr es:[bx], si
	jmp	short L00FC2
L00FDB:	mov	bx, ax
	mov	word ptr es:[bx], di
	and	dx, dx
	jne	L00F8E
	ret
L00FE5:	push	dx
	mov	dx, ax
	xor	ax, ax
	mov	word ptr [bx], ax
	mov	word ptr [bx+8], ax
	mov	ax, dx
	shl	dx, 1
	shl	dx, 1
	shl	dx, 1
	shl	dx, 1
	mov	word ptr [bx+4], dx
	mov	word ptr [bx+6], ax
	mov	cx, ax
	nosmart
	call	far ptr L00749
	smart
	mov	word ptr [bx+2], ax
	pop	dx
	ret
L0100B:	push	dx
	add	ax, word ptr [bx]
	add	ax, 15
	shr	ax, 1
	shr	ax, 1
	shr	ax, 1
	shr	ax, 1
	mov	dx, word ptr [bx+6]
	add	cx, dx
	cmp	cx, 1000h
	jb	L01027
	mov	cx, 0FFFh
L01027:	push	bx
	mov	bx, word ptr [bx+2]
	nosmart
	call	far ptr L00814
	smart
	pop	bx
	mov	word ptr [bx+2], ax
	mov	word ptr [bx+6], cx
	mov	ax, cx
	mov	cl, 4
	shl	ax, cl
	mov	word ptr [bx+4], ax
	pop	dx
	ret
	mov	ax, word ptr [bx]
	add	ax, 15
	mov	cl, 4
	shr	ax, cl
	mov	dx, word ptr [bx+6]
	sub	dx, ax
	je	L01065
	mov	word ptr [bx+6], ax
	mov	word ptr [bx+4], ax
	mov	cl, 4
	shl	word ptr [bx+4], cl
	add	ax, word ptr [bx+2]
	nosmart
	jmp	far ptr L007A4
	smart
L01065:	ret
CODE	ends
	end
