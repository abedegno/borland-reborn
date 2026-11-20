; REPORT.ASM: writing the REF file: pages, headings, the global and module reports, numbers,
; the date and time.


	public	L00000, L0000F, L00018, L00021, L0002A, L00031, L000D3, L000F5, L000FD, L00104, L00108, L0010F, L00113, L00122, L00144, L00171, L00637, L00646, L0065B, L0065D, L00673, L006C7, L006E6
	extrn	L00732:far
	extrn	L00749:far
	extrn	L00902:far
	extrn	L00AA5:near
	extrn	L00AB2:near
	extrn	L00ACD:near
	extrn	cref:near
	extrn	dostime:far
	extrn	dosdate:far
	extrn	dosopen:far
	extrn	doscreate:far
	extrn	dosclose:far
	extrn	dosread:far
	extrn	doswrite:far
DATA	segment word public 'DATA'
	extrn	s_Cref_defined_at:byte
	extrn	s_Global_Symbol_Name:byte
	extrn	s_Module:byte
	extrn	s_Symbol_Name:byte
	extrn	v_0002:byte
	extrn	v_0016:byte
	extrn	v_068E:byte
	extrn	v_0690:byte
	extrn	v_0692:byte
	extrn	v_0694:byte
	extrn	v_0696:byte
	extrn	v_0698:byte
	extrn	v_069A:byte
	extrn	v_069C:byte
	extrn	v_069E:byte
	extrn	v_06A0:byte
	extrn	v_06A2:byte
	extrn	v_06A4:byte
	extrn	v_06A6:byte
	extrn	v_06A8:byte
	extrn	v_06AA:byte
	extrn	v_06AC:byte
	extrn	v_06AE:byte
	extrn	v_06B0:byte
	extrn	v_06B1:byte
	extrn	v_06B2:byte
	extrn	v_06B4:byte
	extrn	v_06B6:byte
	extrn	v_06DA:byte
	extrn	v_06DC:byte
	extrn	v_06DE:byte
	extrn	v_06E0:byte
	extrn	v_06E2:byte
	extrn	v_06E3:byte
DATA	ends

CODE	segment word public 'CODE'
	assume	cs:CODE,ds:DATA
L00000:	mov	word ptr v_068E, sp
	mov	ax, word ptr v_0016
	mov	word ptr v_0690, ax
	call	L00AA5
	clc
	retf
L0000F:	mov	word ptr v_068E, sp
	call	L00ACD
	clc
	retf
L00018:	mov	word ptr v_068E, sp
	call	cref
	clc
	retf
L00021:	mov	word ptr v_068E, sp
	call	L00AB2
	clc
	retf
L0002A:	mov	word ptr v_06A0, 0
	retf
L00031:	mov	word ptr v_06B4, bx
	xor	ax, ax
	mov	cx, 1Ch
	push	ds
	pop	es
	mov	di, 698h
	rep stosb
	mov	ax, word ptr v_0692
	mov	word ptr v_06AC, ax
	mov	ax, word ptr v_0694
	mov	word ptr v_06AE, ax
	mov	byte ptr v_06B0, 1
	mov	word ptr v_06B6, 8
	nosmart
	call	far ptr L00732
	smart
	cmp	ax, 472h
	jae	L0006C
	cmp	ax, 0F2h
	jae	L0006F
	mov	ax, 0F2h
	jmp	short L0006F
L0006C:	mov	ax, 472h
L0006F:	mov	cx, ax
	nosmart
	call	far ptr L00749
	smart
	mov	word ptr v_069A, ax
	mov	es, ax
	xor	ax, ax
	xor	di, di
	mov	word ptr v_069E, cx
	shl	cx, 1
	shl	cx, 1
	shl	cx, 1
	push	cx
	shl	cx, 1
	mov	word ptr v_069C, cx
	pop	cx
	rep stosw
	call	far ptr doscreate
	jae	L0009C
	jmp	short L000EA
L0009C:	mov	word ptr v_06A0, bx
	mov	word ptr v_0698, 720h
	mov	si, 30Ah
	call	L0044C
	call	L004A4
	mov	di, 110h
	mov	si, word ptr v_06B4
	call	L002BE
	mov	cx, 8
	mov	al, 20h
	rep stosb
	call	L00304
	mov	al, 20h
	stosb
	call	L0031F
	sub	di, 110h
	mov	word ptr es:[108h], di
	retf
L000D3:	mov	bx, word ptr v_06A0
	and	bx, bx
	jne	L000DC
	retf
