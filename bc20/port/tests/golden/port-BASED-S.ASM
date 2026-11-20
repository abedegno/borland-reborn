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
   ;	int f(int i)
   ;	
	assume	cs:T_TEXT
_f	proc	far
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	di,word ptr [bp+6]
   ;	
   ;	{
   ;	    int total = *p + *q + p[2] + q[i] + r->b;
   ;	
	mov	ax,di
	shl	ax,1
	les	bx,dword ptr DGROUP:_q
	add	bx,ax
	mov	ax,word ptr DGROUP:_base_seg
	shl	ax,1
	add	bx,ax
	mov	ax,word ptr DGROUP:_base_seg
	shl	ax,1
	push	es
	push	bx
	mov	bx,word ptr DGROUP:_q
	add	bx,ax
	push	es
	push	bx
	mov	bx,word ptr DGROUP:_p
	add	bx,word ptr DGROUP:_base_seg
	mov	al,byte ptr [bx]
	cbw	
	pop	bx
	pop	es
	add	ax,word ptr es:[bx]
	mov	bx,word ptr DGROUP:_p
	add	bx,word ptr DGROUP:_base_seg
	push	ax
	mov	al,byte ptr [bx+2]
	cbw	
	pop	dx
	add	dx,ax
	pop	bx
	pop	es
	add	dx,word ptr es:[bx]
	mov	ax,word ptr DGROUP:_table+2
	shl	ax,1
	mov	bx,word ptr DGROUP:_r
	add	bx,ax
	add	dx,word ptr [bx+2]
	mov	si,dx
   ;	
   ;	    p++;
   ;	
	inc	word ptr DGROUP:_p
   ;	
   ;	    q += 2;
   ;	
	add	word ptr DGROUP:_q,4
   ;	
   ;	    *p = 7;
   ;	
	mov	bx,word ptr DGROUP:_p
	add	bx,word ptr DGROUP:_base_seg
	mov	byte ptr [bx],7
   ;	
   ;	    r[i].a = total;
   ;	
	mov	ax,di
	shl	ax,1
	shl	ax,1
	mov	bx,word ptr DGROUP:_r
	add	bx,ax
	mov	ax,word ptr DGROUP:_table+2
	shl	ax,1
	shl	ax,1
	add	bx,ax
	mov	ax,word ptr DGROUP:_table+2
	shl	ax,1
	add	bx,ax
	mov	word ptr [bx],si
   ;	
   ;	    if (p == 0 || q != 0)
   ;	
	cmp	word ptr DGROUP:_p,0
	je	short @1@74
	mov	ax,word ptr DGROUP:_q
	or	ax,word ptr DGROUP:_q+2
	je	short @1@98
@1@74:
   ;	
   ;	        total += (int)p;
   ;	
	add	si,word ptr DGROUP:_p
@1@98:
   ;	
   ;	    return total + (int)(char near *)p;
   ;	
	mov	ax,si
	add	ax,word ptr DGROUP:_p
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	pop	bp
	ret	
_f	endp
T_TEXT	ends
_BSS	segment word public 'BSS'
_p	label	word
	db	2 dup (?)
_q	label	dword
	db	4 dup (?)
_r	label	word
	db	2 dup (?)
_table	label	word
	db	8 dup (?)
_base_seg	label	word
	db	2 dup (?)
	?debug	C E9
_BSS	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
T_TEXT	segment byte public 'CODE'
T_TEXT	ends
	public	_base_seg
	public	_table
	public	_r
	public	_q
	public	_p
	public	_f
	end
