; Recovered FBOV far-pointer references
		extrn	BCC_DEBUG_BUILD:far
		extrn	BCC_DIAGNOSTIC:far
		extrn	BCC_FAR_A7C4:far
		extrn	BCC_FAR_A9C1:far
		extrn	BCC_FAR_A9E0:far
		extrn	BCC_FAR_AB12:far
CO031_TEXT	segment byte public 'CODE'
CO031_TEXT	ends
CO043_TEXT	segment byte public 'CODE'
CO043_TEXT	ends
CO064_TEXT	segment byte public 'CODE'
CO064_TEXT	ends
CO069_TEXT	segment byte public 'CODE'
CO069_TEXT	ends
		public	X032_0A
		public	X032_0B
		public	X032_01
		public	X032_00
		public	X032_03
		public	X032_02
		public	X032_05
		public	X032_04
		public	X032_07
		public	X032_06
		public	X032_09
		public	X032_08
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1c9d_8246
; BEGIN C133UNIT (listing ovr_1c9d_8246:2460)
	extrn	BCC_RD_8274_W:word
	extrn	BCC_RD_827C_W:word
	extrn	BCC_RD_8292_W:word
	extrn	BCC_RD_828C_W:word
		extrn	BCC_RD_817C_W:word
		extrn	BCC_RD_817C_W:word


CO032_TEXT	segment byte public 'CODE'
	assume	cs:CO032_TEXT,ds:DGROUP

BCC_INPUT_POP	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	mov	bx,word ptr DGROUP:BCC_RD_817C_W
	mov	es,word ptr DGROUP:BCC_RD_8274_W
	mov	si,word ptr es:[bx+10]
	mov	word ptr DGROUP:BCC_RD_817C_W,si
	mov	ax,word ptr es:[si+6]
	mov	word ptr DGROUP:BCC_RD_827C_W,ax
	mov	ax,word ptr es:[si+8]
	add	ax,word ptr es:[si+4]
	mov	word ptr DGROUP:BCC_RD_8292_W,ax
	mov	ax,word ptr es:[si+8]
	add	ax,word ptr es:[si+2]
	mov	word ptr DGROUP:BCC_RD_828C_W,ax
	pop	si
	pop	bp
	dec	bp
	ret
BCC_INPUT_POP	endp
CO032_TEXT	ends

	extrn	BCC_RD_8274_W:word
	extrn	BCC_RD_827C_W:word
	extrn	BCC_RD_8292_W:word
	extrn	BCC_RD_828C_W:word
		extrn	BCC_RD_817C_W:word
		extrn	BCC_RD_817C_W:word
		extrn	BCC_RD_817C_W:word


CO032_TEXT	segment byte public 'CODE'
	assume	cs:CO032_TEXT,ds:DGROUP

BCC_INPUT_PUSH	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	mov	si,word ptr [bp+4]
	cmp	word ptr DGROUP:BCC_RD_817C_W,0
	je	short M001_@@LINK
	mov	bx,word ptr DGROUP:BCC_RD_817C_W
	mov	es,word ptr DGROUP:BCC_RD_8274_W
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	sub	ax,word ptr es:[bx+8]
	mov	word ptr es:[bx+4],ax
M001_@@LINK:
	mov	es,word ptr DGROUP:BCC_RD_8274_W
	mov	ax,word ptr DGROUP:BCC_RD_817C_W
	mov	word ptr es:[si+10],ax
	mov	word ptr DGROUP:BCC_RD_817C_W,si
	mov	ax,word ptr es:[si+6]
	mov	word ptr DGROUP:BCC_RD_827C_W,ax
	mov	ax,word ptr es:[si+8]
	add	ax,word ptr es:[si+4]
	mov	word ptr DGROUP:BCC_RD_8292_W,ax
	mov	ax,word ptr es:[si+8]
	add	ax,word ptr es:[si+2]
	mov	word ptr DGROUP:BCC_RD_828C_W,ax
	pop	si
	pop	bp
	dec	bp
	ret	2
BCC_INPUT_PUSH	endp
CO032_TEXT	ends

CO032_TEXT	segment byte public 'CODE'
		assume	cs:CO032_TEXT
; Original-image layout stub: not recovered source


X032_04	label	far
		db	055h,08Bh,0ECh,056h,057h,0FFh,076h,008h,0FFh,076h,006h,033h,0C0h,050h; ovr_1c9d_8246:24EA
		db	09Ah
		dw	01h
		dw	seg BCC_FAR_A9C1
		db	08Bh,0F8h,083h,0FFh,0FFh,075h,005h,033h,0C0h; ovr_1c9d_8246:24F8
		db	0E9h,0AAh,000h,01Eh,0B8h,074h,082h,050h,0B8h,016h,010h,050h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	08Bh,0F0h,08Eh,006h,074h,082h,026h,089h,03Ch,026h,0C7h; ovr_1c9d_8246:2506
		db	044h,002h,000h,000h,026h,0C7h,044h,006h,074h,082h,005h,016h,000h,026h	; ovr_1c9d_8246:2522
		db	089h,044h,008h,026h,0C7h,044h,004h,000h,000h,0A1h,0C4h,066h,026h,089h	; ovr_1c9d_8246:2530
		db	044h,00Ch,0A1h,0D3h,077h,026h,089h,044h,00Eh,0A1h,034h,082h,026h,089h	; ovr_1c9d_8246:253E
		db	044h,014h,056h,0E8h,044h,0FFh,089h,036h,084h,082h,01Eh,0B8h,046h,078h	; ovr_1c9d_8246:254C
		db	050h,0FFh,076h,008h,0FFh,076h,006h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h,050h; ovr_1c9d_8246:255A
		db	09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	0A3h,0C4h,066h,0FFh,036h,046h,078h,0FFh,036h; ovr_1c9d_8246:2568
		db	0C4h,066h,0FFh,076h,008h,0FFh,076h,006h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0C7h; ovr_1c9d_8246:2576
		db	006h,0D3h,077h,000h,000h,01Eh,0B8h,042h,024h,050h,090h,00Eh,0E8h,073h	; ovr_1c9d_8246:2584
		db	003h,08Eh,006h,074h,082h,026h,0C7h,044h,012h,000h,000h,0A1h,0D5h,077h	; ovr_1c9d_8246:2592
		db	026h,089h,044h,010h,0FFh,036h,0C4h,066h,09Ah
		dw	02Fh
		dw	seg CO064_TEXT
		db	0A3h; ovr_1c9d_8246:25A0
		db	0D5h,077h,0B8h,001h,000h,05Fh,05Eh,05Dh,0CAh,004h,000h,045h,055h,08Bh	; ovr_1c9d_8246:25AE
		db	0ECh,0B8h,0FFh,0FFh,05Dh,04Dh,0C3h; raw:25BC
