		public	X03C_01
		public	X03C_00
		public	X03C_03
		public	X03C_02
		public	X03C_04
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1cc5_8697
; BEGIN C129UNIT (listing ovr_1cc5_8697:6970)

		extrn	BCC_FAR_5BED:far
		extrn	X019_00:far


CO03C_TEXT	segment byte public 'CODE'
		assume	cs:CO03C_TEXT,ds:DGROUP

M000_BCC_DATA_62A0	equ	62A0h

BCC_RN_8000_6970	label	near
BCC_NEAR_6970	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		cmp	byte ptr DGROUP:M000_BCC_DATA_62A0,0
		je	short M000_L_6987
		push	SI
		db	09Ah
		dw	X019_00
		dw	seg X019_00
		jmp	short M000_L_698E
M000_L_6987:
		push	SI
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		pop	CX
M000_L_698E:
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_6970	endp
CO03C_TEXT	ends

; Target-qualified reference aliases (zero bytes)

	extrn	BCC_RD_62A0_B:byte
	extrn	X019_00:far
	extrn	BCC_OUTPUT_ERROR:far


CO03C_TEXT	segment byte public 'CODE'
	assume	cs:CO03C_TEXT,ds:DGROUP
BCC_NEAR_6994	label	near

BCC_NODE_ERROR	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	mov	si,word ptr [bp+4]
	cmp	byte ptr DGROUP:BCC_RD_62A0_B,0
	je	short M001_@@ERROR
	push	si
	db	9Ah
	dw	X019_00
	dw	seg X019_00
	jmp	short M001_@@DONE
M001_@@ERROR:
	push	si
	db	9Ah
	dw	BCC_OUTPUT_ERROR
	dw	seg BCC_OUTPUT_ERROR
	pop	cx
M001_@@DONE:
	pop	si
	pop	bp
	dec	bp
	ret	2
BCC_NODE_ERROR	endp
CO03C_TEXT	ends


	extrn	BCC_RF_1AAA_0008:far


CO03C_TEXT	segment byte public 'CODE'
	assume	cs:CO03C_TEXT,ds:DGROUP

		public	X03C_01
X03C_01	label	far
BCC_NAME_COMPARE	proc	far
	push	bp
	mov	bp,sp
	push	word ptr [bp+12]
	push	word ptr [bp+10]
	push	ds
	les	bx,dword ptr [bp+6]
	push	word ptr es:[bx]
	db	9Ah
	dw	BCC_RF_1AAA_0008
	dw	seg BCC_RF_1AAA_0008
	pop	bp
	retf	8
BCC_NAME_COMPARE	endp
CO03C_TEXT	ends


	extrn	BCC_RD_8254_W:word
	extrn	BCC_RD_679E_B:byte
	extrn	BCC_RD_828C_W:word
	extrn	BCC_RD_827C_W:word
	extrn	X032_05:far
	extrn	X030_09:far
	extrn	X030_06:far
	extrn	X030_0A:far
	extrn	X031_0D:far
	extrn	X031_07:far
	extrn	BCC_RF_1A72_0007:far
	extrn	BCC_RD_16FB_B:byte
	extrn	BCC_PRAGMA_STRING:byte
	extrn	BCC_PRAGMA_TABLE:word
	extrn	BCC_PRAGMA_RESULT:byte
	extrn	_CTYPE:byte
		extrn	BCC_RD_8292_W:word
		extrn	BCC_RD_8292_W:word
		extrn	BCC_RD_8292_W:word


CO03C_TEXT	segment byte public 'CODE'
	assume	cs:CO03C_TEXT,ds:DGROUP

		public	X03C_00
X03C_00	label	far
BCC_LEX_SWITCH	proc	far
	push	bp
	mov	bp,sp
	sub	sp,8
	push	si
	push	di
M003_@@RESTART:
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M003_@@READ_INITIAL
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M003_@@INITIAL_READY
M003_@@READ_INITIAL:
	mov	bx,word ptr DGROUP:BCC_RD_827C_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_8292_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M003_@@INITIAL_READY:
	mov	ah,0
	mov	word ptr [bp-4],ax
M003_@@DISPATCH:
	mov	al,byte ptr [bp-4]
	push	ax
	db	9Ah
	dw	X030_09
	dw	seg X030_09
	xor	di,di
	mov	ax,word ptr [bp-4]
	mov	word ptr [bp-2],ax
	mov	cx,78
	mov	bx,299h
M003_@@SEARCH:
	mov	ax,word ptr cs:[bx]
	cmp	ax,word ptr [bp-2]
	je	short M003_@@FOUND
	inc	bx
	inc	bx
	loop	M003_@@SEARCH
	jmp	M003_@@DEFAULT
M003_@@FOUND:
	db	02Eh,0FFh,0A7h,09Ch,000h
M003_@@CASE_SPECIAL:
	mov	al,byte ptr [bp-4]
	push	ax
	nop
	push	cs
	db	0E8h,0F3h,007h
	jmp	short M003_@@RESTART
M003_@@RETURN_5:
	mov	ax,5
	jmp	M003_@@RETURN
M003_@@RETURN_6:
	mov	ax,6
	jmp	M003_@@RETURN
