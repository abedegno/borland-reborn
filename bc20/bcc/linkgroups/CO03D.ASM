; Recovered FBOV far-pointer references
CO003_TEXT	segment byte public 'CODE'
CO003_TEXT	ends
CO02C_TEXT	segment byte public 'CODE'
CO02C_TEXT	ends
		public	X03D_02
		public	X03D_03
		public	X03D_00
		public	X03D_01
		public	X03D_06
		public	X03D_04
		public	X03D_05
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1cc9_8732
; BEGIN TASSERT (listing ovr_1cc9_8732:7320)
	extrn	X02D_01:far
	extrn	X019_05:far
		extrn	BCC_RD_C23E_W:word
		extrn	BCC_RD_5EC2_W:word


CO03D_TEXT	segment byte public 'CODE'
	assume	cs:CO03D_TEXT,ds:DGROUP

		public	X03D_02
X03D_02	label	far
BCC_TREE_ASSERT	proc	far
	push	bp
	mov	bp,sp
	cmp	word ptr DGROUP:BCC_RD_C23E_W,8
	jne	short M000_@@COMPARE
	db	9Ah
	dw	X02D_01
	dw	seg X02D_01
	jmp	short M000_@@RETURN
M000_@@COMPARE:
	mov	ax,word ptr DGROUP:BCC_RD_5EC2_W
	cmp	ax,word ptr [bp+6]
	je	short M000_@@RETURN
	mov	ax,0CAh
	push	ax
	db	9Ah
	dw	X019_05
	dw	seg X019_05
M000_@@RETURN:
	pop	bp
	retf	2
BCC_TREE_ASSERT	endp
CO03D_TEXT	ends

; END TASSERT
; BEGIN TINT (listing ovr_1cc9_8732:7346)

	extrn	BCC_RD_07B3_W:word
	extrn	BCC_RD_62A0_B:byte


CO03D_TEXT	segment byte public 'CODE'
	assume	cs:CO03D_TEXT,ds:DGROUP

		public	X03D_03
X03D_03	label	far
BCC_TREE_INTEGER	proc	far
	push	bp
	mov	bp,sp
	les	bx,dword ptr [bp+6]
	cmp	word ptr es:[bx],31h
	jne	short M001_@@FLAGS
	push	word ptr es:[bx+9]
	nop
	push	cs
	db	0E8h,040h,000h
	or	ax,ax
	je	short M001_@@RETURN_ZERO_JUMP
M001_@@RETURN_ONE:
	mov	ax,1
	jmp	short M001_@@RETURN
M001_@@RETURN_ZERO_JUMP:
	jmp	short M001_@@RETURN_ZERO
M001_@@RETURN_ONE_JUMP:
	jmp	short M001_@@RETURN
M001_@@FLAGS:
	les	bx,dword ptr [bp+6]
	mov	bx,word ptr es:[bx]
	shl	bx,1
	test	word ptr DGROUP:BCC_RD_07B3_W[bx],8
	jne	short M001_@@RETURN_ONE_LATE
	mov	al,byte ptr DGROUP:BCC_RD_62A0_B
	mov	ah,0
	push	ax
	mov	bx,word ptr [bp+6]
	cmp	word ptr es:[bx],2Bh
	jne	short M001_@@NOT_2B
	mov	ax,1
	jmp	short M001_@@TEST_FLAG
M001_@@NOT_2B:
	xor	ax,ax
M001_@@TEST_FLAG:
	pop	dx
	db	85h,0D0h
	je	short M001_@@RETURN_ZERO
M001_@@RETURN_ONE_LATE:
	jmp	short M001_@@RETURN_ONE
M001_@@RETURN_ZERO:
	xor	ax,ax
M001_@@RETURN:
	pop	bp
	retf	4
BCC_TREE_INTEGER	endp
CO03D_TEXT	ends

; END TINT
; BEGIN TLOOK (listing ovr_1cc9_8732:739B)

	extrn	X02C_1D:far
	extrn	X06C_05:far
	extrn	BCC_RD_63DC_W:word
	extrn	BCC_TYPE_DEFAULT:word
	extrn	BCC_TYPE_SEGMENT:word
	extrn	BCC_RD_A03E_B:byte
	extrn	BCC_RD_5EC6_W:word
		extrn	BCC_RD_383E_W:word
		extrn	BCC_RD_6438_W:word


CO03D_TEXT	segment byte public 'CODE'
	assume	cs:CO03D_TEXT,ds:DGROUP

		public	X03D_00
