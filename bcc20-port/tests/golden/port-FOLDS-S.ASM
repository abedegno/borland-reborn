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
   ;	void f(int x, long y, double d)
   ;	
	assume	cs:T_TEXT
_f	proc	far
	push	bp
	mov	bp,sp
	push	si
	mov	si,word ptr [bp+6]
   ;	
   ;	{
   ;	    r[0] = -7 / 2 + x;
   ;	
	mov	ax,si
	add	ax,65533
	mov	word ptr DGROUP:_r,ax
   ;	
   ;	    r[1] = -7 % 3 + x;
   ;	
	mov	ax,si
	dec	ax
	mov	word ptr DGROUP:_r+2,ax
   ;	
   ;	    r[2] = 7u % 3u + x;
   ;	
	mov	ax,si
	inc	ax
	mov	word ptr DGROUP:_r+4,ax
   ;	
   ;	    r[3] = 5 - 9 + x;
   ;	
	mov	ax,si
	add	ax,65532
	mov	word ptr DGROUP:_r+6,ax
   ;	
   ;	    r[4] = 5u - 9u + x;
   ;	
	mov	ax,si
	add	ax,65532
	mov	word ptr DGROUP:_r+8,ax
   ;	
   ;	    r[5] = -(3 + 4) + x;
   ;	
	mov	ax,si
	add	ax,65529
	mov	word ptr DGROUP:_r+10,ax
   ;	
   ;	    r[6] = ~(1 << 3) + x;
   ;	
	mov	ax,si
	add	ax,65527
	mov	word ptr DGROUP:_r+12,ax
   ;	
   ;	    r[7] = (x * 0) + (x - x);
   ;	
	mov	ax,si
	sub	ax,si
	xor	dx,dx
	add	dx,ax
	mov	word ptr DGROUP:_r+14,dx
   ;	
   ;	    l[0] = (0x12345678L ^ 0x0F0F0F0FL) + y;
   ;	
	mov	ax,word ptr [bp+10]
	mov	dx,word ptr [bp+8]
	add	dx,22903
	adc	ax,7483
	mov	word ptr DGROUP:_l+2,ax
	mov	word ptr DGROUP:_l,dx
   ;	
   ;	    l[1] = -100000L / 7L + y;
   ;	
	mov	ax,word ptr [bp+10]
	mov	dx,word ptr [bp+8]
	add	dx,51251
	adc	ax,65535
	mov	word ptr DGROUP:_l+6,ax
	mov	word ptr DGROUP:_l+4,dx
   ;	
   ;	    l[2] = -100000L % 7L + y;
   ;	
	mov	ax,word ptr [bp+10]
	mov	dx,word ptr [bp+8]
	add	dx,65531
	adc	ax,65535
	mov	word ptr DGROUP:_l+10,ax
	mov	word ptr DGROUP:_l+8,dx
   ;	
   ;	    l[3] = (3L - 9L) * y;
   ;	
	mov	cx,word ptr [bp+10]
	mov	bx,word ptr [bp+8]
	mov	dx,65535
	mov	ax,65530
	call	far ptr F_LXMUL@
	mov	word ptr DGROUP:_l+14,dx
	mov	word ptr DGROUP:_l+12,ax
   ;	
   ;	    d = d + (1.5 * 2.0);
   ;	
	fld	qword ptr [bp+12]
	fadd	dword ptr DGROUP:s@
	fstp	qword ptr [bp+12]
   ;	
   ;	    r[8] = (int)(2.5 / 0.5) % 2;
   ;	
	fwait	
	mov	word ptr DGROUP:_r+16,1
   ;	
   ;	}
   ;	
	pop	si
	pop	bp
	ret	
_f	endp
T_TEXT	ends
_BSS	segment word public 'BSS'
_l	label	word
	db	16 dup (?)
_r	label	word
	db	24 dup (?)
	?debug	C E9
_BSS	ends
_DATA	segment word public 'DATA'
s@	label	byte
	db	0
	db	0
	db	'@@'
_DATA	ends
T_TEXT	segment byte public 'CODE'
T_TEXT	ends
	extrn	F_LXMUL@:far
	public	_r
	public	_l
	public	_f
	end