L000DC:	call	far ptr dosclose
	mov	word ptr v_06A0, 0
	jb	L000EA
	retf
L000EA:	mov	byte ptr v_0696, 2
	stc
	mov	sp, word ptr v_068E
	retf
L000F5:	call	L00538
	push	cs
	call	L000D3
	retf
L000FD:	call	L001E0
	call	L0024F
	retf
L00104:	call	L001CD
	retf
L00108:	call	L001F3
	call	L0024F
	retf
L0010F:	call	L001CD
	retf
L00113:	mov	si, dx
	mov	bx, 0
	call	L004FB
	call	L002BE
	call	L00504
	retf
L00122:	push	ax
	call	L0020F
	mov	si, dx
	mov	bx, 318h
	call	L004FB
	pop	ax
	or	al, al
	mov	ax, 2020h
	je	L00139
	mov	ax, 2023h
L00139:	stosw
	call	L002BE
	mov	al, 3Ah
	stosb
	call	L0050C
	retf
L00144:	mov	byte ptr v_06B2, al
L00147:	mov	bx, 318h
	call	L004FB
	cmp	di, 716h
	ja	L0016A
	mov	ax, 2020h
	stosw
	cmp	byte ptr v_06B2, 0
	je	L00161
	mov	al, 23h
	stosb
L00161:	mov	cx, dx
	call	L005A5
	call	L0050C
	retf
L0016A:	push	dx
	call	L00221
	pop	dx
	jmp	short L00147
L00171:	call	L00221
	retf
	inc	word ptr v_06A4
	mov	word ptr v_06A2, 0
	cmp	byte ptr v_06B0, 1
	je	L00189
	call	L001CD
L00189:	retf
L0018A:	cmp	byte ptr v_06B0, 0
	je	L001CC
	push	si
	mov	byte ptr v_06B0, 0
	mov	word ptr v_06A6, 0
	inc	word ptr v_06A2
	call	L00492
	call	L00540
	mov	bx, 108h
	call	L00343
	mov	si, 328h
	call	L002BE
	call	L0032A
	call	L002FF
	mov	bx, 210h
	call	L0033E
	call	L002FF
	add	word ptr v_06A6, 3
	mov	word ptr v_0698, di
	pop	si
L001CC:	ret
L001CD:	mov	cx, 2
	call	L00540
	mov	al, 12
	stosb
	mov	word ptr v_0698, di
	mov	byte ptr v_06B0, 1
	ret
L001E0:	mov	bx, 0
	mov	si, offset s_Global_Symbol_Name
	call	L0062E
L001E9:	mov	bx, 318h
	mov	si, offset s_Cref_defined_at
	call	L0062E
	ret
L001F3:	push	dx
	mov	bx, 0
	call	L004FB
	mov	si, offset s_Module
	call	L002BE
	pop	si
	call	L002BE
	mov	si, offset s_Symbol_Name
	call	L002BE
	call	L00504
	jmp	short L001E9
L0020F:	push	dx
	mov	es, word ptr v_069A
	cmp	word ptr es:[318h], 0
	je	L0021F
	call	L00221
L0021F:	pop	dx
	ret
L00221:	mov	es, word ptr v_069A
	mov	word ptr es:[31Ah], 320h
	mov	si, 235h
	call	L00296
	jmp	L00518
	call	L00479
	call	L00540
	mov	bx, 0
	call	L00343
	mov	bx, 318h
	call	L0033E
	call	L002FF
	mov	word ptr v_0698, di
	ret
L0024F:	mov	es, word ptr v_069A
	cmp	byte ptr v_06B0, 1
	je	L00269
	mov	ax, word ptr v_06A6
	add	ax, 6
	cmp	ax, word ptr v_06AC
	jbe	L00269
	call	L001CD
L00269:	call	L0018A
	call	L00479
	call	L00540
	call	L002FF
	mov	bx, 0
	call	L00343
	mov	bx, 318h
	call	L00343
	call	L0043E
	call	L002FF
	call	L002FF
	mov	word ptr v_0698, di
	add	word ptr v_06A6, 3
	jmp	L00518
L00296:	call	L0018A
	push	si
	call	si
	pop	si
	inc	word ptr v_06A6
	mov	ax, word ptr v_06A6
	cmp	ax, word ptr v_06AC
	jb	L002AF
	push	si
	call	L001CD
	pop	si