M003_@@CASE_COMMENT:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M003_@@READ_COMMENT
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M003_@@COMMENT_READY
M003_@@READ_COMMENT:
	mov	bx,word ptr DGROUP:BCC_RD_827C_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_8292_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M003_@@COMMENT_READY:
	mov	ah,0
	mov	si,ax
	cmp	si,42
	jne	short M003_@@CHECK_SLASH
	db	9Ah
	dw	X030_06
	dw	seg X030_06
	jmp	short M003_@@COMMENT_RESTART
M003_@@CHECK_SLASH:
	cmp	si,47
	jne	short M003_@@COMMENT_DEFAULT
	db	9Ah
	dw	X030_0A
	dw	seg X030_0A
M003_@@COMMENT_RESTART:
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	jmp	M003_@@RESTART
M003_@@COMMENT_DEFAULT:
	dec	word ptr DGROUP:BCC_RD_8292_W
	jmp	M003_@@DEFAULT
M003_@@CASE_IDENTIFIER:
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	push	word ptr [bp-4]
	db	9Ah
	dw	X031_0D
	dw	seg X031_0D
	mov	al,byte ptr DGROUP:BCC_RD_16FB_B
	cbw
	mov	bx,ax
	mov	byte ptr DGROUP:BCC_RD_679E_B[bx],0
	db	9Ah
	dw	X031_07
	dw	seg X031_07
	mov	word ptr [bp-4],ax
	cmp	ax,0FFFEh
	je	short M003_@@IDENTIFIER_LOOKUP
	cmp	word ptr [bp-4],-1
	je	short M003_@@IDENTIFIER_LOOKUP
	jmp	M003_@@DISPATCH
M003_@@IDENTIFIER_LOOKUP:
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_PRAGMA_STRING
	push	ax
	mov	ax,0F5h
	push	ax
	mov	ax,4
	push	ax
	push	word ptr DGROUP:BCC_PRAGMA_TABLE+2
	push	word ptr DGROUP:BCC_PRAGMA_TABLE
	db	9Ah
	dw	BCC_RF_1A72_0007
	dw	seg BCC_RF_1A72_0007
	mov	word ptr [bp-6],dx
	mov	word ptr [bp-8],ax
	or	ax,word ptr [bp-6]
	je	short M003_@@IDENTIFIER_MISSING
	les	bx,dword ptr [bp-8]
	mov	al,byte ptr es:[bx+3]
	mov	byte ptr DGROUP:BCC_PRAGMA_RESULT,al
	mov	al,byte ptr es:[bx+2]
	mov	ah,0
	jmp	M003_@@RETURN
M003_@@IDENTIFIER_MISSING:
	mov	ax,49
	jmp	M003_@@RETURN
M003_@@CASE_NUMBER:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M003_@@READ_RADIX
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M003_@@RADIX_READY
M003_@@READ_RADIX:
	mov	bx,word ptr DGROUP:BCC_RD_827C_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_8292_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M003_@@RADIX_READY:
	mov	ah,0
	mov	word ptr [bp-4],ax
	cmp	word ptr [bp-4],78h
	je	short M003_@@HEX
	cmp	word ptr [bp-4],58h
	jne	short M003_@@NOT_HEX
M003_@@HEX:
	mov	di,1
	jmp	short M003_@@NUMBER_NEXT
M003_@@NOT_HEX:
	dec	word ptr DGROUP:BCC_RD_8292_W
M003_@@NUMBER_NEXT:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M003_@@READ_NUMBER
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M003_@@NUMBER_READY
M003_@@READ_NUMBER:
	mov	bx,word ptr DGROUP:BCC_RD_827C_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_8292_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M003_@@NUMBER_READY:
	mov	ah,0
	mov	word ptr [bp-4],ax
	mov	bx,word ptr [bp-4]
	mov	al,byte ptr DGROUP:_CTYPE[bx+1]
	cbw
	test	ax,12h
	je	short M003_@@NUMBER_SUFFIX
	mov	al,byte ptr [bp-4]
	push	ax
	db	9Ah
	dw	X030_09
	dw	seg X030_09
	jmp	short M003_@@NUMBER_NEXT
M003_@@NUMBER_SUFFIX:
	cmp	word ptr [bp-4],2Eh
	je	short M003_@@APPEND_SUFFIX
	cmp	word ptr [bp-4],68h
	je	short M003_@@APPEND_SUFFIX
	cmp	word ptr [bp-4],48h
	jne	short M003_@@NUMBER_END
M003_@@APPEND_SUFFIX:
	mov	al,byte ptr [bp-4]
	push	ax
	db	9Ah
	dw	X030_09
	dw	seg X030_09
	jmp	short M003_@@NUMBER_FINISH
M003_@@NUMBER_END:
	dec	word ptr DGROUP:BCC_RD_8292_W
M003_@@NUMBER_FINISH:
	or	di,di
	je	short M003_@@RETURN_NUMBER
	mov	al,48h
	push	ax
	db	9Ah
	dw	X030_09
	dw	seg X030_09
	jmp	short M003_@@RETURN_NUMBER_2
M003_@@RETURN_NUMBER:
	jmp	short M003_@@RETURN_NUMBER_2
M003_@@RETURN_7:
	mov	ax,7
	jmp	short M003_@@RETURN
M003_@@RETURN_124:
	dec	word ptr DGROUP:BCC_RD_8292_W
	mov	ax,124
	jmp	short M003_@@RETURN
M003_@@RETURN_1:
	mov	ax,1
	jmp	short M003_@@RETURN