X032_03	label	far
		db	055h,08Bh,0ECh,056h,057h,08Bh,07Eh; ovr_1c9d_8246:25BC
		db	006h,083h,03Eh,07Ch,081h,000h,075h,005h,033h,0C0h,0E9h,0EEh,000h,08Eh	; ovr_1c9d_8246:25CA
		db	006h,074h,082h,08Bh,01Eh,07Ch,081h,026h,081h,03Fh,0C9h,000h,075h,012h	; ovr_1c9d_8246:25D8
		db	0C7h,006h,07Ah,082h,000h,000h,0A1h,07Ch,081h,0A3h,078h,082h,0E8h,06Bh	; ovr_1c9d_8246:25E6
		db	0FEh,0E9h,0CAh,000h,08Bh,036h,07Ch,081h,08Eh,006h,074h,082h,08Bh,01Eh	; ovr_1c9d_8246:25F4
		db	07Ch,081h,026h,08Bh,007h,03Dh,0C9h,000h,074h,007h,03Dh,0CAh,000h,074h	; ovr_1c9d_8246:2602
		db	002h,0EBh,002h,0EBh,0D1h,08Eh,006h,074h,082h,026h,08Bh,044h,014h,03Bh	; ovr_1c9d_8246:2610
		db	006h,034h,082h,074h,01Bh,00Bh,0FFh,075h,017h,08Bh,01Eh,034h,082h,08Eh	; ovr_1c9d_8246:261E
		db	006h,058h,082h,026h,0FFh,077h,0FEh,0B8h,02Ah,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,059h,08Eh,006h,074h,082h,026h,08Bh,044h,014h,0A3h,034h; ovr_1c9d_8246:262C
		db	082h,08Bh,01Eh,07Ch,081h,026h,0FFh,037h,09Ah
		dw	04h
		dw	seg BCC_FAR_A7C4
		db	08Bh; ovr_1c9d_8246:2648
		db	01Eh,07Ch,081h,08Eh,006h,074h,082h,026h,083h,07Fh,00Ah,000h,075h,003h	; ovr_1c9d_8246:2656
		db	0E9h,06Bh,0FFh,08Eh,006h,074h,082h,026h,08Bh,044h,00Eh,0A3h,0D3h,077h	; ovr_1c9d_8246:2664
		db	026h,0FFh,074h,010h,09Ah
		dw	02Ah
		dw	seg CO064_TEXT
		db	0A3h,0D5h,077h,0A1h,0D3h; ovr_1c9d_8246:2672
		db	077h,0A3h,0BEh,066h,08Eh,006h,074h,082h,026h,08Bh,044h,00Ch,0A3h,0C4h	; ovr_1c9d_8246:2680
		db	066h,0C7h,006h,07Ah,082h,000h,000h,0A1h,07Ch,081h,0A3h,078h,082h,0E8h	; ovr_1c9d_8246:268E
		db	0C2h,0FDh,0A1h,07Ch,081h,0A3h,084h,082h,0C7h,006h,080h,082h,000h,000h	; ovr_1c9d_8246:269C
		db	08Bh,01Eh,07Ch,081h,08Eh,006h,074h,082h,026h,083h,07Fh,00Ah,000h,075h	; ovr_1c9d_8246:26AA
		db	009h,00Bh,0FFh,075h,005h,09Ah
		dw	039h
		dw	seg CO069_TEXT
		db	0B8h,001h,000h,05Fh; ovr_1c9d_8246:26B8
		db	05Eh,05Dh,0CAh,002h,000h; raw:26C6
X032_07	label	far
		db	055h,08Bh,0ECh,083h,0ECh,006h,056h,057h,08Bh; ovr_1c9d_8246:26C6
		db	07Eh,006h,083h,07Eh,00Ah,000h,074h,00Dh,08Bh,05Eh,00Ah,08Eh,006h,03Ah	; ovr_1c9d_8246:26D4
		db	078h,026h,0C7h,047h,002h,000h,000h,083h,03Eh,080h,082h,000h,074h,011h	; ovr_1c9d_8246:26E2
		db	08Bh,036h,080h,082h,08Eh,006h,074h,082h,026h,08Bh,044h,00Ah,0A3h,080h	; ovr_1c9d_8246:26F0
		db	082h,0EBh,019h,01Eh,0B8h,074h,082h,050h,0B8h,012h,000h,050h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	08Bh,0F0h,08Eh,006h,074h,082h,026h,0C7h,004h,0CAh,000h; ovr_1c9d_8246:26FE
		db	08Eh,006h,074h,082h,026h,0C7h,044h,004h,000h,000h,0F7h,0C7h,001h,000h	; ovr_1c9d_8246:271A
		db	074h,005h,0B8h,0A8h,086h,0EBh,003h,0B8h,090h,086h,08Eh,006h,074h,082h	; ovr_1c9d_8246:2728
		db	026h,089h,044h,006h,0F7h,0C7h,001h,000h,074h,005h,0A1h,0A8h,086h,0EBh	; ovr_1c9d_8246:2736
		db	003h,0A1h,090h,086h,089h,046h,0FEh,089h,07Eh,0FCh,0FFh,046h,0FCh,0C7h	; ovr_1c9d_8246:2744
		db	046h,0FAh,000h,000h,0EBh,006h,0FFh,046h,0FCh,0FFh,046h,0FAh,0C4h,05Eh	; ovr_1c9d_8246:2752
		db	0FCh,026h,080h,03Fh,000h,074h,006h,026h,0F6h,007h,080h,074h,0EBh,08Eh	; ovr_1c9d_8246:2760
		db	006h,074h,082h,08Bh,046h,0FAh,026h,089h,044h,002h,08Bh,046h,00Ah,026h	; ovr_1c9d_8246:276E
		db	089h,044h,00Eh,026h,089h,07Ch,010h,08Bh,046h,008h,026h,089h,044h,00Ch	; ovr_1c9d_8246:277C
		db	08Bh,0C7h,040h,026h,089h,044h,008h,056h,0E8h,001h,0FDh,05Fh,05Eh,08Bh	; ovr_1c9d_8246:278A
		db	0E5h,05Dh,0CAh,006h,000h	; ovr_1c9d_8246:2798

