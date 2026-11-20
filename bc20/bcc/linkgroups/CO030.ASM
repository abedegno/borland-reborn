; Recovered FBOV far-pointer references
		extrn	BCC_DIAGNOSTIC:far
CO02E_TEXT	segment byte public 'CODE'
CO02E_TEXT	ends
CO032_TEXT	segment byte public 'CODE'
CO032_TEXT	ends
CO069_TEXT	segment byte public 'CODE'
CO069_TEXT	ends
		public	X030_0A
		public	X030_00
		public	X030_01
		public	X030_02
		public	X030_03
		public	X030_04
		public	X030_05
		public	X030_06
		public	X030_07
		public	X030_08
		public	X030_09
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1c90_7cc3
; BEGIN C130UNIT (listing ovr_1c90_7cc3:CC30)
CO030_TEXT	segment byte public 'CODE'
		assume	cs:CO030_TEXT
; Recovered raw-prefix C owner LG091; original span/provenance retained


X030_02	label	far
		db	055h,08Bh,0ECh,080h,03Eh,0F5h,016h,001h,074h,011h,0FFh,076h,008h,0FFh; ovr_1c90_7cc3:CC30
		db	076h,006h,0FFh,076h,00Ah,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	083h,0C4h,006h,05Dh; ovr_1c90_7cc3:CC3E
		db	0CAh,006h,000h	; ovr_1c90_7cc3:CC4C

CO030_TEXT	ends

	extrn	X032_05:far
	extrn	STRCMP:far
	extrn	BCC_DIAGNOSTIC:far
	extrn	_CTYPE:byte
	extrn	BCC_RD_77D3_W:word
	extrn	BCC_TOKEN_LINE:word
	extrn	BCC_RD_8232_W:word
	extrn	BCC_RD_828C_W:word
	BCC_RD_7C1E_W	equ	827Ch
	extrn	BCC_RD_679E_B:byte
		BCC_RD_920E_W	equ	8292h
		extrn	BCC_RD_8292_W:word
		BCC_RD_921E_W	equ	8292h
		BCC_RD_20BE_B	equ	1F20h
		BCC_RD_5CC2_B	equ	1F20h


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

		public	X030_04
X030_04	label	far
BCC_READ_TOKEN	proc	far
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	push	si
	push	di
	mov	ax,32
	push	ax
	nop
	push	cs
	db	0E8h,038h,011h
	mov	word ptr [bp-2],ax
	cmp	word ptr [bp-2],10
	je	short M001_@@LINE_END
	cmp	word ptr [bp-2],13
	je	short M001_@@LINE_END
	cmp	word ptr [bp-2],26
	jne	short M001_@@NONSPACE
M001_@@LINE_END:
	mov	word ptr DGROUP:BCC_RD_8232_W,0
	cmp	word ptr [bp-2],10
	je	short M001_@@REWIND_LINE
	cmp	word ptr [bp-2],13
	je	short M001_@@REWIND_LINE
	jmp	M001_@@EPILOGUE
M001_@@REWIND_LINE:
	dec	word ptr DGROUP:BCC_RD_920E_W
	jmp	M001_@@EPILOGUE
M001_@@NONSPACE:
	mov	ax,word ptr DGROUP:BCC_RD_77D3_W
	mov	word ptr DGROUP:BCC_TOKEN_LINE,ax
	mov	bx,word ptr [bp-2]
	mov	al,byte ptr DGROUP:_CTYPE[bx+1]
	cbw
	test	ax,12
	jne	short M001_@@IDENTIFIER
	mov	al,byte ptr [bp-2]
	mov	byte ptr DGROUP:BCC_RD_679E_B,al
	mov	byte ptr DGROUP:BCC_RD_679E_B+1,0
	jmp	M001_@@DIAGNOSE
M001_@@IDENTIFIER:
	mov	di,offset DGROUP:BCC_RD_679E_B
	jmp	short M001_@@IDENTIFIER_TEST
M001_@@IDENTIFIER_BODY:
	mov	al,byte ptr [bp-2]
	mov	byte ptr [di],al
	inc	di
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M001_@@BUFFERED_CHARACTER
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M001_@@CHARACTER_READY
M001_@@BUFFERED_CHARACTER:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M001_@@CHARACTER_READY:
	mov	ah,0
	mov	word ptr [bp-2],ax
M001_@@IDENTIFIER_TEST:
	mov	bx,word ptr [bp-2]
	mov	al,byte ptr DGROUP:_CTYPE[bx+1]
	cbw
	test	ax,12
	jne	short M001_@@IDENTIFIER_BODY
	mov	byte ptr [di],0
	push	word ptr [bp-2]
	nop
	push	cs
	db	0E8h,09Dh,010h
	mov	word ptr [bp-2],ax
	mov	si,offset DGROUP:BCC_RD_20BE_B
	jmp	short M001_@@KEYWORD_TEST
M001_@@KEYWORD_BODY:
	push	ds
	push	word ptr [si]
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	db	9Ah
	dw	STRCMP
	dw	seg STRCMP
	or	ax,ax
	jne	short M001_@@NEXT_KEYWORD
	cmp	word ptr [bp+6],0
	je	short M001_@@KEYWORD_TOKEN
	mov	ax,word ptr DGROUP:BCC_RD_77D3_W
	mov	word ptr DGROUP:BCC_TOKEN_LINE,ax
	push	word ptr [bp-2]
	call	word ptr [si+3]
	jmp	short M001_@@EPILOGUE
M001_@@KEYWORD_TOKEN:
	mov	al,byte ptr [si+2]
	cbw
	mov	word ptr DGROUP:BCC_RD_8232_W,ax
	dec	word ptr DGROUP:BCC_RD_920E_W
	jmp	short M001_@@EPILOGUE
M001_@@NEXT_KEYWORD:
	add	si,5
M001_@@KEYWORD_TEST:
	cmp	si,offset DGROUP:BCC_RD_5CC2_B+60
	jc	short M001_@@KEYWORD_BODY
	mov	word ptr DGROUP:BCC_RD_8232_W,0
	cmp	word ptr [bp+6],0
	je	short M001_@@UNGET
M001_@@DIAGNOSE:
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	mov	ax,89
	push	ax
	db	9Ah
	dw	BCC_DIAGNOSTIC
	dw	seg BCC_DIAGNOSTIC
	add	sp,6
M001_@@UNGET:
	push	word ptr [bp-2]
	nop
	push	cs
	db	0E8h,039h,012h
M001_@@EPILOGUE:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf	2
BCC_READ_TOKEN	endp
CO030_TEXT	ends


	extrn	BCC_POOL_UPDATE:near
	extrn	X069_05:far
	extrn	_CTYPE:byte
	extrn	BCC_NAME_TEXT:byte
	extrn	BCC_NAME_FLAGS:byte
	extrn	BCC_SPECIAL_TABLE:byte
	BCC_CONTEXT_PTR	equ	817Ch
	BCC_CONTEXT_SEG	equ	8274h
	extrn	BCC_INVALID_NAME_MESSAGE:byte


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_PARSE_QUALIFIED_NAME	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,6
	push	si
	push	di
	mov	si,word ptr [bp+4]
	cmp	si,45
	je	short M002_@@PREFIX
	cmp	si,43
	je	short M002_@@PREFIX
	cmp	si,46
	je	short M002_@@PREFIX
	jmp	M002_@@INVALID
M002_@@PREFIX:
	mov	word ptr [bp-2],si
	mov	ax,32
	push	ax
	nop
	push	cs
	db	0E8h,003h,010h
	mov	si,ax
	mov	al,byte ptr DGROUP:_CTYPE[si+1]
	cbw
	test	ax,12
	jne	short M002_@@READ_NAME
	jmp	M002_@@INVALID
M002_@@READ_NAME:
	push	si
	nop
	push	cs
	db	0E8h,0B5h,00Dh
	mov	si,ax
	xor	di,di
	mov	word ptr [bp-4],ds
	mov	word ptr [bp-6],offset DGROUP:BCC_SPECIAL_TABLE
	jmp	short M002_@@TABLE_TEST
M002_@@TABLE_BODY:
	les	bx,dword ptr [bp-6]
	mov	al,byte ptr es:[bx]
	cmp	al,byte ptr DGROUP:BCC_NAME_TEXT
	jne	short M002_@@NEXT_ENTRY
	mov	al,byte ptr es:[bx+1]
	cmp	al,byte ptr DGROUP:BCC_NAME_TEXT+1
	jne	short M002_@@NEXT_ENTRY
	mov	al,byte ptr es:[bx+2]
	cmp	al,byte ptr DGROUP:BCC_NAME_TEXT+2
	jne	short M002_@@NEXT_ENTRY
	cmp	word ptr [bp-2],46
	jne	short M002_@@PLUS_OR_MINUS
	mov	al,byte ptr es:[bx+3]
	mov	byte ptr DGROUP:BCC_NAME_FLAGS[di],al
	jmp	short M002_@@NEXT_ENTRY
M002_@@PLUS_OR_MINUS:
	cmp	word ptr [bp-2],43
	jne	short M002_@@MINUS
	mov	byte ptr DGROUP:BCC_NAME_FLAGS[di],1
	jmp	short M002_@@NEXT_ENTRY
M002_@@MINUS:
	mov	byte ptr DGROUP:BCC_NAME_FLAGS[di],0
M002_@@NEXT_ENTRY:
	add	word ptr [bp-6],4
	inc	di
M002_@@TABLE_TEST:
	les	bx,dword ptr [bp-6]
	cmp	byte ptr es:[bx],0
	jne	short M002_@@TABLE_BODY
	mov	bx,word ptr DGROUP:BCC_CONTEXT_PTR
	mov	es,word ptr DGROUP:BCC_CONTEXT_SEG
	cmp	word ptr es:[bx+10],0
	je	short M002_@@CHECK_TABLE
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_TEXT
	push	ax
	mov	al,byte ptr [bp-2]
	push	ax
	db	9Ah
	dw	X069_05
	dw	seg X069_05
M002_@@CHECK_TABLE:
	mov	ax,word ptr [bp-6]
	or	ax,word ptr [bp-4]
	jne	short M002_@@SUCCESS
M002_@@INVALID:
	mov	ax,89
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_INVALID_NAME_MESSAGE
	push	ax
	push	cs
	db	0E8h,0F7h,0FDh
M002_@@SUCCESS:
	mov	ax,si
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret	2
BCC_PARSE_QUALIFIED_NAME	endp
CO030_TEXT	ends


		extrn	X069_03:far
		extrn	X02E_03:far
		extrn	BCC_COMPILER_MODE:byte
		BCC_CONTEXT_PTR	equ	817Ch
		BCC_CONTEXT_SEG	equ	8274h


CO030_TEXT	segment byte public 'CODE'
		assume	cs:CO030_TEXT,ds:DGROUP

BCC_CHECK_NAME_CONTEXT	proc	near
		inc	bp
		push	bp
		mov	bp,sp
		mov	bx,word ptr DGROUP:BCC_CONTEXT_PTR
		mov	es,word ptr DGROUP:BCC_CONTEXT_SEG
		cmp	word ptr es:[bx+10],0
		je	short M003_@@CHECK_MODE
		db	09Ah
		dw	X069_03
		dw	seg X069_03
M003_@@CHECK_MODE:
		mov	al,byte ptr DGROUP:BCC_COMPILER_MODE
		cbw
		or	ax,ax
		jne	short M003_@@DONE
		mov	ax,3
		push	ax
		db	09Ah
		dw	X02E_03
		dw	seg X02E_03
M003_@@DONE:
		mov	ax,word ptr [bp+4]
		pop	bp
		dec	bp
		ret	2