M003_@@RETURN_47:
	mov	ax,47
	jmp	short M003_@@RETURN
M003_@@CASE_QUOTE:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M003_@@READ_QUOTE
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M003_@@QUOTE_READY
M003_@@READ_QUOTE:
	mov	bx,word ptr DGROUP:BCC_RD_827C_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_8292_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M003_@@QUOTE_READY:
	mov	ah,0
	mov	word ptr [bp-4],ax
	mov	al,byte ptr [bp-4]
	push	ax
	db	9Ah
	dw	X030_09
	dw	seg X030_09
	cmp	word ptr [bp-4],27h
	jne	short M003_@@CASE_QUOTE
M003_@@RETURN_NUMBER_2:
	mov	ax,50
	jmp	short M003_@@RETURN
M003_@@DEFAULT:
	mov	ax,123
M003_@@RETURN:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf
BCC_LEX_SWITCH	endp
CO03C_TEXT	ends

CO03C_TEXT	segment byte public 'CODE'
		assume	cs:CO03C_TEXT
; Original-image layout stub: not recovered source


		db	009h,000h,00Ah,000h,00Dh,000h,01Ah,000h,020h,000h,024h,000h,027h,000h	; ovr_1cc5_8697:6C09
		db	028h,000h,02Eh,000h,02Fh,000h,030h,000h,031h,000h,032h,000h,033h,000h	; ovr_1cc5_8697:6C17
		db	034h,000h,035h,000h,036h,000h,037h,000h,038h,000h,039h,000h,03Bh,000h	; ovr_1cc5_8697:6C25
		db	040h,000h,041h,000h,042h,000h,043h,000h,044h,000h,045h,000h,046h,000h	; ovr_1cc5_8697:6C33
		db	047h,000h,048h,000h,049h,000h,04Ah,000h,04Bh,000h,04Ch,000h,04Dh,000h	; ovr_1cc5_8697:6C41
		db	04Eh,000h,04Fh,000h,050h,000h,051h,000h,052h,000h,053h,000h,054h,000h	; ovr_1cc5_8697:6C4F
		db	055h,000h,056h,000h,057h,000h,058h,000h,059h,000h,05Ah,000h,05Fh,000h	; ovr_1cc5_8697:6C5D
		db	061h,000h,062h,000h,063h,000h,064h,000h,065h,000h,066h,000h,067h,000h	; ovr_1cc5_8697:6C6B
		db	068h,000h,069h,000h,06Ah,000h,06Bh,000h,06Ch,000h,06Dh,000h,06Eh,000h	; ovr_1cc5_8697:6C79
		db	06Fh,000h,070h,000h,071h,000h,072h,000h,073h,000h,074h,000h,075h,000h	; ovr_1cc5_8697:6C87
		db	076h,000h,077h,000h,078h,000h,079h,000h,07Ah,000h,07Bh,000h,07Dh,000h	; ovr_1cc5_8697:6C95
		db	0FBh,000h,0C0h,000h,043h,002h,043h,002h,043h,002h,0C0h,000h,022h,001h	; ovr_1cc5_8697:6CA3
		db	056h,002h,04Ch,002h,051h,002h,0D7h,000h,094h,001h,0CFh,001h,0CFh,001h	; ovr_1cc5_8697:6CB1
		db	0CFh,001h,0CFh,001h,0CFh,001h,0CFh,001h,0CFh,001h,0CFh,001h,0CFh,001h	; ovr_1cc5_8697:6CBF
		db	03Eh,002h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h	; ovr_1cc5_8697:6CCD
		db	022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h	; ovr_1cc5_8697:6CDB
		db	022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h	; ovr_1cc5_8697:6CE9
		db	022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h	; ovr_1cc5_8697:6CF7
		db	022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h	; ovr_1cc5_8697:6D05
		db	022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h	; ovr_1cc5_8697:6D13
		db	022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h	; ovr_1cc5_8697:6D21
		db	022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,022h,001h,0CBh,000h	; ovr_1cc5_8697:6D2F
		db	0D1h,000h,069h,000h	; ovr_1cc5_8697:6D3D

CO03C_TEXT	ends

	extrn	BCC_PARSE_TOKEN_KIND:word
	extrn	BCC_PARSE_STATE:word
	extrn	BCC_PARSE_ACTIVE:byte
	extrn	BCC_PARSE_NAME:byte
	extrn	BCC_RD_8254_W:word
	extrn	BCC_RD_679E_B:byte
	extrn	BCC_RD_828C_W:word
	extrn	BCC_RD_827C_W:word
	extrn	X032_05:far
	extrn	BCC_FATAL:far
	extrn	X031_08:far
	extrn	X032_0B:far
	extrn	BCC_SOURCE_LINE:word
	extrn	BCC_SOURCE_COLUMN:word
	extrn	BCC_SOURCE_FILE:word
	extrn	BCC_SOURCE_START:word
