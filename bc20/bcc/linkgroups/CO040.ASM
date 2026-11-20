; Recovered FBOV far-pointer references
CO00A_TEXT	segment byte public 'CODE'
CO00A_TEXT	ends
CO019_TEXT	segment byte public 'CODE'
CO019_TEXT	ends
CO027_TEXT	segment byte public 'CODE'
CO027_TEXT	ends
CO02C_TEXT	segment byte public 'CODE'
CO02C_TEXT	ends
CO02D_TEXT	segment byte public 'CODE'
CO02D_TEXT	ends
CO03D_TEXT	segment byte public 'CODE'
CO03D_TEXT	ends
		public	X040_00
		public	X040_01
		public	X040_02
		public	X040_03
		public	X040_04
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1cdc_8a5b
; BEGIN C131UNIT (listing ovr_1cdc_8a5b:A5B0)
CO040_TEXT	segment byte public 'CODE'
		assume	cs:CO040_TEXT
; Original-image layout stub: not recovered source


		db	045h,055h,08Bh,0ECh,083h,0ECh,00Eh,056h,083h,03Eh,0F2h,062h,043h,075h	; ovr_1cdc_8a5b:A5B0
		db	011h,0C7h,046h,0F6h,000h,000h,0C7h,046h,0F4h,000h,000h,0C7h,046h,0F2h	; ovr_1cdc_8a5b:A5BE
		db	000h,000h,0EBh,013h,0A1h,0EEh,062h,08Bh,016h,0ECh,062h,089h,046h,0F6h	; ovr_1cdc_8a5b:A5CC
		db	089h,056h,0F4h,0A1h,0F0h,062h,089h,046h,0F2h,0FFh,036h,0FEh,062h,09Ah	; ovr_1cdc_8a5b:A5DA
		dw	02Fh
		dw	seg CO00A_TEXT
		db	00Bh,0C2h,075h,00Dh,0B8h,009h,001h,050h,0FFh,036h; ovr_1cdc_8a5b:A5E8
		db	0F6h,062h,09Ah
		dw	02Fh
		dw	seg CO019_TEXT
		db	09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	08Eh,006h; ovr_1cdc_8a5b:A5F6
		db	09Ah,063h,08Bh,01Eh,0FEh,062h,026h,08Bh,01Fh,0F6h,087h,0CAh,009h,001h	; ovr_1cdc_8a5b:A604
		db	074h,047h,080h,03Eh,0CCh,05Eh,000h,075h,054h,080h,03Eh,0A0h,062h,000h	; ovr_1cdc_8a5b:A612
		db	075h,04Dh,0FFh,036h,0FEh,062h,0FFh,036h,0C8h,05Eh,0B8h,001h,000h,050h	; ovr_1cdc_8a5b:A620
		db	09Ah
		dw	020h
		dw	seg CO00A_TEXT
		db	00Ah,0C0h,075h,038h,0FFh,036h,0FEh,062h,0C4h; ovr_1cdc_8a5b:A62E
		db	01Eh,01Ch,064h,026h,0FFh,077h,00Ch,0B8h,001h,000h,050h,09Ah
		dw	020h
		dw	seg CO00A_TEXT
		db	00Ah,0C0h,075h,01Fh,0B8h,04Eh,001h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0EBh,014h,0B8h,070h,000h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0C4h,01Eh; ovr_1cdc_8a5b:A63C
		db	01Ch,064h,026h,08Bh,047h,00Ch,0A3h,0FEh,062h,0B8h,007h,000h,050h,016h	; ovr_1cdc_8a5b:A666
		db	08Dh,046h,0F8h,050h,09Ah
		dw	02Fh
		dw	seg CO03D_TEXT
		db	083h,07Eh,0FAh,000h,07Ch; ovr_1cdc_8a5b:A674
		db	01Dh,07Fh,006h,083h,07Eh,0F8h,010h,076h,015h,0B8h,09Dh,000h,050h,09Ah	; ovr_1cdc_8a5b:A682
		dw	039h
		dw	seg CO019_TEXT
		db	0C7h,046h,0FAh,000h,000h,0C7h,046h,0F8h,010h,000h; ovr_1cdc_8a5b:A690
		db	0EBh,030h,083h,07Eh,0FAh,000h,07Ch,017h,075h,006h,083h,07Eh,0F8h,000h	; ovr_1cdc_8a5b:A69E
		db	072h,00Fh,08Bh,046h,0F8h,00Bh,046h,0FAh,075h,01Ah,083h,03Eh,0F6h,062h	; ovr_1cdc_8a5b:A6AC
		db	000h,074h,013h,0B8h,09Eh,000h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0C7h,046h; ovr_1cdc_8a5b:A6BA
		db	0FAh,000h,000h,0C7h,046h,0F8h,001h,000h,0FFh,076h,0F8h,016h,08Dh,046h	; ovr_1cdc_8a5b:A6C8
		db	0F4h,050h,016h,08Dh,046h,0F2h,050h,016h,08Dh,046h,0FEh,050h,016h,08Dh	; ovr_1cdc_8a5b:A6D6
		db	046h,0FCh,050h,09Ah
		dw	025h
		dw	seg CO027_TEXT
		db	083h,03Eh,0F2h,062h,043h,075h; ovr_1cdc_8a5b:A6E4
		db	036h,08Bh,046h,0F2h,005h,007h,000h,0BBh,008h,000h,099h,0F7h,0FBh,099h	; ovr_1cdc_8a5b:A6F2
		db	001h,046h,0F4h,011h,056h,0F6h,08Bh,046h,0F6h,08Bh,056h,0F4h,03Bh,006h	; ovr_1cdc_8a5b:A700
		db	0EEh,062h,07Ch,02Ah,07Fh,006h,03Bh,016h,0ECh,062h,076h,022h,08Bh,046h	; ovr_1cdc_8a5b:A70E
		db	0F6h,08Bh,056h,0F4h,0A3h,0EEh,062h,089h,016h,0ECh,062h,0EBh,013h,08Bh	; ovr_1cdc_8a5b:A71C
		db	046h,0F6h,08Bh,056h,0F4h,0A3h,0EEh,062h,089h,016h,0ECh,062h,08Bh,046h	; ovr_1cdc_8a5b:A72A
		db	0F2h,0A3h,0F0h,062h,083h,03Eh,0F6h,062h,000h,074h,06Dh,0FFh,036h,0F6h	; ovr_1cdc_8a5b:A738
		db	062h,033h,0C0h,050h,09Ah
		dw	08Eh
		dw	seg CO02C_TEXT
		db	08Bh,0F0h,08Eh,006h,0A4h; ovr_1cdc_8a5b:A746
		db	078h,026h,08Ah,044h,004h,024h,0E3h,08Ah,016h,0F4h,062h,080h,0E2h,007h	; ovr_1cdc_8a5b:A754
		db	0D0h,0E2h,0D0h,0E2h,00Ah,0C2h,026h,088h,044h,004h,0A1h,0FEh,062h,026h	; ovr_1cdc_8a5b:A762
		db	089h,044h,008h,08Bh,046h,0FEh,026h,089h,044h,006h,0A1h,0E8h,062h,026h	; ovr_1cdc_8a5b:A770
		db	089h,044h,00Ah,026h,080h,04Ch,004h,040h,026h,08Ah,044h,005h,024h,0F8h	; ovr_1cdc_8a5b:A77E
		db	08Ah,056h,0FCh,080h,0E2h,007h,00Ah,0C2h,026h,088h,044h,005h,026h,08Ah	; ovr_1cdc_8a5b:A78C
		db	044h,005h,024h,007h,08Ah,056h,0F8h,080h,0E2h,01Fh,0D0h,0E2h,0D0h,0E2h	; ovr_1cdc_8a5b:A79A
		db	0D0h,0E2h,00Ah,0C2h,026h,088h,044h,005h,05Eh,08Bh,0E5h,05Dh,04Dh,0C3h	; ovr_1cdc_8a5b:A7A8