BCC_CHECK_NAME_CONTEXT	endp
CO030_TEXT	ends


	extrn	BCC_POOL_UPDATE:near
	extrn	BCC_RD_80E4_D:dword
	extrn	X032_05:far
	extrn	X035_04:far
	extrn	X035_02:far
	extrn	_CTYPE:byte
	extrn	BCC_RD_828C_W:word
	BCC_RD_7C1E_W	equ	827Ch
	extrn	BCC_INVALID_IDENTIFIER_MESSAGE:byte
	extrn	BCC_INVALID_NAME_MESSAGE:byte
		extrn	BCC_RD_8292_W:word
		BCC_RD_921E_W	equ	8292h


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_NEAR_CE75	label	near
BCC_PARSE_NUMBER_OPERATION	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	push	si
	push	di
	mov	si,word ptr [bp+6]
	mov	al,byte ptr DGROUP:_CTYPE[si+1]
	cbw
	test	ax,12
	jne	short M004_@@READ_NAME
	cmp	si,95
	je	short M004_@@READ_NAME
	mov	ax,89
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_INVALID_IDENTIFIER_MESSAGE
M004_@@MESSAGE_PUSH:
	push	ax
	jmp	M004_@@CALL_WRAPPER
M004_@@READ_NAME:
	push	si
	nop
	push	cs
	db	0E8h,0BDh,00Ch
	mov	si,ax
	xor	ax,ax
	push	ax
	db	0FFh,01Eh
	dw	BCC_RD_80E4_D
	mov	word ptr [bp-2],ax
	cmp	word ptr [bp-2],-1
	jne	short M004_@@CHECK_ZERO
	jmp	M004_@@EPILOGUE
M004_@@CHECK_ZERO:
	cmp	word ptr [bp-2],0
	jne	short M004_@@SCAN_NEXT
	jmp	M004_@@ZERO_RESULT
M004_@@SCAN_NEXT:
	push	si
	nop
	push	cs
	db	0E8h,0D2h,00Eh
	mov	si,ax
	test	byte ptr DGROUP:_CTYPE[si+1],2
	je	short M004_@@DEFAULT_NUMBER
	xor	di,di
	jmp	short M004_@@DIGIT_TEST
M004_@@DIGIT_BODY:
	mov	ax,di
	mov	dx,10
	imul	dx
	add	ax,si
	add	ax,0ffd0h
	mov	di,ax
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M004_@@BUFFERED_CHARACTER
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M004_@@CHARACTER_READY
M004_@@BUFFERED_CHARACTER:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M004_@@CHARACTER_READY:
	mov	ah,0
	mov	si,ax
M004_@@DIGIT_TEST:
	mov	al,byte ptr DGROUP:_CTYPE[si+1]
	cbw
	test	ax,2
	jne	short M004_@@DIGIT_BODY
	push	si
	nop
	push	cs
	db	0E8h,082h,00Eh
	mov	si,ax
	jmp	short M004_@@CHECK_LINE_END
M004_@@DEFAULT_NUMBER:
	mov	di,100
M004_@@CHECK_LINE_END:
	cmp	si,10
	je	short M004_@@COMMIT
	cmp	si,13
	je	short M004_@@COMMIT
	cmp	si,26
	je	short M004_@@COMMIT
	mov	ax,89
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_INVALID_NAME_MESSAGE
	jmp	M004_@@MESSAGE_PUSH
M004_@@COMMIT:
	cmp	word ptr [bp+4],0
	je	short M004_@@COMMIT_B
	push	word ptr [bp-2]
	push	di
	db	9Ah
	dw	X035_04
	dw	seg X035_04
	jmp	short M004_@@AFTER_COMMIT
M004_@@COMMIT_B:
	push	word ptr [bp-2]
	push	di
	db	9Ah
	dw	X035_02
	dw	seg X035_02
M004_@@AFTER_COMMIT:
	jmp	short M004_@@EPILOGUE
	jmp	short M004_@@EPILOGUE
M004_@@ZERO_RESULT:
	mov	ax,20
	push	ax
	xor	ax,ax
	xor	dx,dx
	push	ax
	push	dx
M004_@@CALL_WRAPPER:
	push	cs
	db	0E8h,0CEh,0FCh
M004_@@EPILOGUE:
	mov	ax,si
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret	4
BCC_PARSE_NUMBER_OPERATION	endp
CO030_TEXT	ends





CO030_TEXT	segment byte public 'CODE'
		assume	cs:CO030_TEXT,ds:DGROUP

BCC_NEAR_CF6D	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	word ptr [BP+4]
		xor	AX,AX
		push	AX
		db	0E8h
		dw	0FEFBh
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_CF6D	endp
CO030_TEXT	ends





CO030_TEXT	segment byte public 'CODE'
		assume	cs:CO030_TEXT,ds:DGROUP

BCC_NEAR_CF7F	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	word ptr [BP+4]
		mov	AX,1
		push	AX
		db	0E8h
		dw	0FEE8h
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_CF7F	endp
CO030_TEXT	ends

CO030_TEXT	segment byte public 'CODE'
		assume	cs:CO030_TEXT
; Original-image layout stub: not recovered source


		db	045h,055h,08Bh,0ECh,0C6h,006h,0D9h,077h,001h,08Bh,046h,004h,05Dh,04Dh	; ovr_1c90_7cc3:CF92
		db	0C2h,002h,000h,045h,055h,08Bh,0ECh,0E9h,0A6h,000h,0C7h,006h,054h,082h	; ovr_1c90_7cc3:CFA0
		db	09Eh,067h,0EBh,02Fh,08Ah,046h,004h,050h,090h,00Eh,0E8h,0A2h,00Dh,0A1h	; ovr_1c90_7cc3:CFAE
		db	092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh; ovr_1c90_7cc3:CFBC
		db	011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h	; ovr_1c90_7cc3:CFCA
		db	082h,026h,08Ah,007h,0B4h,000h,089h,046h,004h,08Bh,05Eh,004h,080h,0BFh	; ovr_1c90_7cc3:CFD8
		db	001h,021h,0F7h,074h,012h,083h,07Eh,004h,01Ah,074h,00Ch,083h,07Eh,004h	; ovr_1c90_7cc3:CFE6
		db	00Ah,074h,006h,083h,07Eh,004h,00Dh,075h,0B5h,01Eh,0B8h,09Fh,067h,050h	; ovr_1c90_7cc3:CFF4
		db	0B8h,001h,000h,050h,09Ah
		dw	04Dh
		dw	seg CO02E_TEXT
		db	00Bh,0C0h,075h,01Dh,080h; ovr_1c90_7cc3:D002
		db	03Eh,0F5h,016h,001h,074h,016h,01Eh,0B8h,09Eh,067h,050h,01Eh,0B8h,0E7h	; ovr_1c90_7cc3:D010
		db	01Fh,050h,0B8h,05Bh,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	083h,0C4h,00Ah; ovr_1c90_7cc3:D01E
		db	08Bh,01Eh,07Ch,081h,08Eh,006h,074h,082h,026h,083h,07Fh,00Ah,000h,074h	; ovr_1c90_7cc3:D02C
		db	00Ah,01Eh,0B8h,09Fh,067h,050h,09Ah
		dw	034h
		dw	seg CO069_TEXT
		db	0FFh,076h,004h; ovr_1c90_7cc3:D03A
		db	090h,00Eh,0E8h,04Ah,00Dh,089h,046h,004h,083h,07Eh,004h,01Ah,074h,00Fh	; ovr_1c90_7cc3:D048
		db	083h,07Eh,004h,00Ah,074h,009h,083h,07Eh,004h,00Dh,074h,003h,0E9h,045h	; ovr_1c90_7cc3:D056
		db	0FFh,0C7h,006h,054h,082h,09Eh,067h,08Bh,046h,004h,05Dh,04Dh,0C2h,002h	; ovr_1c90_7cc3:D064
		db	000h,045h,055h,08Bh,0ECh,0C6h,006h,0DFh,077h,001h,08Bh,046h,004h,05Dh	; ovr_1c90_7cc3:D072
		db	04Dh,0C2h,002h,000h,045h,055h,08Bh,0ECh,0C6h,006h,029h,05Fh,001h,08Bh	; ovr_1c90_7cc3:D080
		db	046h,004h,05Dh,04Dh,0C2h,002h,000h	; ovr_1c90_7cc3:D08E

CO030_TEXT	ends

	extrn	X032_05:far
	extrn	_CTYPE:byte
	extrn	BCC_RD_828C_W:word
	BCC_RD_7C1E_W	equ	827Ch
		extrn	BCC_RD_8292_W:word
		BCC_RD_921E_W	equ	8292h


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_SCAN_ALNUM	proc	far
	push	bp
	mov	bp,sp
	jmp	short M008_@@TEST
M008_@@BODY:
	mov	al,byte ptr [bp+6]
	push	ax
	nop
	push	cs
	db	0E8h,0BAh,00Ch
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M008_@@BUFFERED_CHARACTER
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M008_@@CHARACTER_READY
M008_@@BUFFERED_CHARACTER:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M008_@@CHARACTER_READY:
	mov	ah,0
	mov	word ptr [bp+6],ax
M008_@@TEST:
	mov	bx,word ptr [bp+6]
	test	byte ptr DGROUP:_CTYPE[bx+1],14
	jne	short M008_@@BODY
	cmp	word ptr [bp+6],95
	je	short M008_@@BODY
	mov	ax,word ptr [bp+6]
	pop	bp
	retf	2
BCC_SCAN_ALNUM	endp
CO030_TEXT	ends


	extrn	BCC_RD_8100_D:dword
	extrn	BCC_NAME_APPEND:far
	extrn	X035_05:far
	extrn	BCC_RF_15A7_017D:far
	extrn	X032_05:far
	extrn	X056_0D:far
	extrn	X064_03:far
	extrn	_CTYPE:byte
	extrn	BCC_SCAN_FLAG:byte
	extrn	BCC_RD_8254_W:word
	extrn	BCC_RD_679E_B:byte
	extrn	BCC_RD_828C_W:word
	BCC_RD_7C1E_W	equ	827Ch
	extrn	BCC_LINE_END:word
	extrn	BCC_RD_8664_W:word
	BCC_DEFAULT_DECLARATION	equ	82F2h
	BCC_LANGUAGE_MODE	equ	1776h
	extrn	BCC_ERROR_CODE:word
		extrn	BCC_RD_8292_W:word
		BCC_RD_921E_W	equ	8292h


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_PARSE_DECLARATION	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,4
	push	si
	push	di
	mov	si,word ptr [bp+4]
	db	0FFh,01Eh
	dw	BCC_RD_8100_D
	mov	byte ptr DGROUP:BCC_SCAN_FLAG,1
	mov	word ptr [bp-4],0
	xor	di,di
	push	si
	nop
	push	cs
	db	0E8h,095h,00Ch
	mov	si,ax
	cmp	si,10
	je	short M009_@@LINE_END_INITIAL
	cmp	si,13
	je	short M009_@@LINE_END_INITIAL
	cmp	si,26
	jne	short M009_@@CHECK_IDENTIFIER
M009_@@LINE_END_INITIAL:
	mov	ax,word ptr DGROUP:BCC_LINE_END
M009_@@COPY_LINE:
	mov	word ptr DGROUP:BCC_RD_8664_W,ax
	jmp	M009_@@PARSE_ERROR
M009_@@CHECK_IDENTIFIER:
	test	byte ptr DGROUP:_CTYPE[si+1],14
	jne	short M009_@@FIRST_NAME
	cmp	si,95
	je	short M009_@@FIRST_NAME
	jmp	M009_@@INVALID_IDENTIFIER
M009_@@FIRST_NAME:
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	push	si
	push	cs
	db	0E8h,05Fh,0FFh
	mov	si,ax
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	db	9Ah
	dw	BCC_NAME_APPEND
	dw	seg BCC_NAME_APPEND
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	db	9Ah
	dw	X035_05
	dw	seg X035_05
	mov	word ptr [bp-2],ax