BCC_PARSE_ENABLED	equ	63AEh
	extrn	BCC_PARSE_LEFT:word
	extrn	BCC_PARSE_RIGHT:word
	extrn	BCC_PARSE_HANDLE:word
	extrn	BCC_PARSE_BUFFER:word
	extrn	X057_00:far
	extrn	X057_04:far
	extrn	BCC_STRING_LENGTH:far
	extrn	X043_02:far
	extrn	BCC_RD_5EE6_W:word
	extrn	BCC_PARSE_HOOK:dword
	extrn	BCC_PARSE_FILENAME:word
	extrn	BCC_PARSE_COPY:far
	extrn	X05D_00:far
	extrn	BCC_PARSE_DEST:byte
		extrn	BCC_RD_8292_W:word
		extrn	BCC_RD_8292_W:word
		extrn	BCC_RD_6398_W:word
		extrn	BCC_RD_86C8_W:word
		extrn	BCC_RD_8520_D:dword
		extrn	BCC_RD_8520_D:dword


CO03C_TEXT	segment byte public 'CODE'
	assume	cs:CO03C_TEXT,ds:DGROUP

		public	X03C_02
X03C_02	label	far
BCC_PARSE	proc	far
	push	bp
	mov	bp,sp
	sub	sp,10
	push	si
	push	di
	mov	word ptr DGROUP:BCC_PARSE_TOKEN_KIND,82h
	xor	si,si
	mov	word ptr DGROUP:BCC_PARSE_STATE,1
	mov	byte ptr DGROUP:BCC_PARSE_ACTIVE,1
M005_@@OUTER:
	mov	word ptr [bp-4],1
M005_@@RESTART:
	mov	word ptr [bp-6],0
	xor	di,di
	mov	word ptr DGROUP:BCC_RD_8520_D+2,ds
	mov	word ptr DGROUP:BCC_RD_8520_D,offset DGROUP:BCC_PARSE_NAME
	db	0E8h,0D1h,003h
	mov	word ptr [bp-2],ax
	mov	cx,7
	mov	bx,5D3h
M005_@@SEARCH:
	mov	ax,word ptr cs:[bx]
	cmp	ax,word ptr [bp-2]
	je	short M005_@@FOUND
	inc	bx
	inc	bx
	loop	M005_@@SEARCH
	jmp	M005_@@AFTER_TOKEN
M005_@@FOUND:
	db	02Eh,0FFh,067h,00Eh
M005_@@SPECIAL:
	mov	al,9
	push	ax
	nop
	push	cs
	db	0E8h,093h,004h
	mov	word ptr [bp-6],1
	jmp	M005_@@FINISH_TOKEN
M005_@@DECLARATION:
	db	0E8h,0BBh,001h
	mov	word ptr [bp-6],ax
	cmp	word ptr [bp-6],0
	jne	short M005_@@DECL_EXPR
	jmp	M005_@@AFTER_TOKEN
M005_@@DECL_EXPR:
	db	0E8h,097h,002h
	mov	di,ax
	jmp	M005_@@AFTER_TOKEN
M005_@@NAME:
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	mov	di,1
	jmp	M005_@@AFTER_TOKEN
M005_@@PRAGMA:
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	or	si,si
	jne	short M005_@@PRAGMA_AGAIN
	mov	si,1
	jmp	short M005_@@RESTART
M005_@@PRAGMA_AGAIN:
	mov	ax,47h
	push	ax
	db	0E8h,0BAh,0FBh
	jmp	short M005_@@RESTART
M005_@@LINE_DIRECTIVE:
	cmp	si,1
	jne	M005_@@BAD_DIRECTIVE
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M005_@@READ_LINE
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M005_@@LINE_READY
M005_@@READ_LINE:
	mov	bx,word ptr DGROUP:BCC_RD_827C_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_8292_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M005_@@LINE_READY:
	mov	ah,0
	mov	word ptr [bp-8],ax
	cmp	word ptr [bp-8],1Ah
	jne	short M005_@@APPEND_LINE
	mov	ax,1Dh
	push	ax
	db	9Ah
	dw	BCC_FATAL
	dw	seg BCC_FATAL
	pop	cx
	xor	si,si
	jmp	short M005_@@AFTER_TOKEN
M005_@@APPEND_LINE:
	mov	al,byte ptr [bp-8]
	push	ax
	db	9Ah
	dw	X031_08
	dw	seg X031_08
	mov	ax,word ptr DGROUP:BCC_SOURCE_LINE
	mov	word ptr DGROUP:BCC_PARSE_LEFT,ax
	db	9Ah
	dw	X032_0B
	dw	seg X032_0B
	sub	ax,word ptr DGROUP:BCC_SOURCE_START
	inc	ax
	mov	word ptr DGROUP:BCC_PARSE_RIGHT,ax
	mov	ax,word ptr DGROUP:BCC_SOURCE_FILE
	mov	word ptr DGROUP:BCC_SOURCE_COLUMN,ax
	mov	word ptr DGROUP:BCC_RD_8520_D+2,ds
	mov	word ptr DGROUP:BCC_RD_8520_D,offset DGROUP:BCC_PARSE_NAME
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	jmp	M005_@@RESTART
M005_@@BAD_DIRECTIVE:
	mov	ax,165h
	push	ax
	db	0E8h,019h,0FBh
	mov	word ptr [bp-4],0
	mov	word ptr [bp-6],1
	mov	al,9
	push	ax
	nop
	push	cs
	db	0E8h,0C3h,003h
M005_@@FINISH_TOKEN:
	db	0E8h,0DEh,001h
	mov	di,ax
M005_@@AFTER_TOKEN:
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	or	si,si
	jne	short M005_@@CHECK_RESULT
	mov	si,2
M005_@@CHECK_RESULT:
	cmp	word ptr [bp-6],0
	jne	short M005_@@CHECK_ENABLED
	jmp	M005_@@FINISH