CO040_TEXT	ends

		BCC_RD_F23E_W	equ	62F2h
		extrn	BCC_RD_62EC_W:word
		extrn	BCC_RD_62EE_W:word
		extrn	BCC_RD_62F0_W:word
		BCC_EXPR_SEGMENT	equ	639Ah
		BCC_EXPR_LINKSEG	equ	5F3Eh
		BCC_MEMBER_SEGMENT	equ	78A4h
		extrn	BCC_CURRENT_NAME:word
		extrn	X00A_03:far
		extrn	X019_04:far
		extrn	X019_01:far
		extrn	X019_06:far
		extrn	X027_02:far
		extrn	X02C_01:far
		extrn	X019_00:far
		extrn	BCC_RD_62FE_W:word
		BCC_RD_FE1E_W	equ	62FEh
		BCC_RD_E81E_W	equ	62E8h
		extrn	BCC_RD_62E8_W:word
		extrn	BCC_RD_62A0_B:byte
		BCC_RD_A03E_B	equ	62A0h


CO040_TEXT	segment byte public 'CODE'
		assume	cs:CO040_TEXT,ds:DGROUP

		public	X040_02
X040_02	label	far
BCC_TYPE_LAYOUT	proc	far
	push	bp
	mov	bp,sp
	sub	sp,0Ch
	push	si
	cmp	word ptr DGROUP:BCC_RD_F23E_W,43h
	jne	short M001_@@INITIAL_VALUES
	mov	word ptr [bp-8],0
	mov	word ptr [bp-0Ah],0
	mov	word ptr [bp-0Ch],0
	jmp	short M001_@@FIND_MEMBER
M001_@@INITIAL_VALUES:
	mov	ax,word ptr DGROUP:BCC_RD_62EE_W
	mov	dx,word ptr DGROUP:BCC_RD_62EC_W
	mov	word ptr [bp-8],ax
	mov	word ptr [bp-0Ah],dx
	mov	ax,word ptr DGROUP:BCC_RD_62F0_W
	mov	word ptr [bp-0Ch],ax
M001_@@FIND_MEMBER:
	mov	bx,word ptr DGROUP:BCC_RD_E81E_W
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	si,word ptr es:[bx+2]
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	byte ptr es:[4],0
	jmp	short M001_@@TEST_MEMBER
M001_@@NEXT_MEMBER:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	si,word ptr es:[si]
M001_@@TEST_MEMBER:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	test	byte ptr es:[si+4],3
	jne	short M001_@@NEXT_MEMBER
	mov	al,byte ptr DGROUP:BCC_RD_62A0_B
	mov	ah,0
	or	ax,ax
	jne	short M001_@@COERCE_CURRENT
	or	si,si
	je	short M001_@@COERCE_CURRENT
	push	word ptr es:[si+8]
	db	9Ah
	dw	X00A_03
	dw	seg X00A_03
	or	ax,dx
	jne	short M001_@@COERCE_CURRENT
	mov	ax,109h
	push	ax
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	push	word ptr es:[si+2]
	db	9Ah
	dw	X019_04
	dw	seg X019_04
	push	dx
	push	ax
	xor	ax,ax
	xor	dx,dx
	push	ax
	push	dx
	db	9Ah
	dw	X019_01
	dw	seg X019_01
	db	0E9h
	dw	00188h
M001_@@COERCE_CURRENT:
	push	word ptr DGROUP:BCC_RD_62FE_W
	db	9Ah
	dw	X00A_03
	dw	seg X00A_03
	mov	word ptr [bp-4],dx
	mov	word ptr [bp-6],ax
	or	ax,word ptr [bp-4]
	jne	short M001_@@CHECK_SIZE
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr DGROUP:BCC_RD_FE1E_W
	cmp	word ptr es:[bx],11h
	jne	short M001_@@BAD_TYPE
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M001_@@CHECK_SIZE
M001_@@BAD_TYPE:
	mov	ax,109h
	push	ax
	push	word ptr DGROUP:BCC_CURRENT_NAME
	db	9Ah
	dw	X019_06
	dw	seg X019_06
	db	0E9h
	dw	0014Fh
M001_@@CHECK_SIZE:
	cmp	word ptr [bp-4],0
	jl	short M001_@@SIZE_CAPPED
	jg	short M001_@@CAP_SIZE
	cmp	word ptr [bp-6],-1
	jbe	short M001_@@SIZE_CAPPED
M001_@@CAP_SIZE:
	mov	word ptr [bp-4],0
	mov	word ptr [bp-6],2
M001_@@SIZE_CAPPED:
	push	word ptr [bp-4]
	push	word ptr [bp-6]
	push	ss
	lea	ax,[bp-0Ah]
	push	ax
	push	ss
	lea	ax,[bp-0Ch]
	push	ax
	push	ss
	lea	ax,[bp-2]
	push	ax
	db	9Ah
	dw	X027_02
	dw	seg X027_02
	cmp	word ptr DGROUP:BCC_RD_F23E_W,43h
	jne	short M001_@@STORE_NONCLASS
	mov	ax,word ptr [bp-0Ch]
	add	ax,7
	mov	bx,8
	cwd
	idiv	bx
	cwd
	add	word ptr [bp-0Ah],ax
	adc	word ptr [bp-8],dx
	mov	ax,word ptr [bp-8]
	mov	dx,word ptr [bp-0Ah]
	cmp	ax,word ptr DGROUP:BCC_RD_62EE_W
	jl	short M001_@@CREATE_MEMBER
	jg	short M001_@@STORE_CLASS_SIZE
	cmp	dx,word ptr DGROUP:BCC_RD_62EC_W
	jbe	short M001_@@CREATE_MEMBER
M001_@@STORE_CLASS_SIZE:
	mov	ax,word ptr [bp-8]
	mov	dx,word ptr [bp-0Ah]
	mov	word ptr DGROUP:BCC_RD_62EE_W,ax
	mov	word ptr DGROUP:BCC_RD_62EC_W,dx
	jmp	short M001_@@CREATE_MEMBER