M009_@@SCAN_AFTER_NAME:
	push	si
	nop
	push	cs
	db	0E8h,042h,00Ch
	mov	si,ax
	test	byte ptr DGROUP:_CTYPE[si+1],14
	jne	short M009_@@EXTRA_NAME
	cmp	si,95
	jne	short M009_@@AFTER_NAMES
M009_@@EXTRA_NAME:
	cmp	word ptr [bp-4],0
	je	short M009_@@READ_EXTRA_NAME
	mov	ax,372
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_017D
	dw	seg BCC_RF_15A7_017D
	pop	cx
M009_@@READ_EXTRA_NAME:
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	push	si
	push	cs
	db	0E8h,017h,0FFh
	mov	si,ax
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	db	9Ah
	dw	BCC_NAME_APPEND
	dw	seg BCC_NAME_APPEND
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	db	9Ah
	dw	X035_05
	dw	seg X035_05
	mov	word ptr [bp-4],ax
	jmp	short M009_@@SCAN_AFTER_NAME
M009_@@AFTER_NAMES:
	cmp	si,34
	je	short M009_@@QUOTED_NAME
	jmp	M009_@@CHECK_LINE_END
M009_@@QUOTED_NAME:
	or	di,di
	je	short M009_@@READ_QUOTED
	mov	ax,372
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_017D
	dw	seg BCC_RF_15A7_017D
	pop	cx
M009_@@READ_QUOTED:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M009_@@QUOTED_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M009_@@QUOTED_CHARACTER
M009_@@QUOTED_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M009_@@QUOTED_CHARACTER:
	mov	ah,0
	mov	si,ax
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	push	si
	push	cs
	db	0E8h,0B6h,0FEh
	mov	si,ax
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	db	9Ah
	dw	BCC_NAME_APPEND
	dw	seg BCC_NAME_APPEND
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	db	9Ah
	dw	X035_05
	dw	seg X035_05
	mov	di,ax
	cmp	si,34
	jne	short M009_@@WARNING_EXIT
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M009_@@CLOSING_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M009_@@CLOSING_CHARACTER
M009_@@CLOSING_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M009_@@CLOSING_CHARACTER:
	mov	ah,0
	mov	si,ax
	jmp	M009_@@SCAN_AFTER_NAME
M009_@@WARNING_EXIT:
	mov	ax,372
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_017D
	dw	seg BCC_RF_15A7_017D
	pop	cx
	jmp	short M009_@@EPILOGUE
M009_@@CHECK_LINE_END:
	cmp	si,10
	je	short M009_@@COMMIT
	cmp	si,13
	je	short M009_@@COMMIT
	cmp	si,26
	je	short M009_@@COMMIT
	jmp	short M009_@@WARNING_EXIT
M009_@@COMMIT:
	or	di,di
	jne	short M009_@@SELECT_MODE
	mov	di,word ptr DGROUP:BCC_DEFAULT_DECLARATION
M009_@@SELECT_MODE:
	cmp	byte ptr DGROUP:BCC_LANGUAGE_MODE,0
	je	short M009_@@MODE_ONE
	mov	ax,2
	jmp	short M009_@@COMMIT_CALL
M009_@@MODE_ONE:
	mov	ax,1
M009_@@COMMIT_CALL:
	push	ax
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	push	di
	db	9Ah
	dw	X056_0D
	dw	seg X056_0D
	jmp	M009_@@COPY_LINE
M009_@@INVALID_IDENTIFIER:
	jmp	short M009_@@WARNING_EXIT
M009_@@PARSE_ERROR:
	push	word ptr DGROUP:BCC_ERROR_CODE
	db	9Ah
	dw	X064_03
	dw	seg X064_03
M009_@@EPILOGUE:
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	mov	ax,si
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret	2
BCC_PARSE_DECLARATION	endp
CO030_TEXT	ends


	extrn	BCC_COMPARE_NAME:far
	extrn	_CTYPE:byte
	extrn	BCC_HANDLER_TABLE:word
	extrn	BCC_OPERATOR_NAME:byte


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_PARSE_DISPATCH	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,4
	push	si
	mov	si,word ptr [bp+4]
	test	byte ptr DGROUP:_CTYPE[si+1],12
	je	short M00A_@@FINISH
	push	si
	nop
	push	cs
	db	0E8h,0C2h,008h
	push	ax
	nop
	push	cs
	db	0E8h,0F5h,00Ah
	mov	si,ax
	mov	word ptr [bp-2],ds
	mov	word ptr [bp-4],offset DGROUP:BCC_HANDLER_TABLE
	jmp	short M00A_@@TEST_HANDLER
M00A_@@TRY_HANDLER:
	push	ds
	mov	ax,offset DGROUP:BCC_OPERATOR_NAME
	push	ax
	push	ds
	les	bx,dword ptr [bp-4]
	push	word ptr es:[bx+2]
	db	9Ah
	dw	BCC_COMPARE_NAME
	dw	seg BCC_COMPARE_NAME
	or	ax,ax
	jne	short M00A_@@NEXT_HANDLER
	push	si
	les	bx,dword ptr [bp-4]
	call	word ptr es:[bx]
	mov	si,ax
	jmp	short M00A_@@FINISH
M00A_@@NEXT_HANDLER:
	add	word ptr [bp-4],4
M00A_@@TEST_HANDLER:
	les	bx,dword ptr [bp-4]
	cmp	word ptr es:[bx+2],0
	jne	short M00A_@@TRY_HANDLER
M00A_@@FINISH:
	push	si
	nop
	push	cs
	db	0E8h,0B8h,00Ch
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret	2
BCC_PARSE_DISPATCH	endp
CO030_TEXT	ends


	extrn	X032_05:far
	extrn	X031_04:far
	extrn	BCC_STRING_WARNING:far
	extrn	BCC_RD_679E_B:byte
	extrn	BCC_RD_828C_W:word
	BCC_RD_7C1E_W	equ	827Ch
		extrn	BCC_RD_8292_W:word
		BCC_RD_921E_W	equ	8292h
		extrn	BCC_RD_8254_W:word
		BCC_RD_541E_W	equ	8254h


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_SCAN_STRING	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	mov	bx,word ptr DGROUP:BCC_RD_541E_W
	mov	byte ptr [bx],0
	jmp	M00B_@@TEST_END
M00B_@@BODY:
	mov	al,byte ptr [bp+4]
	push	ax
	nop
	push	cs
	db	0E8h,055h,00Ah
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M00B_@@FIRST_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M00B_@@FIRST_CHARACTER
M00B_@@FIRST_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M00B_@@FIRST_CHARACTER:
	mov	ah,0
	mov	word ptr [bp+4],ax
	cmp	word ptr [bp+4],92
	jne	short M00B_@@TEST_END
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M00B_@@ESCAPE_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M00B_@@ESCAPE_CHARACTER
M00B_@@ESCAPE_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M00B_@@ESCAPE_CHARACTER:
	mov	ah,0
	mov	word ptr [bp+4],ax
	cmp	word ptr [bp+4],10
	je	short M00B_@@CONTINUATION
	cmp	word ptr [bp+4],13
	jne	short M00B_@@LITERAL_BACKSLASH
M00B_@@CONTINUATION:
	mov	al,byte ptr [bp+4]
	push	ax
	db	9Ah
	dw	X031_04
	dw	seg X031_04
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M00B_@@NEXT_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M00B_@@NEXT_CHARACTER
M00B_@@NEXT_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M00B_@@NEXT_CHARACTER:
	mov	ah,0
	mov	word ptr [bp+4],ax
	jmp	short M00B_@@TEST_END
M00B_@@LITERAL_BACKSLASH:
	mov	al,92
	push	ax
	nop
	push	cs
	db	0E8h,0BEh,009h
M00B_@@TEST_END:
	cmp	word ptr [bp+4],26
	je	short M00B_@@FINISH
	cmp	word ptr [bp+4],10
	je	short M00B_@@FINISH
	cmp	word ptr [bp+4],13
	je	short M00B_@@FINISH
	jmp	M00B_@@BODY
M00B_@@FINISH:
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	mov	ax,8
	push	ax
	db	9Ah
	dw	BCC_STRING_WARNING
	dw	seg BCC_STRING_WARNING
	add	sp,6
	pop	bp
	dec	bp
	ret	2
BCC_SCAN_STRING	endp
CO030_TEXT	ends


	extrn	X032_05:far
	extrn	X031_03:far
	extrn	BCC_STRING_LENGTH:far
	extrn	BCC_STRING_COPY:far
	extrn	BCC_RF_15A7_011B:far
	extrn	X02E_07:far
	extrn	X032_04:far
	extrn	X02E_06:far
	extrn	BCC_RD_8254_W:word
	extrn	BCC_RD_679E_B:byte
	extrn	BCC_RD_828C_W:word
	BCC_RD_7C1E_W	equ	827Ch
	extrn	BCC_RD_779E_B:byte
	BCC_INCLUDE_PATH	equ	1756h
		extrn	BCC_RD_8292_W:word
		BCC_RD_921E_W	equ	8292h
		BCC_RD_920E_W	equ	8292h


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_RN_7000_D3CA	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,6
	push	si
	push	di
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	cmp	word ptr [bp+4],60
	je	short M00C_@@QUOTED
	cmp	word ptr [bp+4],34
	je	short M00C_@@QUOTED
	jmp	M00C_@@UNQUOTED
M00C_@@QUOTED:
	mov	byte ptr DGROUP:BCC_RD_679E_B,0
	cmp	word ptr [bp+4],60
	jne	short M00C_@@DOUBLE_QUOTE
	mov	word ptr [bp-4],62
	jmp	short M00C_@@EMIT_OPEN
M00C_@@DOUBLE_QUOTE:
	mov	word ptr [bp-4],34
M00C_@@EMIT_OPEN:
	mov	al,byte ptr [bp+4]
	push	ax
	nop
	push	cs
	db	0E8h,055h,009h
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M00C_@@BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M00C_@@CHARACTER
M00C_@@BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M00C_@@CHARACTER:
	mov	ah,0
	mov	word ptr [bp+4],ax
	cmp	word ptr [bp+4],26
	je	short M00C_@@QUOTED_DONE
	cmp	word ptr [bp+4],10
	je	short M00C_@@QUOTED_DONE
	cmp	word ptr [bp+4],13
	je	short M00C_@@QUOTED_DONE
	cmp	ax,word ptr [bp-4]
	jne	short M00C_@@EMIT_OPEN
M00C_@@QUOTED_DONE:
	mov	ax,word ptr [bp+4]
	cmp	ax,word ptr [bp-4]
	jne	short M00C_@@RESET_TOKEN
	mov	al,byte ptr [bp+4]
	push	ax
	nop
	push	cs
	db	0E8h,007h,009h
	mov	word ptr [bp+4],32
M00C_@@RESET_TOKEN:
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	push	word ptr [bp+4]
	db	0E8h,00Eh,00Ah
	jmp	short M00C_@@TRIM
M00C_@@UNQUOTED:
	dec	word ptr DGROUP:BCC_RD_920E_W
	xor	ax,ax
	push	ax
	mov	ax,1
	push	ax
	db	9Ah
	dw	X031_03
	dw	seg X031_03
M00C_@@TRIM:
	nop
	push	cs
	db	0E8h,0DDh,000h
	mov	si,ax
	push	ds
	push	si
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	mov	dx,si
	add	dx,ax
	dec	dx
	mov	word ptr [bp-2],dx
	cmp	byte ptr [si],34
	je	short M00C_@@CHECK_DELIMITERS
	cmp	byte ptr [si],60
	je	short M00C_@@CHECK_DELIMITERS
	mov	ax,17
M00C_@@WARN:
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
	jmp	M00C_@@EPILOGUE
M00C_@@CHECK_DELIMITERS:
	cmp	byte ptr [si],34
	jne	short M00C_@@CHECK_ANGLE
	mov	bx,word ptr [bp-2]
	cmp	byte ptr [bx],34
	jne	short M00C_@@BAD_DELIMITER