CO032_TEXT	ends

	extrn	BCC_POOL_F:word
	extrn	BCC_POOL_E:word


CO032_TEXT	segment byte public 'CODE'
	assume	cs:CO032_TEXT,ds:DGROUP

		public	X032_0A
X032_0A	label	far
BCC_INPUT_BYTE	proc	far
	push	bp
	mov	bp,sp
	push	si
	mov	si,word ptr [bp+6]
	test	si,1
	jz	short M003_@@EVEN
	mov	ax,word ptr DGROUP:BCC_POOL_F
	jmp	short M003_@@SELECTED
M003_@@EVEN:
	mov	ax,word ptr DGROUP:BCC_POOL_E
M003_@@SELECTED:
	db	08Eh,0C0h
	mov	al,byte ptr es:[si]
	pop	si
	pop	bp
	retf	2
BCC_INPUT_BYTE	endp
CO032_TEXT	ends

CO032_TEXT	segment byte public 'CODE'
		assume	cs:CO032_TEXT
; Original-image layout stub: not recovered source


		db	045h,055h,08Bh,0ECh,083h,0ECh,004h,056h,057h,083h,03Eh,080h,082h,000h	; ovr_1c9d_8246:27BC
		db	074h,011h,08Bh,036h,080h,082h,08Eh,006h,074h,082h,026h,08Bh,044h,00Ah	; ovr_1c9d_8246:27CA
		db	0A3h,080h,082h,0EBh,019h,01Eh,0B8h,074h,082h,050h,0B8h,012h,000h,050h	; ovr_1c9d_8246:27D8
		db	09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	08Bh,0F0h,08Eh,006h,074h,082h,026h,0C7h,004h; ovr_1c9d_8246:27E6
		db	0CAh,000h,08Eh,006h,074h,082h,026h,0C7h,044h,004h,000h,000h,0A1h,03Eh	; ovr_1c9d_8246:27F4
		db	082h,08Bh,056h,004h,089h,046h,0FEh,089h,056h,0FCh,033h,0FFh,0EBh,004h	; ovr_1c9d_8246:2802
		db	0FFh,046h,0FCh,047h,0C4h,05Eh,0FCh,026h,080h,03Fh,000h,074h,006h,026h	; ovr_1c9d_8246:2810
		db	0F6h,007h,080h,074h,0EDh,08Eh,006h,074h,082h,026h,089h,07Ch,002h,026h	; ovr_1c9d_8246:281E
		db	0C7h,044h,00Eh,000h,000h,026h,0C7h,044h,010h,000h,000h,026h,0C7h,044h	; ovr_1c9d_8246:282C
		db	00Ch,000h,000h,026h,0C7h,044h,006h,03Eh,082h,08Bh,046h,004h,026h,089h	; ovr_1c9d_8246:283A
		db	044h,008h,0FFh,006h,0D7h,077h,056h,0E8h,044h,0FCh,05Fh,05Eh,08Bh,0E5h	; ovr_1c9d_8246:2848
		db	05Dh,04Dh,0C2h,002h,000h,045h,055h,08Bh,0ECh,083h,0ECh,004h,056h,057h	; ovr_1c9d_8246:2856
		db	083h,03Eh,080h,082h,000h,074h,011h,08Bh,036h,080h,082h,08Eh,006h,074h	; ovr_1c9d_8246:2864
		db	082h,026h,08Bh,044h,00Ah,0A3h,080h,082h,0EBh,019h,01Eh,0B8h,074h,082h	; ovr_1c9d_8246:2872
		db	050h,0B8h,012h,000h,050h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	08Bh,0F0h,08Eh,006h; ovr_1c9d_8246:2880
		db	074h,082h,026h,0C7h,004h,0CAh,000h,08Eh,006h,074h,082h,026h,0C7h,044h	; ovr_1c9d_8246:288E
		db	004h,000h,000h,0A1h,046h,082h,08Bh,056h,004h,089h,046h,0FEh,089h,056h	; ovr_1c9d_8246:289C
		db	0FCh,033h,0FFh,0EBh,016h,0C4h,05Eh,0FCh,026h,0F6h,007h,080h,075h,016h	; ovr_1c9d_8246:28AA
		db	0C4h,05Eh,0FCh,026h,080h,03Fh,01Ah,074h,00Dh,0FFh,046h,0FCh,047h,0C4h	; ovr_1c9d_8246:28B8
		db	05Eh,0FCh,026h,080h,03Fh,000h,075h,0E1h,08Eh,006h,074h,082h,026h,089h	; ovr_1c9d_8246:28C6
		db	07Ch,002h,026h,0C7h,044h,00Eh,000h,000h,026h,0C7h,044h,010h,000h,000h	; ovr_1c9d_8246:28D4
		db	026h,0C7h,044h,00Ch,000h,000h,026h,0C7h,044h,006h,046h,082h,08Bh,046h	; ovr_1c9d_8246:28E2
		db	004h,026h,089h,044h,008h,0FFh,006h,0D7h,077h,056h,0E8h,099h,0FBh,05Fh	; ovr_1c9d_8246:28F0
		db	05Eh,08Bh,0E5h,05Dh,04Dh,0C2h,002h,000h	; ovr_1c9d_8246:28FE