X03D_00	label	far
BCC_TYPE_LOOKUP	proc	far
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	di,word ptr [bp+6]
	push	di
	db	9Ah
	dw	X02C_1D
	dw	seg X02C_1D
	mov	si,ax
	or	si,si
	jne	short M002_@@HAVE_TYPE
	cmp	word ptr DGROUP:BCC_RD_383E_W,0
	je	short M002_@@HAVE_TYPE
	push	di
	push	word ptr DGROUP:BCC_RD_6438_W
	db	9Ah
	dw	X06C_05
	dw	seg X06C_05
	or	ax,ax
	je	short M002_@@HAVE_TYPE
	jmp	short M002_@@RETURN_ZERO
M002_@@HAVE_TYPE:
	or	si,si
	jne	short M002_@@FOUND
	push	di
	push	word ptr DGROUP:BCC_RD_63DC_W
	db	9Ah
	dw	07Fh
	dw	seg CO02C_TEXT
	mov	si,ax
M002_@@FOUND:
	or	si,si
	je	short M002_@@FALLBACK_CHECK
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,8
	je	short M002_@@LOAD_VALUE
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M002_@@FALLBACK_CHECK
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,0Bh
	jne	short M002_@@FALLBACK_CHECK
M002_@@LOAD_VALUE:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+4]
	jmp	short M002_@@RETURN
M002_@@FALLBACK_CHECK:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M002_@@RETURN_ZERO
	or	si,si
	jne	short M002_@@RETURN_ZERO
	push	di
	push	word ptr DGROUP:BCC_RD_5EC6_W
	db	9Ah
	dw	07Fh
	dw	seg CO02C_TEXT
	mov	si,ax
	or	si,si
	je	short M002_@@RETURN_ZERO
	jmp	short M002_@@LOAD_VALUE
M002_@@RETURN_ZERO:
	xor	ax,ax
M002_@@RETURN:
	pop	di
	pop	si
	pop	bp
	retf	2
BCC_TYPE_LOOKUP	endp
CO03D_TEXT	ends

; END TLOOK
; BEGIN TCHECK (listing ovr_1cc9_8732:7436)

	extrn	BCC_RD_5EC2_W:word
	extrn	X02D_01:far
	extrn	X019_05:far


CO03D_TEXT	segment byte public 'CODE'
	assume	cs:CO03D_TEXT,ds:DGROUP

		public	X03D_05
X03D_05	label	far
BCC_TREE_CHECK	proc	far
	push	bp
	mov	bp,sp
	mov	ax,word ptr DGROUP:BCC_RD_5EC2_W
	cmp	ax,word ptr [bp+8]
	jne	short M003_@@ERROR
	db	9Ah
	dw	X02D_01
	dw	seg X02D_01
	jmp	short M003_@@RETURN
M003_@@ERROR:
	push	word ptr [bp+6]
	db	9Ah
	dw	X019_05
	dw	seg X019_05
M003_@@RETURN:
	pop	bp
	retf	4
BCC_TREE_CHECK	endp
CO03D_TEXT	ends

; END TCHECK
; BEGIN TCALL (listing ovr_1cc9_8732:7454)

	extrn	BCC_RD_5EC2_W:word
	extrn	X02D_01:far
	extrn	X019_06:far
	extrn	BCC_TREE_CALLED:byte


CO03D_TEXT	segment byte public 'CODE'
	assume	cs:CO03D_TEXT,ds:DGROUP

		public	X03D_06
X03D_06	label	far
BCC_TREE_INVOKE	proc	far
	push	bp
	mov	bp,sp
	mov	ax,word ptr DGROUP:BCC_RD_5EC2_W
	cmp	ax,word ptr [bp+12]
	jne	short M004_@@INVOKE
	db	9Ah
	dw	X02D_01
	dw	seg X02D_01
	jmp	short M004_@@RETURN
M004_@@INVOKE:
	push	word ptr [bp+10]
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	xor	ax,ax
	xor	dx,dx
	push	ax
	push	dx
	db	9Ah
	dw	X019_06
	dw	seg X019_06
	mov	byte ptr DGROUP:BCC_TREE_CALLED,1
M004_@@RETURN:
	pop	bp
	retf	8
BCC_TREE_INVOKE	endp
CO03D_TEXT	ends

; END TCALL
; BEGIN EARGS (listing ovr_1cc9_8732:7483)

	extrn	X05A_01:far
	extrn	BCC_EMIT_END:far
	extrn	X05A_02:far
	extrn	BCC_PARSE_ENABLED:byte
	extrn	BCC_RD_823E_W:word
	extrn	X02D_01:far
	extrn	X02D_02:far
	extrn	BCC_DEBUG_ENABLED:byte
	extrn	X05A_00:far