M00C_@@CHECK_ANGLE:
	cmp	byte ptr [si],60
	jne	short M00C_@@DELIMITERS_OK
	mov	bx,word ptr [bp-2]
	cmp	byte ptr [bx],62
	je	short M00C_@@DELIMITERS_OK
M00C_@@BAD_DELIMITER:
	mov	ax,58
	jmp	short M00C_@@WARN
M00C_@@DELIMITERS_OK:
	mov	al,byte ptr [si]
	cbw
	mov	word ptr [bp-4],ax
	mov	bx,word ptr [bp-2]
	mov	byte ptr [bx],0
	inc	si
	push	ds
	push	si
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	mov	word ptr [bp-6],ax
	cmp	word ptr [bp-6],80
	jle	short M00C_@@LENGTH_OK
	mov	ax,48
	jmp	short M00C_@@WARN
M00C_@@LENGTH_OK:
	mov	ax,word ptr [bp-6]
	inc	ax
	mov	dx,offset DGROUP:BCC_RD_779E_B
	sub	dx,ax
	mov	di,dx
	push	ds
	push	di
	push	ds
	push	si
	db	9Ah
	dw	BCC_STRING_COPY
	dw	seg BCC_STRING_COPY
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	push	ds
	push	di
	db	9Ah
	dw	BCC_STRING_COPY
	dw	seg BCC_STRING_COPY
	cmp	word ptr [bp-4],34
	je	short M00C_@@TRY_INCLUDE
	cmp	byte ptr [di+1],58
	je	short M00C_@@TRY_INCLUDE
	cmp	byte ptr [di],47
	je	short M00C_@@TRY_INCLUDE
	cmp	byte ptr [di],92
	je	short M00C_@@TRY_INCLUDE
	les	bx,dword ptr DGROUP:BCC_INCLUDE_PATH
	cmp	byte ptr es:[bx],0
	jne	short M00C_@@TRY_DIRECT
M00C_@@TRY_INCLUDE:
	push	ds
	push	di
	db	9Ah
	dw	X032_04
	dw	seg X032_04
	or	ax,ax
	je	short M00C_@@TRY_DIRECT
	jmp	short M00C_@@CLOSE_PATH
M00C_@@TRY_DIRECT:
	push	ds
	push	di
	db	9Ah
	dw	X02E_07
	dw	seg X02E_07
	or	ax,ax
	jne	short M00C_@@CLOSE_PATH
	push	ds
	push	di
	mov	ax,57
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	add	sp,6
M00C_@@CLOSE_PATH:
	db	9Ah
	dw	X02E_06
	dw	seg X02E_06
M00C_@@EPILOGUE:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret	2
BCC_RN_7000_D3CA	endp
CO030_TEXT	ends


	extrn	BCC_STRING_LENGTH:far
		extrn	BCC_RD_9E3E_B:byte
		extrn	BCC_RD_679E_B:byte
		extrn	BCC_RD_679D_B:byte
		extrn	BCC_RD_9EFE_B:byte
		extrn	BCC_RD_9EBE_B:byte


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

		public	X030_08
X030_08	label	far
BCC_TOKEN_TRIM	proc	far
	push	bp
	mov	bp,sp
	push	si
	cmp	byte ptr DGROUP:BCC_RD_9E3E_B,0
	jne	short M00D_@@NONEMPTY
	mov	ax,offset DGROUP:BCC_RD_679E_B
	jmp	short M00D_@@EPILOGUE
M00D_@@NONEMPTY:
	push	ds
	mov	ax,offset DGROUP:BCC_RD_679E_B
	push	ax
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	add	ax,offset DGROUP:BCC_RD_679D_B-1
	mov	si,ax
	jmp	short M00D_@@TRAILING_TEST
M00D_@@TRAILING_BODY:
	cmp	byte ptr [si],32
	je	short M00D_@@TRIM_CHARACTER
	cmp	byte ptr [si],9
	je	short M00D_@@TRIM_CHARACTER
	cmp	byte ptr [si],251
	jne	short M00D_@@LEADING_START
M00D_@@TRIM_CHARACTER:
	mov	byte ptr [si],0
	dec	si
M00D_@@TRAILING_TEST:
	cmp	si,offset DGROUP:BCC_RD_9EFE_B
	jnc	short M00D_@@TRAILING_BODY
M00D_@@LEADING_START:
	mov	si,offset DGROUP:BCC_RD_9EBE_B
	jmp	short M00D_@@LEADING_TEST
M00D_@@LEADING_BODY:
	inc	si
M00D_@@LEADING_TEST:
	cmp	byte ptr [si],32
	je	short M00D_@@LEADING_BODY
	cmp	byte ptr [si],9
	je	short M00D_@@LEADING_BODY
	mov	ax,si
M00D_@@EPILOGUE:
	pop	si
	pop	bp
	retf
BCC_TOKEN_TRIM	endp
CO030_TEXT	ends


	extrn	X031_0C:far
	extrn	BCC_STRING_COPY:far
	extrn	BCC_STRING_LENGTH:far
	extrn	BCC_COMPARE_NAME:far
	extrn	X043_02:far
	extrn	X033_03:far
	extrn	X031_03:far
	extrn	BCC_RF_15A7_011B:far
	extrn	_CTYPE:byte
	extrn	BCC_NAME_BUFFER:byte
	extrn	BCC_MACRO_COUNT:word
	extrn	BCC_RD_679E_B:byte
	extrn	BCC_MACRO_DIAGNOSTIC:byte
	BCC_RD_920E_W	equ	8292h
		BCC_RD_423E_W	equ	8242h
		extrn	BCC_RD_8242_W:word
		extrn	BCC_RD_823E_W:word
		BCC_RD_3E06_W	equ	823Eh
		extrn	BCC_RD_8254_W:word
		BCC_RD_541E_W	equ	8254h


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_PARSE_MACRO	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,46
	push	si
	push	di
	mov	si,word ptr [bp+4]
	mov	al,byte ptr DGROUP:_CTYPE[si+1]
	cbw
	test	ax,12
	jne	short M00E_@@VALID_IDENTIFIER
	cmp	si,95
	je	short M00E_@@VALID_IDENTIFIER
	mov	ax,32
M00E_@@WARNING_ONE:
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
	push	si
	nop
	push	cs
	db	0E8h,0C6h,009h
	jmp	M00E_@@EPILOGUE
M00E_@@VALID_IDENTIFIER:
	push	si
	nop
	push	cs
	db	0E8h,080h,005h
	mov	si,ax
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_BUFFER
	push	ax
	db	9Ah
	dw	X031_0C
	dw	seg X031_0C
	or	ax,ax
	je	short M00E_@@COPY_NAME
	mov	ax,32
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
M00E_@@COPY_NAME:
	push	ss
	lea	ax,[bp-46]
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_BUFFER
	push	ax
	db	9Ah
	dw	BCC_STRING_COPY
	dw	seg BCC_STRING_COPY
	mov	word ptr [bp-4],-1
	push	ds
	mov	ax,offset DGROUP:BCC_RD_823E_W
	push	ax
	xor	ax,ax
	push	ax
	db	9Ah
	dw	X043_02
	dw	seg X043_02
	mov	word ptr [bp-2],ax
	cmp	si,40
	je	short M00E_@@PARAMETERS
	dec	word ptr DGROUP:BCC_RD_920E_W
M00E_@@EMPTY_PARAMETERS:
	xor	ax,ax
	push	ax
	push	ax
	db	9Ah
	dw	X031_03
	dw	seg X031_03
	jmp	M00E_@@TRIM_TOKEN
M00E_@@PARAMETERS:
	mov	word ptr [bp-4],0
	mov	ax,32
	push	ax
	nop
	push	cs
	db	0E8h,058h,007h
	mov	si,ax
	cmp	si,41
	jne	short M00E_@@PARAMETER_IDENTIFIER
	jmp	short M00E_@@EMPTY_PARAMETERS
M00E_@@PARAMETER_IDENTIFIER:
	mov	al,byte ptr DGROUP:_CTYPE[si+1]
	cbw
	test	ax,12
	jne	short M00E_@@READ_PARAMETER
	cmp	si,95
	je	short M00E_@@READ_PARAMETER
	mov	ax,15
	jmp	M00E_@@WARNING_ONE
M00E_@@READ_PARAMETER:
	push	si
	nop
	push	cs
	db	0E8h,0FBh,004h
	mov	si,ax
	mov	di,word ptr [bp-2]
	jmp	short M00E_@@DUPLICATE_TEST
M00E_@@DUPLICATE_BODY:
	push	word ptr DGROUP:BCC_RD_823E_W
	push	di
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_BUFFER
	push	ax
	db	9Ah
	dw	BCC_COMPARE_NAME
	dw	seg BCC_COMPARE_NAME
	or	ax,ax
	jne	short M00E_@@NEXT_PARAMETER
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_BUFFER
	push	ax
	mov	ax,173
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	add	sp,6
	jmp	short M00E_@@STORE_PARAMETER
M00E_@@NEXT_PARAMETER:
	push	word ptr DGROUP:BCC_RD_823E_W
	push	di
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	inc	ax
	add	di,ax
M00E_@@DUPLICATE_TEST:
	cmp	di,word ptr DGROUP:BCC_RD_423E_W
	jc	short M00E_@@DUPLICATE_BODY
M00E_@@STORE_PARAMETER:
	push	ds
	mov	ax,offset DGROUP:BCC_RD_823E_W
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_BUFFER
	push	ax
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	inc	ax
	push	ax
	db	9Ah
	dw	X043_02
	dw	seg X043_02
	mov	di,ax
	push	word ptr DGROUP:BCC_RD_823E_W
	push	di
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_BUFFER
	push	ax
	db	9Ah
	dw	BCC_STRING_COPY
	dw	seg BCC_STRING_COPY
	inc	word ptr [bp-4]
	push	si
	nop
	push	cs
	db	0E8h,0C4h,006h
	mov	si,ax
	cmp	si,41
	je	short M00E_@@PARAMETERS_DONE
	cmp	si,44
	je	short M00E_@@PARAMETER_COMMA
	mov	ax,13
	jmp	M00E_@@WARNING_ONE
M00E_@@PARAMETER_COMMA:
	mov	ax,32
	push	ax
	nop
	push	cs
	db	0E8h,0A9h,006h
	mov	si,ax
	jmp	M00E_@@PARAMETER_IDENTIFIER
M00E_@@PARAMETERS_DONE:
	mov	ax,32
	push	ax
	nop
	push	cs
	db	0E8h,09Bh,006h
	mov	si,ax
M00E_@@AFTER_PARAMETERS:
	dec	word ptr DGROUP:BCC_RD_920E_W
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	mov	bx,word ptr DGROUP:BCC_RD_541E_W
	mov	byte ptr [bx],0
	push	ds
	mov	ax,offset DGROUP:BCC_RD_823E_W
	push	ax
	mov	ax,1
	push	ax
	db	9Ah
	dw	X043_02
	dw	seg X043_02
	mov	di,ax
	mov	es,word ptr DGROUP:BCC_RD_3E06_W
	mov	byte ptr es:[di],0
	push	word ptr [bp-2]
	xor	ax,ax
	push	ax
	db	9Ah
	dw	X031_03
	dw	seg X031_03
	mov	word ptr [bp-6],ds
	mov	word ptr [bp-8],offset DGROUP:BCC_RD_679E_B
	jmp	short M00E_@@MARKER_TEST
M00E_@@MARKER_BODY:
	les	bx,dword ptr [bp-8]
	cmp	byte ptr es:[bx],253
	jne	short M00E_@@NEXT_MARKER
	test	byte ptr es:[bx+1],128
	je	short M00E_@@MARKER_WARNING
	cmp	byte ptr es:[bx+1],251
	jc	short M00E_@@NEXT_MARKER
M00E_@@MARKER_WARNING:
	push	ds
	mov	ax,offset DGROUP:BCC_MACRO_DIAGNOSTIC
	push	ax
	mov	ax,89
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	add	sp,6
	jmp	short M00E_@@TRIM_TOKEN
