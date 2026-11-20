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
_pf	label	word
	db	0
	db	0
	db	0
	db	0
	dd	@A@f$qi
_DATA	ends
_BSS	segment word public 'BSS'
_BSS	ends
_DATA	segment word public 'DATA'
_pg	label	word
	db	0
	db	0
	db	1
	db	0
	db	4
	db	0
	db	0
	db	0
_DATA	ends
_BSS	segment word public 'BSS'
_BSS	ends
_DATA	segment word public 'DATA'
_pm	label	word
	db	3
	db	0
_DATA	ends
_BSS	segment word public 'BSS'
_BSS	ends
T_TEXT	segment byte public 'CODE'
   ;	
   ;	int test(A &a, A *p)
   ;	
	assume	cs:T_TEXT
@test$qm1An1A	proc	far
	push	bp
	mov	bp,sp
	push	si
   ;	
   ;	{
   ;	    int r = 0;
   ;	
	xor	si,si
   ;	
   ;	    if (pf == pg) r++;
   ;	
	mov	ax,word ptr DGROUP:_pf
	cmp	ax,word ptr DGROUP:_pg
	jne	short @1@146
	mov	ax,word ptr DGROUP:_pf+2
	cmp	ax,word ptr DGROUP:_pg+2
	jne	short @1@146
	mov	ax,word ptr DGROUP:_pf+4
	cmp	ax,word ptr DGROUP:_pg+4
	jne	short @1@146
	mov	ax,word ptr DGROUP:_pf+6
	cmp	ax,word ptr DGROUP:_pg+6
	jne	short @1@146
	inc	si
@1@146:
   ;	
   ;	    if (pf != 0) r++;
   ;	
	mov	ax,word ptr DGROUP:_pf
	or	ax,word ptr DGROUP:_pf+2
	or	ax,word ptr DGROUP:_pf+4
	or	ax,word ptr DGROUP:_pf+6
	je	short @1@194
	inc	si
@1@194:
   ;	
   ;	    if (pm == &A::x) r++;
   ;	
	cmp	word ptr DGROUP:_pm,1
	jne	short @1@242
	inc	si
@1@242:
   ;	
   ;	    if (pm != 0) r++;
   ;	
	cmp	word ptr DGROUP:_pm,0
	je	short @1@290
	inc	si
@1@290:
   ;	
   ;	    if (!pf) r++;
   ;	
	mov	ax,word ptr DGROUP:_pf
	or	ax,word ptr DGROUP:_pf+2
	or	ax,word ptr DGROUP:_pf+4
	or	ax,word ptr DGROUP:_pf+6
	or	ax,ax
	jne	short @1@338
	inc	si
@1@338:
   ;	
   ;	    r += (a.*pf)(1) + (p->*pg)(2);
   ;	
	mov	ax,1
	push	ax
	mov	ax,word ptr [bp+6]
	add	ax,word ptr DGROUP:_pf
	push	word ptr [bp+8]
	push	ax
	cmp	word ptr DGROUP:_pf+2,0
	je	short @1@386
	les	bx,dword ptr [bp+6]
	add	bx,word ptr DGROUP:_pf
	add	bx,word ptr DGROUP:_pf+4
	mov	bx,word ptr es:[bx]
	mov	ax,word ptr DGROUP:_pf+2
	dec	ax
	add	bx,ax
	mov	dx,word ptr [bx+2]
	mov	ax,word ptr [bx]
	jmp	short @1@410
@1@386:
	mov	dx,word ptr DGROUP:_pf+6
	mov	ax,word ptr DGROUP:_pf+4
@1@410:
	push	cs
	mov	cx,offset $+7
	push	cx
	push	dx
	push	ax
	ret	
	add	sp,6
	push	ax
	mov	ax,2
	push	ax
	mov	ax,word ptr [bp+10]
	add	ax,word ptr DGROUP:_pg
	push	word ptr [bp+12]
	push	ax
	cmp	word ptr DGROUP:_pg+2,0
	je	short @1@458
	les	bx,dword ptr [bp+10]
	add	bx,word ptr DGROUP:_pg
	add	bx,word ptr DGROUP:_pg+4
	mov	bx,word ptr es:[bx]
	mov	ax,word ptr DGROUP:_pg+2
	dec	ax
	add	bx,ax
	mov	dx,word ptr [bx+2]
	mov	ax,word ptr [bx]
	jmp	short @1@482
@1@458:
	mov	dx,word ptr DGROUP:_pg+6
	mov	ax,word ptr DGROUP:_pg+4
@1@482:
	push	cs
	mov	cx,offset $+7
	push	cx
	push	dx
	push	ax
	ret	
	add	sp,6
	pop	dx
	add	dx,ax
	add	si,dx
   ;	
   ;	    r += a.operator int();
   ;	
	les	bx,dword ptr [bp+6]
	add	si,word ptr es:[bx]
   ;	
   ;	    return r;
   ;	
	mov	ax,si
	jmp	short @1@506
@1@506:
   ;	
   ;	}
   ;	
	pop	si
	pop	bp
	ret	
@test$qm1An1A	endp
	?debug	C E9
T_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
T_TEXT	segment byte public 'CODE'
T_TEXT	ends
_s@	equ	s@
	public	_pf
	extrn	@A@f$qi:far
	public	_pg
	public	_pm
	public	@test$qm1An1A
	end