M001_@@STORE_NONCLASS:
	mov	ax,word ptr [bp-8]
	mov	dx,word ptr [bp-0Ah]
	mov	word ptr DGROUP:BCC_RD_62EE_W,ax
	mov	word ptr DGROUP:BCC_RD_62EC_W,dx
	mov	ax,word ptr [bp-0Ch]
	mov	word ptr DGROUP:BCC_RD_62F0_W,ax
M001_@@CREATE_MEMBER:
	push	word ptr DGROUP:BCC_CURRENT_NAME
	xor	ax,ax
	push	ax
	db	9Ah
	dw	X02C_01
	dw	seg X02C_01
	mov	si,ax
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	ax,word ptr DGROUP:BCC_RD_62FE_W
	mov	word ptr es:[si+8],ax
	mov	ax,word ptr [bp-2]
	mov	word ptr es:[si+6],ax
	mov	ax,word ptr DGROUP:BCC_RD_62E8_W
	mov	word ptr es:[si+0Ah],ax
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M001_@@CHECK_TREE
	cmp	word ptr DGROUP:BCC_RD_F23E_W,43h
	jne	short M001_@@CHECK_TREE
	mov	bx,word ptr DGROUP:BCC_RD_FE1E_W
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	test	byte ptr es:[bx+2],4
	jne	short M001_@@WARN_MEMBER
	mov	bx,word ptr es:[bx]
	test	byte ptr [bx+09CAh],14h
	je	short M001_@@CHECK_TREE
	mov	bx,word ptr DGROUP:BCC_RD_FE1E_W
	test	byte ptr es:[bx+2],20h
	je	short M001_@@CHECK_TREE
M001_@@WARN_MEMBER:
	mov	ax,0B8h
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
M001_@@CHECK_TREE:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M001_@@RETURN
	mov	bx,word ptr DGROUP:BCC_RD_E81E_W
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	test	word ptr es:[bx+18h],108h
	je	short M001_@@RETURN
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr DGROUP:BCC_RD_FE1E_W
	mov	bx,word ptr es:[bx]
	test	byte ptr [bx+09CAh],40h
	je	short M001_@@RETURN
	mov	bx,word ptr DGROUP:BCC_RD_FE1E_W
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	test	word ptr es:[bx+18h],10h
	je	short M001_@@RETURN
	mov	bx,word ptr DGROUP:BCC_RD_E81E_W
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	test	word ptr es:[bx+18h],100h
	je	short M001_@@SECOND_WARNING
	mov	ax,138h
	jmp	short M001_@@EMIT_WARNING
M001_@@SECOND_WARNING:
	mov	ax,0C1h
M001_@@EMIT_WARNING:
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
M001_@@RETURN:
	pop	si
	mov	sp,bp
	pop	bp
	retf
BCC_TYPE_LAYOUT	endp
CO040_TEXT	ends


		BCC_MEMBER_SEGMENT	equ	78A4h


CO040_TEXT	segment byte public 'CODE'
		assume	cs:CO040_TEXT,ds:DGROUP

BCC_MEMBER_REVERSE	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	dx,word ptr [bp+4]
	xor	si,si
	jmp	short M002_@@TEST
M002_@@REVERSE:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	bx,dx
	mov	di,word ptr es:[bx]
	mov	word ptr es:[bx],si
	mov	si,dx
	mov	dx,di
M002_@@TEST:
	or	dx,dx
	jne	short M002_@@REVERSE
	mov	ax,si
	pop	di
	pop	si
	pop	bp
	dec	bp
	ret	2
BCC_MEMBER_REVERSE	endp
CO040_TEXT	ends

; Target-qualified reference aliases (zero bytes)
BCC_RN_8000_A5B0	equ	BCC_MEMBER_REVERSE-432h
BCC_RN_8000_A7B6	equ	BCC_MEMBER_REVERSE-22Ch
		extrn	BCC_TREE_BASE:word
		extrn	BCC_RD_6300_B:byte
		extrn	X010_06:far
		BCC_RD_C23E_W	equ	5EC2h
		BCC_EXPR_SEGMENT	equ	639Ah
		BCC_RD_0B3E_B	equ	630Bh
		BCC_RD_0C3E_B	equ	630Ch
		extrn	X019_00:far
		extrn	X019_06:far
		extrn	BCC_RD_62FE_W:word
		BCC_RD_FE1E_W	equ	62FEh
		extrn	BCC_RD_62F6_W:word
		BCC_RD_F63E_W	equ	62F6h
		extrn	BCC_RD_62FA_W:word
		BCC_RD_FA3E_W	equ	62FAh
		BCC_RD_FC3E_W	equ	62FCh
		BCC_RD_FC1E_W	equ	62FCh
		extrn	BCC_RD_630A_W:word
		BCC_RD_0A3E_W	equ	630Ah


CO040_TEXT	segment byte public 'CODE'
		assume	cs:CO040_TEXT,ds:DGROUP

M003_BCC_TOKEN_NAMES	equ	6182h

BCC_TYPE_FINISH	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,8
	mov	byte ptr [bp-1],0
	mov	ax,word ptr DGROUP:BCC_RD_62FE_W
	mov	word ptr [bp-4],ax
	cmp	word ptr [bp-4],0
	jne	short M003_@@PARSE
	mov	ax,word ptr DGROUP:BCC_TREE_BASE
	mov	word ptr DGROUP:BCC_RD_62FE_W,ax
	mov	byte ptr [bp-1],1
M003_@@PARSE:
	push	word ptr DGROUP:BCC_RD_62FE_W
	mov	ax,2
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_RD_62FE_W
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_RD_62F6_W
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_RD_62FA_W
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_RD_6300_B
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_RD_630A_W
	push	ax
	push	ss
	lea	ax,[bp-8]
	push	ax
	db	9Ah
	dw	X010_06
	dw	seg X010_06
	cmp	word ptr DGROUP:BCC_RD_F63E_W,0
	jne	short M003_@@HAVE_EXPR
	cmp	word ptr DGROUP:BCC_RD_C23E_W,21h
	je	short M003_@@HAVE_EXPR
	mov	ax,0D4h
	jmp	short M003_@@WARN
M003_@@HAVE_EXPR:
	cmp	byte ptr [bp-1],0
	je	short M003_@@CLASSIFY
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr DGROUP:BCC_RD_FE1E_W
	cmp	word ptr es:[bx],12h
	je	short M003_@@CLASSIFY
	mov	bx,word ptr es:[bx]
	test	byte ptr [bx+09CAh],14h
	je	short M003_@@CHECK_TOKEN
	mov	bx,word ptr DGROUP:BCC_RD_FE1E_W
	mov	bx,word ptr es:[bx+7]
	cmp	word ptr es:[bx],12h
	je	short M003_@@CLASSIFY
M003_@@CHECK_TOKEN:
	cmp	word ptr DGROUP:BCC_RD_FC3E_W,82h
	jne	short M003_@@CLASSIFY
	mov	ax,0F7h