M005_@@CHECK_ENABLED:
	mov	al,0
	push	ax
	nop
	push	cs
	db	0E8h,0A0h,003h
	cmp	byte ptr DGROUP:BCC_PARSE_ENABLED,0
	jne	short M005_@@CHECK_COUNTS
	jmp	M005_@@FINISH
M005_@@CHECK_COUNTS:
	mov	ax,word ptr DGROUP:BCC_RD_6398_W
	cmp	ax,word ptr DGROUP:BCC_PARSE_HANDLE
	je	short M005_@@COPY_NAMES
	push	word ptr DGROUP:BCC_PARSE_BUFFER
	push	ds
	mov	ax,offset DGROUP:BCC_PARSE_NAME
	push	ax
	push	word ptr [bp-4]
	push	word ptr DGROUP:BCC_SOURCE_COLUMN
	push	word ptr DGROUP:BCC_PARSE_LEFT
	db	9Ah
	dw	X057_00
	dw	seg X057_00
	push	ax
	push	word ptr DGROUP:BCC_RD_5EE6_W
	db	9Ah
	dw	X057_04
	dw	seg X057_04
	jmp	short M005_@@FINISH
M005_@@COPY_NAMES:
	push	ds
	mov	ax,offset DGROUP:BCC_PARSE_NAME
	push	ax
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	mov	word ptr [bp-8],ax
	push	ds
	mov	ax,offset DGROUP:BCC_PARSE_FILENAME
	push	ax
	mov	ax,word ptr [bp-8]
	inc	ax
	inc	ax
	push	ax
	db	9Ah
	dw	X043_02
	dw	seg X043_02
	mov	word ptr [bp-10],ax
	push	word ptr DGROUP:BCC_RD_86C8_W
	db	0FFh,01Eh
	dw	DGROUP:BCC_PARSE_HOOK
	push	word ptr DGROUP:BCC_PARSE_FILENAME
	push	word ptr [bp-10]
	push	ds
	mov	ax,offset DGROUP:BCC_PARSE_NAME
	push	ax
	db	9Ah
	dw	BCC_PARSE_COPY
	dw	seg BCC_PARSE_COPY
	push	word ptr [bp-10]
	db	9Ah
	dw	X05D_00
	dw	seg X05D_00
	push	word ptr DGROUP:BCC_PARSE_FILENAME
	push	word ptr [bp-10]
	push	ds
	mov	ax,offset DGROUP:BCC_PARSE_DEST
	push	ax
	db	9Ah
	dw	BCC_PARSE_COPY
	dw	seg BCC_PARSE_COPY
	push	word ptr [bp-10]
	db	9Ah
	dw	X05D_00
	dw	seg X05D_00
M005_@@FINISH:
	or	di,di
	je	short M005_@@EMPTY
	cmp	si,1
	je	short M005_@@DONE
	mov	ax,47h
	push	ax
	db	0E8h,066h,0FAh
	jmp	short M005_@@DONE
M005_@@EMPTY:
	cmp	si,1
	jne	short M005_@@DONE
	jmp	M005_@@OUTER
M005_@@DONE:
	mov	byte ptr DGROUP:BCC_PARSE_ACTIVE,0
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf
BCC_PARSE	endp
CO03C_TEXT	ends

CO03C_TEXT	segment byte public 'CODE'
		assume	cs:CO03C_TEXT
; Original-image layout stub: not recovered source


		db	001h,000h,002h,000h,003h,000h,004h,000h,005h,000h,006h,000h,07Ch,000h	; ovr_1cc5_8697:6F43
		db	021h,004h,031h,004h,0E0h,004h,029h,004h,054h,004h,048h,004h,06Ch,004h	; ovr_1cc5_8697:6F51

CO03C_TEXT	ends

	extrn	BCC_PRAGMA_RESULT:byte
	extrn	BCC_RD_6398_W:word
	extrn	BCC_PARSE_HANDLE:word
	extrn	BCC_PARSE_HOOK2:dword
	extrn	BCC_RD_8292_W:word


CO03C_TEXT	segment byte public 'CODE'
	assume	cs:CO03C_TEXT,ds:DGROUP

BCC_PARSE_DECL	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	push	si
	push	di
	mov	al,byte ptr DGROUP:BCC_PRAGMA_RESULT
	mov	ah,0
	mov	di,ax
	mov	al,9
	push	ax
	nop
	push	cs
	db	0E8h,0B6h,002h
	push	cs
	db	0E8h,057h,0FAh
	mov	si,ax
	cmp	ax,7Eh
	je	short M007_@@CASE_7E
	cmp	ax,7Fh
	je	short M007_@@CASE_7F
	cmp	ax,80h
	je	short M007_@@CASE_80
	jmp	short M007_@@DISPATCH
M007_@@CASE_80:
	or	di,100h
	db	0E8h,07Ch,002h
	push	cs
	db	0E8h,039h,0FAh
	mov	si,ax
	jmp	short M007_@@DISPATCH
M007_@@CASE_7F:
	push	cs
	db	0E8h,031h,0FAh
	mov	si,ax
	cmp	ax,81h
	je	short M007_@@CASE_7F_81
	jmp	short M007_@@UNEXPECTED