CO032_TEXT	ends

	extrn	X043_02:far
	extrn	BCC_STRING_LENGTH:far
	extrn	BCC_STRING_DATA:word
		extrn	BCC_RD_8274_W:word
		extrn	BCC_RD_8274_W:word


CO032_TEXT	segment byte public 'CODE'
	assume	cs:CO032_TEXT,ds:DGROUP

		public	X032_08
X032_08	label	far
BCC_INPUT_STRING	proc	far
	push	bp
	mov	bp,sp
	push	si
	mov	ax,word ptr [bp+8]
	mov	word ptr DGROUP:BCC_STRING_DATA,ax
	push	ds
	mov	ax,offset DGROUP:BCC_RD_8274_W
	push	ax
	mov	ax,12
	push	ax
	db	9Ah
	dw	X043_02
	dw	seg X043_02
	mov	si,ax
	mov	es,word ptr DGROUP:BCC_RD_8274_W
	mov	word ptr es:[si],201
	mov	word ptr es:[si+6],offset DGROUP:BCC_STRING_DATA
	mov	ax,word ptr [bp+6]
	mov	word ptr es:[si+8],ax
	mov	word ptr es:[si+4],0
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	mov	es,word ptr DGROUP:BCC_RD_8274_W
	mov	word ptr es:[si+2],ax
	push	si
	db	0E8h,043h,0FBh
	pop	si
	pop	bp
	retf	4
BCC_INPUT_STRING	endp
CO032_TEXT	ends


	extrn	X043_02:far
	extrn	BCC_STRING_LENGTH:far
		extrn	BCC_RD_8274_W:word
		extrn	BCC_RD_8274_W:word


CO032_TEXT	segment byte public 'CODE'
	assume	cs:CO032_TEXT,ds:DGROUP

		public	X032_06
X032_06	label	far
BCC_INPUT_STRING_PTR	proc	far
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	di,word ptr [bp+8]
	push	ds
	mov	ax,offset DGROUP:BCC_RD_8274_W
	push	ax
	mov	ax,12
	push	ax
	db	9Ah
	dw	X043_02
	dw	seg X043_02
	mov	si,ax
	mov	es,word ptr DGROUP:BCC_RD_8274_W
	mov	word ptr es:[si],201
	mov	word ptr es:[si+6],di
	mov	ax,word ptr [bp+6]
	mov	word ptr es:[si+8],ax
	mov	word ptr es:[si+4],0
	push	word ptr [di]
	push	word ptr [bp+6]
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	mov	es,word ptr DGROUP:BCC_RD_8274_W
	mov	word ptr es:[si+2],ax
	push	si
	db	0E8h,0F6h,0FAh
	pop	di
	pop	si
	pop	bp
	retf	4
BCC_INPUT_STRING_PTR	endp
CO032_TEXT	ends

CO032_TEXT	segment byte public 'CODE'
		assume	cs:CO032_TEXT
; Original-image layout stub: not recovered source