M003_@@WARN:
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
M003_@@CLASSIFY:
	cmp	word ptr DGROUP:BCC_RD_FC3E_W,82h
	je	short M003_@@CHECK_KIND
	mov	ax,82h
	push	ax
	mov	bx,word ptr DGROUP:BCC_RD_FC1E_W
	shl	bx,1
	push	word ptr [bx+M003_BCC_TOKEN_NAMES]
	db	9Ah
	dw	X019_06
	dw	seg X019_06
M003_@@CHECK_KIND:
	cmp	byte ptr DGROUP:BCC_RD_0A3E_W,0
	jne	short M003_@@BAD_KIND
	cmp	byte ptr DGROUP:BCC_RD_0C3E_B,0
	jne	short M003_@@BAD_KIND
	cmp	byte ptr DGROUP:BCC_RD_0B3E_B,0
	je	short M003_@@CHECK_CURRENT
M003_@@BAD_KIND:
	mov	ax,31h
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
M003_@@CHECK_CURRENT:
	cmp	word ptr DGROUP:BCC_RD_FA3E_W,0
	je	short M003_@@CHECK_TREE
	mov	ax,0D4h
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
M003_@@CHECK_TREE:
	cmp	word ptr DGROUP:BCC_RD_C23E_W,21h
	jne	short M003_@@RETURN_THREE
	mov	ax,2
	jmp	short M003_@@RETURN
M003_@@RETURN_THREE:
	mov	ax,3
M003_@@RETURN:
	mov	sp,bp
	pop	bp
	dec	bp
	ret
BCC_RN_8000_AB05	label	near
BCC_TYPE_FINISH	endp
CO040_TEXT	ends

; Target-qualified reference aliases (zero bytes)

		extrn	BCC_RD_62FE_W:word
		extrn	BCC_RD_630A_W:word
		extrn	BCC_EXPR_STATE:byte
		BCC_RD_A03E_B	equ	62A0h
		extrn	BCC_COPY_WORDS:far
		extrn	X03F_01:far
		extrn	X03F_0B:far
		extrn	X03F_08:far
		extrn	X03F_0D:far
		extrn	X03F_07:far
		extrn	X02D_00:far
		extrn	X019_00:far
		extrn	X019_05:far
		BCC_RD_C23E_W	equ	5EC2h
		BCC_RD_C21E_W	equ	5EC2h


CO040_TEXT	segment byte public 'CODE'
		assume	cs:CO040_TEXT,ds:DGROUP

M004_BCC_TOKEN_FLAGS	equ	07B3h

		public	X040_03
X040_03	label	far
BCC_TYPE_LOOP	proc	far
	push	bp
	mov	bp,sp
	sub	sp,6
	push	si
	mov	si,1
	mov	ax,word ptr DGROUP:BCC_RD_62FE_W
	mov	word ptr [bp-2],ax
	lea	ax,[bp-6]
	push	ss
	push	ax
	mov	ax,offset DGROUP:BCC_RD_630A_W
	push	ds
	push	ax
	mov	cx,3
	db	9Ah
	dw	BCC_COPY_WORDS
	dw	seg BCC_COPY_WORDS
	mov	si,1
	db	0E9h
	dw	000D6h
M004_@@DECLARATION:
	mov	ax,word ptr [bp-2]
	mov	word ptr DGROUP:BCC_RD_62FE_W,ax
	mov	ax,offset DGROUP:BCC_RD_630A_W
	push	ds
	push	ax
	lea	ax,[bp-6]
	push	ss
	push	ax
	mov	cx,3
	db	9Ah
	dw	BCC_COPY_WORDS
	dw	seg BCC_COPY_WORDS
	mov	byte ptr DGROUP:BCC_EXPR_STATE,0
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M004_@@FINISH_NEAR
	db	9Ah
	dw	X03F_01
	dw	seg X03F_01
	jmp	short M004_@@CLASSIFY
M004_@@FINISH_NEAR:
	db	0E8h
	dw	0FEB1h
M004_@@CLASSIFY:
	dec	ax
	dec	ax
	mov	bx,ax
	cmp	bx,5
	ja	short M004_@@AFTER_CASE
	shl	bx,1
	jmp	word ptr cs:[bx+067Fh]
M004_@@CASE_ZERO:
	db	9Ah
	dw	X03F_0B
	dw	seg X03F_0B
	jmp	short M004_@@AFTER_CASE
M004_@@CASE_TWO:
	push	si
	db	9Ah
	dw	X03F_08
	dw	seg X03F_08
	or	al,al
	je	short M004_@@AFTER_CASE
M004_@@RETURN_TRUE:
	mov	al,1
	db	0E9h
	dw	000A9h
M004_@@CASE_THREE:
	push	si
	db	9Ah
	dw	X03F_0D
	dw	seg X03F_0D
	or	al,al
	je	short M004_@@AFTER_CASE
	jmp	short M004_@@RETURN_TRUE
M004_@@CASE_FOUR:
	db	9Ah
	dw	X03F_07
	dw	seg X03F_07
	jmp	short M004_@@AFTER_CASE
M004_@@CASE_FIVE:
	db	0E8h
	dw	0FA19h
	jmp	short M004_@@AFTER_CASE
M004_@@CASE_ONE:
	push	cs
	db	0E8h
	dw	0FC19h
M004_@@AFTER_CASE:
	cmp	word ptr DGROUP:BCC_RD_C23E_W,8
	jne	short M004_@@CHECK_SEPARATOR
	db	9Ah
	dw	X02D_00
	dw	seg X02D_00
	mov	bx,word ptr DGROUP:BCC_RD_C21E_W
	shl	bx,1
	test	word ptr [bx+M004_BCC_TOKEN_FLAGS],10h
	jne	short M004_@@NEXT
	mov	ax,0CDh
M004_@@EMIT_ERROR:
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
	db	9Ah
	dw	X019_05
	dw	seg X019_05
	jmp	short M004_@@RETURN_TRUE
M004_@@CHECK_SEPARATOR:
	cmp	word ptr DGROUP:BCC_RD_C23E_W,7
	je	short M004_@@NEXT
	cmp	word ptr DGROUP:BCC_RD_C23E_W,6
	je	short M004_@@NEXT
	mov	bx,word ptr DGROUP:BCC_RD_C21E_W
	shl	bx,1
	test	word ptr [bx+M004_BCC_TOKEN_FLAGS],10h
	je	short M004_@@CHECK_COLON
	mov	ax,0CAh
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
	mov	si,1
	jmp	short M004_@@NEXT
M004_@@CHECK_COLON:
	cmp	word ptr DGROUP:BCC_RD_C23E_W,0Bh
	jne	short M004_@@UNEXPECTED_TOKEN
	mov	ax,0C7h
	jmp	short M004_@@SELECT_ERROR
M004_@@UNEXPECTED_TOKEN:
	mov	ax,0EBh
M004_@@SELECT_ERROR:
	jmp	short M004_@@EMIT_ERROR
M004_@@NEXT:
	inc	si
M004_@@LOOP_TEST:
	cmp	word ptr DGROUP:BCC_RD_C23E_W,2Bh
	jne	short M004_@@TEST_COLON
	db	0E9h
	dw	0FF20h
