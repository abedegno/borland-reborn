; TSRINST.ASM: the installing part of the TesSeRact TSR library 1.10 (see
; TESS.ASM), which the linker took from the library after THELP: TsrInstall,
; TsrCheck and the stack set-up. Assembled with MASM, like TESS.ASM.
	locals
	.186
code	segment	byte public 'CODE'
	assume	cs:code,ds:code,es:code,ss:code
	public	tsrinstall
	public	tsrcheck
	public	tsrstacks
	extrn	dosmajor:byte
	extrn	indosptr:byte
	extrn	critptr:byte
	extrn	tsrinfo:byte
	extrn	tsrnumber:byte
	extrn	tsrhotscan:byte
	extrn	tsrhotshift:byte
	extrn	tsrflags:byte
	extrn	tsrpsp:byte
	extrn	tsrdta:byte
	extrn	tsrcs:byte
	extrn	fgstack:byte
	extrn	bgstack:byte
	extrn	nullint:near
	extrn	tsrhook:near
	extrn	getpsp:near
	extrn	beep:near
	extrn	tsrsetup:near

; TsrInstall: AX = hot key, BX = flags, DX = bytes to keep resident.
; Hooks the interrupts and terminates, staying resident
tsrinstall:	mov	word ptr tsrcs, cs
	push	dx
	push	bx
	push	ax
	mov	ax, 3000h
	int	21h
	mov	byte ptr dosmajor, al
	push	cs
	pop	es
	mov	si, offset tsrname
	mov	di, offset tsrinfo
	mov	cx, 0Ah
	rep movsb
	mov	ax, 3400h
	int	21h
	mov	word ptr indosptr, bx
	mov	word ptr indosptr+2, es
	cmp	byte ptr dosmajor, 4
	ja	@@7
	mov	word ptr critptr+2, es
	mov	cx, 8000h
	mov	bx, 0
@@1:	mov	ax, 3E80h
	mov	di, bx
	repne scasw
	je	@@2
	jmp	short @@3
@@2:	mov	al, byte ptr es:[di+5]
	cmp	al, 0BCh
	je	@@8
	mov	bx, di
@@3:	push	bx
	rcr	bx, 1
	pop	bx
	jb	@@5
	jcxz	@@4
	jmp	@@1
@@4:	mov	bx, 1
	mov	cx, 8000h
@@5:	jcxz	@@6
	jmp	@@1
@@6:	jmp	@@20
@@7:	mov	word ptr critptr+2, cs
	mov	word ptr critptr, 108h
	jmp	short @@9
@@8:	mov	ax, word ptr es:[di]
	mov	word ptr critptr, ax
@@9:	pop	ax
	mov	byte ptr tsrhotscan, al
	mov	byte ptr tsrhotshift, ah
	xor	ax, ax
	mov	word ptr tsrflags, ax
	push	es
	mov	ax, 2F00h
	int	21h
	mov	word ptr tsrdta+2, es
	mov	word ptr tsrdta, bx
	pop	es
	call	getpsp
	mov	word ptr tsrpsp, bx
	pop	ax
	mov	word ptr tsrflags, ax
	push	cs
	pop	ds
	mov	si, 1E0h
	xor	ax, ax
@@10:	lodsb
	or	al, al
	je	@@11
	add	ah, al
	jmp	@@10
@@11:	cmp	ah, 0E0h
	je	@@12
	call	beep
	jmp	@@11
@@12:	push	ds
	mov	ax, word ptr tsrpsp
	mov	ds, ax
	mov	bx, 18h
	mov	cx, 3
@@13:	push	word ptr [bx]
	inc	bx
	inc	bx
	loop	@@13
	mov	cx, 5
@@14:	push	cx
	mov	bx, cx
	dec	bx
	mov	ah, 3Eh
	int	21h
	pop	cx
	loop	@@14
	mov	bx, 1Ch
	mov	cx, 3
@@15:	pop	word ptr [bx]
	dec	bx
	dec	bx
	loop	@@15
	pop	ds
	mov	ax, 3508h
	int	21h
	cmp	word ptr es:[bx-4], 4B53h
	jne	@@18
	cmp	word ptr es:[bx-2], 4942h
	jne	@@18
	mov	cx, 64h
	mov	al, 1Fh
	mov	di, bx
@@16:	repne scasb
	je	@@17
	jcxz	@@18
@@17:	cmp	byte ptr es:[di+4], 74h
	jne	@@16
	mov	byte ptr es:[di+4], 0EBh
@@18:	push	ds
	mov	ax, 40h
	mov	ds, ax
	mov	si, 80h
	lodsw
	or	ax, ax
	jne	@@19
	mov	di, 80h
	push	ds
	pop	es
	cli
	mov	ax, 1Eh
	stosw
	add	ax, 20h
	stosw
	mov	di, 1Ah
	sub	ax, 20h
	stosw
	stosw
	sti
@@19:	pop	ds
	xor	ax, ax
	inc	ax
	call	tsrhook
	mov	ax, 5453h
	mov	bx, 10h
	mov	cx, word ptr tsrnumber
	int	2Fh
	push	ds
	mov	ax, word ptr tsrcs
	mov	ds, ax
	xor	ax, ax
	call	tsrsetup
	pop	ds
	pop	dx
	shr	dx, 1
	shr	dx, 1
	shr	dx, 1
	shr	dx, 1
	inc	dx
	xor	al, al
	mov	ah, 31h
	int	21h
@@20:	ret

; makes sure INT 2Fh has a handler
hook2f:	xor	ax, ax
	mov	es, ax
	mov	bx, 2Fh
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr es:[bx]
	or	ax, word ptr es:[bx+2]
	jne	@@1
	mov	ax, offset nullint
	mov	word ptr es:[bx], ax
	mov	word ptr es:[bx+2], cs
@@1:	ret
tsrname	db	10 dup (0)

; is a TSR with this name loaded? SI = name, DI = its number; AX = FFFFh if so
tsrcheck:	push	ds
	push	di
	push	si
	call	hook2f
	pop	si
	push	ds
	push	si
	xor	cx, cx
	xor	bx, bx
	mov	ax, 5453h
	int	2Fh
	pop	si
	pop	ds
	cmp	ax, 0FFFFh
	je	@@1
	push	cx
	mov	di, offset tsrname
	push	cs
	pop	es
	mov	cx, 8
	rep movsb
	pop	ax
	stosw
	pop	di
	stosw
	xor	ax, ax
	jmp	short @@2
@@1:	pop	di
	mov	word ptr [di], cx
@@2:	pop	ds
	ret

; sets the stacks for popping up (DI) and for the background (SI)
tsrstacks:	push	cs
	pop	es
	mov	bx, di
	or	bx, bx
	jne	@@1
	mov	word ptr cs:fgstack, sp
	mov	word ptr cs:fgstack+2, ss
	jmp	short @@2
@@1:	db	81h, 0E3h, 0FEh, 0FFh	; and bx, 0FFFEh  (MASM's encoding: TASM sign-extends a byte immediate)
	mov	word ptr cs:fgstack, bx
	mov	word ptr cs:fgstack+2, es
@@2:	mov	bx, si
	db	81h, 0E3h, 0FEh, 0FFh	; and bx, 0FFFEh  (MASM's encoding: TASM sign-extends a byte immediate)
	mov	word ptr cs:bgstack, bx
	mov	word ptr cs:bgstack+2, es
	ret
tsrtail	db	8 dup (0)
code	ends
	end