X032_05	label	far
		db	055h,08Bh,0ECh,083h,0ECh,006h,056h,057h,08Eh,006h,074h,082h,08Bh,01Eh; ovr_1c9d_8246:29A6
		db	07Ch,081h,026h,08Bh,007h,03Dh,0C9h,000h,075h,003h,0E9h,042h,003h,03Dh	; ovr_1c9d_8246:29B4
		db	0CAh,000h,075h,003h,0E9h,0B2h,000h,0EBh,000h,08Bh,01Eh,07Ch,081h,08Eh	; ovr_1c9d_8246:29C2
		db	006h,074h,082h,026h,08Bh,05Fh,006h,08Ch,0D8h,039h,007h,075h,007h,0C7h	; ovr_1c9d_8246:29D0
		db	046h,0FEh,000h,000h,0EBh,025h,08Eh,006h,074h,082h,08Bh,01Eh,07Ch,081h	; ovr_1c9d_8246:29DE
		db	026h,0FFh,037h,026h,08Bh,05Fh,006h,0FFh,037h,08Bh,01Eh,07Ch,081h,026h	; ovr_1c9d_8246:29EC
		db	0FFh,077h,008h,0B8h,000h,010h,050h,09Ah
		dw	00h
		dw	seg BCC_FAR_A9E0
		db	089h,046h; ovr_1c9d_8246:29FA
		db	0FEh,083h,07Eh,0FEh,000h,07Eh,031h,08Bh,01Eh,07Ch,081h,08Eh,006h,074h	; ovr_1c9d_8246:2A08
		db	082h,026h,08Bh,047h,002h,026h,001h,047h,012h,08Bh,046h,0FEh,026h,089h	; ovr_1c9d_8246:2A16
		db	047h,002h,026h,0C7h,047h,004h,001h,000h,026h,08Bh,047h,008h,0A3h,092h	; ovr_1c9d_8246:2A24
		db	082h,026h,08Bh,047h,008h,003h,046h,0FEh,0A3h,08Ch,082h,0E9h,0DEh,002h	; ovr_1c9d_8246:2A32
		db	08Ch,01Eh,08Ah,082h,08Bh,01Eh,07Ch,081h,08Eh,006h,074h,082h,026h,0C7h	; ovr_1c9d_8246:2A40
		db	047h,006h,08Ah,082h,026h,0C7h,047h,004h,001h,000h,026h,0C7h,047h,002h	; ovr_1c9d_8246:2A4E
		db	002h,000h,026h,0C7h,047h,008h,040h,024h,0C7h,006h,07Ch,082h,08Ah,082h	; ovr_1c9d_8246:2A5C
		db	0C7h,006h,092h,082h,041h,024h,0C7h,006h,08Ch,082h,042h,024h,0B0h,00Ah	; ovr_1c9d_8246:2A6A
		db	0E9h,0B4h,002h,08Bh,036h,07Ch,081h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh	; ovr_1c9d_8246:2A78
		db	01Eh,08Ch,082h,026h,08Ah,007h,0B4h,000h,089h,046h,0FEh,00Bh,0C0h,075h	; ovr_1c9d_8246:2A86
		db	05Ch,08Eh,006h,074h,082h,026h,083h,07Ch,00Eh,000h,074h,010h,026h,08Bh	; ovr_1c9d_8246:2A94
		db	044h,010h,026h,08Bh,05Ch,00Eh,08Eh,006h,03Ah,078h,026h,089h,047h,002h	; ovr_1c9d_8246:2AA2
		db	0FFh,00Eh,0D7h,077h,083h,03Eh,0D7h,077h,000h,075h,021h,0C7h,006h,044h	; ovr_1c9d_8246:2AB0
		db	082h,000h,000h,0C7h,006h,042h,082h,001h,000h,0C7h,006h,04Ch,082h,000h	; ovr_1c9d_8246:2ABE
		db	000h,0C7h,006h,04Ah,082h,001h,000h,0C7h,006h,080h,082h,000h,000h,0E9h	; ovr_1c9d_8246:2ACC
		db	027h,002h,0E8h,081h,0F9h,08Eh,006h,074h,082h,0A1h,080h,082h,026h,089h	; ovr_1c9d_8246:2ADA
		db	044h,00Ah,089h,036h,080h,082h,0E9h,021h,002h,0A1h,08Ch,082h,040h,08Bh	; ovr_1c9d_8246:2AE8
		db	0F8h,08Bh,046h,0FEh,089h,046h,0FAh,0B9h,006h,000h,0BBh,0D5h,008h,02Eh	; ovr_1c9d_8246:2AF6
		db	08Bh,007h,03Bh,046h,0FAh,074h,007h,043h,043h,0E2h,0F4h,0E9h,010h,001h	; ovr_1c9d_8246:2B04
		db	02Eh,0FFh,067h,00Ch,0C6h,006h,0DCh,077h,001h,08Bh,01Eh,07Ch,082h,08Eh	; ovr_1c9d_8246:2B12
		db	007h,026h,08Ah,005h,0B4h,000h,089h,046h,0FEh,0F7h,046h,0FEh,080h,000h	; ovr_1c9d_8246:2B20
		db	074h,04Ch,081h,07Eh,0FEh,0FBh,000h,07Dh,045h,047h,081h,066h,0FEh,07Fh	; ovr_1c9d_8246:2B2E
		db	000h,08Eh,006h,074h,082h,026h,08Bh,044h,00Ch,089h,046h,0FCh,081h,066h	; ovr_1c9d_8246:2B3C
		db	0FEh,07Fh,000h,0EBh,017h,083h,046h,0FCh,002h,0FFh,036h,03Eh,082h,0FFh	; ovr_1c9d_8246:2B4A
		db	076h,0FCh,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h,001h,046h,0FCh,0FFh,04Eh,0FEh; ovr_1c9d_8246:2B58
		db	083h,07Eh,0FEh,001h,07Fh,0E3h,08Eh,006h,03Eh,082h,08Bh,05Eh,0FCh,026h	; ovr_1c9d_8246:2B66
		db	0FFh,037h,0E8h,0E2h,0FCh,0E9h,002h,001h,0E9h,0FFh,000h,08Bh,01Eh,07Ch	; ovr_1c9d_8246:2B74
		db	082h,08Eh,007h,026h,08Ah,005h,0B4h,000h,089h,046h,0FEh,047h,0F7h,046h	; ovr_1c9d_8246:2B82
		db	0FEh,080h,000h,074h,007h,081h,07Eh,0FEh,0FBh,000h,07Ch,00Eh,0B8h,055h	; ovr_1c9d_8246:2B90
		db	000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,04Fh,0E9h,0D4h,000h,08Eh,006h; ovr_1c9d_8246:2B9E
		db	074h,082h,026h,08Bh,044h,00Ch,089h,046h,0FCh,081h,066h,0FEh,07Fh,000h	; ovr_1c9d_8246:2BAC
		db	0EBh,017h,083h,046h,0FCh,002h,0FFh,036h,03Eh,082h,0FFh,076h,0FCh,09Ah	; ovr_1c9d_8246:2BBA
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h,001h,046h,0FCh,0FFh,04Eh,0FEh,083h,07Eh,0FEh; ovr_1c9d_8246:2BC8
		db	001h,07Fh,0E3h,08Eh,006h,03Eh,082h,08Bh,05Eh,0FCh,026h,08Bh,007h,0A3h	; ovr_1c9d_8246:2BD6
		db	056h,082h,01Eh,0B8h,044h,024h,050h,00Eh,0E8h,017h,0FDh,0E9h,08Ch,000h	; ovr_1c9d_8246:2BE4
		db	0C7h,046h,0FEh,000h,000h,0C6h,006h,0DAh,077h,001h,0E9h,084h,000h,08Bh	; ovr_1c9d_8246:2BF2
		db	01Eh,07Ch,082h,08Eh,007h,026h,08Ah,005h,0B4h,000h,089h,046h,0FEh,047h	; ovr_1c9d_8246:2C00
		db	0EBh,073h,08Eh,006h,074h,082h,026h,083h,07Ch,010h,000h,075h,068h,0C7h	; ovr_1c9d_8246:2C0E
		db	046h,0FEh,000h,000h,0EBh,061h,081h,066h,0FEh,07Fh,000h,08Eh,006h,074h	; ovr_1c9d_8246:2C1C
		db	082h,026h,08Bh,044h,00Ch,089h,046h,0FCh,081h,066h,0FEh,07Fh,000h,0EBh	; ovr_1c9d_8246:2C2A
		db	017h,083h,046h,0FCh,002h,0FFh,036h,03Eh,082h,0FFh,076h,0FCh,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h,001h,046h,0FCh,0FFh,04Eh,0FEh,083h,07Eh,0FEh,001h; ovr_1c9d_8246:2C38
		db	07Fh,0E3h,08Eh,006h,074h,082h,026h,08Bh,05Ch,006h,08Eh,007h,026h,080h	; ovr_1c9d_8246:2C54
		db	03Dh,0FEh,075h,00Fh,08Eh,006h,03Eh,082h,08Bh,05Eh,0FCh,026h,0FFh,037h	; ovr_1c9d_8246:2C62
		db	0E8h,0E8h,0FBh,0EBh,009h,08Bh,046h,0FCh,040h,040h,050h,0E8h,03Eh,0FBh	; ovr_1c9d_8246:2C70
		db	0C7h,046h,0FEh,000h,000h,08Eh,006h,074h,082h,026h,089h,07Ch,008h,0A1h	; ovr_1c9d_8246:2C7E
		db	074h,082h,03Bh,006h,074h,082h,075h,00Dh,03Bh,036h,07Ch,081h,075h,007h	; ovr_1c9d_8246:2C8C
		db	089h,03Eh,092h,082h,0EBh,001h,047h,08Eh,006h,074h,082h,026h,08Bh,05Ch	; ovr_1c9d_8246:2C9A
		db	006h,08Eh,007h,026h,080h,03Dh,000h,074h,020h,08Eh,006h,074h,082h,026h	; ovr_1c9d_8246:2CA8
		db	08Bh,05Ch,006h,08Eh,007h,026h,0F6h,005h,080h,075h,010h,08Eh,006h,074h	; ovr_1c9d_8246:2CB6
		db	082h,026h,08Bh,05Ch,006h,08Eh,007h,026h,080h,03Dh,01Ah,075h,0CFh,08Eh	; ovr_1c9d_8246:2CC4
		db	006h,074h,082h,026h,0C7h,044h,004h,000h,000h,08Bh,0C7h,026h,02Bh,044h	; ovr_1c9d_8246:2CD2
		db	008h,026h,089h,044h,002h,0A1h,074h,082h,03Bh,006h,074h,082h,075h,00Ah	; ovr_1c9d_8246:2CE0
		db	03Bh,036h,07Ch,081h,075h,004h,089h,03Eh,08Ch,082h,083h,07Eh,0FEh,000h	; ovr_1c9d_8246:2CEE
		db	074h,014h,08Ah,046h,0FEh,0EBh,02Ch,0C7h,006h,07Ah,082h,000h,000h,0A1h	; ovr_1c9d_8246:2CFC
		db	07Ch,081h,0A3h,078h,082h,0E8h,04Eh,0F7h,0A1h,092h,082h,03Bh,006h,08Ch	; ovr_1c9d_8246:2D0A
		db	082h,072h,003h,0E9h,090h,0FCh,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh	; ovr_1c9d_8246:2D18
		db	092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,05Fh,05Eh,08Bh,0E5h,05Dh	; ovr_1c9d_8246:2D26
		db	0CBh,01Ah,000h,0FBh,000h,0FCh,000h,0FDh,000h,0FEh,000h,0FFh,000h,0B0h	; ovr_1c9d_8246:2D34
		db	007h,023h,008h,092h,007h,01Fh,007h,0B6h,006h,09Fh,007h; raw:2D42
