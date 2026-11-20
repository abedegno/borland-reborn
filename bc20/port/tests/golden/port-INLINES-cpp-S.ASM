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
	?debug	S "t.cpp"
	?debug	C E90000212805742E637070
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
_DATA	segment word public 'DATA'
_initial	label	word
	db	0
	db	0
_DATA	ends
_BSS	segment word public 'BSS'
_BSS	ends
_DATA	segment word public 'DATA'
other	label	word
	db	0
	db	0
_DATA	ends
_BSS	segment word public 'BSS'
_BSS	ends
T_TEXT	segment byte public 'CODE'
   ;	
   ;	int use(int x, int y)
   ;	
	assume	cs:T_TEXT
@use$qii	proc	far
	push	bp
	mov	bp,sp
	sub	sp,34
	push	si
	push	di
	mov	si,word ptr [bp+6]
	mov	di,word ptr [bp+8]
   ;	
   ;	{
   ;	    Holder a, b;
   ;	
	mov	ax,seg @M@$bctr$qv
	push	ax
	mov	ax,offset @M@$bctr$qv
	push	ax
	mov	ax,5
	push	ax
	mov	ax,4
	push	ax
	mov	ax,2
	push	ax
	push	ss
	lea	ax,word ptr [bp-10]
	push	ax
	call	far ptr __vector_new_
	add	sp,14
	mov	ax,seg @M@$bctr$qv
	push	ax
	mov	ax,offset @M@$bctr$qv
	push	ax
	mov	ax,5
	push	ax
	mov	ax,4
	push	ax
	mov	ax,2
	push	ax
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	far ptr __vector_new_
	add	sp,14
   ;	
   ;	    a = b;
   ;	
	lea	ax,word ptr [bp-10]
	push	ss
	push	ax
	lea	ax,word ptr [bp-20]
	push	ss
	push	ax
	mov	cx,10
	call	far ptr F_SCOPY@
   ;	
   ;	    D *d = new D;
   ;	
	mov	word ptr [bp-26],0
	mov	word ptr [bp-28],0
	mov	ax,4
	push	ax
	call	far ptr @$bnew$qui
	pop	cx
	mov	word ptr [bp-26],dx
	mov	word ptr [bp-28],ax
	or	ax,dx
	je	short @1@74
	les	bx,dword ptr [bp-28]
	mov	word ptr es:[bx],offset @@B@
	mov	ax,word ptr [bp-28]
	inc	ax
	inc	ax
	push	word ptr [bp-26]
	push	ax
	call	far ptr @M@$bctr$qv
	pop	cx
	pop	cx
	les	bx,dword ptr [bp-28]
	mov	word ptr es:[bx],offset @@D@
	jmp	short @1@74
@1@74:
	mov	ax,word ptr [bp-26]
	mov	dx,word ptr [bp-28]
	mov	word ptr [bp-22],ax
	mov	word ptr [bp-24],dx
   ;	
   ;	    delete d;
   ;	
	mov	ax,word ptr [bp-24]
	or	ax,word ptr [bp-22]
	je	short @1@122
	mov	ax,3
	push	ax
	push	word ptr [bp-22]
	push	word ptr [bp-24]
	les	bx,dword ptr [bp-24]
	mov	bx,word ptr es:[bx]
	call	dword ptr [bx]
	add	sp,6
	jmp	short @1@122
@1@122:
   ;	
   ;	    return pick(x, y) + clamp(x - y);
   ;	
	cmp	si,di
	jle	short @1@170
	mov	ax,si
	jmp	short @1@290
@1@170:
	cmp	si,di
	jne	short @1@218
	mov	ax,si
	shl	ax,1
	mov	word ptr [bp-32],ax
	jmp	short @1@290
@1@218:
	cmp	di,10
	jle	short @1@266
	mov	ax,10
	jmp	short @1@290
@1@266:
	mov	ax,di
@1@290:
	mov	dx,si
	sub	dx,di
	mov	word ptr [bp-34],dx
	push	ax
	cmp	word ptr [bp-34],0
	jge	short @1@338
	xor	ax,ax
	jmp	short @1@362
@1@338:
	mov	ax,word ptr [bp-34]
	inc	ax
	mov	word ptr [bp-34],ax
@1@362:
	pop	dx
	add	dx,ax
	mov	word ptr [bp-30],dx
	mov	ax,seg @M@$bdtr$qv
	push	ax
	mov	ax,offset @M@$bdtr$qv
	push	ax
	mov	ax,5
	push	ax
	mov	ax,4
	push	ax
	mov	ax,2
	push	ax
	push	ss
	lea	ax,word ptr [bp-20]
	push	ax
	call	far ptr __vector_delete_
	add	sp,14
	mov	ax,seg @M@$bdtr$qv
	push	ax
	mov	ax,offset @M@$bdtr$qv
	push	ax
	mov	ax,5
	push	ax
	mov	ax,4
	push	ax
	mov	ax,2
	push	ax
	push	ss
	lea	ax,word ptr [bp-10]
	push	ax
	call	far ptr __vector_delete_
	add	sp,14
	mov	ax,word ptr [bp-30]
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
@use$qii	endp
T_TEXT	ends
_INIT_	segment word public 'INITDATA'
	db	1
	db	32
	dd	@_STCON_$qv
_INIT_	ends
T_TEXT	segment byte public 'CODE'
	assume	cs:T_TEXT
@_STCON_$qv	proc	far
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	mov	ax,3
	push	ax
	call	far ptr @g$qi
	pop	cx
	mov	word ptr DGROUP:_initial,ax
	cmp	word ptr DGROUP:_initial,2
	jle	short @2@74
	jmp	short @2@146
@2@74:
	cmp	word ptr DGROUP:_initial,2
	jne	short @2@122
	mov	ax,word ptr DGROUP:_initial
	shl	ax,1
	mov	word ptr [bp-2],ax
	jmp	short @2@146
@2@122:
	mov	ax,2
@2@146:
	mov	word ptr DGROUP:other,ax
	mov	sp,bp
	pop	bp
	ret	
@_STCON_$qv	endp
T_TEXT	ends
_DATA	segment word public 'DATA'
@D@	segment	virtual
@@D@	label	byte
	dd	@@D@$bdtr$qv
@D@	ends
_DATA	ends
T_TEXT	segment byte public 'CODE'
T_TEXT	ends
_DATA	segment word public 'DATA'
@B@	segment	virtual
@@B@	label	byte
	dd	@B@$bdtr$qv
@B@	ends
_DATA	ends
T_TEXT	segment byte public 'CODE'
T_TEXT	ends
T_TEXT	segment byte public 'CODE'
@D@$bdtr$qv	segment	virtual
	assume	cs:@D@$bdtr$qv
@@D@$bdtr$qv	proc	far
	push	bp
	mov	bp,sp
	mov	ax,word ptr [bp+6]
	or	ax,word ptr [bp+8]
	je	short @3@122
	les	bx,dword ptr [bp+6]
	mov	word ptr es:[bx],offset @@D@
	mov	ax,2
	push	ax
	mov	ax,word ptr [bp+6]
	inc	ax
	inc	ax
	push	word ptr [bp+8]
	push	ax
	call	far ptr @M@$bdtr$qv
	add	sp,6
	xor	ax,ax
	push	ax
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	call	far ptr @B@$bdtr$qv
	add	sp,6
	test	word ptr [bp+10],1
	je	short @3@122
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	call	far ptr @$bdele$qnv
	pop	cx
	pop	cx
	jmp	short @3@122
@3@122:
	pop	bp
	ret	
@@D@$bdtr$qv	endp
	?debug	C E9
@D@$bdtr$qv	ends
T_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
T_TEXT	segment byte public 'CODE'
@D@$bdtr$qv	segment	virtual
@D@$bdtr$qv	ends
T_TEXT	ends
_s@	equ	s@
	public	_initial
_other	equ	other
	public	@use$qii
	extrn	__vector_new_:far
	extrn	@M@$bctr$qv:far
	extrn	F_SCOPY@:near
	extrn	@$bnew$qui:far
	extrn	__vector_delete_:far
	extrn	@M@$bdtr$qv:far
	extrn	@g$qi:far
	extrn	@B@$bdtr$qv:far
	extrn	@$bdele$qnv:far
	end