M007_@@CASE_7F_81:
	or	di,200h
	db	0E8h,060h,002h
	push	cs
	db	0E8h,01Dh,0FAh
	mov	si,ax
	jmp	short M007_@@DISPATCH
M007_@@CASE_7E:
	push	cs
	db	0E8h,015h,0FAh
	mov	si,ax
	cmp	ax,81h
	je	short M007_@@CASE_7E_81
M007_@@UNEXPECTED:
	db	0E8h,04Ah,002h
	jmp	short M007_@@DISPATCH
M007_@@CASE_7E_81:
	or	di,400h
	db	0E8h,041h,002h
	push	cs
	db	0E8h,0FEh,0F9h
	mov	si,ax
M007_@@DISPATCH:
	mov	word ptr [bp-2],si
	mov	cx,12
	mov	bx,6AAh
M007_@@SEARCH:
	mov	ax,word ptr cs:[bx]
	cmp	ax,word ptr [bp-2]
	je	short M007_@@FOUND
	inc	bx
	inc	bx
	loop	M007_@@SEARCH
	jmp	short M007_@@DEFAULT
M007_@@FOUND:
	db	02Eh,0FFh,067h,018h
M007_@@MATCHED:
	mov	ax,word ptr DGROUP:BCC_RD_6398_W
	cmp	ax,word ptr DGROUP:BCC_PARSE_HANDLE
	je	short M007_@@DEFAULT
	push	di
	db	0FFh,01Eh
	dw	DGROUP:BCC_PARSE_HOOK2
	db	0E8h,049h,000h
	or	ax,ax
	je	short M007_@@MATCHED_DONE
	dec	word ptr DGROUP:BCC_RD_8292_W
M007_@@MATCHED_DONE:
	xor	ax,ax
	jmp	short M007_@@RETURN
M007_@@DEFAULT:
	db	0E8h,000h,002h
	mov	ax,1
M007_@@RETURN:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret
BCC_PARSE_DECL	endp
CO03C_TEXT	ends

CO03C_TEXT	segment byte public 'CODE'
		assume	cs:CO03C_TEXT
; Original-image layout stub: not recovered source


		db	031h,000h,074h,000h,075h,000h,076h,000h,077h,000h,078h,000h,07Bh,000h	; ovr_1cc5_8697:701A
		db	07Ch,000h,07Dh,000h,07Eh,000h,07Fh,000h,080h,000h,080h,006h,080h,006h	; ovr_1cc5_8697:7028
		db	080h,006h,080h,006h,080h,006h,080h,006h,080h,006h,080h,006h,080h,006h	; ovr_1cc5_8697:7036
		db	080h,006h,080h,006h,080h,006h	; ovr_1cc5_8697:7044

CO03C_TEXT	ends

	extrn	BCC_RD_679E_B:byte
	extrn	BCC_RF_1AB2_0031:far
	extrn	BCC_TOKEN_TABLE:word
	extrn	BCC_RF_1AA8_0007:far
	extrn	BCC_RD_86FB_W:word
	extrn	BCC_PRAGMA_HOOK:dword
	extrn	BCC_PRAGMA_HOOK2:dword


CO03C_TEXT	segment byte public 'CODE'
	assume	cs:CO03C_TEXT,ds:DGROUP

BCC_PARSE_EXPR	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,6
	push	si
	push	di
M009_@@NEXT:
	push	cs
	db	0E8h,07Ah,0F9h
	mov	word ptr [bp-2],ax
	mov	cx,16
	mov	bx,796h
M009_@@SEARCH:
	mov	ax,word ptr cs:[bx]
	cmp	ax,word ptr [bp-2]
	je	short M009_@@FOUND
	inc	bx
	inc	bx
	loop	M009_@@SEARCH
	jmp	M009_@@DEFAULT
M009_@@FOUND:
	db	02Eh,0FFh,067h,020h
M009_@@RETURN_ZERO:
	xor	ax,ax
	jmp	M009_@@RETURN
M009_@@RETURN_ONE:
	mov	ax,1
	jmp	short M009_@@RETURN_ZERO+2
M009_@@RETURN_ZERO_2:
	jmp	short M009_@@RETURN_ZERO
M009_@@SKIP:
	db	0E8h,08Eh,001h
	jmp	short M009_@@NEXT
M009_@@PRAGMA_NAME:
	mov	byte ptr [bp-6],5Fh
	mov	al,byte ptr DGROUP:BCC_RD_679E_B
	cbw
	push	ax
	db	9Ah
	dw	BCC_RF_1AB2_0031
	dw	seg BCC_RF_1AB2_0031
	mov	byte ptr [bp-5],al
	mov	al,byte ptr DGROUP:BCC_RD_679E_B+1
	cbw
	push	ax
	db	9Ah
	dw	BCC_RF_1AB2_0031
	dw	seg BCC_RF_1AB2_0031
	mov	byte ptr [bp-4],al
	mov	byte ptr [bp-3],0
	mov	si,offset DGROUP:BCC_TOKEN_TABLE
	jmp	short M009_@@TEST_KEYWORD
M009_@@COMPARE_KEYWORD:
	push	ds
	push	word ptr [si]
	push	ss
	lea	ax,[bp-6]
	push	ax
	db	9Ah
	dw	BCC_RF_1AA8_0007
	dw	seg BCC_RF_1AA8_0007
	or	ax,ax
	jne	short M009_@@NEXT_KEYWORD
	mov	cl,byte ptr [si+2]
	mov	ax,1
	shl	ax,cl
	or	word ptr DGROUP:BCC_RD_86FB_W,ax
	jmp	short M009_@@KEYWORDS_DONE