X032_01	label	far
		db	055h,08Bh,0ECh; ovr_1c9d_8246:2D42
		db	04Ch,04Ch,056h,08Ah,046h,00Ch,050h,0FFh,05Eh,008h,083h,03Eh,056h,082h	; ovr_1c9d_8246:2D50
		db	000h,075h,003h,0E9h,0CFh,000h,08Bh,036h,056h,082h,0EBh,049h,08Eh,006h	; ovr_1c9d_8246:2D5E
		db	046h,082h,026h,080h,03Ch,01Ah,074h,049h,08Eh,006h,046h,082h,026h,080h	; ovr_1c9d_8246:2D6C
		db	03Ch,022h,074h,006h,026h,080h,03Ch,05Ch,075h,008h,0B0h,05Ch,050h,0FFh	; ovr_1c9d_8246:2D7A
		db	05Eh,008h,0EBh,01Bh,08Eh,006h,046h,082h,026h,080h,03Ch,0FCh,074h,01Ch	; ovr_1c9d_8246:2D88
		db	026h,080h,03Ch,0FBh,074h,016h,08Eh,006h,046h,082h,026h,080h,03Ch,0FFh	; ovr_1c9d_8246:2D96
		db	075h,001h,046h,08Eh,006h,046h,082h,026h,08Ah,004h,050h,0FFh,05Eh,008h	; ovr_1c9d_8246:2DA4
		db	046h,08Eh,006h,046h,082h,026h,080h,03Ch,000h,075h,0ADh,08Ah,046h,00Ch	; ovr_1c9d_8246:2DB2
		db	050h,0FFh,05Eh,008h,0C7h,006h,056h,082h,000h,000h,0B8h,001h,000h,0E9h	; ovr_1c9d_8246:2DC0
		db	0BBh,000h,083h,07Eh,0FEh,05Ch,075h,044h,0A1h,092h,082h,03Bh,006h,08Ch	; ovr_1c9d_8246:2DCE
		db	082h,072h,006h,00Eh,0E8h,0C3h,0FBh,0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh	; ovr_1c9d_8246:2DDC
		db	007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h	; ovr_1c9d_8246:2DEA
		db	089h,046h,0FEh,083h,07Eh,0FEh,00Dh,074h,00Eh,083h,07Eh,0FEh,00Ah,074h	; ovr_1c9d_8246:2DF8
		db	008h,0B0h,05Ch,050h,0FFh,05Eh,008h,0EBh,01Dh,08Ah,046h,0FEh,050h,09Ah	; ovr_1c9d_8246:2E06
		dw	04Dh
		dw	seg CO031_TEXT
		db	0EBh,019h,08Ah,046h,00Ch,098h,03Bh,046h,0FEh,075h; ovr_1c9d_8246:2E14
		db	009h,08Ah,046h,0FEh,050h,0FFh,05Eh,008h,0EBh,09Eh,08Ah,046h,0FEh,050h	; ovr_1c9d_8246:2E22
		db	0FFh,05Eh,008h,0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,006h,00Eh,0E8h	; ovr_1c9d_8246:2E30
		db	066h,0FBh,0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h	; ovr_1c9d_8246:2E3E
		db	0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h,089h,046h,0FEh,03Dh,01Ah	; ovr_1c9d_8246:2E4C
		db	000h,074h,00Fh,083h,07Eh,0FEh,00Ah,074h,009h,083h,07Eh,0FEh,00Dh,074h	; ovr_1c9d_8246:2E5A
		db	003h,0E9h,064h,0FFh,083h,07Eh,006h,000h,074h,013h,0B8h,056h,000h,050h	; ovr_1c9d_8246:2E68
		db	09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,08Ah,046h,00Ch,050h,0FFh,05Eh,008h,0EBh; ovr_1c9d_8246:2E76
		db	000h,0FFh,00Eh,092h,082h,033h,0C0h,05Eh,08Bh,0E5h,05Dh,0CAh,008h,000h	; ovr_1c9d_8246:2E84

