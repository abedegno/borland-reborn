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
   ;	int f(int a) { return a * 3; }
   ;	
	assume	cs:T_TEXT
_f	proc	far
	push	bp
	mov	bp,sp
	mov	ax,word ptr [bp+6]
	mov	dx,3
	imul	dx
	pop	bp
	ret	
_f	endp
	?debug	C E9
T_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
T_TEXT	segment byte public 'CODE'
T_TEXT	ends
	public	_f
	end