M00E_@@NEXT_MARKER:
	inc	word ptr [bp-8]
M00E_@@MARKER_TEST:
	les	bx,dword ptr [bp-8]
	cmp	byte ptr es:[bx],0
	jne	short M00E_@@MARKER_BODY
M00E_@@TRIM_TOKEN:
	push	cs
	db	0E8h,0E5h,0FDh
	mov	word ptr [bp-6],ds
	mov	word ptr [bp-8],ax
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	mov	dx,word ptr [bp-6]
	mov	bx,word ptr [bp-8]
	add	bx,ax
	mov	word ptr [bp-10],dx
	mov	word ptr [bp-12],bx
	mov	ax,word ptr [bp-8]
	inc	ax
	cmp	ax,word ptr [bp-12]
	jnc	short M00E_@@CHECK_FIRST_MARKER
	mov	es,word ptr [bp-10]
	cmp	byte ptr es:[bx-1],254
	jne	short M00E_@@CHECK_FIRST_MARKER
	jmp	short M00E_@@MARKER_ERROR
M00E_@@CHECK_FIRST_MARKER:
	les	bx,dword ptr [bp-8]
	cmp	byte ptr es:[bx],254
	jne	short M00E_@@TERMINATE_BODY
M00E_@@MARKER_ERROR:
	push	ds
	mov	ax,offset DGROUP:BCC_MACRO_DIAGNOSTIC
	push	ax
	mov	ax,89
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	add	sp,6
M00E_@@TERMINATE_BODY:
	les	bx,dword ptr [bp-12]
	mov	byte ptr es:[bx],251
	inc	word ptr [bp-12]
	les	bx,dword ptr [bp-12]
	mov	byte ptr es:[bx],0
	push	ss
	lea	ax,[bp-46]
	push	ax
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	mov	al,byte ptr [bp-4]
	push	ax
	push	word ptr [bp-2]
	db	9Ah
	dw	X033_03
	dw	seg X033_03
	mov	word ptr DGROUP:BCC_MACRO_COUNT,0
	mov	ax,word ptr [bp-2]
	mov	word ptr DGROUP:BCC_RD_8242_W,ax
M00E_@@EPILOGUE:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret	2
BCC_PARSE_MACRO	endp
CO030_TEXT	ends


	extrn	X031_0C:far
	extrn	X033_01:far
	extrn	BCC_RF_15A7_011B:far
	extrn	_CTYPE:byte
	extrn	BCC_NAME_BUFFER:byte


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_PARSE_UNDEF	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	mov	si,word ptr [bp+4]
	mov	al,byte ptr DGROUP:_CTYPE[si+1]
	cbw
	test	ax,12
	jne	short M00F_@@VALID_IDENTIFIER
	cmp	si,95
	je	short M00F_@@VALID_IDENTIFIER
	mov	ax,88
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
	push	si
	nop
	push	cs
	db	0E8h,073h,007h
	jmp	short M00F_@@EPILOGUE
M00F_@@VALID_IDENTIFIER:
	push	si
	nop
	push	cs
	db	0E8h,02Eh,003h
	push	ax
	db	0E8h,041h,006h
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_BUFFER
	push	ax
	db	9Ah
	dw	X031_0C
	dw	seg X031_0C
	or	ax,ax
	je	short M00F_@@REMOVE
	mov	ax,88
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
M00F_@@REMOVE:
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_BUFFER
	push	ax
	db	9Ah
	dw	X033_01
	dw	seg X033_01
M00F_@@EPILOGUE:
	pop	si
	pop	bp
	dec	bp
	ret	2
BCC_PARSE_UNDEF	endp
CO030_TEXT	ends


	extrn	X043_02:far
	extrn	BCC_RD_77D3_W:word
	extrn	BCC_RD_8234_W:word
		extrn	BCC_RD_8258_W:word
		extrn	BCC_RD_5806_W:word


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_SAVE_LINE_MARKER	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	push	ds
	mov	ax,offset DGROUP:BCC_RD_8258_W
	push	ax
	mov	ax,4
	push	ax
	db	9Ah
	dw	X043_02
	dw	seg X043_02
	mov	si,ax
	mov	es,word ptr DGROUP:BCC_RD_5806_W
	mov	ax,word ptr [bp+4]
	mov	word ptr es:[si],ax
	mov	ax,word ptr DGROUP:BCC_RD_77D3_W
	mov	word ptr es:[si+2],ax
	mov	ax,si
	add	ax,4
	mov	word ptr DGROUP:BCC_RD_8234_W,ax
	pop	si
	pop	bp
	dec	bp
	ret	2
BCC_SAVE_LINE_MARKER	endp
CO030_TEXT	ends


	extrn	BCC_EVAL_EXPRESSION:dword
	BCC_RD_920E_W	equ	8292h
	extrn	BCC_CONDITION_VALUE:word
	extrn	BCC_CONDITION_AUX:word
	BCC_DIRECTIVE_MODE	equ	8232h


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_PARSE_CONDITIONAL	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	mov	si,word ptr [bp+4]
	dec	word ptr DGROUP:BCC_RD_920E_W
	db	0FFh,01Eh
	dw	BCC_EVAL_EXPRESSION
	mov	si,ax
	dec	word ptr DGROUP:BCC_RD_920E_W
	or	si,si
	je	short M011_@@DEFAULT_MARKER
	mov	ax,word ptr DGROUP:BCC_CONDITION_VALUE
	or	ax,word ptr DGROUP:BCC_CONDITION_AUX
	je	short M011_@@DEFAULT_MARKER
	jmp	short M011_@@MARKER_ONE
M011_@@DEFAULT_MARKER:
	mov	ax,1
	push	ax
	xor	ax,ax
	push	ax
	db	0E8h,00Dh,003h
	cmp	word ptr DGROUP:BCC_DIRECTIVE_MODE,8
	jne	short M011_@@CHECK_MODE_TEN
	mov	ax,2
	jmp	short M011_@@SAVE_MARKER
M011_@@CHECK_MODE_TEN:
	cmp	word ptr DGROUP:BCC_DIRECTIVE_MODE,10
	jne	short M011_@@EPILOGUE
M011_@@MARKER_ONE:
	mov	ax,1
M011_@@SAVE_MARKER:
	push	ax
	db	0E8h,083h,0FFh
M011_@@EPILOGUE:
	pop	si
	pop	bp
	dec	bp
	ret	2
BCC_PARSE_CONDITIONAL	endp
CO030_TEXT	ends


	extrn	X033_00:far
	extrn	BCC_RF_15A7_011B:far
	extrn	_CTYPE:byte
	extrn	BCC_NAME_BUFFER:byte
	BCC_DIRECTIVE_MODE	equ	8232h


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_PARSE_IFDEF	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	si,word ptr [bp+6]
	mov	di,word ptr [bp+4]
	mov	al,byte ptr DGROUP:_CTYPE[si+1]
	cbw
	test	ax,12
	jne	short M012_@@VALID_IDENTIFIER
	cmp	si,95
	je	short M012_@@VALID_IDENTIFIER
	or	di,di
	je	short M012_@@IFNDEF_WARNING
	mov	ax,53
	jmp	short M012_@@WARN
M012_@@IFNDEF_WARNING:
	mov	ax,54
M012_@@WARN:
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
	push	si
	nop
	push	cs
	db	0E8h,088h,006h
	jmp	short M012_@@MARKER_ONE
M012_@@VALID_IDENTIFIER:
	push	si
	nop
	push	cs
	db	0E8h,043h,002h
	push	ax
	db	0E8h,056h,005h
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_BUFFER
	push	ax
	db	9Ah
	dw	X033_00
	dw	seg X033_00
	cmp	ax,di
	jne	short M012_@@SCAN_CONDITIONAL
	jmp	short M012_@@MARKER_ONE
M012_@@SCAN_CONDITIONAL:
	mov	ax,1
	push	ax
	xor	ax,ax
	push	ax
	db	0E8h,093h,002h
	cmp	word ptr DGROUP:BCC_DIRECTIVE_MODE,8
	jne	short M012_@@CHECK_MODE_TEN
	mov	ax,2
	jmp	short M012_@@SAVE_MARKER
M012_@@CHECK_MODE_TEN:
	cmp	word ptr DGROUP:BCC_DIRECTIVE_MODE,10
	jne	short M012_@@EPILOGUE
M012_@@MARKER_ONE:
	mov	ax,1
M012_@@SAVE_MARKER:
	push	ax
	db	0E8h,009h,0FFh
M012_@@EPILOGUE:
	pop	di
	pop	si
	pop	bp
	dec	bp
	ret	4
BCC_PARSE_IFDEF	endp
CO030_TEXT	ends



CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP
BCC_NEAR_D95A	label	near

BCC_PARSE_IF	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	word ptr [bp+4]
	mov	ax,1
	push	ax
	db	0E8h,077h,0FFh
	pop	bp
	dec	bp
	ret	2
BCC_PARSE_IF	endp
CO030_TEXT	ends


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP
BCC_NEAR_D96D	label	near

BCC_PARSE_IFN	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	word ptr [bp+4]
	xor	ax,ax
	push	ax
	db	0E8h,065h,0FFh
	pop	bp
	dec	bp
	ret	2
BCC_PARSE_IFN	endp
CO030_TEXT	ends

	extrn	BCC_RF_15A7_011B:far
	extrn	BCC_RD_5806_W:word
	extrn	BCC_CONDITION_STATE:word
	extrn	BCC_CONDITION_MARK:word
		extrn	BCC_RD_343E_W:word
		extrn	BCC_RD_341E_W:word
		extrn	BCC_RD_342E_W:word
		extrn	BCC_RD_8234_W:word


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_PARSE_ELSE	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	mov	si,word ptr [bp+4]
	cmp	word ptr DGROUP:BCC_RD_343E_W,0
	je	short M015_@@INVALID_ELSE
	mov	bx,word ptr DGROUP:BCC_RD_341E_W
	mov	es,word ptr DGROUP:BCC_RD_5806_W
	cmp	word ptr es:[bx-4],1
	jne	short M015_@@INVALID_ELSE
	push	si
	db	0E8h,0D4h,004h
	xor	ax,ax
	push	ax
	push	ax
	db	0E8h,024h,002h
	sub	word ptr DGROUP:BCC_RD_342E_W,4
	mov	word ptr DGROUP:BCC_CONDITION_STATE,0
	mov	ax,word ptr DGROUP:BCC_RD_8234_W
	mov	word ptr DGROUP:BCC_CONDITION_MARK,ax
	jmp	short M015_@@EPILOGUE
M015_@@INVALID_ELSE:
	push	si
	nop
	push	cs
	db	0E8h,0DAh,005h
	mov	ax,38
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
M015_@@EPILOGUE:
	pop	si
	pop	bp
	dec	bp
	ret	2
BCC_PARSE_ELSE	endp
CO030_TEXT	ends


	extrn	BCC_RF_15A7_011B:far
	extrn	BCC_RD_5806_W:word
	BCC_DIRECTIVE_MODE	equ	8232h
	extrn	BCC_CONDITION_STATE:word
	extrn	BCC_CONDITION_MARK:word
		extrn	BCC_RD_343E_W:word
		extrn	BCC_RD_341E_W:word
		extrn	BCC_RD_342E_W:word
		extrn	BCC_RD_8234_W:word


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_PARSE_ELIF	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	mov	si,word ptr [bp+4]
	cmp	word ptr DGROUP:BCC_RD_343E_W,0
	je	short M016_@@INVALID_ELIF
	mov	bx,word ptr DGROUP:BCC_RD_341E_W
	mov	es,word ptr DGROUP:BCC_RD_5806_W
	cmp	word ptr es:[bx-4],1
	jne	short M016_@@INVALID_ELIF
	push	si
	nop
	push	cs
	db	0E8h,0A6h,005h
