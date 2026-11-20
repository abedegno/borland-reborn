; DOSIO.ASM: the DOS calls, as far procedures; some are never called.


	public	dosinit, dosexit, dostime, dosdate, dosopen, doscreate, dosclose, dosread, doswrite, dosseek, dosdelete
DATA	segment word public 'DATA'
	extrn	v_06B8:byte
	extrn	v_06BA:byte
	extrn	v_06C5:byte
	extrn	v_06C7:byte
DATA	ends

DOSIO	segment byte public 'CODE'
	assume	cs:DOSIO,ds:DATA
dosinit:	mov	ax, ds
	mov	es, ax
	mov	ah, 30h
	int	21h
	xchg	al, ah
	cmp	ax, 200h
	jb	L010BD
	mov	di, 6BAh
	mov	si, di
	xor	cx, cx
L0107C:	mov	dx, 36Ch
	mov	ax, 3D01h
	int	21h
	cld
	jb	L0108E
	stosw
	inc	cx
	cmp	cx, 10h
	jne	L0107C
L0108E:	mov	word ptr v_06B8, cx
	mov	dx, si
	jcxz	L010A0
L01096:	lodsw
	mov	bx, ax
	mov	ah, 3Eh
	int	21h
	cld
	loop	L01096
L010A0:	mov	di, dx
	mov	ax, 3800h
	int	21h
	mov	ah, 30h
	int	21h
	xchg	al, ah
	cld
	cmp	ax, 20Bh
	cmc
	jae	L010BD
	mov	byte ptr [di+11], 2Fh
	mov	byte ptr [di+13], 3Ah
	clc
L010BD:	retf
dosexit:	mov	ah, 4Ch
	int	21h
	mov	ax, word ptr v_06B8
dosftime:	retf
	mov	ax, 5700h
	int	21h
	retf
dostime:	mov	ah, 2Ch
	int	21h
	cld
	mov	al, byte ptr v_06C7
	retf
dosdate:	mov	ah, 2Ah
	int	21h
	cld
	sub	cx, 76Ch
	cmp	cx, 64h
	jb	L010E6
	sub	cx, 64h
L010E6:	mov	ch, cl
	mov	cl, dh
	mov	dh, dl
	mov	ax, word ptr v_06BA
	cmp	ax, 2
	je	L01105
	cmp	ax, 1
	je	L01103
	mov	dl, ch
	mov	ch, cl
	mov	cl, dh
	mov	dh, dl
	jmp	short L01105
L01103:	xchg	ch, dh
L01105:	mov	al, byte ptr v_06C5
	retf
dosopen:	mov	ah, 3Dh
	int	21h
	cld
	jb	L01112
	mov	bx, ax
L01112:	retf
doscreate:	xor	cx, cx
	mov	ah, 3Ch
	int	21h
	cld
	jb	L0111E
	mov	bx, ax
L0111E:	retf
dosclose:	mov	ah, 3Eh
	int	21h
	cld
	retf
dosread:	push	ds
	mov	ds, ax
	mov	ah, 3Fh
	int	21h
	cld
	pop	ds
	retf
doswrite:	push	ds
	mov	ds, ax
	mov	ah, 40h
	int	21h
	cld
	pop	ds
	jb	L0113C
	cmp	ax, cx
L0113C:	retf
dosseek:	mov	ah, 42h
	int	21h
	cld
	retf
dosdelete:	mov	ah, 41h
	int	21h
	cld
	retf
dosrename:	mov	ax, ds
	mov	es, ax
	mov	ah, 56h
	int	21h
	cld
	retf
doscurdir:	mov	ah, 19h
	int	21h
	add	al, 41h
	mov	byte ptr [di], al
	inc	di
	mov	byte ptr [di], 3Ah
	inc	di
	mov	byte ptr [di], 5Ch
	inc	di
	mov	si, di
	xor	dl, dl
	mov	ah, 47h
	int	21h
	cld
	retf
	push	ax
	push	di
	push	dx
	push	ds
	mov	ds, ax
	mov	dx, di
	mov	ah, 1Ah
	int	21h
	pop	ds
	pop	dx
	mov	ah, 4Eh
	jmp	short L0118C
	push	ax
	push	di
	mov	dx, di
	mov	ds, ax
	mov	ah, 1Ah
	int	21h
	mov	ah, 4Fh
L0118C:	int	21h
	cld
	pop	si
	mov	di, si
	pop	ds
	push	ds
	pop	es
	pushf
	add	di, 17h
	add	si, 1Eh
	mov	cx, 7
	rep movsw
	popf
	retf
DOSIO	ends
	end