CO032_TEXT	ends

	extrn	BCC_RD_817C_W:word
	extrn	BCC_RD_8274_W:word
	extrn	BCC_RD_8292_W:word
		extrn	BCC_RD_8284_W:word
		extrn	BCC_RD_8284_W:word


CO032_TEXT	segment byte public 'CODE'
	assume	cs:CO032_TEXT,ds:DGROUP

		public	X032_0B
X032_0B	label	far
BCC_INPUT_POSITION	proc	far
	push	bp
	mov	bp,sp
	mov	ax,word ptr DGROUP:BCC_RD_817C_W
	cmp	ax,word ptr DGROUP:BCC_RD_8284_W
	jne	short M008_@@SAVED_POSITION
	mov	es,word ptr DGROUP:BCC_RD_8274_W
	mov	bx,word ptr DGROUP:BCC_RD_8284_W
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	sub	ax,word ptr es:[bx+8]
	jmp	short M008_@@ADD_BASE
M008_@@SAVED_POSITION:
	mov	es,word ptr DGROUP:BCC_RD_8274_W
	mov	bx,word ptr DGROUP:BCC_RD_8284_W
	mov	ax,word ptr es:[bx+4]
M008_@@ADD_BASE:
	mov	bx,word ptr DGROUP:BCC_RD_8284_W
	mov	es,word ptr DGROUP:BCC_RD_8274_W
	push	ax
	mov	ax,word ptr es:[bx+18]
	pop	dx
	add	ax,dx
	xor	dx,dx
	pop	bp
	retf
BCC_INPUT_POSITION	endp
CO032_TEXT	ends


	extrn	BCC_BUFFER_ALLOC:far
	extrn	BCC_INPUT_HANDLE:word
	extrn	BCC_INPUT_LINE:word
	extrn	BCC_RD_8274_W:word
	extrn	BCC_RD_8284_W:word
	extrn	BCC_INPUT_BUFFER_SEG:word
	extrn	BCC_INPUT_BUFFER_OFF:word
	extrn	BCC_RD_8282_W:word
		extrn	BCC_RD_827E_W:word
		extrn	BCC_RD_827E_W:word


CO032_TEXT	segment byte public 'CODE'
	assume	cs:CO032_TEXT,ds:DGROUP

		public	X032_00
X032_00	label	far
BCC_INPUT_OPEN	proc	far
	push	bp
	mov	bp,sp
	mov	ax,word ptr [bp+12]
	dec	ax
	mov	word ptr DGROUP:BCC_INPUT_HANDLE,ax
	mov	ax,word ptr DGROUP:BCC_INPUT_LINE
	cmp	ax,word ptr [bp+10]
	jne	short M009_@@LINE_MISMATCH
	mov	es,word ptr DGROUP:BCC_RD_8274_W
	mov	bx,word ptr DGROUP:BCC_RD_8284_W
	mov	ax,word ptr es:[bx]
	mov	word ptr DGROUP:BCC_RD_827E_W,ax
	cmp	word ptr DGROUP:BCC_RD_827E_W,200
	jc	short M009_@@ALLOCATE
	cmp	word ptr DGROUP:BCC_RD_827E_W,203
	ja	short M009_@@ALLOCATE
M009_@@RESET_TYPE:
	mov	word ptr DGROUP:BCC_RD_827E_W,0
	jmp	short M009_@@EPILOGUE
M009_@@LINE_MISMATCH:
	jmp	short M009_@@RESET_TYPE
M009_@@ALLOCATE:
	push	word ptr DGROUP:BCC_RD_827E_W
	xor	ax,ax
	xor	dx,dx
	push	ax
	push	dx
	mov	ax,1
	push	ax
	db	9Ah
	dw	BCC_BUFFER_ALLOC
	dw	seg BCC_BUFFER_ALLOC
	mov	word ptr DGROUP:BCC_INPUT_BUFFER_SEG,dx
	mov	word ptr DGROUP:BCC_INPUT_BUFFER_OFF,ax
	push	word ptr DGROUP:BCC_RD_827E_W
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	xor	ax,ax
	push	ax
	db	9Ah
	dw	BCC_BUFFER_ALLOC
	dw	seg BCC_BUFFER_ALLOC
	mov	word ptr DGROUP:BCC_RD_8282_W,0
M009_@@EPILOGUE:
	pop	bp
	retf	8
BCC_INPUT_OPEN	endp
CO032_TEXT	ends


	extrn	BCC_INPUT_READ:far
	extrn	BCC_INPUT_UNGET_CHAR:word
	extrn	BCC_RD_827E_W:word
		extrn	BCC_RD_8282_W:word
		extrn	BCC_RD_8282_W:word


CO032_TEXT	segment byte public 'CODE'
	assume	cs:CO032_TEXT,ds:DGROUP

BCC_INPUT_GET	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	cmp	word ptr DGROUP:BCC_RD_8282_W,0
	je	short M00A_@@READ
	mov	word ptr DGROUP:BCC_RD_8282_W,0
	mov	ax,word ptr DGROUP:BCC_INPUT_UNGET_CHAR
	jmp	short M00A_@@EPILOGUE
M00A_@@READ:
	push	word ptr DGROUP:BCC_RD_827E_W
	push	ss
	lea	ax,[bp-2]
	push	ax
	mov	ax,1
	push	ax
	db	9Ah
	dw	BCC_INPUT_READ
	dw	seg BCC_INPUT_READ
	cmp	ax,1
	jne	short M00A_@@EOF
	mov	ax,word ptr [bp-2]
	and	ax,0ffh
	jmp	short M00A_@@EPILOGUE