M016_@@SCAN_NESTED:
	mov	ax,1
	push	ax
	push	ax
	db	0E8h,0CFh,001h
	cmp	word ptr DGROUP:BCC_DIRECTIVE_MODE,10
	je	short M016_@@SCAN_NESTED
	cmp	word ptr DGROUP:BCC_DIRECTIVE_MODE,8
	je	short M016_@@SCAN_NESTED
	sub	word ptr DGROUP:BCC_RD_342E_W,4
	mov	word ptr DGROUP:BCC_CONDITION_STATE,0
	mov	ax,word ptr DGROUP:BCC_RD_8234_W
	mov	word ptr DGROUP:BCC_CONDITION_MARK,ax
	jmp	short M016_@@EPILOGUE
M016_@@INVALID_ELIF:
	push	si
	nop
	push	cs
	db	0E8h,077h,005h
	mov	ax,37
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
M016_@@EPILOGUE:
	pop	si
	pop	bp
	dec	bp
	ret	2
BCC_PARSE_ELIF	endp
CO030_TEXT	ends


	extrn	BCC_RF_15A7_011B:far
	extrn	BCC_CONDITION_STATE:word
	extrn	BCC_CONDITION_MARK:word
		extrn	BCC_RD_343E_W:word
		extrn	BCC_RD_342E_W:word
		extrn	BCC_RD_8234_W:word


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_PARSE_ENDIF	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	cmp	word ptr DGROUP:BCC_RD_343E_W,0
	je	short M017_@@INVALID_ENDIF
	sub	word ptr DGROUP:BCC_RD_342E_W,4
	mov	word ptr DGROUP:BCC_CONDITION_STATE,0
	mov	ax,word ptr DGROUP:BCC_RD_8234_W
	mov	word ptr DGROUP:BCC_CONDITION_MARK,ax
	jmp	short M017_@@FINISH_LINE
M017_@@INVALID_ENDIF:
	mov	ax,39
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
M017_@@FINISH_LINE:
	push	word ptr [bp+4]
	db	0E8h,013h,004h
	pop	bp
	dec	bp
	ret	2
BCC_PARSE_ENDIF	endp
CO030_TEXT	ends


	extrn	X031_03:far
	extrn	BCC_STRING_LENGTH:far
	extrn	BCC_RF_1AAA_0008:far
	extrn	BCC_STRING_COPY:far
	extrn	X043_02:far
	extrn	BCC_RF_15A7_011B:far
	extrn	_CTYPE:byte
	extrn	BCC_RD_8254_W:word
	extrn	BCC_RD_679E_B:byte
	BCC_RD_920E_W	equ	8292h
	extrn	BCC_LINE_DIAGNOSTIC:byte
	extrn	BCC_FILENAME_POOL:word
	extrn	BCC_SOURCE_NAME:word
	extrn	BCC_RD_77D3_W:word
	extrn	BCC_OUTPUT_LINE:word


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_PARSE_LINE	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	push	si
	push	di
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	dec	word ptr DGROUP:BCC_RD_920E_W
	xor	ax,ax
	push	ax
	mov	ax,1
	push	ax
	db	9Ah
	dw	X031_03
	dw	seg X031_03
	mov	word ptr DGROUP:BCC_RD_8254_W,offset DGROUP:BCC_RD_679E_B
	push	cs
	db	0E8h,0CCh,0FAh
	mov	si,ax
	mov	word ptr [bp-2],0
	mov	al,byte ptr [si]
	cbw
	mov	bx,ax
	mov	al,byte ptr DGROUP:_CTYPE[bx+1]
	cbw
	test	ax,2
	jne	short M018_@@DIGIT_TEST
	push	ds
	mov	ax,offset DGROUP:BCC_LINE_DIAGNOSTIC
	push	ax
	mov	ax,89
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	add	sp,6
	jmp	M018_@@EPILOGUE
M018_@@DIGIT_BODY:
	mov	ax,word ptr [bp-2]
	mov	dx,10
	imul	dx
	push	ax
	mov	al,byte ptr [si]
	cbw
	pop	dx
	add	dx,ax
	add	dx,-48
	mov	word ptr [bp-2],dx
	inc	si
M018_@@DIGIT_TEST:
	mov	al,byte ptr [si]
	cbw
	mov	bx,ax
	mov	al,byte ptr DGROUP:_CTYPE[bx+1]
	cbw
	test	ax,2
	jne	short M018_@@DIGIT_BODY
	jmp	short M018_@@SPACE_TEST
M018_@@SPACE_BODY:
	inc	si
M018_@@SPACE_TEST:
	cmp	byte ptr [si],32
	je	short M018_@@SPACE_BODY
	cmp	byte ptr [si],0
	je	short M018_@@SET_LINE
	push	ds
	push	si
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	mov	dx,si
	add	dx,ax
	dec	dx
	mov	di,dx
	cmp	byte ptr [si],34
	jne	short M018_@@BAD_FILENAME
	cmp	byte ptr [di],34
	je	short M018_@@QUOTED_FILENAME
M018_@@BAD_FILENAME:
	mov	ax,17
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
	jmp	short M018_@@EPILOGUE
M018_@@QUOTED_FILENAME:
	inc	si
	mov	byte ptr [di],0
	push	word ptr DGROUP:BCC_FILENAME_POOL
	push	word ptr DGROUP:BCC_SOURCE_NAME
	push	ds
	push	si
	db	9Ah
	dw	BCC_RF_1AAA_0008
	dw	seg BCC_RF_1AAA_0008
	or	ax,ax
	je	short M018_@@SET_LINE
	push	ds
	mov	ax,offset DGROUP:BCC_FILENAME_POOL
	push	ax
	push	ds
	push	si
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	inc	ax
	push	ax
	db	9Ah
	dw	X043_02
	dw	seg X043_02
	mov	word ptr DGROUP:BCC_SOURCE_NAME,ax
	push	word ptr DGROUP:BCC_FILENAME_POOL
	push	word ptr DGROUP:BCC_SOURCE_NAME
	push	ds
	push	si
	db	9Ah
	dw	BCC_STRING_COPY
	dw	seg BCC_STRING_COPY
M018_@@SET_LINE:
	mov	ax,word ptr [bp-2]
	dec	ax
	mov	word ptr DGROUP:BCC_RD_77D3_W,ax
	mov	word ptr DGROUP:BCC_OUTPUT_LINE,ax
M018_@@EPILOGUE:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret	2
BCC_READ_NAME	label	near
BCC_PARSE_LINE	endp
CO030_TEXT	ends

; Original-target semantic aliases (zero bytes)

	extrn	X032_05:far
	extrn	_CTYPE:byte
	extrn	BCC_NAME_BUFFER:byte
	extrn	BCC_RD_16FB_B:byte
	extrn	BCC_RD_828C_W:word
	BCC_RD_7C1E_W	equ	827Ch
		extrn	BCC_RD_8292_W:word
		BCC_RD_921E_W	equ	8292h


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

		public	X030_07
X030_07	label	far
BCC_SCAN_TOKEN	proc	far
	push	bp
	mov	bp,sp
	sub	sp,4
	mov	word ptr [bp-2],ds
	mov	word ptr [bp-4],offset DGROUP:BCC_NAME_BUFFER
	jmp	short M019_@@TEST
M019_@@BODY:
	mov	al,byte ptr DGROUP:BCC_RD_16FB_B
	cbw
	add	ax,offset DGROUP:BCC_NAME_BUFFER
	cmp	ax,word ptr [bp-4]
	jbe	short M019_@@READ_NEXT
	les	bx,dword ptr [bp-4]
	mov	al,byte ptr [bp+6]
	mov	byte ptr es:[bx],al
	inc	word ptr [bp-4]
M019_@@READ_NEXT:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M019_@@BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M019_@@CHARACTER
M019_@@BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M019_@@CHARACTER:
	mov	ah,0
	mov	word ptr [bp+6],ax
M019_@@TEST:
	mov	bx,word ptr [bp+6]
	test	byte ptr DGROUP:_CTYPE[bx+1],14
	jne	short M019_@@BODY
	cmp	word ptr [bp+6],95
	je	short M019_@@BODY
	les	bx,dword ptr [bp-4]
	mov	byte ptr es:[bx],0
	mov	ax,word ptr [bp+6]
	mov	sp,bp
	pop	bp
	retf	2
BCC_SCAN_TOKEN	endp
CO030_TEXT	ends


	extrn	BCC_DIRECTIVE_DECODE:near
	extrn	BCC_EVAL_EXPRESSION:dword
	extrn	X032_05:far
	extrn	X031_04:far
	extrn	BCC_RF_15A7_011B:far
	extrn	BCC_RD_77D3_W:word
	extrn	BCC_RD_828C_W:word
	BCC_RD_7C1E_W	equ	827Ch
	BCC_DIRECTIVE_MODE	equ	8232h
	extrn	BCC_CONDITION_VALUE:word
	extrn	BCC_CONDITION_AUX:word
		extrn	BCC_RD_8292_W:word
		BCC_RD_921E_W	equ	8292h
		BCC_RD_920E_W	equ	8292h


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_CONDITIONAL_SCAN	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,4
	push	si
	push	di
	mov	di,word ptr [bp+6]
	mov	ax,word ptr DGROUP:BCC_RD_77D3_W
	mov	word ptr [bp-4],ax
	xor	si,si
M01A_@@NEXT_LINE:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M01A_@@INITIAL_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M01A_@@INITIAL_CHARACTER
M01A_@@INITIAL_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M01A_@@INITIAL_CHARACTER:
	mov	ah,0
	push	ax
	nop
	push	cs
	db	0E8h,08Eh,001h
	mov	word ptr [bp-2],ax
	cmp	word ptr [bp-2],26
	jne	short M01A_@@CHECK_DIRECTIVE
	push	word ptr [bp-4]
	mov	ax,42
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
	pop	cx
	jmp	M01A_@@EPILOGUE
M01A_@@CHECK_DIRECTIVE:
	cmp	word ptr [bp-2],35
	je	short M01A_@@DIRECTIVE
	jmp	M01A_@@SKIP_LINE
M01A_@@DIRECTIVE:
	xor	ax,ax
	push	ax
	push	cs
	db	0E8h,01Ch,0F0h
	cmp	word ptr DGROUP:BCC_DIRECTIVE_MODE,7
	je	short M01A_@@ENTER_CONDITIONAL
	cmp	word ptr DGROUP:BCC_DIRECTIVE_MODE,4
	je	short M01A_@@ENTER_CONDITIONAL
	cmp	word ptr DGROUP:BCC_DIRECTIVE_MODE,5
	jne	short M01A_@@CHECK_ENDIF
M01A_@@ENTER_CONDITIONAL:
	inc	si
	jmp	short M01A_@@READ_DIRECTIVE_CHAR
M01A_@@CHECK_ENDIF:
	cmp	word ptr DGROUP:BCC_DIRECTIVE_MODE,6
	jne	short M01A_@@CHECK_ELSE
	jmp	short M01A_@@LEAVE_CONDITIONAL
M01A_@@CHECK_ELSE:
	cmp	word ptr DGROUP:BCC_DIRECTIVE_MODE,8
	jne	short M01A_@@CHECK_ELIF
	or	si,si
	jne	short M01A_@@CHECK_ELIF
	or	di,di
	je	short M01A_@@UNEXPECTED_ELSE
	cmp	word ptr [bp+4],0
	jne	short M01A_@@CLEAR_ELSE
M01A_@@LEAVE_CONDITIONAL:
	dec	si
	jmp	short M01A_@@READ_DIRECTIVE_CHAR
M01A_@@CLEAR_ELSE:
	xor	di,di
	jmp	short M01A_@@READ_DIRECTIVE_CHAR
M01A_@@UNEXPECTED_ELSE:
	mov	ax,38
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
	jmp	short M01A_@@READ_DIRECTIVE_CHAR
