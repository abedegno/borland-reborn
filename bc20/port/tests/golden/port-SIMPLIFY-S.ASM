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
   ;	
   ;	void f(int x, long y, double d, unsigned u)
   ;	
	assume	cs:T_TEXT
_f	proc	far
	push	bp
	mov	bp,sp
	sub	sp,10
	push	si
	push	di
	mov	si,word ptr [bp+6]
	mov	di,word ptr [bp+20]
   ;	
   ;	{
   ;	    r[0] = x * -1;
   ;	
	mov	ax,si
	mov	dx,65535
	imul	dx
	mov	word ptr DGROUP:_r,ax
   ;	
   ;	    r[1] = x / -1;
   ;	
	mov	ax,si
	mov	bx,65535
	cwd	
	idiv	bx
	mov	word ptr DGROUP:_r+2,ax
   ;	
   ;	    d = d * -1.0;
   ;	
	fld	qword ptr [bp+12]
	fmul	dword ptr DGROUP:s@
	fstp	qword ptr [bp+12]
   ;	
   ;	    d = d / -1.0;
   ;	
	fld	qword ptr [bp+12]
	fdiv	dword ptr DGROUP:s@
	fstp	qword ptr [bp+12]
   ;	
   ;	    r[2] = (x * 0 + 7) / -2;
   ;	
	xor	ax,ax
	add	ax,7
	mov	bx,65534
	cwd	
	idiv	bx
	fwait	
	mov	word ptr DGROUP:_r+4,ax
   ;	
   ;	    r[3] = (x * 0 - 9) % 4;
   ;	
	xor	ax,ax
	add	ax,65527
	mov	bx,4
	cwd	
	idiv	bx
	mov	word ptr DGROUP:_r+6,dx
   ;	
   ;	    r[4] = (u * 0 + 7u) % 3u;
   ;	
	xor	ax,ax
	add	ax,7
	mov	bx,3
	xor	dx,dx
	div	bx
	mov	word ptr DGROUP:_r+8,dx
   ;	
   ;	    r[5] = (x * 0 + 5) - 9;
   ;	
	xor	ax,ax
	add	ax,65532
	mov	word ptr DGROUP:_r+10,ax
   ;	
   ;	    r[6] = (u * 0 + 5u) - 9u;
   ;	
	xor	ax,ax
	add	ax,5
	sub	ax,9
	mov	word ptr DGROUP:_r+12,ax
   ;	
   ;	    l[0] = (y * 0 + 0x1234L) ^ 0x0F0FL;
   ;	
	xor	ax,ax
	xor	dx,dx
	add	dx,4660
	adc	ax,0
	xor	dx,3855
	mov	word ptr DGROUP:_l+2,ax
	mov	word ptr DGROUP:_l,dx
   ;	
   ;	    r[7] = (x * 0 + 12) / 4 + (x * 0 - 12) / 4;
   ;	
	xor	ax,ax
	add	ax,12
	mov	bx,4
	cwd	
	idiv	bx
	push	ax
	xor	ax,ax
	add	ax,65524
	cwd	
	idiv	bx
	pop	dx
	add	dx,ax
	mov	word ptr DGROUP:_r+14,dx
   ;	
   ;	    *g() += 1;
   ;	
	call	far ptr _g
	mov	bx,ax
	mov	es,dx
	inc	word ptr es:[bx]
   ;	
   ;	    a[idx()] *= 3;
   ;	
	call	far ptr _idx
	shl	ax,1
	mov	dx,3
	mov	bx,ax
	mov	ax,word ptr DGROUP:_a[bx]
	imul	dx
	mov	word ptr DGROUP:_a[bx],ax
   ;	
   ;	    h()->b += 2;
   ;	
	call	far ptr _h
	mov	word ptr [bp-2],dx
	mov	es,dx
	mov	word ptr [bp-4],ax
	mov	bx,ax
	mov	al,byte ptr es:[bx]
	and	ax,7
	inc	ax
	inc	ax
	and	ax,7
	les	bx,dword ptr [bp-4]
	and	byte ptr es:[bx],248
	or	byte ptr es:[bx],al
   ;	
   ;	    h()->c -= 4;
   ;	
	call	far ptr _h
	mov	bx,ax
	mov	es,dx
	sub	word ptr es:[bx+1],4
   ;	
   ;	    (*g())++;
   ;	
	call	far ptr _g
	mov	bx,ax
	mov	es,dx
	inc	word ptr es:[bx]
   ;	
   ;	    a[idx()]--;
   ;	
	call	far ptr _idx
	shl	ax,1
	mov	bx,ax
	dec	word ptr DGROUP:_a[bx]
   ;	
   ;	    h()->b++;
   ;	
	call	far ptr _h
	mov	word ptr [bp-6],dx
	mov	es,dx
	mov	word ptr [bp-8],ax
	mov	bx,ax
	mov	al,byte ptr es:[bx]
	and	ax,7
	inc	ax
	and	ax,7
	les	bx,dword ptr [bp-8]
	and	byte ptr es:[bx],248
	or	byte ptr es:[bx],al
   ;	
   ;	    l[idx()] /= 3;
   ;	
	xor	ax,ax
	mov	dx,3
	push	ax
	push	dx
	call	far ptr _idx
	shl	ax,1
	shl	ax,1
	add	ax,offset DGROUP:_l
	mov	word ptr [bp-10],ax
	mov	bx,ax
	push	word ptr [bx+2]
	push	word ptr [bx]
	call	far ptr F_LDIV@
	mov	bx,word ptr [bp-10]
	mov	word ptr [bx+2],dx
	mov	word ptr [bx],ax
   ;	
   ;	    r[8] = (x + 7) - (x + 2);
   ;	
	mov	ax,si
	add	ax,7
	mov	dx,si
	inc	dx
	inc	dx
	sub	ax,dx
	mov	word ptr DGROUP:_r+16,ax
   ;	
   ;	    r[9] = (u + 7u) - (u - 2u);
   ;	
	mov	ax,di
	add	ax,7
	mov	dx,di
	dec	dx
	dec	dx
	sub	ax,dx
	mov	word ptr DGROUP:_r+18,ax
   ;	
   ;	    r[10] = 9 - (x + 2);
   ;	
	mov	ax,si
	inc	ax
	inc	ax
	mov	dx,9
	sub	dx,ax
	mov	word ptr DGROUP:_r+20,dx
   ;	
   ;	    r[11] = (x - 3) - (x + 4);
   ;	
	mov	ax,si
	add	ax,65533
	mov	dx,si
	add	dx,4
	sub	ax,dx
	mov	word ptr DGROUP:_r+22,ax
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_f	endp
T_TEXT	ends
_BSS	segment word public 'BSS'
_a	label	word
	db	20 dup (?)
_l	label	word
	db	16 dup (?)
_r	label	word
	db	32 dup (?)
	?debug	C E9
_BSS	ends
_DATA	segment word public 'DATA'
s@	label	byte
	db	0
	db	0
	db	-128
	db	-65
_DATA	ends
T_TEXT	segment byte public 'CODE'
T_TEXT	ends
	extrn	F_LDIV@:far
	extrn	_idx:far
	public	_r
	public	_l
	extrn	_h:far
	extrn	_g:far
	public	_f
	public	_a
	end
