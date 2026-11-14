	ifndef	??version
?debug	macro
	endm
publicdll macro	name
	public	name
	endm
$comm	macro	name,dist,size,count
	comm	dist name:BYTE:count*size
	endm
	else
$comm	macro	name,dist,size,count
	comm	dist name[size]:BYTE:count
	endm
	endif
	?debug	S "t.c"
	?debug	C E90000212803742E63
	?debug	C E9000021280E433A5C50524F4A5C444154412E48
T_TEXT	segment byte public 'CODE'
T_TEXT	ends
DGROUP	group	_DATA,_BSS
	assume	cs:T_TEXT,ds:DGROUP
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
_BSS	ends
T_TEXT	segment byte public 'CODE'
	assume	cs:T_TEXT
SET_PROGRAM_TOP	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	cmp	byte ptr DGROUP:DOS_HOST_MODE,8
	je	short @1@266
 	mov	 es,word ptr DGROUP:PROGRAM_PSP
 	mov	 ax,[bp+4]
 	sub	 ax,word ptr DGROUP:PROGRAM_PSP
 	mov	 bx,ax
 	mov	 ah,4Ah
 	int	 21h
	jnc	short @1@242
	mov	ax,bx
	add	ax,word ptr DGROUP:PROGRAM_PSP
	jmp	short @1@794
@1@242:
	jmp	short @1@770
@1@266:
 	mov	 ax,[bp+4]
 	mov	 dx,word ptr DGROUP:EXTENDER_BASE
 	sub	 ax,dx
 	xor	 dx,dx
 	mov	 cx,10h
 	mul	 cx
 	mov	 cx,dx
 	mov	 dx,ax
 	mov	 bx,word ptr DGROUP:EXTENDER_HEAP_TOP
 	mov	 ax,0E905h
 	int	 21h
	jnc	short @1@770
 	shr	 cx,1
 	rcr	 dx,1
 	shr	 cx,1
 	rcr	 dx,1
 	shr	 cx,1
 	rcr	 dx,1
 	shr	 cx,1
 	rcr	 dx,1
	mov	ax,dx
	jmp	short @1@794
@1@770:
	xor	ax,ax
@1@794:
	pop	bp
	dec	bp
	ret	2
SET_PROGRAM_TOP	endp
	?debug	C E9
T_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
T_TEXT	segment byte public 'CODE'
T_TEXT	ends
	extrn	PROGRAM_PSP:word
	public	SET_PROGRAM_TOP
	extrn	EXTENDER_HEAP_TOP:word
	extrn	EXTENDER_BASE:word
	extrn	DOS_HOST_MODE:byte
	end