L002AF:	cmp	byte ptr v_06B1, 0
	je	L002BD
	mov	byte ptr v_06B1, 0
	jmp	short L00296
L002BD:	ret
L002BE:	mov	dx, di
L002C0:	lodsb
	or	al, al
	je	L002C8
	stosb
	jmp	short L002C0
L002C8:	mov	cx, di
	sub	cx, dx
	ret
	mov	dx, di
L002CF:	lodsb
	cmp	al, 9
	je	L002E3
	cmp	al, 10
	je	L002CF
	cmp	al, 1Ah
	je	L002CF
	cmp	al, 13
	je	L002FA
	stosb
	jmp	short L002CF
L002E3:	mov	cx, di
	sub	cx, dx
	mov	ax, word ptr v_06B6
L002EA:	sub	cx, ax
	jae	L002EA
	add	cx, ax
	neg	cx
	add	cx, ax
	mov	al, 20h
	rep stosb
	jmp	short L002CF
L002FA:	mov	cx, di
	sub	cx, dx
	ret
L002FF:	mov	ax, 0A0Dh
	stosw
	ret
L00304:	push	es
	push	di
	call	far ptr dosdate
	pop	di
	pop	es
L0030D:	push	cx
	mov	cl, ch
	call	L005DE
	stosb
	pop	cx
	call	L005DE
	stosb
	mov	cl, dh
	call	L005DE
	ret
L0031F:	push	es
	push	di
	call	far ptr dostime
	pop	di
	pop	es
	jmp	short L0030D
L0032A:	mov	cx, word ptr v_06A4
	jcxz	L00336
	call	L005A5
	mov	al, 2Dh
	stosb
L00336:	mov	cx, word ptr v_06A2
	call	L005A5
	ret
L0033E:	mov	bp, 0
	jmp	short L00346
L00343:	mov	bp, 1
L00346:	mov	ax, es
	mov	ds, ax
	mov	si, word ptr [bx+2]
	mov	cx, word ptr [bx]
	mov	dx, word ptr [bx+4]
	or	dx, dx
	je	L0037D
	cmp	cx, dx
	ja	L00382
	mov	ax, cx
	rep movsb
	cmp	bx, 318h
	je	L0036A
	cmp	bx, 108h
	jae	L0036C
L0036A:	mov	word ptr [bx], cx
L0036C:	cmp	bp, 0
	je	L0037D
	mov	cx, word ptr [bx+4]
	sub	cx, ax
	add	cx, word ptr [bx+6]
L00379:	mov	al, 20h
	rep stosb
L0037D:	mov	ax, ss
	mov	ds, ax
	ret
L00382:	mov	cx, dx
	add	si, dx
	inc	cx
	jmp	short L0038F
L00389:	dec	si
	cmp	byte ptr [si], 2Ch
	je	L003F9
L0038F:	cmp	byte ptr [si], 20h
	je	L003A5
	cmp	byte ptr [si], 28h
	je	L003A5
	cmp	byte ptr [si], 5Bh
	je	L003A5
	cmp	byte ptr [si], 2Bh
	loopne	L00389
	jcxz	L003FC
L003A5:	mov	cx, si
	mov	si, word ptr [bx+2]
	sub	cx, si
	sub	dx, cx
	mov	ax, cx
	rep movsb
	mov	cx, word ptr [bx]
	sub	cx, ax
L003B6:	cmp	byte ptr [si], 20h
	jne	L003BE
	inc	si
	loop	L003B6
L003BE:	mov	cx, dx
	mov	al, 20h
	rep stosb
L003C4:	sub	si, word ptr [bx+2]
	add	word ptr [bx+2], si
	sub	word ptr [bx], si
	mov	cx, word ptr [bx+6]
	je	L00379
	jcxz	L003DB
	mov	al, 2Bh
	stosb
	dec	cx
	mov	al, 20h
	rep stosb
L003DB:	mov	ax, 4
	sub	word ptr [bx+2], ax
	add	word ptr [bx], ax
	mov	si, word ptr [bx+2]
	mov	ax, 2020h
	mov	word ptr [si], ax
	mov	word ptr [si+2], ax
	stc
	mov	ax, ss
	mov	ds, ax
	mov	byte ptr v_06B1, 1
	ret
L003F9:	inc	si
	jmp	short L003A5