M009_@@NEXT_KEYWORD:
	add	si,7
M009_@@TEST_KEYWORD:
	cmp	word ptr [si],0
	jne	short M009_@@COMPARE_KEYWORD
M009_@@KEYWORDS_DONE:
	jmp	short M009_@@SKIP
M009_@@DOUBLE_SKIP:
	db	0E8h,039h,001h
	push	cs
	db	0E8h,0F6h,0F8h
	jmp	short M009_@@SKIP
M009_@@HOOK:
	db	0FFh,01Eh
	dw	DGROUP:BCC_PRAGMA_HOOK
	jmp	short M009_@@SKIP
M009_@@HOOK_RESULT:
	db	0FFh,01Eh
	dw	DGROUP:BCC_PRAGMA_HOOK2
	mov	di,ax
	or	di,di
	jne	short M009_@@RESULT_NONZERO
	jmp	short M009_@@RETURN_ZERO
M009_@@RESULT_NONZERO:
	cmp	di,1
	je	short M009_@@RESULT_ONE
	jmp	M009_@@NEXT
M009_@@RESULT_ONE:
	db	0E8h,016h,001h
	jmp	M009_@@NEXT
M009_@@DEFAULT:
	jmp	short M009_@@SKIP
M009_@@RETURN:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret
BCC_PARSE_EXPR	endp
CO03C_TEXT	ends

CO03C_TEXT	segment byte public 'CODE'
		assume	cs:CO03C_TEXT
; Original-image layout stub: not recovered source


		db	006h,000h,007h,000h,02Fh,000h,031h,000h,032h,000h,074h,000h,076h,000h	; ovr_1cc5_8697:7106
		db	077h,000h,078h,000h,079h,000h,07Ah,000h,07Ch,000h,07Dh,000h,07Eh,000h	; ovr_1cc5_8697:7114
		db	07Fh,000h,080h,000h,008h,007h,00Dh,007h,073h,007h,06Dh,007h,00Fh,007h	; ovr_1cc5_8697:7122
		db	071h,007h,071h,007h,071h,007h,071h,007h,064h,007h,014h,007h,003h,007h	; ovr_1cc5_8697:7130
		db	071h,007h,071h,007h,071h,007h,071h,007h	; ovr_1cc5_8697:713E

CO03C_TEXT	ends

	extrn	BCC_RD_86FB_W:word


CO03C_TEXT	segment byte public 'CODE'
	assume	cs:CO03C_TEXT,ds:DGROUP

BCC_LEX_TOKEN	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	push	si
	mov	byte ptr [bp-1],9
	push	cs
	db	0E8h,07Ch,0F8h
	mov	si,ax
	cmp	si,7Ch
	je	short M00B_@@RETURN_TOKEN
	cmp	si,5
	je	short M00B_@@RETURN_TOKEN
	cmp	si,6
	jne	short M00B_@@CHECK_7D
M00B_@@RETURN_TOKEN:
	mov	ax,si
	jmp	M00B_@@RETURN
M00B_@@CHECK_7D:
	cmp	si,7Dh
	jne	short M00B_@@CHECK_74
	mov	al,byte ptr [bp-1]
	push	ax
	nop
	push	cs
	db	0E8h,0B3h,000h
	db	0E8h,094h,000h
	push	cs
	db	0E8h,051h,0F8h
	mov	si,ax
	mov	byte ptr [bp-1],20h
M00B_@@CHECK_74:
	cmp	si,74h
	je	short M00B_@@KEYWORD
	cmp	si,77h
	je	short M00B_@@KEYWORD
	cmp	si,75h
	jne	short M00B_@@CHECK_78
M00B_@@KEYWORD:
	cmp	si,75h
	jne	short M00B_@@KEYWORD_EMIT
	or	word ptr DGROUP:BCC_RD_86FB_W,1055h
M00B_@@KEYWORD_EMIT:
	mov	al,byte ptr [bp-1]
	push	ax
	nop
	push	cs
	db	0E8h,083h,000h
	jmp	short M00B_@@RETURN_ONE_ADVANCE
M00B_@@CHECK_78:
	cmp	si,78h
	jne	short M00B_@@CHECK_76
	mov	al,byte ptr [bp-1]
	push	ax
	nop
	push	cs
	db	0E8h,073h,000h
	db	0E8h,054h,000h
	mov	ax,2
	jmp	short M00B_@@RETURN
M00B_@@CHECK_76:
	cmp	si,76h
	jne	short M00B_@@CHECK_SLASH
	mov	al,byte ptr [bp-1]
	push	ax
	nop
	push	cs
	db	0E8h,05Dh,000h
	db	0E8h,03Eh,000h
	push	cs
	db	0E8h,0FBh,0F7h
	mov	si,ax
	cmp	si,77h
	jne	short M00B_@@RETURN_THREE_ADVANCE
M00B_@@RETURN_ONE_ADVANCE:
	db	0E8h,030h,000h
	mov	ax,1
	jmp	short M00B_@@RETURN
M00B_@@CHECK_SLASH:
	cmp	si,2Fh
	jne	short M00B_@@OTHER
	mov	al,byte ptr [bp-1]
	push	ax
	nop
	push	cs
	db	0E8h,039h,000h
	db	0E8h,01Ah,000h
	mov	ax,4
	jmp	short M00B_@@RETURN
