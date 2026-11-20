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
   ;	void f(void)
   ;	
	assume	cs:T_TEXT
_f	proc	far
	push	bp
	mov	bp,sp
	push	si
   ;	
   ;	{
   ;	    asm mov ax, es:[bx]
   ;	
 	mov	 ax, es:[bx]
   ;	
   ;	    asm mov cs:[si], ax
   ;	
 	mov	 cs:[si], ax
   ;	
   ;	    asm fld qword ptr ss:[bp-8]
   ;	
 	fld	 qword ptr ss:[bp-8]
   ;	
   ;	    asm fstp dword ptr ds:v
   ;	
 	fstp	 dword ptr ds:DGROUP:_v
   ;	
   ;	    asm fwait
   ;	
 	fwait	
   ;	
   ;	    asm db 90h, 0CCh
   ;	
 	db	 90h, 0CCh
   ;	
   ;	    asm dw 1234h
   ;	
 	dw	 1234h
   ;	
   ;	    asm jmp short done
   ;	
	jmp	short @1@218
@1@218:
   ;	
   ;	done:
   ;	    asm nop
   ;	
 	nop	
   ;	
   ;	}
   ;	
	pop	si
	pop	bp
	ret	
_f	endp
T_TEXT	ends
_BSS	segment word public 'BSS'
_v	label	word
	db	2 dup (?)
	?debug	C E9
_BSS	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
T_TEXT	segment byte public 'CODE'
T_TEXT	ends
	public	_v
	public	_f
	end
