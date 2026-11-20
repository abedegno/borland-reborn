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
   ;	int interrupt int_result(void) { return 5; }
   ;	
	assume	cs:T_TEXT
_int_result	proc	far
	push	ax
	push	bx
	push	cx
	push	dx
	push	es
	push	ds
	push	si
	push	di
	push	bp
	mov	bp,DGROUP
	mov	ds,bp
	mov	bp,sp
	mov	ax,5
	jmp	short @1@50
@1@50:
	pop	bp
	pop	di
	pop	si
	pop	ds
	pop	es
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	iret	
_int_result	endp
   ;	
   ;	long interrupt long_result(void) { return 70000L; }
   ;	
	assume	cs:T_TEXT
_long_result	proc	far
	push	ax
	push	bx
	push	cx
	push	dx
	push	es
	push	ds
	push	si
	push	di
	push	bp
	mov	bp,DGROUP
	mov	ds,bp
	mov	bp,sp
	mov	dx,1
	mov	ax,4464
	jmp	short @2@50
@2@50:
	pop	bp
	pop	di
	pop	si
	pop	ds
	pop	es
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	iret	
_long_result	endp
   ;	
   ;	char far * interrupt pointer_result(void) { return (char far *)0x12345678L; }
   ;	
	assume	cs:T_TEXT
_pointer_result	proc	far
	push	ax
	push	bx
	push	cx
	push	dx
	push	es
	push	ds
	push	si
	push	di
	push	bp
	mov	bp,DGROUP
	mov	ds,bp
	mov	bp,sp
	mov	dx,4660
	mov	ax,22136
	jmp	short @3@50
@3@50:
	pop	bp
	pop	di
	pop	si
	pop	ds
	pop	es
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	iret	
_pointer_result	endp
   ;	
   ;	void interrupt plain(void) { }
   ;	
	assume	cs:T_TEXT
_plain	proc	far
	push	ax
	push	bx
	push	cx
	push	dx
	push	es
	push	ds
	push	si
	push	di
	push	bp
	mov	bp,DGROUP
	mov	ds,bp
	mov	bp,sp
	pop	bp
	pop	di
	pop	si
	pop	ds
	pop	es
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	iret	
_plain	endp
   ;	
   ;	int _saveregs saved_int(int a) { return a + 1; }
   ;	
	assume	cs:T_TEXT
_saved_int	proc	far
	push	ax
	push	cx
	push	dx
	push	bx
	push	sp
	push	bp
	push	si
	push	di
	push	ds
	push	es
	mov	bp,sp
	mov	ax,word ptr [bp+24]
	inc	ax
	jmp	short @5@50
@5@50:
	mov	word ptr [bp+18],ax
	pop	es
	pop	ds
	pop	di
	pop	si
	pop	bp
	pop	bx
	pop	bx
	pop	dx
	pop	cx
	pop	ax
	ret	
_saved_int	endp
   ;	
   ;	long _saveregs saved_long(long a) { return a * 2; }
   ;	
	assume	cs:T_TEXT
_saved_long	proc	far
	push	ax
	push	cx
	push	dx
	push	bx
	push	sp
	push	bp
	push	si
	push	di
	push	ds
	push	es
	mov	bp,sp
	mov	dx,word ptr [bp+26]
	mov	ax,word ptr [bp+24]
	shl	ax,1
	rcl	dx,1
	jmp	short @6@50
@6@50:
	mov	word ptr [bp+18],ax
	mov	word ptr [bp+16],dx
	pop	es
	pop	ds
	pop	di
	pop	si
	pop	bp
	pop	bx
	pop	bx
	pop	dx
	pop	cx
	pop	ax
	ret	
_saved_long	endp
   ;	
   ;	void _saveregs saved_void(void) { }
   ;	
	assume	cs:T_TEXT
_saved_void	proc	far
	push	ax
	push	cx
	push	dx
	push	bx
	push	sp
	push	bp
	push	si
	push	di
	push	ds
	push	es
	mov	bp,sp
	pop	es
	pop	ds
	pop	di
	pop	si
	pop	bp
	pop	bx
	pop	bx
	pop	dx
	pop	cx
	pop	ax
	ret	
_saved_void	endp
	?debug	C E9
T_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
T_TEXT	segment byte public 'CODE'
T_TEXT	ends
	public	_saved_long
	public	_saved_void
	public	_saved_int
	public	_pointer_result
	public	_long_result
	public	_plain
	public	_int_result
	end