M01A_@@CHECK_ELIF:
	cmp	word ptr DGROUP:BCC_DIRECTIVE_MODE,10
	jne	short M01A_@@READ_DIRECTIVE_CHAR
	or	si,si
	jne	short M01A_@@READ_DIRECTIVE_CHAR
	or	di,di
	jne	short M01A_@@EVALUATE_ELIF
	mov	ax,37
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
	jmp	short M01A_@@READ_DIRECTIVE_CHAR
M01A_@@EVALUATE_ELIF:
	cmp	word ptr [bp+4],0
	jne	short M01A_@@READ_DIRECTIVE_CHAR
	dec	word ptr DGROUP:BCC_RD_920E_W
	db	0FFh,01Eh
	dw	BCC_EVAL_EXPRESSION
	or	ax,ax
	jne	short M01A_@@CHECK_ELIF_VALUE
	jmp	M01A_@@NEXT_LINE
M01A_@@CHECK_ELIF_VALUE:
	mov	ax,word ptr DGROUP:BCC_CONDITION_VALUE
	or	ax,word ptr DGROUP:BCC_CONDITION_AUX
	jne	short M01A_@@STOP
	jmp	M01A_@@NEXT_LINE
M01A_@@STOP:
	jmp	short M01A_@@REWIND
M01A_@@READ_DIRECTIVE_CHAR:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M01A_@@DIRECTIVE_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M01A_@@DIRECTIVE_CHARACTER
M01A_@@DIRECTIVE_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M01A_@@DIRECTIVE_CHARACTER:
	mov	ah,0
	mov	word ptr [bp-2],ax
M01A_@@SKIP_LINE:
	push	word ptr [bp-2]
	nop
	push	cs
	db	0E8h,0B3h,002h
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M01A_@@LINE_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M01A_@@LINE_CHARACTER
M01A_@@LINE_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M01A_@@LINE_CHARACTER:
	mov	ah,0
	mov	word ptr [bp-2],ax
	or	si,si
	jl	short M01A_@@REWIND
	cmp	word ptr [bp-2],10
	je	short M01A_@@UNGET_LINE
	cmp	word ptr [bp-2],13
	je	short M01A_@@UNGET_LINE
	jmp	M01A_@@NEXT_LINE
M01A_@@UNGET_LINE:
	mov	al,byte ptr [bp-2]
	push	ax
	db	9Ah
	dw	X031_04
	dw	seg X031_04
	jmp	M01A_@@NEXT_LINE
M01A_@@REWIND:
	dec	word ptr DGROUP:BCC_RD_920E_W
M01A_@@EPILOGUE:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret	4
BCC_CONDITIONAL_SCAN	endp
CO030_TEXT	ends

	extrn	BCC_TOKEN_LIMIT:word
		extrn	BCC_RD_543E_W:word
		BCC_RD_541E_W	equ	8254h
		extrn	BCC_RD_8254_W:word


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

		public	X030_01
X030_01	label	far
BCC_SCAN_WRITE	proc	far
	push	bp
	mov	bp,sp
	cmp	word ptr DGROUP:BCC_RD_543E_W,offset DGROUP:BCC_TOKEN_LIMIT
	jnc	short M01B_@@TERMINATE
	mov	bx,word ptr DGROUP:BCC_RD_541E_W
	mov	al,byte ptr [bp+6]
	mov	byte ptr [bx],al
	inc	word ptr DGROUP:BCC_RD_8254_W
M01B_@@TERMINATE:
	mov	bx,word ptr DGROUP:BCC_RD_541E_W
	mov	byte ptr [bx],0
	pop	bp
	retf	2
BCC_SCAN_WRITE	endp
CO030_TEXT	ends
	extrn	BCC_EMIT_LIMIT:word
		extrn	BCC_RD_543E_W:word
		BCC_RD_541E_W	equ	8254h
		extrn	BCC_RD_8254_W:word


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

		public	X030_09
X030_09	label	far
BCC_SCAN_EMIT	proc	far
	push	bp
	mov	bp,sp
	mov	dl,byte ptr [bp+6]
	cmp	word ptr DGROUP:BCC_RD_543E_W,offset DGROUP:BCC_EMIT_LIMIT
	jnc	short M01C_@@TERMINATE
	test	dl,128
	je	short M01C_@@STORE
	cmp	dl,251
	je	short M01C_@@STORE
	mov	bx,word ptr DGROUP:BCC_RD_541E_W
	mov	byte ptr [bx],255
	inc	word ptr DGROUP:BCC_RD_8254_W
M01C_@@STORE:
	mov	bx,word ptr DGROUP:BCC_RD_541E_W
	mov	al,dl
	mov	byte ptr [bx],al
	inc	word ptr DGROUP:BCC_RD_8254_W
M01C_@@TERMINATE:
	mov	bx,word ptr DGROUP:BCC_RD_541E_W
	mov	byte ptr [bx],0
	pop	bp
	retf	2
BCC_SCAN_EMIT	endp
CO030_TEXT	ends

	extrn	X032_05:far
	extrn	X031_04:far
	extrn	BCC_RD_828C_W:word
	BCC_RD_7C1E_W	equ	827Ch
	BCC_COMMENT_MODE	equ	16F5h
	extrn	BCC_RD_2101_B:byte
		extrn	BCC_RD_8292_W:word
		BCC_RD_921E_W	equ	8292h
		BCC_RD_920E_W	equ	8292h


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

		public	X030_00
X030_00	label	far
BCC_SCAN_NEXT	proc	far
	push	bp
	mov	bp,sp
M01D_@@TEST:
	cmp	word ptr [bp+6],47
	jne	short M01D_@@CHECK_BACKSLASH
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M01D_@@SLASH_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M01D_@@SLASH_CHARACTER
M01D_@@SLASH_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M01D_@@SLASH_CHARACTER:
	mov	ah,0
	mov	word ptr [bp+6],ax
	cmp	word ptr [bp+6],42
	jne	short M01D_@@CHECK_LINE_COMMENT
	nop
	push	cs
	db	0E8h,0E2h,002h
	jmp	short M01D_@@READ_NEXT
M01D_@@CHECK_LINE_COMMENT:
	cmp	byte ptr DGROUP:BCC_COMMENT_MODE,1
	je	short M01D_@@RETURN_SLASH
	cmp	word ptr [bp+6],47
	jne	short M01D_@@RETURN_SLASH
	nop
	push	cs
	db	0E8h,081h,003h
	jmp	short M01D_@@READ_NEXT
M01D_@@RETURN_SLASH:
	dec	word ptr DGROUP:BCC_RD_920E_W
	mov	ax,47
	jmp	M01D_@@EPILOGUE
M01D_@@CHECK_BACKSLASH:
	cmp	word ptr [bp+6],92
	jne	short M01D_@@CHECK_SPACE
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M01D_@@BACKSLASH_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M01D_@@BACKSLASH_CHARACTER
M01D_@@BACKSLASH_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M01D_@@BACKSLASH_CHARACTER:
	mov	ah,0
	mov	word ptr [bp+6],ax
	mov	bx,word ptr [bp+6]
	cmp	byte ptr DGROUP:BCC_RD_2101_B[bx+1],236
	jne	short M01D_@@RETURN_BACKSLASH
	mov	al,byte ptr [bp+6]
	push	ax
	db	9Ah
	dw	X031_04
	dw	seg X031_04
	jmp	short M01D_@@READ_NEXT
M01D_@@RETURN_BACKSLASH:
	dec	word ptr DGROUP:BCC_RD_920E_W
	mov	ax,92
	jmp	short M01D_@@EPILOGUE
M01D_@@CHECK_SPACE:
	mov	bx,word ptr [bp+6]
	cmp	byte ptr DGROUP:BCC_RD_2101_B[bx+1],247
	jne	short M01D_@@RETURN_CHARACTER
M01D_@@READ_NEXT:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M01D_@@NEXT_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M01D_@@NEXT_CHARACTER
M01D_@@NEXT_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M01D_@@NEXT_CHARACTER:
	mov	ah,0
	mov	word ptr [bp+6],ax
	jmp	M01D_@@TEST
M01D_@@RETURN_CHARACTER:
	mov	ax,word ptr [bp+6]
M01D_@@EPILOGUE:
	pop	bp
	retf	2
BCC_SCAN_NEXT	endp
CO030_TEXT	ends

; END C130UNIT
; BEGIN C137UNIT (listing ovr_1c90_7cc3:DE75)

	extrn	X032_05:far
	extrn	X031_04:far
	extrn	BCC_RF_15A7_011B:far
	extrn	BCC_RD_828C_W:word
	BCC_RD_7C1E_W	equ	827Ch
	BCC_COMMENT_MODE	equ	16F5h
		BCC_RD_920E_W	equ	8292h
		extrn	BCC_RD_8292_W:word
		BCC_RD_921E_W	equ	8292h


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

BCC_PATH_PARSE	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
M01E_@@DISPATCH:
	mov	ax,word ptr [bp+4]
	mov	word ptr [bp-2],ax
	mov	cx,7
	mov	bx,134fh
M01E_@@SWITCH_LOOP:
	mov	ax,word ptr cs:[bx]
	cmp	ax,word ptr [bp-2]
	je	short M01E_@@SWITCH_JUMP
	inc	bx
	inc	bx
	loop	M01E_@@SWITCH_LOOP
	jmp	M01E_@@DEFAULT
M01E_@@SWITCH_JUMP:
	jmp	word ptr cs:[bx+14]
M01E_@@CASE_REWIND:
	dec	word ptr DGROUP:BCC_RD_920E_W
	jmp	M01E_@@EPILOGUE
M01E_@@CASE_SLASH:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M01E_@@SLASH_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M01E_@@SLASH_CHARACTER
M01E_@@SLASH_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M01E_@@SLASH_CHARACTER:
	mov	ah,0
	mov	word ptr [bp+4],ax
	cmp	word ptr [bp+4],42
	jne	short M01E_@@SLASH_NOT_COMMENT
	nop
	push	cs
	db	0E8h,0E1h,001h
	jmp	short M01E_@@READ_NEXT
M01E_@@SLASH_NOT_BLOCK:
	nop
M01E_@@SLASH_NOT_COMMENT:
	cmp	byte ptr DGROUP:BCC_COMMENT_MODE,1
	je	short M01E_@@SLASH_REWIND
	cmp	word ptr [bp+4],47
	jne	short M01E_@@SLASH_REWIND
	nop
	push	cs
	db	0E8h,07Fh,002h
	jmp	short M01E_@@READ_NEXT
M01E_@@SLASH_REWIND:
	dec	word ptr DGROUP:BCC_RD_920E_W
	jmp	short M01E_@@READ_NEXT
M01E_@@CASE_BACKSLASH:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M01E_@@BACKSLASH_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M01E_@@BACKSLASH_CHARACTER
M01E_@@BACKSLASH_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M01E_@@BACKSLASH_CHARACTER:
	mov	ah,0
	mov	word ptr [bp+4],ax
	cmp	word ptr [bp+4],10
	je	short M01E_@@BACKSLASH_UNGET
	cmp	word ptr [bp+4],13
	jne	short M01E_@@READ_NEXT
M01E_@@BACKSLASH_UNGET:
	mov	al,byte ptr [bp+4]
	push	ax
	db	9Ah
	dw	X031_04
	dw	seg X031_04
	jmp	short M01E_@@READ_NEXT
M01E_@@DEFAULT:
	cmp	byte ptr DGROUP:BCC_COMMENT_MODE,1
	jne	short M01E_@@FINISH_LINE
	push	word ptr [bp+4]
	push	word ptr [bp+4]
	mov	ax,55
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	add	sp,6
M01E_@@FINISH_LINE:
	push	word ptr [bp+4]
	nop
	push	cs
	db	0E8h,04Eh,000h
	jmp	short M01E_@@EPILOGUE