M00B_@@OTHER:
	mov	al,byte ptr [bp-1]
	push	ax
	nop
	push	cs
	db	0E8h,028h,000h
M00B_@@RETURN_THREE_ADVANCE:
	db	0E8h,009h,000h
	mov	ax,3
M00B_@@RETURN:
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret
BCC_LEX_TOKEN	endp
CO03C_TEXT	ends


	extrn	BCC_RD_679E_B:byte


CO03C_TEXT	segment byte public 'CODE'
	assume	cs:CO03C_TEXT,ds:DGROUP

BCC_LEX_ADVANCE	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	mov	si,offset DGROUP:BCC_RD_679E_B
	jmp	short M00C_@@TEST
M00C_@@EMIT:
	mov	al,byte ptr [si]
	push	ax
	nop
	push	cs
	db	0E8h,00Ah,000h
	inc	si
M00C_@@TEST:
	cmp	byte ptr [si],0
	jne	short M00C_@@EMIT
	pop	si
	pop	bp
	dec	bp
	ret
BCC_LEX_ADVANCE	endp
CO03C_TEXT	ends

		extrn	BCC_RD_8520_D:dword
		extrn	BCC_RD_8520_D:dword
		extrn	BCC_RD_8520_D:dword


CO03C_TEXT	segment byte public 'CODE'
	assume	cs:CO03C_TEXT,ds:DGROUP

		public	X03C_04
X03C_04	label	far
BCC_LEX_SPECIAL	proc	far
	push	bp
	mov	bp,sp
	cmp	word ptr DGROUP:BCC_RD_8520_D,84FFh
	jnc	short M00D_@@CHECK_ZERO
	les	bx,dword ptr DGROUP:BCC_RD_8520_D
	mov	al,byte ptr [bp+6]
	mov	byte ptr es:[bx],al
	inc	word ptr DGROUP:BCC_RD_8520_D
	jmp	short M00D_@@RETURN
M00D_@@CHECK_ZERO:
	cmp	byte ptr [bp+6],0
	jne	short M00D_@@RETURN
	mov	ax,0Eh
	push	ax
	db	0E8h,040h,0F7h
M00D_@@RETURN:
	pop	bp
	retf	2
BCC_LEX_SPECIAL	endp
CO03C_TEXT	ends

	extrn	BCC_RD_828C_W:word
	extrn	BCC_RD_827C_W:word
	extrn	X032_05:far
	extrn	X030_06:far
	extrn	X030_0A:far
		extrn	BCC_RD_8292_W:word
		extrn	BCC_RD_8292_W:word
		extrn	BCC_RD_8292_W:word


CO03C_TEXT	segment byte public 'CODE'
	assume	cs:CO03C_TEXT,ds:DGROUP

		public	X03C_03
X03C_03	label	far
BCC_LEX_SKIP	proc	far
	push	bp
	mov	bp,sp
	push	si
M00E_@@NEXT:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M00E_@@READ
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M00E_@@READY
M00E_@@READ:
	mov	bx,word ptr DGROUP:BCC_RD_827C_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_8292_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M00E_@@READY:
	mov	ah,0
	mov	si,ax
	cmp	si,0Dh
	jne	short M00E_@@CHECK_LF
	jmp	M00E_@@RETURN
M00E_@@CHECK_LF:
	cmp	si,0Ah
	jne	short M00E_@@CHECK_SEMICOLON
	jmp	M00E_@@RETURN
M00E_@@CHECK_SEMICOLON:
	cmp	si,3Bh
	je	M00E_@@RETURN
	cmp	si,27h
	jne	short M00E_@@CHECK_SLASH
M00E_@@QUOTED:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M00E_@@READ_QUOTED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M00E_@@QUOTED_READY
M00E_@@READ_QUOTED:
	mov	bx,word ptr DGROUP:BCC_RD_827C_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_8292_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M00E_@@QUOTED_READY:
	mov	ah,0
	mov	si,ax
	cmp	si,27h
	jne	short M00E_@@QUOTED
	jmp	short M00E_@@NEXT
M00E_@@CHECK_SLASH:
	cmp	si,2Fh
	jne	short M00E_@@NEXT
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M00E_@@READ_COMMENT
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M00E_@@COMMENT_READY
M00E_@@READ_COMMENT:
	mov	bx,word ptr DGROUP:BCC_RD_827C_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_8292_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M00E_@@COMMENT_READY:
	mov	ah,0
	mov	si,ax
	cmp	si,2Ah
	jne	short M00E_@@CHECK_LINE_COMMENT
	db	9Ah
	dw	X030_06
	dw	seg X030_06
	jmp	M00E_@@NEXT
M00E_@@CHECK_LINE_COMMENT:
	cmp	si,2Fh
	jne	short M00E_@@UNREAD
	db	9Ah
	dw	X030_0A
	dw	seg X030_0A
	jmp	M00E_@@NEXT
M00E_@@UNREAD:
	dec	word ptr DGROUP:BCC_RD_8292_W
	jmp	M00E_@@NEXT
M00E_@@RETURN:
	pop	si
	pop	bp
	retf
BCC_LEX_SKIP	endp
CO03C_TEXT	ends

; END C129UNIT
		end