M00A_@@EOF:
	mov	ax,26
M00A_@@EPILOGUE:
	mov	sp,bp
	pop	bp
	dec	bp
	ret
BCC_INPUT_GET	endp
CO032_TEXT	ends


	extrn	BCC_RD_8282_W:word
	extrn	BCC_INPUT_UNGET_CHAR:word


CO032_TEXT	segment byte public 'CODE'
	assume	cs:CO032_TEXT,ds:DGROUP

BCC_INPUT_UNGET	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	mov	word ptr DGROUP:BCC_RD_8282_W,1
	mov	ax,word ptr [bp+4]
	mov	word ptr DGROUP:BCC_INPUT_UNGET_CHAR,ax
	pop	bp
	dec	bp
	ret	2
BCC_INPUT_UNGET	endp
CO032_TEXT	ends


	extrn	BCC_OUTPUT_STRING:far
	extrn	BCC_OUTPUT_CHAR:far
	extrn	BCC_RD_827E_W:word
	extrn	BCC_INPUT_HANDLE:word
	extrn	BCC_DUMP_PREFIX:byte
	extrn	BCC_DUMP_SUFFIX:byte
	extrn	BCC_DUMP_INDENT:byte


CO032_TEXT	segment byte public 'CODE'
	assume	cs:CO032_TEXT,ds:DGROUP

		public	X032_02
X032_02	label	far
BCC_INPUT_DUMP	proc	far
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	push	si
	push	di
	mov	si,word ptr [bp+6]
	cmp	word ptr DGROUP:BCC_RD_827E_W,0
	jne	short M00C_@@CHECK_HANDLE
	jmp	M00C_@@EPILOGUE
M00C_@@CHECK_HANDLE:
	cmp	word ptr DGROUP:BCC_INPUT_HANDLE,si
	jc	short M00C_@@BEGIN
	jmp	M00C_@@EPILOGUE
M00C_@@BEGIN:
	push	ds
	mov	ax,offset DGROUP:BCC_DUMP_PREFIX
	push	ax
	db	9Ah
	dw	BCC_OUTPUT_STRING
	dw	seg BCC_OUTPUT_STRING
	jmp	short M00C_@@LINE_TEST
M00C_@@NEXT_LINE:
	xor	di,di
	push	ds
	mov	ax,offset DGROUP:BCC_DUMP_INDENT
	push	ax
	db	9Ah
	dw	BCC_OUTPUT_STRING
	dw	seg BCC_OUTPUT_STRING
M00C_@@READ_CHAR:
	db	0E8h,074h,0FFh
	mov	word ptr [bp-2],ax
	cmp	word ptr [bp-2],13
	jne	short M00C_@@CHECK_LF
	db	0E8h,068h,0FFh
	mov	word ptr [bp-2],ax
	cmp	word ptr [bp-2],10
	je	short M00C_@@END_LINE
	push	word ptr [bp-2]
	db	0E8h,098h,0FFh
	jmp	short M00C_@@END_LINE
M00C_@@CHECK_LF:
	cmp	word ptr [bp-2],10
	jne	short M00C_@@CHECK_EOF
	db	0E8h,04Eh,0FFh
	mov	word ptr [bp-2],ax
	cmp	word ptr [bp-2],13
	je	short M00C_@@END_LINE
	push	word ptr [bp-2]
	db	0E8h,07Eh,0FFh
	jmp	short M00C_@@END_LINE
M00C_@@CHECK_EOF:
	cmp	word ptr [bp-2],26
	jne	short M00C_@@COPY_CHAR
	mov	ax,si
	dec	ax
	mov	word ptr DGROUP:BCC_INPUT_HANDLE,ax
	jmp	short M00C_@@END_LINE
M00C_@@COPY_CHAR:
	cmp	di,128
	jge	short M00C_@@READ_CHAR
	mov	al,byte ptr [bp-2]
	push	ax
	db	9Ah
	dw	BCC_OUTPUT_CHAR
	dw	seg BCC_OUTPUT_CHAR
	inc	di
	jmp	short M00C_@@READ_CHAR
M00C_@@END_LINE:
	push	ds
	mov	ax,offset DGROUP:BCC_DUMP_SUFFIX
	push	ax
	db	9Ah
	dw	BCC_OUTPUT_STRING
	dw	seg BCC_OUTPUT_STRING
	inc	word ptr DGROUP:BCC_INPUT_HANDLE
M00C_@@LINE_TEST:
	cmp	word ptr DGROUP:BCC_INPUT_HANDLE,si
	jc	short M00C_@@NEXT_LINE
	push	ds
	mov	ax,offset DGROUP:BCC_DUMP_PREFIX
	push	ax
	db	9Ah
	dw	BCC_OUTPUT_STRING
	dw	seg BCC_OUTPUT_STRING
M00C_@@EPILOGUE:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf	2
BCC_INPUT_DUMP	endp
CO032_TEXT	ends


	extrn	BCC_INPUT_FLUSH:far
	extrn	BCC_RD_8290_W:word
	extrn	BCC_RD_828E_W:word
		extrn	BCC_RD_827E_W:word
		extrn	BCC_RD_827E_W:word


CO032_TEXT	segment byte public 'CODE'
	assume	cs:CO032_TEXT,ds:DGROUP

		public	X032_09
X032_09	label	far
BCC_INPUT_CLOSE	proc	far
	push	bp
	mov	bp,sp
	cmp	word ptr DGROUP:BCC_RD_827E_W,0
	je	short M00D_@@DONE
	push	word ptr DGROUP:BCC_RD_827E_W
	push	word ptr DGROUP:BCC_RD_8290_W
	push	word ptr DGROUP:BCC_RD_828E_W
	xor	ax,ax
	push	ax
	db	9Ah
	dw	BCC_INPUT_FLUSH
	dw	seg BCC_INPUT_FLUSH
M00D_@@DONE:
	pop	bp
	retf
BCC_INPUT_CLOSE	endp
CO032_TEXT	ends

; END C133UNIT
		end