M01E_@@READ_NEXT:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M01E_@@NEXT_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M01E_@@NEXT_CHARACTER
M01E_@@NEXT_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M01E_@@NEXT_CHARACTER:
	mov	ah,0
	mov	word ptr [bp+4],ax
	jmp	M01E_@@DISPATCH
M01E_@@EPILOGUE:
	mov	sp,bp
	pop	bp
	dec	bp
	ret	2
BCC_PATH_PARSE	endp
CO030_TEXT	ends

; Original-target semantic aliases (zero bytes)
BCC_SCAN_UNGET	equ	BCC_PATH_PARSE+126h
CO030_TEXT	segment byte public 'CODE'
		assume	cs:CO030_TEXT
; Original-image layout stub: not recovered source


		db	009h,000h,00Ah,000h,00Dh,000h,01Ah,000h,020h,000h,02Fh,000h,05Ch,000h	; ovr_1c90_7cc3:DF7F
		db	01Fh,013h,06Ah,012h,06Ah,012h,048h,013h,01Fh,013h,071h,012h,0BFh,012h	; ovr_1c90_7cc3:DF8D

CO030_TEXT	ends
; END C137UNIT
; BEGIN C139UNIT (listing ovr_1c90_7cc3:DF9B)

	extrn	X032_01:far
	extrn	X032_05:far
	extrn	X031_04:far
	extrn	BCC_RD_828C_W:word
	BCC_RD_7C1E_W	equ	827Ch
	BCC_COMMENT_MODE	equ	16F5h
	extrn	BCC_DIRECTIVE_CONTEXT:word
		BCC_RD_920E_W	equ	8292h
		extrn	BCC_RD_8292_W:word
		BCC_RD_921E_W	equ	8292h


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

		public	X030_05
X030_05	label	far
BCC_SCAN_FINISH	proc	far
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
M020_@@DISPATCH:
	mov	ax,word ptr [bp+6]
	mov	word ptr [bp-2],ax
	mov	cx,7
	mov	bx,1467h
M020_@@SWITCH_LOOP:
	mov	ax,word ptr cs:[bx]
	cmp	ax,word ptr [bp-2]
	je	short M020_@@SWITCH_JUMP
	inc	bx
	inc	bx
	loop	M020_@@SWITCH_LOOP
	jmp	M020_@@READ_NEXT
M020_@@SWITCH_JUMP:
	jmp	word ptr cs:[bx+14]
M020_@@CASE_REWIND:
	dec	word ptr DGROUP:BCC_RD_920E_W
	jmp	M020_@@EPILOGUE
M020_@@CASE_SLASH:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M020_@@SLASH_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M020_@@SLASH_CHARACTER
M020_@@SLASH_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M020_@@SLASH_CHARACTER:
	mov	ah,0
	mov	word ptr [bp+6],ax
	cmp	word ptr [bp+6],42
	jne	short M020_@@SLASH_NOT_BLOCK
	nop
	push	cs
	db	0E8h,0BCh,000h
	jmp	short M020_@@READ_NEXT
M020_@@SLASH_NOT_BLOCK:
	cmp	byte ptr DGROUP:BCC_COMMENT_MODE,1
	je	short M020_@@SLASH_REWIND
	cmp	word ptr [bp+6],47
	jne	short M020_@@SLASH_REWIND
	nop
	push	cs
	db	0E8h,05Bh,001h
	jmp	short M020_@@READ_NEXT
M020_@@SLASH_REWIND:
	dec	word ptr DGROUP:BCC_RD_920E_W
	jmp	short M020_@@READ_NEXT
M020_@@CASE_BACKSLASH:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M020_@@BACKSLASH_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M020_@@BACKSLASH_CHARACTER
M020_@@BACKSLASH_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M020_@@BACKSLASH_CHARACTER:
	mov	ah,0
	mov	word ptr [bp+6],ax
	cmp	word ptr [bp+6],10
	je	short M020_@@BACKSLASH_UNGET
	cmp	word ptr [bp+6],13
	jne	short M020_@@READ_NEXT
M020_@@BACKSLASH_UNGET:
	mov	al,byte ptr [bp+6]
	push	ax
	db	9Ah
	dw	X031_04
	dw	seg X031_04
	jmp	short M020_@@READ_NEXT
M020_@@DEFAULT:
	mov	al,byte ptr [bp+6]
	push	ax
	push	word ptr DGROUP:BCC_DIRECTIVE_CONTEXT+2
	push	word ptr DGROUP:BCC_DIRECTIVE_CONTEXT
	xor	ax,ax
	push	ax
	db	9Ah
	dw	X032_01
	dw	seg X032_01
	or	ax,ax
	jz	short M020_@@EPILOGUE
M020_@@READ_NEXT:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M020_@@NEXT_BUFFERED
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	jmp	short M020_@@NEXT_CHARACTER
M020_@@NEXT_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M020_@@NEXT_CHARACTER:
	mov	ah,0
	mov	word ptr [bp+6],ax
	jmp	M020_@@DISPATCH
M020_@@EPILOGUE:
	mov	sp,bp
	pop	bp
	retf	2
BCC_SCAN_FINISH	endp
CO030_TEXT	ends

CO030_TEXT	segment byte public 'CODE'
		assume	cs:CO030_TEXT
; Original-image layout stub: not recovered source


		db	00Ah,000h,00Dh,000h,01Ah,000h,022h,000h,027h,000h,02Fh,000h,05Ch,000h	; ovr_1c90_7cc3:E097
		db	08Fh,013h,08Fh,013h,061h,014h,020h,014h,020h,014h,096h,013h,0E3h,013h	; ovr_1c90_7cc3:E0A5

CO030_TEXT	ends
; END C139UNIT
; BEGIN C138UNIT (listing ovr_1c90_7cc3:E0B3)

	extrn	X032_05:far
	extrn	X031_04:far
	extrn	BCC_RF_15A7_011B:far
	extrn	BCC_COMMENT_LINE_NUMBER:word
	extrn	BCC_RD_8292_W:word
	extrn	BCC_RD_828C_W:word
	extrn	BCC_RD_7C3E_W:word
	extrn	BCC_COMMENT_NESTED:byte


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

		public	X030_06
X030_06	label	far
BCC_COMMENT_BLOCK	proc	far
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	bx,word ptr DGROUP:BCC_COMMENT_LINE_NUMBER
	xor	cx,cx
M022_@@RELOAD:
	push	ds
	pop	es
	mov	si,word ptr DGROUP:BCC_RD_8292_W
	mov	dx,word ptr DGROUP:BCC_RD_828C_W
	mov	di,word ptr DGROUP:BCC_RD_7C3E_W
	mov	ds,word ptr [di]
	cld
M022_@@SCAN:
	cmp	si,dx
	jnc	short M022_@@REFILL_SCAN
	lodsb
M022_@@CHARACTER:
	cmp	al,42
	je	short M022_@@POSSIBLE_END
	cmp	al,47
	je	short M022_@@POSSIBLE_NESTED
	cmp	al,26
	je	short M022_@@UNEXPECTED_EOF
	cmp	al,13
	je	short M022_@@UNGET_NEWLINE
	cmp	al,10
	jne	short M022_@@SCAN
M022_@@UNGET_NEWLINE:
	push	es
	pop	ds
	mov	word ptr DGROUP:BCC_RD_8292_W,si
	push	bx
	push	cx
	cbw
	push	ax
	db	9Ah
	dw	X031_04
	dw	seg X031_04
	pop	cx
	pop	bx
	jmp	M022_@@RELOAD
M022_@@POSSIBLE_END:
	cmp	si,dx
	jnc	short M022_@@REFILL_END
	lodsb
M022_@@END_CHARACTER:
	cmp	al,47
	jne	short M022_@@CHARACTER
	dec	cx
	jge	short M022_@@SCAN
	push	es
	pop	ds
	mov	word ptr DGROUP:BCC_RD_8292_W,si
	jmp	M022_@@EPILOGUE
M022_@@REFILL_SCAN:
	call	M022_@@REFILL
	jmp	short M022_@@CHARACTER
M022_@@REFILL_END:
	call	M022_@@REFILL
	jmp	short M022_@@END_CHARACTER
M022_@@REFILL_NESTED:
	call	M022_@@REFILL
	jmp	short M022_@@NESTED_CHARACTER
M022_@@POSSIBLE_NESTED:
	cmp	byte ptr es:[BCC_COMMENT_NESTED],0
	je	short M022_@@SCAN
	cmp	si,dx
	jnc	short M022_@@REFILL_NESTED
	lodsb
M022_@@NESTED_CHARACTER:
	cmp	al,42
	jne	short M022_@@CHARACTER
	inc	cx
	jmp	short M022_@@SCAN
M022_@@REFILL:
	push	es
	pop	ds
	mov	word ptr DGROUP:BCC_RD_8292_W,si
	push	bx
	push	cx
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	pop	cx
	pop	bx
	push	ds
	pop	es
	mov	si,word ptr DGROUP:BCC_RD_8292_W
	mov	dx,word ptr DGROUP:BCC_RD_828C_W
	mov	di,word ptr DGROUP:BCC_RD_7C3E_W
	mov	ds,word ptr [di]
	cld
	retn
M022_@@UNEXPECTED_EOF:
	push	es
	pop	ds
	push	bx
	mov	ax,41
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
	pop	cx
M022_@@EPILOGUE:
	pop	di
	pop	si
	pop	bp
	retf
BCC_COMMENT_BLOCK	endp
CO030_TEXT	ends


	extrn	X032_05:far
	extrn	BCC_RF_15A7_011B:far
	extrn	BCC_COMMENT_LINE_NUMBER:word
	extrn	BCC_RD_8292_W:word
	extrn	BCC_RD_828C_W:word
	extrn	BCC_RD_7C3E_W:word


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

		public	X030_0A
X030_0A	label	far
BCC_COMMENT_LINE	proc	far
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	bx,word ptr DGROUP:BCC_COMMENT_LINE_NUMBER
	push	ds
	pop	es
	mov	si,word ptr DGROUP:BCC_RD_8292_W
	mov	dx,word ptr DGROUP:BCC_RD_828C_W
	mov	di,word ptr DGROUP:BCC_RD_7C3E_W
	mov	ds,word ptr [di]
	cld
M023_@@SCAN:
	cmp	si,dx
	jnc	short M023_@@REFILL
	lodsb
M023_@@CHARACTER:
	cmp	al,26
	je	short M023_@@UNEXPECTED_EOF
	cmp	al,13
	je	short M023_@@NEWLINE
	cmp	al,10
	jne	short M023_@@SCAN
M023_@@NEWLINE:
	push	es
	pop	ds
	dec	si
	mov	word ptr DGROUP:BCC_RD_8292_W,si
	jmp	short M023_@@EPILOGUE
M023_@@REFILL:
	push	es
	pop	ds
	mov	word ptr DGROUP:BCC_RD_8292_W,si
	push	bx
	db	9Ah
	dw	X032_05
	dw	seg X032_05
	pop	bx
	push	ds
	pop	es
	mov	si,word ptr DGROUP:BCC_RD_8292_W
	mov	dx,word ptr DGROUP:BCC_RD_828C_W
	mov	di,word ptr DGROUP:BCC_RD_7C3E_W
	mov	ds,word ptr [di]
	cld
	jmp	M023_@@CHARACTER
M023_@@UNEXPECTED_EOF:
	push	es
	pop	ds
	push	bx
	mov	ax,41
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
	pop	cx
M023_@@EPILOGUE:
	pop	di
	pop	si
	pop	bp
	retf
BCC_COMMENT_LINE	endp
CO030_TEXT	ends


CO030_TEXT	segment byte public 'CODE'
	assume	cs:CO030_TEXT,ds:DGROUP

		public	X030_03
X030_03	label	far
BCC_SCAN_EMPTY	proc	far
	push	bp
	mov	bp,sp
	pop	bp
	retf	2
BCC_SCAN_EMPTY	endp
CO030_TEXT	ends

; END C138UNIT
		end