L003FC:	mov	cx, dx
	rep movsb
	jmp	short L003C4
	mov	ax, es
	mov	ds, ax
	mov	si, word ptr [bx+2]
	mov	cx, word ptr [bx]
	mov	dx, word ptr [bx+4]
	or	dx, dx
	je	L0042A
	cmp	cx, dx
	ja	L00433
	sub	dx, cx
	xchg	dx, cx
	mov	al, 20h
	rep stosb
	mov	cx, dx
	rep movsb
	clc
L00423:	mov	al, 20h
	mov	cx, word ptr [bx+6]
	rep stosb
L0042A:	mov	word ptr [bx], 0
	mov	ax, ss
	mov	ds, ax
	ret
L00433:	sub	cx, dx
	add	si, cx
	mov	cx, dx
	rep movsb
	stc
	jmp	short L00423
L0043E:	mov	cx, di
	jcxz	L0044B
	dec	di
	std
	mov	al, 20h
	repe scasb
	cld
	inc	di
	inc	di
L0044B:	ret
L0044C:	mov	es, word ptr v_069A
L00450:	xor	ax, ax
	mov	bx, word ptr [si]
	cmp	bx, -1
	je	L00478
	mov	word ptr es:[bx], ax
	mov	cx, bx
	add	cx, 8
	mov	word ptr es:[bx+2], cx
	mov	al, byte ptr [si+2]
	mov	word ptr es:[bx+4], ax
	mov	al, byte ptr [si+3]
	mov	word ptr es:[bx+6], ax
	add	si, 4
	jmp	short L00450
L00478:	ret
L00479:	call	L00485
	add	cx, word ptr es:[31Ch]
	add	cx, 4
	ret
L00485:	mov	es, word ptr v_069A
	add	cx, word ptr es:[4]
	add	cx, 2
	ret
L00492:	mov	es, word ptr v_069A
	mov	cx, word ptr es:[10Ch]
	add	cx, word ptr es:[210h]
	add	cx, 20h
	ret
L004A4:	mov	si, 31Ch
	mov	es, word ptr v_069A
	xor	di, di
L004AD:	cmp	word ptr [si+2], -1
	je	L004DD
	mov	bx, 64h
	mov	ax, word ptr v_06AE
	mul	bx
	div	word ptr [si+2]
	xor	bx, bx
	mov	bl, byte ptr [si+4]
	cmp	ax, bx
	ja	L004CE
	mov	bl, byte ptr [si+5]
	cmp	ax, bx
	ja	L004D0
L004CE:	mov	ax, bx
L004D0:	mov	bx, word ptr [si]
	mov	word ptr es:[bx+4], ax
	add	di, ax
	add	si, 6
	jmp	short L004AD
L004DD:	mov	cl, byte ptr [si+4]
	xor	ch, ch
	add	di, cx
	mov	ax, word ptr v_06AE
	sub	ax, di
	jb	L004F2
	mov	cl, byte ptr [si+5]
	cmp	ax, cx
	ja	L004F4
L004F2:	mov	ax, cx
L004F4:	mov	bx, word ptr [si]
	mov	word ptr es:[bx+4], ax
	ret
L004FB:	mov	es, word ptr v_069A
	mov	di, word ptr es:[bx+2]
	ret
L00504:	sub	di, word ptr es:[bx+2]
	mov	word ptr es:[bx], di
	ret
L0050C:	sub	di, word ptr es:[bx+2]
	add	word ptr es:[bx], di
	add	word ptr es:[bx+2], di
	ret
L00518:	mov	es, word ptr v_069A
	xor	ax, ax
	mov	byte ptr v_06B1, al
	mov	word ptr es:[0], ax
	mov	word ptr es:[2], 8
	mov	word ptr es:[318h], ax
	mov	word ptr es:[31Ah], 320h
	ret
L00538:	mov	cx, word ptr v_069C
	sub	cx, 720h
L00540:	les	di, dword ptr v_0698
	add	cx, di
	cmp	cx, word ptr v_069C
	jbe	L00573
	mov	cx, word ptr v_0698
	sub	cx, 720h
	mov	ax, word ptr v_069A
	mov	dx, 720h
	mov	bx, word ptr v_06A0
	call	far ptr doswrite
	jae	L00568
	jmp	L000EA
L00568:	mov	es, word ptr v_069A
	mov	di, 720h
	mov	word ptr v_0698, di
L00573:	ret
	call	L004FB
	cmp	cl, 0FFh
	jne	L0058B
	not	ax
	not	dx
	add	ax, 1
	adc	dx, 0
	push	ax
	mov	al, 2Dh
	stosb
	pop	ax