M004_@@TEST_COLON:
	cmp	word ptr DGROUP:BCC_RD_C23E_W,21h
	jne	short M004_@@TEST_FLAGS
	db	0E9h
	dw	0FF16h
M004_@@TEST_FLAGS:
	mov	bx,word ptr DGROUP:BCC_RD_C21E_W
	shl	bx,1
	test	word ptr [bx+M004_BCC_TOKEN_FLAGS],10h
	je	short M004_@@RETURN_FALSE
	db	0E9h
	dw	0FF05h
M004_@@RETURN_FALSE:
	mov	al,0
M004_@@RETURN:
	pop	si
	mov	sp,bp
	pop	bp
	retf
BCC_TYPE_LOOP	endp
CO040_TEXT	ends

CO040_TEXT	segment byte public 'CODE'
		assume cs:CO040_TEXT,ds:DGROUP
BCC_TYPE_TABLE2	label	word
	dw	05E4h,05E9h,05BBh
	dw	05C2h,05D1h,05DDh

CO040_TEXT	ends



		extrn	BCC_EXPR_FLAG5:byte
		extrn	BCC_RD_62F6_W:word
		extrn	BCC_RD_630A_W:word
		extrn	BCC_SAVED_NAME:word
		extrn	BCC_COPY_WORDS:far
		extrn	X03D_03:far
		extrn	BCC_NAME_STATE:byte
		extrn	BCC_PARSE_BYTE6303:byte
		extrn	BCC_PARSE_BYTE6302:byte
		extrn	X010_04:far
		extrn	X019_06:far
		BCC_EXPR_SEGMENT	equ	639Ah
		BCC_EXPR_LINKSEG	equ	5F3Eh
		BCC_TYPE_SEGMENT	equ	6410h
		extrn	X019_00:far
		extrn	BCC_RD_62FE_W:word
		BCC_RD_FE1E_W	equ	62FEh
		extrn	BCC_RD_62FC_W:word
		BCC_RD_FC3E_W	equ	62FCh
		BCC_RD_FC1E_W	equ	62FCh
		BCC_RD_C21E_W	equ	5EC2h
		BCC_RD_C23E_W	equ	5EC2h


CO040_TEXT	segment byte public 'CODE'
		assume	cs:CO040_TEXT,ds:DGROUP

M005_BCC_TOKEN_NAMES	equ	6182h
M005_BCC_TOKEN_FLAGS	equ	07B3h


		public	X040_04
X040_04	label	far
BCC_TYPE_CHECK2	proc	far
	push	bp
	mov	bp,sp
	mov	word ptr DGROUP:BCC_RD_62FC_W,82h
	mov	word ptr DGROUP:BCC_RD_62FE_W,0
	mov	byte ptr DGROUP:BCC_EXPR_FLAG5,0
	mov	word ptr DGROUP:BCC_RD_62F6_W,0
	mov	ax,offset DGROUP:BCC_RD_630A_W
	push	ds
	push	ax
	mov	ax,offset DGROUP:BCC_SAVED_NAME
	push	ds
	push	ax
	mov	cx,3
	db	9Ah
	dw	BCC_COPY_WORDS
	dw	seg BCC_COPY_WORDS
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_STATE
	push	ax
	db	9Ah
	dw	X03D_03
	dw	seg X03D_03
	or	al,al
	je	short M005_@@CHECK_TREE
	mov	ax,2
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_RD_62FC_W
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_PARSE_BYTE6303
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_PARSE_BYTE6302
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_RD_62FE_W
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_RD_630A_W
	push	ax
	push	ds
	mov	ax,offset DGROUP:BCC_EXPR_FLAG5
	push	ax
	db	9Ah
	dw	X010_04
	dw	seg X010_04
	cmp	word ptr DGROUP:BCC_RD_FC3E_W,82h
	je	short M005_@@CHECK_TREE
	mov	ax,82h
	push	ax
	mov	bx,word ptr DGROUP:BCC_RD_FC1E_W
	shl	bx,1
	push	word ptr [bx+M005_BCC_TOKEN_NAMES]
	db	9Ah
	dw	X019_06
	dw	seg X019_06
M005_@@CHECK_TREE:
	mov	bx,word ptr DGROUP:BCC_RD_C21E_W
	shl	bx,1
	test	word ptr [bx+M005_BCC_TOKEN_FLAGS],10h
	jne	short M005_@@RETURN_TRUE
	cmp	word ptr DGROUP:BCC_RD_C23E_W,21h
	jne	short M005_@@CHECK_TYPE
M005_@@RETURN_TRUE:
	mov	ax,1
	jmp	short M005_@@RETURN
M005_@@CHECK_TYPE:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr DGROUP:BCC_RD_FE1E_W
	cmp	word ptr es:[bx],15h
	je	short M005_@@RETURN_FALSE
	mov	bx,word ptr es:[bx]
	mov	al,byte ptr [bx+09CAh]
	mov	ah,0
	test	ax,40h
	je	short M005_@@BAD_TYPE
	mov	bx,word ptr DGROUP:BCC_RD_FE1E_W
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	bx,word ptr es:[bx+6]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	cmp	word ptr es:[bx+2],0
	jne	short M005_@@RETURN_FALSE
M005_@@BAD_TYPE:
	mov	ax,0B3h
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
M005_@@RETURN_FALSE:
	xor	ax,ax
M005_@@RETURN:
	pop	bp
	retf
BCC_TYPE_CHECK2	endp
CO040_TEXT	ends


		BCC_RD_C23E_W	equ	5EC2h
		extrn	X019_00:far
		extrn	X02D_00:far


CO040_TEXT	segment byte public 'CODE'
		assume	cs:CO040_TEXT,ds:DGROUP

BCC_TYPE_SKIP2	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	cmp	word ptr DGROUP:BCC_RD_C23E_W,7
	jne	short M006_@@RETURN
	mov	ax,78h
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
	jmp	short M006_@@TEST
M006_@@SKIP:
	db	9Ah
	dw	X02D_00
	dw	seg X02D_00
M006_@@TEST:
	cmp	word ptr DGROUP:BCC_RD_C23E_W,7
	je	short M006_@@SKIP
M006_@@RETURN:
	pop	bp
	dec	bp
	ret
BCC_TYPE_SKIP2	endp
CO040_TEXT	ends

; Target-qualified reference aliases (zero bytes)
BCC_RN_8000_AC3B	equ	BCC_TYPE_SKIP2-0DAh
		extrn	X019_00:far
		extrn	X02D_00:far
		BCC_RD_A03E_B	equ	62A0h
		extrn	X03F_11:far
		extrn	X03F_09:far
		extrn	X03F_13:far
		extrn	X03F_0E:far
		extrn	X03F_0F:far
		extrn	X03F_0A:far
		extrn	BCC_TOKEN_MASK:word
		extrn	X03F_04:far
		BCC_RD_E81E_W	equ	62E8h
		BCC_EXPR_SEGMENT	equ	639Ah
		BCC_EXPR_LINKSEG	equ	5F3Eh
		BCC_RD_F03E_W	equ	62F0h
		BCC_PACK_FLAG	equ	16F2h
		extrn	X03D_05:far
		extrn	BCC_RD_62EE_W:word
		BCC_RD_EE3E_W	equ	62EEh
		extrn	BCC_RD_62EC_W:word
		BCC_RD_EC3E_W	equ	62ECh
		BCC_RD_C23E_W	equ	5EC2h
		BCC_RD_C21E_W	equ	5EC2h