CO03D_TEXT	segment byte public 'CODE'
	assume	cs:CO03D_TEXT,ds:DGROUP

		public	X03D_04
X03D_04	label	far
BCC_EMIT_ARGS	proc	far
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	push	si
	push	di
	xor	si,si
	db	9Ah
	dw	X05A_01
	dw	seg X05A_01
	les	bx,dword ptr [bp+10]
	mov	word ptr es:[bx],ax
	jmp	short M005_@@TEST
M005_@@ARGUMENT:
	xor	di,di
	jmp	short M005_@@NEXT
M005_@@COUNT:
	inc	si
	cmp	byte ptr DGROUP:BCC_PARSE_ENABLED,0
	je	short M005_@@NEXT
	mov	al,byte ptr [bp-2]
	push	ax
	db	9Ah
	dw	X05A_02
	dw	seg X05A_02
M005_@@NEXT:
	mov	ax,di
	inc	di
	push	ax
	db	9Ah
	dw	X02D_02
	dw	seg X02D_02
	mov	word ptr [bp-2],ax
	cmp	ax,0FFFFh
	jne	short M005_@@COUNT
	db	9Ah
	dw	X02D_01
	dw	seg X02D_01
M005_@@TEST:
	cmp	word ptr DGROUP:BCC_RD_823E_W,34h
	je	short M005_@@ARGUMENT
	mov	ax,si
	inc	ax
	les	bx,dword ptr [bp+6]
	mov	word ptr es:[bx],ax
	cmp	byte ptr DGROUP:BCC_PARSE_ENABLED,0
	je	short M005_@@CHECK_DEBUG
	mov	al,0
	push	ax
	db	9Ah
	dw	X05A_02
	dw	seg X05A_02
M005_@@CHECK_DEBUG:
	cmp	byte ptr DGROUP:BCC_PARSE_ENABLED,0
	je	short M005_@@RETURN
	cmp	byte ptr DGROUP:BCC_DEBUG_ENABLED,0
	je	short M005_@@RETURN
	les	bx,dword ptr [bp+10]
	push	word ptr es:[bx]
	db	9Ah
	dw	X05A_00
	dw	seg X05A_00
	les	bx,dword ptr [bp+10]
	mov	word ptr es:[bx],ax
M005_@@RETURN:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf	8
BCC_EMIT_ARGS	endp
CO03D_TEXT	ends

; END EARGS
; BEGIN TVALUE (listing ovr_1cc9_8732:750A)

	extrn	X022_01:far
	extrn	BCC_TYPE_CONTEXT2:word
	extrn	X03E_05:far
	extrn	X02A_0D:far
	extrn	BCC_TYPE_SEGMENT2:word
	extrn	X023_0B:far
	extrn	X019_05:far
	extrn	X023_07:far


CO03D_TEXT	segment byte public 'CODE'
	assume	cs:CO03D_TEXT,ds:DGROUP

		public	X03D_01
X03D_01	label	far
BCC_TYPE_VALUE	proc	far
	push	bp
	mov	bp,sp
	push	si
	push	word ptr [bp+10]
	db	9Ah
	dw	X022_01
	dw	seg X022_01
	mov	si,ax
	push	si
	push	word ptr DGROUP:BCC_TYPE_CONTEXT2
	db	9Ah
	dw	020h
	dw	seg CO003_TEXT
	push	ax
	mov	al,0
	push	ax
	db	9Ah
	dw	X02A_0D
	dw	seg X02A_0D
	mov	si,ax
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT2
	cmp	word ptr es:[si],0
	jne	short M006_@@CHECK
	les	bx,dword ptr [bp+6]
	mov	word ptr es:[bx+2],0
	mov	word ptr es:[bx],1
	jmp	short M006_@@RELEASE
M006_@@CHECK:
	push	si
	db	9Ah
	dw	X023_0B
	dw	seg X023_0B
	or	al,al
	je	short M006_@@ERROR
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT2
	mov	ax,word ptr es:[si+12]
	mov	dx,word ptr es:[si+10]
	les	bx,dword ptr [bp+6]
	mov	word ptr es:[bx+2],ax
	mov	word ptr es:[bx],dx
	jmp	short M006_@@RELEASE
M006_@@ERROR:
	mov	ax,0F1h
	push	ax
	db	9Ah
	dw	X019_05
	dw	seg X019_05
M006_@@RELEASE:
	push	si
	db	9Ah
	dw	X023_07
	dw	seg X023_07
	pop	si
	pop	bp
	retf	6
BCC_TYPE_VALUE	endp
CO03D_TEXT	ends

; END TVALUE
		end