L0058B:	mov	word ptr v_06A8, ax
	mov	cx, 2
	or	dx, dx
	je	L0059B
	mov	word ptr v_06AA, dx
	add	cx, cx
L0059B:	mov	si, 6A8h
	call	L00607
	call	L0050C
	ret
L005A5:	push	ax
	push	si
	mov	ah, 30h
	mov	si, 2710h
	call	L005CC
	mov	si, 3E8h
	call	L005CC
	mov	si, 64h
	call	L005CC
	mov	si, 10
	call	L005CC
	mov	si, 1
	mov	ah, 0FFh
	call	L005CC
	pop	si
	pop	ax
	ret
L005CC:	mov	al, 2Fh
L005CE:	inc	al
	sub	cx, si
	jae	L005CE
	add	cx, si
	cmp	al, ah
	je	L005DD
	mov	ah, 0FFh
	stosb
L005DD:	ret
L005DE:	push	ax
	push	si
	mov	ah, 30h
	cmp	cl, 63h
	ja	L005F7
	mov	ch, 0
	mov	ah, 0FFh
	mov	si, 10
	call	L005CC
	mov	si, 1
	call	L005CC
L005F7:	pop	si
	pop	ax
	ret
	add	si, cx
	dec	si
	std
L005FE:	lodsb
	or	al, al
	loope	L005FE
	inc	cx
	inc	si
	jmp	short L0060B
L00607:	add	si, cx
	dec	si
L0060A:	std
L0060B:	lodsb
	cld
	push	ax
	shr	al, 1
	shr	al, 1
	shr	al, 1
	shr	al, 1
	call	L00620
	pop	ax
	call	L00620
	loop	L0060A
	ret
L00620:	and	al, 15
	cmp	al, 10
	jae	L0062A
	add	al, 30h
	stosb
	ret
L0062A:	add	al, 37h
	stosb
	ret
L0062E:	call	L004FB
	call	L002BE
	jmp	L00504
L00637:	xor	ax, ax
	mov	word ptr v_06DA, ax
	mov	word ptr v_06DC, ax
	mov	word ptr v_06DE, 0FFFFh
	ret
L00646:	mov	bx, word ptr v_06DE
	cmp	bx, -1
	je	L0065A
	mov	word ptr v_06DE, 0FFFFh
	call	far ptr dosclose
L0065A:	ret
L0065B:	stc
	ret
L0065D:	mov	cx, word ptr v_06DA
L00661:	jcxz	L00672
	mov	es, cx
	push	es
	push	si
	call	si
	pop	si
	pop	es
	mov	cx, word ptr es:[2]
	jmp	short L00661
L00672:	ret
L00673:	mov	di, dx
	push	ss
	pop	es
	mov	cx, 0FFFFh
	xor	al, al
	repne scasb
	neg	cx
	dec	cx
	mov	ax, cx
	add	ax, 13h
	shr	ax, 1
	shr	ax, 1
	shr	ax, 1
	shr	ax, 1
	push	cx
	mov	cx, ax
	nosmart
	call	far ptr L00902
	smart
	pop	cx
	mov	es, ax
	mov	di, 4
	mov	si, dx
	rep movsb
	mov	cx, word ptr v_06DC
	mov	dx, es
	mov	word ptr v_06DC, dx
	mov	word ptr es:[0], cx
	mov	word ptr es:[2], 0
	jcxz	L006C2
	push	ds
	mov	ds, cx
	mov	word ptr v_0002, dx
	pop	ds
	jmp	short L006C6
L006C2:	mov	word ptr v_06DA, dx
L006C6:	ret
L006C7:	call	L00646
	mov	word ptr v_06E0, es
	push	es
	pop	ds
	mov	dx, 4
	xor	al, al
	call	far ptr dosopen
	mov	ax, ss
	mov	ds, ax
	jb	L006E5
	mov	word ptr v_06DE, bx
	clc
L006E5:	ret
L006E6:	mov	dx, 6E2h
	mov	cx, 3
	mov	bx, word ptr v_06DE
	mov	ax, ds
	call	far ptr dosread
	jb	L0071E
	cmp	ax, cx
	jb	L0071E
	mov	cx, word ptr v_06E3
	cmp	cx, 401h
	cmc
	jb	L0071E
	mov	dx, 6E5h
	mov	ax, ds
	call	far ptr dosread
	jb	L0071E
	cmp	ax, cx
	jb	L0071E
	mov	si, 6E5h
	mov	al, byte ptr v_06E2
L0071E:	ret
CODE	ends
	end