CO040_TEXT	segment byte public 'CODE'
		assume	cs:CO040_TEXT,ds:DGROUP

M007_BCC_TOKEN_FLAGS	equ	07B3h

		public	X040_00
X040_00	label	far
BCC_TYPE_CLOSE	proc	far
	push	bp
	mov	bp,sp
	cmp	word ptr DGROUP:BCC_RD_C23E_W,7
	je	short M007_@@SKIP_INITIAL
	db	0E9h
	dw	00083h
M007_@@SKIP_INITIAL:
	mov	ax,0CDh
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
	jmp	short M007_@@INITIAL_TEST
M007_@@INITIAL_SYNC:
	db	9Ah
	dw	X02D_00
	dw	seg X02D_00
M007_@@INITIAL_TEST:
	cmp	word ptr DGROUP:BCC_RD_C23E_W,7
	je	short M007_@@INITIAL_SYNC
	jmp	short M007_@@LOOP_TEST
M007_@@DECLARATION:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M007_@@CHECK_NEAR
	db	9Ah
	dw	X03F_11
	dw	seg X03F_11
	jmp	short M007_@@CLASSIFY
M007_@@CHECK_NEAR:
	push	cs
	db	0E8h
	dw	0FEC9h
M007_@@CLASSIFY:
	dec	ax
	mov	bx,ax
	cmp	bx,5
	ja	short M007_@@AFTER_CASE
	shl	bx,1
	jmp	word ptr cs:[bx+08E5h]
M007_@@CASE_ZERO:
	db	9Ah
	dw	X03F_09
	dw	seg X03F_09
	jmp	short M007_@@SKIP_SEPARATOR
M007_@@CASE_TWO:
	db	9Ah
	dw	X03F_13
	dw	seg X03F_13
	jmp	short M007_@@AFTER_CASE
M007_@@CASE_THREE:
	db	9Ah
	dw	X03F_0E
	dw	seg X03F_0E
	jmp	short M007_@@AFTER_CASE
M007_@@CASE_FOUR:
	db	9Ah
	dw	X03F_0F
	dw	seg X03F_0F
	jmp	short M007_@@AFTER_CASE
M007_@@CASE_FIVE:
	db	9Ah
	dw	X03F_0A
	dw	seg X03F_0A
	or	al,al
	je	short M007_@@AFTER_CASE
	jmp	short M007_@@SKIP_SEPARATOR
M007_@@CASE_ONE:
	push	cs
	db	0E8h
	dw	0FD59h
	or	al,al
	jne	short M007_@@SKIP_SEPARATOR
M007_@@AFTER_CASE:
	cmp	word ptr DGROUP:BCC_RD_C23E_W,7
	jne	short M007_@@EXPECTED_SEPARATOR
	db	9Ah
	dw	X02D_00
	dw	seg X02D_00
	jmp	short M007_@@SKIP_SEPARATOR
M007_@@EXPECTED_SEPARATOR:
	mov	ax,1Fh
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
M007_@@SKIP_SEPARATOR:
	db	0E8h
	dw	0FF4Bh
M007_@@LOOP_TEST:
	mov	bx,word ptr DGROUP:BCC_RD_C21E_W
	shl	bx,1
	mov	ax,word ptr DGROUP:BCC_TOKEN_MASK
	test	word ptr [bx+M007_BCC_TOKEN_FLAGS],ax
	jne	short M007_@@DECLARATION
	cmp	word ptr DGROUP:BCC_RD_C23E_W,21h
	je	short M007_@@DECLARATION
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M007_@@REVERSE_MEMBERS
	db	9Ah
	dw	X03F_04
	dw	seg X03F_04
M007_@@REVERSE_MEMBERS:
	mov	bx,word ptr DGROUP:BCC_RD_E81E_W
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	push	word ptr es:[bx+2]
	db	0E8h
	dw	0FBDFh
	mov	bx,word ptr DGROUP:BCC_RD_E81E_W
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	word ptr es:[bx+2],ax
	cmp	word ptr DGROUP:BCC_RD_F03E_W,0
	jle	short M007_@@CHECK_PACKING
	add	word ptr DGROUP:BCC_RD_62EC_W,1
	adc	word ptr DGROUP:BCC_RD_62EE_W,0
M007_@@CHECK_PACKING:
	cmp	byte ptr DGROUP:BCC_PACK_FLAG,0
	je	short M007_@@CHECK_SIZE
	mov	ax,word ptr DGROUP:BCC_RD_62EE_W
	mov	dx,word ptr DGROUP:BCC_RD_62EC_W
	add	dx,1
	adc	ax,0
	db	081h,0E2h,0FEh,0FFh	; and dx,0FFFEh (word immediate)
	and	ax,0FFFFh
	mov	word ptr DGROUP:BCC_RD_62EE_W,ax
	mov	word ptr DGROUP:BCC_RD_62EC_W,dx
M007_@@CHECK_SIZE:
	cmp	word ptr DGROUP:BCC_RD_EE3E_W,0
	jl	short M007_@@STORE_SIZE
	jg	short M007_@@SIZE_OVERFLOW
	cmp	word ptr DGROUP:BCC_RD_EC3E_W,-1
	jbe	short M007_@@STORE_SIZE
M007_@@SIZE_OVERFLOW:
	mov	word ptr DGROUP:BCC_RD_62EE_W,0
	mov	word ptr DGROUP:BCC_RD_62EC_W,0FFBFh
	mov	ax,57h
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
M007_@@STORE_SIZE:
	mov	bx,word ptr DGROUP:BCC_RD_E81E_W
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	ax,word ptr DGROUP:BCC_RD_62EC_W
	mov	word ptr es:[bx+4],ax
	mov	ax,6
	push	ax
	mov	ax,0E6h
	push	ax
	db	9Ah
	dw	X03D_05
	dw	seg X03D_05
	pop	bp
	retf
BCC_TYPE_CLOSE	endp
CO040_TEXT	ends

CO040_TEXT	segment byte public 'CODE'
		assume cs:CO040_TEXT,ds:DGROUP
BCC_TYPE_TABLE3	label	word
	dw	07F8h,07D1h,07D8h
	dw	07DFh,07E6h,07EDh
CO040_TEXT	ends


		extrn	X02C_22:far
		BCC_TYPE_SEGMENT	equ	6410h
		BCC_EXPR_SEGMENT	equ	639Ah
		BCC_EXPR_LINKSEG	equ	5F3Eh


CO040_TEXT	segment byte public 'CODE'
		assume	cs:CO040_TEXT,ds:DGROUP


