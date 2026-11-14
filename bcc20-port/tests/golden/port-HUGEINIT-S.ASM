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
	assume	cs:T_TEXT,ds:T_DATA
T_DATA	segment word public 'FAR_DATA'
d@	label	byte
d@w	label	word
b@	label	byte
b@w	label	word
T_DATA	ends
T5_FAR	segment para public 'FAR_DATA'
_big	label	byte
	db	1
	db	2
	db	3
	db	65533 dup (0)
T5_FAR	ends
T6_FAR	segment para public 'FAR_DATA'
	db	4464 dup (?)
T6_FAR	ends
T7_FAR	segment para public 'FAR_DATA'
_longs	label	word
	db	5
	db	0
	db	0
	db	0
	db	65532 dup (0)
T7_FAR	ends
T8_FAR	segment para public 'FAR_DATA'
	db	14464 dup (?)
T8_FAR	ends
T_DATA	segment word public 'FAR_DATA'
_folds	label	word
	db	254
	db	255
	db	253
	db	255
	db	255
	db	255
	db	1
	db	0
	db	252
	db	255
	db	3
	db	0
_lfolds	label	word
	db	119
	db	89
	db	59
	db	29
	db	51
	db	200
	db	255
	db	255
	db	251
	db	255
	db	255
	db	255
	db	250
	db	255
	db	255
	db	255
	?debug	C E9
s@	label	byte
T_DATA	ends
T_TEXT	segment byte public 'CODE'
T_TEXT	ends
	public	_lfolds
	public	_big
	public	_longs
	public	_folds
	end