BCC_TYPE_WRAP	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	di,word ptr [bp+0Ah]
	push	word ptr [bp+8]
	mov	ax,2
	push	ax
	db	9Ah
	dw	X02C_22
	dw	seg X02C_22
	mov	si,ax
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	word ptr es:[si+4],di
	mov	al,byte ptr es:[si+7]
	and	al,7
	or	al,78h
	mov	byte ptr es:[si+7],al
	mov	ax,word ptr [bp+4]
	mov	word ptr es:[si+8],ax
	or	byte ptr es:[si+6],2
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[di+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	ax,word ptr es:[bx+2]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	word ptr es:[si+0Ah],ax
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[di+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	word ptr es:[bx+2],si
	pop	di
	pop	si
	pop	bp
	dec	bp
	ret	8
BCC_TYPE_WRAP	endp
CO040_TEXT	ends


		extrn	X02D_00:far
		extrn	X02C_02:far
		extrn	X02C_18:far
		extrn	X02C_1E:far
		BCC_TYPE_SEGMENT	equ	6410h
		BCC_EXPR_SEGMENT	equ	639Ah
		BCC_EXPR_LINKSEG	equ	5F3Eh
		extrn	BCC_TREE_BASE:word
		BCC_RD_2E3E_W	equ	5F2Eh
		BCC_RD_A03E_B	equ	62A0h
		BCC_TREE_FLAG	equ	5EDAh
		BCC_RD_C23E_W	equ	5EC2h
		extrn	X019_00:far
		extrn	BCC_TYPE_NAME:word
		extrn	X03D_01:far
		extrn	BCC_ENUM_LIMIT_LO:word
		extrn	BCC_ENUM_LIMIT_HI:word
		extrn	X019_06:far
		extrn	X03F_0C:far
		BCC_RD_CC3E_B	equ	5ECCh
		extrn	X019_0A:far
		BCC_RD_E81E_W	equ	62E8h
		BCC_MEMBER_SEGMENT	equ	78A4h
		BCC_RD_B03E_B	equ	62B0h
		extrn	BCC_INT_LIMIT_LO:word
		extrn	BCC_INT_LIMIT_HI:word
		extrn	BCC_ENUM_MIN_LO:word
		extrn	BCC_ENUM_MIN_HI:word
		extrn	BCC_ENUM_MAX_LO:word
		extrn	BCC_ENUM_MAX_HI:word
		BCC_TYPE_PTR	equ	641Ch
		extrn	BCC_TYPE_INT:word
		extrn	X03D_05:far


CO040_TEXT	segment byte public 'CODE'
		assume	cs:CO040_TEXT,ds:DGROUP

		public	X040_01
X040_01	label	far
BCC_ENUM_BUILD	proc	far
	push	bp
	mov	bp,sp
	sub	sp,16h
	push	si
	push	di
	mov	byte ptr [bp-15h],0
	db	9Ah
	dw	X02D_00
	dw	seg X02D_00
	cmp	byte ptr [bp+6],0
	je	short M009_@@NEW_OUTER
	les	bx,[bp+8]
	push	word ptr es:[bx+9]
	db	9Ah
	dw	X02C_02
	dw	seg X02C_02
	jmp	short M009_@@HAVE_OUTER
M009_@@NEW_OUTER:
	xor	ax,ax
	push	ax
	mov	ax,1
	push	ax
	db	9Ah
	dw	X02C_18
	dw	seg X02C_18
M009_@@HAVE_OUTER:
	mov	di,ax
	mov	ax,15h
	push	ax
	db	9Ah
	dw	X02C_1E
	dw	seg X02C_1E
	mov	si,ax
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	word ptr es:[di+4],si
	mov	al,byte ptr es:[di+7]
	and	al,0F8h
	or	al,2
	mov	byte ptr es:[di+7],al
	mov	al,byte ptr es:[di+7]
	and	al,7
	push	ax
	cmp	byte ptr [bp+6],0
	je	short M009_@@OUTER_KIND
	mov	al,0Bh
	jmp	short M009_@@SET_KIND
M009_@@OUTER_KIND:
	mov	al,8
M009_@@SET_KIND:
	and	al,1Fh
	shl	al,1
	shl	al,1
	shl	al,1
	pop	dx
	or	dl,al
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	byte ptr es:[di+7],dl
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	word ptr es:[bx+2],0
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	word ptr es:[bx+6],di
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	ax,word ptr DGROUP:BCC_TREE_BASE
	mov	word ptr es:[bx+4],ax
	cmp	word ptr DGROUP:BCC_RD_2E3E_W,0
	je	short M009_@@CHECK_SCOPED
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	or	byte ptr es:[si+2],20h
	jmp	short M009_@@INIT_RANGES
M009_@@CHECK_SCOPED:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M009_@@INIT_RANGES
	cmp	word ptr DGROUP:BCC_TREE_FLAG,0
	je	short M009_@@INIT_RANGES
	mov	byte ptr [bp-15h],1
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	or	byte ptr es:[si+2],40h
M009_@@INIT_RANGES:
	mov	word ptr [bp-2],0FFFFh
	mov	word ptr [bp-4],0FFFFh
	mov	word ptr [bp-0Ch],0
	mov	word ptr [bp-0Eh],7FFFh
	mov	word ptr [bp-10h],0FFFFh
	mov	word ptr [bp-12h],8000h
	cmp	word ptr DGROUP:BCC_RD_C23E_W,31h
	jne	short M009_@@MISSING_NAME
	db	0E9h
	dw	0012Dh
M009_@@MISSING_NAME:
	mov	ax,0D4h
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
	db	0E9h
	dw	00121h
M009_@@NEXT_ITEM:
	mov	ax,word ptr DGROUP:BCC_TYPE_NAME
	mov	word ptr [bp-0Ah],ax
	db	9Ah
	dw	X02D_00
	dw	seg X02D_00
	cmp	word ptr DGROUP:BCC_RD_C23E_W,0Bh
	jne	short M009_@@IMPLICIT_VALUE
	db	9Ah
	dw	X02D_00
	dw	seg X02D_00
	mov	ax,8
	push	ax
	push	ss
	lea	ax,[bp-8]
	push	ax
	db	9Ah
	dw	X03D_01
	dw	seg X03D_01
	jmp	short M009_@@HAVE_VALUE
M009_@@IMPLICIT_VALUE:
	mov	ax,word ptr [bp-2]
	mov	dx,word ptr [bp-4]
	cmp	ax,word ptr DGROUP:BCC_ENUM_LIMIT_HI
	jg	short M009_@@VALUE_OVERFLOW
	jl	short M009_@@INCREMENT_VALUE
	cmp	dx,word ptr DGROUP:BCC_ENUM_LIMIT_LO
	jnc	short M009_@@VALUE_OVERFLOW
M009_@@INCREMENT_VALUE:
	mov	ax,word ptr [bp-2]
	mov	dx,word ptr [bp-4]
	add	dx,1
	adc	ax,0
	mov	word ptr [bp-6],ax
	mov	word ptr [bp-8],dx
	jmp	short M009_@@HAVE_VALUE
M009_@@VALUE_OVERFLOW:
	mov	ax,word ptr [bp-2]
	mov	dx,word ptr [bp-4]
	mov	word ptr [bp-6],ax
	mov	word ptr [bp-8],dx
	mov	ax,12Ah
	push	ax
	push	word ptr [bp-0Ah]
	db	9Ah
	dw	X019_06
	dw	seg X019_06
M009_@@HAVE_VALUE:
	mov	ax,word ptr [bp-6]
	mov	dx,word ptr [bp-8]
	cmp	ax,word ptr [bp-0Ch]
	jg	short M009_@@CHECK_MAX
	jl	short M009_@@UPDATE_MIN
	cmp	dx,word ptr [bp-0Eh]
	jnc	short M009_@@CHECK_MAX
M009_@@UPDATE_MIN:
	mov	ax,word ptr [bp-6]
	mov	dx,word ptr [bp-8]
	mov	word ptr [bp-0Ch],ax
	mov	word ptr [bp-0Eh],dx
M009_@@CHECK_MAX:
	mov	ax,word ptr [bp-6]
	mov	dx,word ptr [bp-8]
	cmp	ax,word ptr [bp-10h]
	jl	short M009_@@SAVE_CURRENT
	jg	short M009_@@UPDATE_MAX
	cmp	dx,word ptr [bp-12h]
	jbe	short M009_@@SAVE_CURRENT
M009_@@UPDATE_MAX:
	mov	ax,word ptr [bp-6]
	mov	dx,word ptr [bp-8]
	mov	word ptr [bp-10h],ax
	mov	word ptr [bp-12h],dx
M009_@@SAVE_CURRENT:
	mov	ax,word ptr [bp-6]
	mov	dx,word ptr [bp-8]
	mov	word ptr [bp-2],ax
	mov	word ptr [bp-4],dx
	cmp	byte ptr [bp-15h],0
	je	short M009_@@ADD_NEAR
	push	si
	push	word ptr [bp-0Ah]
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	db	9Ah
	dw	X03F_0C
	dw	seg X03F_0C
	jmp	short M009_@@AFTER_ADD
M009_@@ADD_NEAR:
	push	si
	push	word ptr [bp-0Ah]
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	db	0E8h
	dw	0FDB9h
M009_@@AFTER_ADD:
	cmp	word ptr DGROUP:BCC_RD_C23E_W,8
	jne	short M009_@@EXPECT_COMMA
	db	9Ah
	dw	X02D_00
	dw	seg X02D_00
	cmp	word ptr DGROUP:BCC_RD_C23E_W,31h
	je	short M009_@@FINISH_ITEMS
	cmp	word ptr DGROUP:BCC_RD_C23E_W,6
	jne	short M009_@@MISSING_COMMA
	cmp	byte ptr DGROUP:BCC_RD_CC3E_B,0
	jne	short M009_@@CONSUME_COMMA
M009_@@MISSING_COMMA:
	mov	ax,0D4h
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
M009_@@CONSUME_COMMA:
	mov	ax,6
	push	ax
	db	9Ah
	dw	X019_0A
	dw	seg X019_0A
	jmp	short M009_@@FINISH_ITEMS
M009_@@EXPECT_COMMA:
	cmp	word ptr DGROUP:BCC_RD_C23E_W,6
	je	short M009_@@FINISH_ITEMS
	mov	ax,28h
	push	ax
	db	9Ah
	dw	X019_00
	dw	seg X019_00
	mov	ax,6
	push	ax
	db	9Ah
	dw	X019_0A
	dw	seg X019_0A
M009_@@FINISH_ITEMS:
	cmp	word ptr DGROUP:BCC_RD_C23E_W,31h
	jne	short M009_@@FINISH_ENUM
	db	0E9h
	dw	0FED5h
M009_@@FINISH_ENUM:
	cmp	byte ptr [bp-15h],0
	je	short M009_@@SELECT_TYPE
	mov	bx,word ptr DGROUP:BCC_RD_E81E_W
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	bx,word ptr es:[bx+2]
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	or	byte ptr es:[bx+4],20h
M009_@@SELECT_TYPE:
	cmp	byte ptr DGROUP:BCC_RD_B03E_B,0
	je	short M009_@@CHECK_UNSIGNED
	jmp	short M009_@@DEFAULT_TYPE
M009_@@CHECK_UNSIGNED:
	cmp	word ptr [bp-0Ch],0
	jl	short M009_@@CHECK_SIGNED
	jne	short M009_@@UNSIGNED_RANGE
	cmp	word ptr [bp-0Eh],0
	jc	short M009_@@CHECK_SIGNED
M009_@@UNSIGNED_RANGE:
	mov	ax,word ptr [bp-10h]
	mov	dx,word ptr [bp-12h]
	cmp	ax,word ptr DGROUP:BCC_INT_LIMIT_HI
	jg	short M009_@@CHECK_SIGNED
	jne	short M009_@@UNSIGNED_TYPE
	cmp	dx,word ptr DGROUP:BCC_INT_LIMIT_LO
	ja	short M009_@@CHECK_SIGNED
M009_@@UNSIGNED_TYPE:
	les	bx,dword ptr DGROUP:BCC_TYPE_PTR
	mov	ax,word ptr es:[bx+4]
	jmp	short M009_@@STORE_TYPE
M009_@@CHECK_SIGNED:
	mov	ax,word ptr [bp-0Ch]
	mov	dx,word ptr [bp-0Eh]
	cmp	ax,word ptr DGROUP:BCC_ENUM_MIN_HI
	jl	short M009_@@DEFAULT_TYPE
	jne	short M009_@@SIGNED_UPPER
	cmp	dx,word ptr DGROUP:BCC_ENUM_MIN_LO
	jc	short M009_@@DEFAULT_TYPE
M009_@@SIGNED_UPPER:
	mov	ax,word ptr [bp-10h]
	mov	dx,word ptr [bp-12h]
	cmp	ax,word ptr DGROUP:BCC_ENUM_MAX_HI
	jg	short M009_@@DEFAULT_TYPE
	jne	short M009_@@SIGNED_TYPE
	cmp	dx,word ptr DGROUP:BCC_ENUM_MAX_LO
	ja	short M009_@@DEFAULT_TYPE
M009_@@SIGNED_TYPE:
	mov	ax,word ptr DGROUP:BCC_TYPE_INT
	jmp	short M009_@@STORE_TYPE
M009_@@DEFAULT_TYPE:
	mov	ax,word ptr DGROUP:BCC_TREE_BASE
M009_@@STORE_TYPE:
	mov	word ptr [bp-14h],ax
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	ax,word ptr [bp-14h]
	mov	word ptr es:[bx+4],ax
	mov	ax,6
	push	ax
	mov	ax,0E6h
	push	ax
	db	9Ah
	dw	X03D_05
	dw	seg X03D_05
	mov	ax,si
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf	6
BCC_ENUM_BUILD	endp
CO040_TEXT	ends

; END C131UNIT
		end
