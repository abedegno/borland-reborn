; Recovered FBOV far-pointer references
		extrn	BCC_COMPARE_NAME:far
		extrn	BCC_COPY_WORDS:far
		extrn	BCC_DEBUG_BUILD:far
		extrn	BCC_DIAGNOSTIC:far
		extrn	BCC_FAR_9E16:far
		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_AB51:far
		extrn	BCC_FAR_AF0C:far
		extrn	BCC_FAR_AF23:far
		extrn	BCC_FAR_B0F1:far
		extrn	BCC_SEG_14:far
CO02F_TEXT	segment byte public 'CODE'
CO02F_TEXT	ends
CO030_TEXT	segment byte public 'CODE'
CO030_TEXT	ends
CO032_TEXT	segment byte public 'CODE'
CO032_TEXT	ends
CO033_TEXT	segment byte public 'CODE'
CO033_TEXT	ends
CO043_TEXT	segment byte public 'CODE'
CO043_TEXT	ends
CO05A_TEXT	segment byte public 'CODE'
CO05A_TEXT	ends
		public	X031_0A
		public	X031_0B
		public	X031_0C
		public	X031_0D
		public	X031_0E
		public	X031_00
		public	X031_01
		public	X031_02
		public	X031_03
		public	X031_04
		public	X031_05
		public	X031_06
		public	X031_07
		public	X031_08
		public	X031_09
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1c96_8000
; BEGIN C226UNIT (listing ovr_1c96_8000:0000)

	extrn	BCC_SET_OPTION:far
	extrn	BCC_POOL_INIT:far
	extrn	BCC_INIT_OPTION:byte
	extrn	BCC_POOL_A:word
	extrn	BCC_POOL_B:word
	extrn	BCC_POOL_C:word
	extrn	BCC_POOL_D:word
	extrn	BCC_POOL_E:word
	extrn	BCC_POOL_F:word


CO031_TEXT	segment byte public 'CODE'
	assume	cs:CO031_TEXT,ds:DGROUP

		public	X031_00
X031_00	label	far
BCC_LEXER_POOL_INIT	proc	far
	push	bp
	mov	bp,sp
	mov	al,byte ptr DGROUP:BCC_INIT_OPTION
	push	ax
	db	9Ah
	dw	BCC_SET_OPTION
	dw	seg BCC_SET_OPTION
	mov	ax,1
	mov	word ptr DGROUP:BCC_POOL_A+2,ax
	mov	word ptr DGROUP:BCC_POOL_A+4,ax
	mov	word ptr DGROUP:BCC_POOL_A+6,0
	push	ds
	mov	ax,offset DGROUP:BCC_POOL_A
	push	ax
	mov	ax,1
	push	ax
	db	9Ah
	dw	BCC_POOL_INIT
	dw	seg BCC_POOL_INIT
	xor	ax,ax
	mov	word ptr DGROUP:BCC_POOL_B+2,ax
	mov	word ptr DGROUP:BCC_POOL_B+4,ax
	mov	word ptr DGROUP:BCC_POOL_B+6,0
	push	ds
	mov	ax,offset DGROUP:BCC_POOL_B
	push	ax
	xor	ax,ax
	push	ax
	db	9Ah
	dw	BCC_POOL_INIT
	dw	seg BCC_POOL_INIT
	mov	ax,2
	mov	word ptr DGROUP:BCC_POOL_C+2,ax
	mov	word ptr DGROUP:BCC_POOL_C+4,ax
	mov	word ptr DGROUP:BCC_POOL_C+6,0
	push	ds
	mov	ax,offset DGROUP:BCC_POOL_C
	push	ax
	mov	ax,2
	push	ax
	db	9Ah
	dw	BCC_POOL_INIT
	dw	seg BCC_POOL_INIT
	mov	ax,1
	mov	word ptr DGROUP:BCC_POOL_D+2,ax
	mov	word ptr DGROUP:BCC_POOL_D+4,ax
	mov	word ptr DGROUP:BCC_POOL_D+6,0
	push	ds
	mov	ax,offset DGROUP:BCC_POOL_D
	push	ax
	mov	ax,1
	push	ax
	db	9Ah
	dw	BCC_POOL_INIT
	dw	seg BCC_POOL_INIT
	mov	ax,2
	mov	word ptr DGROUP:BCC_POOL_E+2,ax
	mov	word ptr DGROUP:BCC_POOL_E+4,ax
	mov	word ptr DGROUP:BCC_POOL_E+6,0
	push	ds
	mov	ax,offset DGROUP:BCC_POOL_E
	push	ax
	mov	ax,2
	push	ax
	db	9Ah
	dw	BCC_POOL_INIT
	dw	seg BCC_POOL_INIT
	mov	ax,1
	mov	word ptr DGROUP:BCC_POOL_F+2,ax
	mov	word ptr DGROUP:BCC_POOL_F+4,ax
	mov	word ptr DGROUP:BCC_POOL_F+6,0
	push	ds
	mov	ax,offset DGROUP:BCC_POOL_F
	push	ax
	mov	ax,1
	push	ax
	db	9Ah
	dw	BCC_POOL_INIT
	dw	seg BCC_POOL_INIT
	pop	bp
	retf
BCC_LEXER_POOL_INIT	endp
CO031_TEXT	ends


	extrn	BCC_STATE_817C:word
	extrn	BCC_STATE_8252:word
	extrn	BCC_STATE_8284:word
	extrn	BCC_STATE_8280:word
	extrn	BCC_STATE_8234:word
	extrn	BCC_STATE_8256:word
	extrn	BCC_STATE_8260:word
	extrn	BCC_STATE_6382:word
	extrn	BCC_STATE_5EC2:word


CO031_TEXT	segment byte public 'CODE'
	assume	cs:CO031_TEXT,ds:DGROUP

		public	X031_0A
X031_0A	label	far
BCC_LEXER_STATE_INIT	proc	far
	push	bp
	mov	bp,sp
	mov	word ptr DGROUP:BCC_STATE_817C,0
	mov	word ptr DGROUP:BCC_STATE_8252,2101h
	mov	word ptr DGROUP:BCC_STATE_8252+2,679eh
	mov	word ptr DGROUP:BCC_STATE_8284,0
	mov	word ptr DGROUP:BCC_STATE_8284+2,0
	mov	word ptr DGROUP:BCC_STATE_8280,0
	mov	word ptr DGROUP:BCC_STATE_8234,0
	mov	word ptr DGROUP:BCC_STATE_8256,0
	mov	word ptr DGROUP:BCC_STATE_8260,82h
	mov	word ptr DGROUP:BCC_STATE_6382,82h
	mov	word ptr DGROUP:BCC_STATE_5EC2,82h
	pop	bp
	retf
BCC_LEXER_STATE_INIT	endp
CO031_TEXT	ends

CO031_TEXT	segment byte public 'CODE'
		assume	cs:CO031_TEXT
; Original-image layout stub: not recovered source


X031_09	label	far
		db	055h,08Bh,0ECh,083h,0ECh,004h,056h,0A1h,092h,082h,03Bh,006h,08Ch,082h; ovr_1c96_8000:0101
		db	072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh; ovr_1c96_8000:010F
		db	007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h	; ovr_1c96_8000:011D
		db	089h,046h,0FEh,08Bh,01Eh,052h,082h,003h,05Eh,0FEh,08Ah,007h,098h,08Bh	; ovr_1c96_8000:012B
		db	0F0h,08Bh,0DEh,083h,0EBh,0DEh,083h,0FBh,022h,076h,003h,0E9h,00Eh,001h	; ovr_1c96_8000:0139
		db	0D1h,0E3h,02Eh,0FFh,0A7h,00Ch,00Ah,083h,07Eh,0FEh,04Ch,075h,054h,0A1h	; ovr_1c96_8000:0147
		db	092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh; ovr_1c96_8000:0155
		db	011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h	; ovr_1c96_8000:0163
		db	082h,026h,08Ah,007h,0B4h,000h,089h,046h,0FCh,083h,07Eh,0FCh,027h,074h	; ovr_1c96_8000:0171
		db	006h,083h,07Eh,0FCh,022h,075h,01Eh,08Ch,0D8h,08Ch,0DAh,03Bh,0C2h,075h	; ovr_1c96_8000:017F
		db	008h,081h,03Eh,052h,082h,001h,021h,074h,009h,08Ah,046h,0FEh,050h,09Ah	; ovr_1c96_8000:018D
		dw	052h
		dw	seg CO030_TEXT
		db	08Bh,046h,0FCh,0EBh,087h,0FFh,00Eh,092h,082h,0A1h; ovr_1c96_8000:019B
		db	0D3h,077h,0A3h,065h,082h,09Ah
		dw	025h
		dw	seg CO032_TEXT
		db	02Bh,006h,03Ah,082h; ovr_1c96_8000:01A9
		db	0A3h,067h,082h,0A1h,0D5h,077h,0A3h,063h,082h,0C6h,006h,0DCh,077h,000h	; ovr_1c96_8000:01B7
		db	08Ah,046h,0FEh,050h,090h,00Eh,0E8h,028h,010h,08Ch,0D8h,08Ch,0DAh,03Bh	; ovr_1c96_8000:01C5
		db	0C2h,075h,011h,081h,03Eh,052h,082h,001h,022h,075h,009h,0B8h,031h,000h	; ovr_1c96_8000:01D3
		db	0A3h,060h,082h,0E9h,020h,008h,090h,00Eh,0E8h,047h,011h,089h,046h,0FEh	; ovr_1c96_8000:01E1
		db	083h,07Eh,0FEh,000h,07Ch,003h,0E9h,036h,0FFh,08Ch,0D8h,08Ch,0DAh,03Bh	; ovr_1c96_8000:01EF
		db	0C2h,075h,011h,081h,03Eh,052h,082h,001h,023h,075h,009h,0B8h,031h,000h	; ovr_1c96_8000:01FD
		db	0A3h,060h,082h,0E9h,0F6h,007h,0A1h,096h,082h,0A3h,069h,082h,08Bh,01Eh	; ovr_1c96_8000:020B
		db	096h,082h,08Eh,006h,03Ah,078h,026h,08Bh,047h,004h,089h,046h,0FEh,083h	; ovr_1c96_8000:0219
		db	07Eh,0FEh,000h,075h,009h,0B8h,031h,000h,0A3h,060h,082h,0E9h,0D2h,007h	; ovr_1c96_8000:0227
		db	080h,03Eh,0D0h,077h,000h,074h,010h,080h,03Eh,0F5h,016h,001h,075h,009h	; ovr_1c96_8000:0235
		db	0B8h,031h,000h,0A3h,060h,082h,0E9h,0BBh,007h,08Bh,046h,0FEh,0A3h,060h	; ovr_1c96_8000:0243
		db	082h,0E9h,0B2h,007h,0A1h,0D3h,077h,0A3h,065h,082h,09Ah
		dw	025h
		dw	seg CO032_TEXT
		db	02Bh,006h,03Ah,082h,0A3h,067h,082h,0A1h,0D5h,077h,0A3h,063h,082h; ovr_1c96_8000:0251
		db	08Bh,0C6h,0A3h,060h,082h,0E9h,092h,007h,0A1h,092h,082h,03Bh,006h,08Ch	; ovr_1c96_8000:026D
		db	082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h; ovr_1c96_8000:027B
		db	08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h	; ovr_1c96_8000:0289
		db	000h,089h,046h,0FCh,083h,07Eh,0FCh,00Ah,074h,006h,083h,07Eh,0FCh,00Dh	; ovr_1c96_8000:0297
		db	075h,00Ch,08Ah,046h,0FCh,050h,090h,00Eh,0E8h,0DCh,00Eh,0E9h,03Dh,007h	; ovr_1c96_8000:02A5
		db	083h,07Eh,0FCh,03Fh,075h,021h,0A1h,0D3h,077h,0A3h,065h,082h,09Ah
		dw	025h
		dw	seg CO032_TEXT
		db	02Bh,006h,03Ah,082h,0A3h,067h,082h,0A1h,0D5h,077h,0A3h; ovr_1c96_8000:02B3
		db	063h,082h,0B8h,020h,000h,0A3h,060h,082h,0E9h,02Dh,007h,0FFh,00Eh,092h	; ovr_1c96_8000:02CF
		db	082h,0FFh,076h,0FEh,0FFh,076h,0FEh,0B8h,037h,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	083h,0C4h,006h,0E9h,0FDh,006h,033h,0C0h,050h,09Ah
		dw	034h
		dw	seg CO032_TEXT
		db	00Bh,0C0h,074h,003h,0E9h,0EEh,006h,033h,0C0h,0A3h,060h,082h; ovr_1c96_8000:02DD
		db	0E9h,0FDh,006h,080h,03Eh,0D0h,077h,000h,074h,009h,0B8h,00Ah,000h,0A3h	; ovr_1c96_8000:0307
		db	060h,082h,0E9h,0EDh,006h,08Ah,046h,0FEh,050h,090h,00Eh,0E8h,02Fh,007h	; ovr_1c96_8000:0315
		db	0E9h,0CAh,006h,0A1h,0D3h,077h,0A3h,065h,082h,09Ah
		dw	025h
		dw	seg CO032_TEXT
		db	02Bh,006h,03Ah,082h,0A3h,067h,082h,0A1h,0D5h,077h,0A3h,063h,082h,08Ah	; ovr_1c96_8000:0331
		db	046h,0FEh,050h,0E8h,0ACh,012h,08Bh,0F0h,08Ch,0D8h,08Ch,0DAh,03Bh,0C2h	; ovr_1c96_8000:033F
		db	074h,003h,0E9h,09Eh,006h,081h,03Eh,052h,082h,001h,021h,074h,003h,0E9h	; ovr_1c96_8000:034D
		db	093h,006h,056h,0E8h,00Eh,017h,0A3h,060h,082h,0E9h,0A0h,006h,08Bh,0C6h	; ovr_1c96_8000:035B
		db	0F7h,0D8h,08Bh,0F0h,0A1h,0D3h,077h,0A3h,065h,082h,09Ah
		dw	025h
		dw	seg CO032_TEXT
		db	02Bh,006h,03Ah,082h,0A3h,067h,082h,0A1h,0D5h,077h,0A3h,063h,082h; ovr_1c96_8000:0369
		db	0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h	; ovr_1c96_8000:0393
		db	092h,082h,026h,08Ah,007h,0B4h,000h,089h,046h,0FCh,083h,07Eh,0FCh,02Ah	; ovr_1c96_8000:03A1
		db	075h,008h,09Ah
		dw	043h
		dw	seg CO030_TEXT
		db	0E9h,037h,006h,080h,03Eh,0F5h,016h; ovr_1c96_8000:03AF
		db	001h,074h,00Eh,083h,07Eh,0FCh,02Fh,075h,008h,09Ah
		dw	020h
		dw	seg CO030_TEXT
		db	0E9h,022h,006h,080h,03Eh,0FDh,020h,000h,074h,013h,08Bh,046h,0FCh,03Bh	; ovr_1c96_8000:03CB
		db	046h,0FEh,075h,00Bh,0A0h,0FDh,020h,0B4h,000h,0A3h,060h,082h,0E9h,01Fh	; ovr_1c96_8000:03D9
		db	006h,083h,07Eh,0FCh,03Dh,075h,00Bh,0A0h,0F4h,020h,0B4h,000h,0A3h,060h	; ovr_1c96_8000:03E7
		db	082h,0E9h,00Eh,006h,0FFh,00Eh,092h,082h,0A0h,0EBh,020h,0B4h,000h,0A3h	; ovr_1c96_8000:03F5
		db	060h,082h,0E9h,0FFh,005h,08Bh,0C6h,0F7h,0D8h,08Bh,0F0h,0A1h,0D3h,077h	; ovr_1c96_8000:0403
		db	0A3h,065h,082h,09Ah
		dw	025h
		dw	seg CO032_TEXT
		db	02Bh,006h,03Ah,082h,0A3h,067h; ovr_1c96_8000:0411
		db	082h,0A1h,0D5h,077h,0A3h,063h,082h,0A1h,092h,082h,03Bh,006h,08Ch,082h	; ovr_1c96_8000:041F
		db	072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh; ovr_1c96_8000:042D
		db	007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h	; ovr_1c96_8000:043B
		db	089h,046h,0FCh,080h,0BCh,0F8h,020h,000h,074h,011h,03Bh,046h,0FEh,075h	; ovr_1c96_8000:0449
		db	00Ch,08Ah,084h,0F8h,020h,0B4h,000h,0A3h,060h,082h,0E9h,0A3h,005h,083h	; ovr_1c96_8000:0457
		db	07Eh,0FCh,03Dh,075h,00Ch,08Ah,084h,0EFh,020h,0B4h,000h,0A3h,060h,082h	; ovr_1c96_8000:0465
		db	0E9h,091h,005h,0FFh,00Eh,092h,082h,08Ah,084h,0E6h,020h,0B4h,000h,0A3h	; ovr_1c96_8000:0473
		db	060h,082h,0E9h,081h,005h,0A1h,0D3h,077h,0A3h,065h,082h,09Ah
		dw	025h
		dw	seg CO032_TEXT
		db	02Bh,006h,03Ah,082h,0A3h,067h,082h,0A1h,0D5h,077h,0A3h,063h; ovr_1c96_8000:0481
		db	082h,0B8h,034h,000h,0A3h,060h,082h,0E9h,060h,005h,0A1h,0D3h,077h,0A3h	; ovr_1c96_8000:049D
		db	065h,082h,09Ah
		dw	025h
		dw	seg CO032_TEXT
		db	02Bh,006h,03Ah,082h,0A3h,067h,082h; ovr_1c96_8000:04AB
		db	0A1h,0D5h,077h,0A3h,063h,082h,0E8h,09Ch,017h,0A3h,060h,082h,0E9h,03Fh	; ovr_1c96_8000:04B9
		db	005h,0A1h,0D3h,077h,0A3h,065h,082h,09Ah
		dw	025h
		dw	seg CO032_TEXT
		db	02Bh,006h; ovr_1c96_8000:04C7
		db	03Ah,082h,0A3h,067h,082h,0A1h,0D5h,077h,0A3h,063h,082h,0A1h,092h,082h	; ovr_1c96_8000:04D5
		db	03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh; ovr_1c96_8000:04E3
		db	01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h	; ovr_1c96_8000:04F1
		db	08Ah,007h,0B4h,000h,089h,046h,0FEh,083h,07Eh,0FEh,03Ah,075h,009h,0B8h	; ovr_1c96_8000:04FF
		db	067h,000h,0A3h,060h,082h,0E9h,0F2h,004h,0FFh,00Eh,092h,082h,0B8h,021h	; ovr_1c96_8000:050D
		db	000h,0A3h,060h,082h,0E9h,0E5h,004h,0A1h,0D3h,077h,0A3h,065h,082h,09Ah	; ovr_1c96_8000:051B
		dw	025h
		dw	seg CO032_TEXT
		db	02Bh,006h,03Ah,082h,0A3h,067h,082h,0A1h,0D5h,077h; ovr_1c96_8000:0529
		db	0A3h,063h,082h,0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h; ovr_1c96_8000:0537
		db	082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h,089h,046h,0FEh,083h	; ovr_1c96_8000:0553
		db	07Eh,0FEh,02Dh,075h,009h,0B8h,02Eh,000h,0A3h,060h,082h,0E9h,098h,004h	; ovr_1c96_8000:0561
		db	083h,07Eh,0FEh,03Dh,075h,009h,0B8h,00Dh,000h,0A3h,060h,082h,0E9h,089h	; ovr_1c96_8000:056F
		db	004h,083h,07Eh,0FEh,03Eh,075h,042h,0A1h,092h,082h,03Bh,006h,08Ch,082h	; ovr_1c96_8000:057D
		db	072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh; ovr_1c96_8000:058B
		db	007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h	; ovr_1c96_8000:0599
		db	089h,046h,0FEh,083h,07Eh,0FEh,02Ah,075h,009h,0B8h,066h,000h,0A3h,060h	; ovr_1c96_8000:05A7
		db	082h,0E9h,04Eh,004h,0FFh,00Eh,092h,082h,0B8h,030h,000h,0A3h,060h,082h	; ovr_1c96_8000:05B5
		db	0E9h,041h,004h,0FFh,00Eh,092h,082h,0B8h,017h,000h,0A3h,060h,082h,0E9h	; ovr_1c96_8000:05C3
		db	034h,004h,0A1h,0D3h,077h,0A3h,065h,082h,09Ah
		dw	025h
		dw	seg CO032_TEXT
		db	02Bh; ovr_1c96_8000:05D1
		db	006h,03Ah,082h,0A3h,067h,082h,0A1h,0D5h,077h,0A3h,063h,082h,0A1h,092h	; ovr_1c96_8000:05DF
		db	082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h; ovr_1c96_8000:05ED
		db	08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h	; ovr_1c96_8000:05FB
		db	026h,08Ah,007h,0B4h,000h,089h,046h,0FEh,08Bh,01Eh,052h,082h,003h,05Eh	; ovr_1c96_8000:0609
		db	0FEh,080h,03Fh,0F5h,075h,016h,0FFh,00Eh,092h,082h,0B0h,02Eh,050h,0E8h	; ovr_1c96_8000:0617
		db	0CAh,00Fh,08Bh,0F0h,056h,0E8h,042h,014h,0A3h,060h,082h,0E9h,0D4h,003h	; ovr_1c96_8000:0625
		db	083h,07Eh,0FEh,02Eh,075h,04Dh,0A1h,092h,082h,03Bh,006h,08Ch,082h,072h	; ovr_1c96_8000:0633
		db	007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h; ovr_1c96_8000:0641
		db	08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h,089h	; ovr_1c96_8000:064F
		db	046h,0FEh,083h,07Eh,0FEh,02Eh,074h,018h,0B8h,022h,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	044h,044h,0FFh,00Eh,092h,082h,0B8h,02Fh,000h,0A3h,060h; ovr_1c96_8000:065D
		db	082h,0E9h,08Ah,003h,0B8h,009h,000h,0A3h,060h,082h,0E9h,081h,003h,083h	; ovr_1c96_8000:0679
		db	07Eh,0FEh,02Ah,075h,009h,0B8h,064h,000h,0A3h,060h,082h,0E9h,072h,003h	; ovr_1c96_8000:0687
		db	0FFh,00Eh,092h,082h,0B8h,02Fh,000h,0A3h,060h,082h,0E9h,065h,003h,0A1h	; ovr_1c96_8000:0695
		db	0D3h,077h,0A3h,065h,082h,09Ah
		dw	025h
		dw	seg CO032_TEXT
		db	02Bh,006h,03Ah,082h; ovr_1c96_8000:06A3
		db	0A3h,067h,082h,0A1h,0D5h,077h,0A3h,063h,082h,0A1h,092h,082h,03Bh,006h	; ovr_1c96_8000:06B1
		db	08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch; ovr_1c96_8000:06BF
		db	082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h	; ovr_1c96_8000:06CD
		db	0B4h,000h,089h,046h,0FEh,083h,07Eh,0FEh,03Dh,075h,009h,0B8h,028h,000h	; ovr_1c96_8000:06DB
		db	0A3h,060h,082h,0E9h,018h,003h,083h,07Eh,0FEh,03Ch,075h,042h,0A1h,092h	; ovr_1c96_8000:06E9
		db	082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h; ovr_1c96_8000:06F7
		db	08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h	; ovr_1c96_8000:0705
		db	026h,08Ah,007h,0B4h,000h,089h,046h,0FEh,083h,07Eh,0FEh,03Dh,075h,009h	; ovr_1c96_8000:0713
		db	0B8h,014h,000h,0A3h,060h,082h,0E9h,0DDh,002h,0FFh,00Eh,092h,082h,0B8h	; ovr_1c96_8000:0721
		db	01Eh,000h,0A3h,060h,082h,0E9h,0D0h,002h,0FFh,00Eh,092h,082h,0B8h,026h	; ovr_1c96_8000:072F
		db	000h,0A3h,060h,082h,0E9h,0C3h,002h,0A1h,0D3h,077h,0A3h,065h,082h,09Ah	; ovr_1c96_8000:073D
		dw	025h
		dw	seg CO032_TEXT
		db	02Bh,006h,03Ah,082h,0A3h,067h,082h,0A1h,0D5h,077h; ovr_1c96_8000:074B
		db	0A3h,063h,082h,0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h; ovr_1c96_8000:0759
		db	082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h,089h,046h,0FEh,083h	; ovr_1c96_8000:0775
		db	07Eh,0FEh,03Dh,075h,009h,0B8h,029h,000h,0A3h,060h,082h,0E9h,076h,002h	; ovr_1c96_8000:0783
		db	083h,07Eh,0FEh,03Eh,075h,042h,0A1h,092h,082h,03Bh,006h,08Ch,082h,072h	; ovr_1c96_8000:0791
		db	007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h; ovr_1c96_8000:079F
		db	08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h,089h	; ovr_1c96_8000:07AD
		db	046h,0FEh,083h,07Eh,0FEh,03Dh,075h,009h,0B8h,015h,000h,0A3h,060h,082h	; ovr_1c96_8000:07BB
		db	0E9h,03Bh,002h,0FFh,00Eh,092h,082h,0B8h,01Fh,000h,0A3h,060h,082h,0E9h	; ovr_1c96_8000:07C9
		db	02Eh,002h,0FFh,00Eh,092h,082h,0B8h,027h,000h,0A3h,060h,082h,0E9h,021h	; ovr_1c96_8000:07D7
		db	002h,0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh; ovr_1c96_8000:07E5
		db	006h,092h,082h,026h,08Ah,007h,0B4h,000h,089h,046h,0FEh,083h,07Eh,0FEh	; ovr_1c96_8000:0801
		db	00Ah,074h,015h,083h,07Eh,0FEh,00Dh,074h,00Fh,0FFh,00Eh,092h,082h,0B0h	; ovr_1c96_8000:080F
		db	05Ch,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0E9h,0C9h,001h,08Ah,046h,0FEh,050h; ovr_1c96_8000:081D
		db	090h,00Eh,0E8h,05Ch,009h,0E9h,0BDh,001h,0A1h,092h,082h,03Bh,006h,08Ch	; ovr_1c96_8000:082B
		db	082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h; ovr_1c96_8000:0839
		db	08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h	; ovr_1c96_8000:0847
		db	000h,089h,046h,0FEh,083h,07Eh,0FEh,00Ah,074h,012h,083h,07Eh,0FEh,00Dh	; ovr_1c96_8000:0855
		db	074h,00Ch,08Ah,046h,0FEh,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0E9h,07Fh,001h; ovr_1c96_8000:0863
		db	08Ah,046h,0FEh,050h,090h,00Eh,0E8h,012h,009h,0E9h,073h,001h,0A1h,092h	; ovr_1c96_8000:0871
		db	082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h; ovr_1c96_8000:087F
		db	08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h	; ovr_1c96_8000:088D
		db	026h,08Ah,007h,0B4h,000h,089h,046h,0FEh,083h,07Eh,0FEh,02Ah,075h,025h	; ovr_1c96_8000:089B
		db	09Ah
		dw	043h
		dw	seg CO030_TEXT
		db	081h,03Eh,054h,082h,09Eh,067h,076h,00Dh,08Bh; ovr_1c96_8000:08A9
		db	01Eh,054h,082h,080h,07Fh,0FFh,020h,075h,003h,0E9h,02Dh,001h,0B0h,020h	; ovr_1c96_8000:08B7
		db	050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0E9h,022h,001h,080h,03Eh,0F5h,016h,001h; ovr_1c96_8000:08C5
		db	074h,02Bh,083h,07Eh,0FEh,02Fh,075h,025h,09Ah
		dw	020h
		dw	seg CO030_TEXT
		db	081h; ovr_1c96_8000:08D3
		db	03Eh,054h,082h,09Eh,067h,076h,00Dh,08Bh,01Eh,054h,082h,080h,07Fh,0FFh	; ovr_1c96_8000:08E1
		db	020h,075h,003h,0E9h,0FBh,000h,0B0h,020h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0E9h,0F0h,000h,0FFh,00Eh,092h,082h,0B0h,02Fh,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0E9h,0E1h,000h,081h,03Eh,054h,082h,09Eh,067h,076h,00Dh,08Bh,01Eh; ovr_1c96_8000:08FD
		db	054h,082h,080h,07Fh,0FFh,020h,075h,003h,0E9h,0CCh,000h,0B0h,020h,050h	; ovr_1c96_8000:0919
		db	09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0E9h,0C1h,000h,08Ah,046h,0FEh,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0E9h,0B5h,000h,08Ah,046h,0FEh,050h,0FFh,036h,03Eh,020h; ovr_1c96_8000:0927
		db	0FFh,036h,03Ch,020h,0B8h,001h,000h,050h,09Ah
		dw	02Ah
		dw	seg CO032_TEXT
		db	00Bh; ovr_1c96_8000:0943
		db	0C0h,074h,003h,0E9h,099h,000h,0B8h,00Ah,000h,0A3h,060h,082h,0E9h,0A7h	; ovr_1c96_8000:0951
		db	000h,08Ah,046h,0FEh,050h,0FFh,036h,03Eh,020h,0FFh,036h,03Ch,020h,033h	; ovr_1c96_8000:095F
		db	0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO032_TEXT
		db	00Bh,0C0h,075h,078h,0B8h,00Ah,000h; ovr_1c96_8000:096D
		db	0A3h,060h,082h,0E9h,086h,000h,0A1h,092h,082h,03Bh,006h,08Ch,082h,072h	; ovr_1c96_8000:097B
		db	007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h; ovr_1c96_8000:0989
		db	08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h,089h	; ovr_1c96_8000:0997
		db	046h,0FEh,083h,07Eh,0FEh,023h,075h,02Fh,0EBh,004h,0FFh,00Eh,054h,082h	; ovr_1c96_8000:09A5
		db	081h,03Eh,054h,082h,09Eh,067h,076h,00Ah,08Bh,01Eh,054h,082h,080h,07Fh	; ovr_1c96_8000:09B3
		db	0FFh,020h,074h,0EAh,0B0h,0FEh,050h,09Ah
		dw	02Ah
		dw	seg CO030_TEXT
		db	0B8h,020h; ovr_1c96_8000:09C1
		db	000h,050h,09Ah
		dw	025h
		dw	seg CO030_TEXT
		db	0FFh,00Eh,092h,082h,0EBh,014h,0B0h; ovr_1c96_8000:09CF
		db	0FDh,050h,09Ah
		dw	02Ah
		dw	seg CO030_TEXT
		db	0FFh,076h,0FEh,09Ah
		dw	025h
		dw	seg CO030_TEXT
		db	0FFh,00Eh,092h,082h,0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,008h; ovr_1c96_8000:09DD
		db	09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0E9h,028h,0F7h,0E9h,014h,0F7h,0E9h,022h,0F7h; ovr_1c96_8000:09F9
		db	05Eh,08Bh,0E5h,05Dh,0CBh,0C8h,004h,00Fh,009h,033h,008h,060h,009h,07Dh	; ovr_1c96_8000:0A07
		db	008h,081h,009h,0E6h,007h,03Bh,009h,02Fh,009h,0F3h,002h,055h,002h,055h	; ovr_1c96_8000:0A15
		db	002h,075h,002h,055h,002h,00Ah,003h,044h,007h,0DEh,002h,0A2h,006h,0D3h	; ovr_1c96_8000:0A23
		db	005h,022h,005h,0A7h,004h,055h,002h,086h,004h,026h,003h,04Eh,001h,0F0h	; ovr_1c96_8000:0A31
		db	009h,008h,004h,008h,004h,008h,004h,067h,003h,008h,004h,008h,004h,008h	; ovr_1c96_8000:0A3F
		db	004h,008h,004h,008h,004h	; ovr_1c96_8000:0A4D

CO031_TEXT	ends

	extrn	X030_01:far
	extrn	X030_05:far
	extrn	BCC_RD_920E_W:word


CO031_TEXT	segment byte public 'CODE'
	assume	cs:CO031_TEXT,ds:DGROUP

		public	X031_08
X031_08	label	far
BCC_LEX_HASH	proc	far
	push	bp
	mov	bp,sp
	mov	al,byte ptr [bp+6]
	push	ax
	nop
	push	cs
	db	0E8h,02Eh,007h
	mov	ax,32
	push	ax
	db	9Ah
	dw	X030_01
	dw	seg X030_01
	mov	byte ptr [bp+6],al
	cmp	byte ptr [bp+6],35
	jne	short M003_@@REWIND
	mov	ax,1
	push	ax
	db	9Ah
	dw	X030_05
	dw	seg X030_05
	jmp	short M003_@@EPILOGUE
M003_@@REWIND:
	dec	word ptr DGROUP:BCC_RD_920E_W
M003_@@EPILOGUE:
	pop	bp
	retf	2
BCC_LEX_HASH	endp
CO031_TEXT	ends


	extrn	BCC_LEX_TOKEN:near
	extrn	X033_04:far
	extrn	X030_02:far
	extrn	BCC_STRING_LENGTH:far
	extrn	BCC_RF_15A7_011B:far
	extrn	BCC_RD_8252_W:word
	extrn	BCC_LEX_BUFFER_END:word
	extrn	BCC_RD_920E_W:word
	extrn	BCC_MACRO_MODE:byte
		extrn	BCC_RD_541E_W:word
		extrn	BCC_RD_8254_W:word
		extrn	BCC_RD_543E_W:word


CO031_TEXT	segment byte public 'CODE'
	assume	cs:CO031_TEXT,ds:DGROUP

		public	X031_03
X031_03	label	far
BCC_LEX_READ	proc	far
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	cmp	word ptr [bp+6],0
	je	short M004_@@NORMAL_MODE
	mov	word ptr DGROUP:BCC_RD_8252_W,2301h
	jmp	short M004_@@MODE_DONE
M004_@@NORMAL_MODE:
	mov	word ptr DGROUP:BCC_RD_8252_W,2201h
M004_@@MODE_DONE:
	mov	bx,word ptr DGROUP:BCC_RD_541E_W
	mov	byte ptr [bx],0
	mov	byte ptr DGROUP:BCC_MACRO_MODE,1
M004_@@NEXT_TOKEN:
	push	cs
	db	0E8h,055h,0F6h
	or	ax,ax
	je	short M004_@@FINISH
	cmp	ax,10
	je	short M004_@@LINE_END
	cmp	ax,49
	je	short M004_@@IDENTIFIER
	jmp	short M004_@@NEXT_TOKEN
M004_@@IDENTIFIER:
	push	word ptr [bp+8]
	db	9Ah
	dw	X033_04
	dw	seg X033_04
	mov	word ptr [bp-2],ax
	or	ax,ax
	jz	short M004_@@COPY_NAME
	mov	al,byte ptr [bp-2]
	add	al,80h
	push	ax
	db	9Ah
	dw	X030_02
	dw	seg X030_02
	jmp	short M004_@@NEXT_TOKEN
M004_@@COPY_NAME:
	push	ds
	push	word ptr DGROUP:BCC_RD_8254_W
	db	9Ah
	dw	BCC_STRING_LENGTH
	dw	seg BCC_STRING_LENGTH
	add	word ptr DGROUP:BCC_RD_8254_W,ax
	jmp	short M004_@@NEXT_TOKEN
M004_@@LINE_END:
	dec	word ptr DGROUP:BCC_RD_920E_W
M004_@@FINISH:
	mov	word ptr DGROUP:BCC_RD_8252_W,2101h
	cmp	word ptr DGROUP:BCC_RD_543E_W,779ch
	jc	short M004_@@WITHIN_LIMIT
	mov	ax,67
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
M004_@@WITHIN_LIMIT:
	mov	byte ptr DGROUP:BCC_MACRO_MODE,0
	mov	word ptr DGROUP:BCC_RD_8254_W,679eh
	mov	sp,bp
	pop	bp
	retf	4
BCC_LEX_READ	endp
CO031_TEXT	ends

CO031_TEXT	segment byte public 'CODE'
		assume	cs:CO031_TEXT
; Original-image layout stub: not recovered source


		db	045h,055h,08Bh,0ECh,083h,0ECh,010h,056h,057h,08Bh,03Eh,096h,082h,08Eh	; ovr_1c96_8000:0B15
		db	006h,03Ah,078h,026h,08Bh,045h,002h,089h,046h,0FEh,0FFh,076h,0FEh,09Ah	; ovr_1c96_8000:0B23
		dw	020h
		dw	seg CO032_TEXT
		db	0B4h,000h,089h,046h,0F8h,081h,07Eh,0F8h,0FFh,000h; ovr_1c96_8000:0B31
		db	075h,00Bh,0FFh,006h,0D7h,077h,057h,033h,0C0h,050h,0E9h,062h,001h,0C7h	; ovr_1c96_8000:0B3F
		db	046h,0FAh,000h,000h,0B8h,020h,000h,050h,09Ah
		dw	025h
		dw	seg CO030_TEXT
		db	088h; ovr_1c96_8000:0B4D
		db	046h,0F7h,080h,03Eh,0D0h,077h,000h,075h,00Ch,080h,07Eh,0F7h,00Ah,074h	; ovr_1c96_8000:0B5B
		db	0E7h,080h,07Eh,0F7h,00Dh,074h,0E1h,080h,07Eh,0F7h,028h,074h,009h,0FFh	; ovr_1c96_8000:0B69
		db	00Eh,092h,082h,033h,0C0h,0E9h,03Ah,001h,08Bh,036h,054h,082h,0FFh,006h	; ovr_1c96_8000:0B77
		db	0D7h,077h,0B8h,020h,000h,050h,09Ah
		dw	025h
		dw	seg CO030_TEXT
		db	088h,046h,0F7h; ovr_1c96_8000:0B85
		db	080h,07Eh,0F7h,029h,075h,019h,083h,07Eh,0F8h,000h,074h,004h,057h,0E8h	; ovr_1c96_8000:0B93
		db	01Dh,001h,057h,033h,0C0h,050h,0FFh,076h,0FEh,09Ah
		dw	048h
		dw	seg CO032_TEXT
		db	0E9h,004h,001h,0FFh,00Eh,092h,082h,016h,08Dh,046h,0F2h,050h,0E8h,0E3h	; ovr_1c96_8000:0BAF
		db	001h,088h,046h,0F7h,080h,07Eh,0F7h,01Ah,075h,004h,0E9h,0ECh,000h,046h	; ovr_1c96_8000:0BBD
		db	080h,03Ch,020h,074h,0FAh,080h,03Ch,009h,074h,0F5h,01Eh,0B8h,03Eh,082h	; ovr_1c96_8000:0BCB
		db	050h,033h,0C0h,050h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	089h,046h,0FAh,01Eh,056h; ovr_1c96_8000:0BD9
		db	09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	08Bh,0D6h,003h,0D0h,04Ah,089h,056h,0F4h,0EBh; ovr_1c96_8000:0BE7
		db	003h,0FFh,04Eh,0F4h,039h,076h,0F4h,072h,008h,08Bh,05Eh,0F4h,080h,03Fh	; ovr_1c96_8000:0BF5
		db	020h,074h,0F0h,08Bh,05Eh,0F4h,0C6h,047h,001h,000h,083h,07Eh,0F8h,000h	; ovr_1c96_8000:0C03
		db	075h,00Bh,057h,0E8h,0A9h,000h,0FFh,00Eh,0D7h,077h,0E9h,098h,000h,01Eh	; ovr_1c96_8000:0C11
		db	0B8h,03Eh,082h,050h,01Eh,056h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	005h,003h,000h; ovr_1c96_8000:0C1F
		db	050h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	089h,046h,0FCh,0A1h,042h,082h,089h,046h; ovr_1c96_8000:0C2D
		db	0F0h,08Eh,006h,03Eh,082h,08Bh,05Eh,0FCh,08Bh,046h,0F2h,026h,089h,007h	; ovr_1c96_8000:0C3B
		db	08Bh,046h,0FCh,040h,040h,0FFh,036h,03Eh,082h,050h,01Eh,056h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0FFh,04Eh,0F8h,080h,07Eh,0F7h,02Ch,075h,03Dh,08Bh,036h; ovr_1c96_8000:0C49
		db	054h,082h,016h,08Dh,046h,0F2h,050h,0E8h,032h,001h,088h,046h,0F7h,080h	; ovr_1c96_8000:0C65
		db	07Eh,0F7h,01Ah,075h,00Fh,0C7h,006h,044h,082h,000h,000h,08Bh,046h,0FAh	; ovr_1c96_8000:0C73
		db	0A3h,042h,082h,0EBh,030h,046h,080h,03Ch,020h,074h,0FAh,080h,03Ch,009h	; ovr_1c96_8000:0C81
		db	074h,0F5h,0C7h,006h,044h,082h,000h,000h,08Bh,046h,0F0h,0A3h,042h,082h	; ovr_1c96_8000:0C8F
		db	0E9h,045h,0FFh,083h,07Eh,0F8h,000h,074h,004h,057h,0E8h,016h,000h,057h	; ovr_1c96_8000:0C9D
		db	0FFh,076h,0FAh,0FFh,076h,0FEh,09Ah
		dw	048h
		dw	seg CO032_TEXT
		db	0B8h,001h,000h; ovr_1c96_8000:0CAB
		db	05Fh,05Eh,08Bh,0E5h,05Dh,04Dh,0C3h	; ovr_1c96_8000:0CB9

CO031_TEXT	ends

	extrn	X019_02:far
	extrn	BCC_RF_15A7_011B:far


CO031_TEXT	segment byte public 'CODE'
	assume	cs:CO031_TEXT,ds:DGROUP

BCC_LEX_ERROR	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	word ptr [bp+4]
	db	9Ah
	dw	X019_02
	dw	seg X019_02
	push	dx
	push	ax
	mov	ax,11
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	add	sp,6
	pop	bp
	dec	bp
	ret	2
BCC_LEX_ERROR	endp
CO031_TEXT	ends


	extrn	BCC_RF_1AA8_0007:far
	extrn	BCC_RD_240B_B:byte
	extrn	BCC_PREDEFINED_2:byte
	extrn	BCC_PREDEFINED_3:byte
	extrn	BCC_PREDEFINED_4:byte
	extrn	BCC_PREDEFINED_5:byte
	extrn	BCC_PREDEFINED_6:byte
	extrn	BCC_COMMENT_MODE:byte
	extrn	BCC_OPTION_FLAGS:byte


CO031_TEXT	segment byte public 'CODE'
	assume	cs:CO031_TEXT,ds:DGROUP

		public	X031_0C
X031_0C	label	far
BCC_LEX_PREDEFINED	proc	far
	push	bp
	mov	bp,sp
	les	bx,dword ptr [bp+6]
	cmp	byte ptr es:[bx],5fh
	jne	short M007_@@NOT_FOUND
	cmp	byte ptr es:[bx+1],5fh
	je	short M007_@@DOUBLE_UNDERSCORE
M007_@@NOT_FOUND:
	jmp	M007_@@RETURN_ZERO
M007_@@DOUBLE_UNDERSCORE:
	add	word ptr [bp+6],2
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	ds
	mov	ax,offset DGROUP:BCC_RD_240B_B
	push	ax
	db	9Ah
	dw	BCC_RF_1AA8_0007
	dw	seg BCC_RF_1AA8_0007
	or	ax,ax
	jne	short M007_@@CHECK_SECOND
	cmp	byte ptr DGROUP:BCC_COMMENT_MODE,1
	jne	short M007_@@CHECK_SECOND
M007_@@RETURN_ONE:
	mov	ax,1
	jmp	M007_@@EPILOGUE
M007_@@CHECK_SECOND:
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	ds
	mov	ax,offset DGROUP:BCC_PREDEFINED_2
	push	ax
	db	9Ah
	dw	BCC_RF_1AA8_0007
	dw	seg BCC_RF_1AA8_0007
	or	ax,ax
	jne	short M007_@@CHECK_THIRD
	test	byte ptr DGROUP:BCC_OPTION_FLAGS,1
	jz	short M007_@@CHECK_THIRD
	jmp	short M007_@@RETURN_ONE
M007_@@CHECK_THIRD:
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	ds
	mov	ax,offset DGROUP:BCC_PREDEFINED_3
	push	ax
	db	9Ah
	dw	BCC_RF_1AA8_0007
	dw	seg BCC_RF_1AA8_0007
	or	ax,ax
	jne	short M007_@@CHECK_FOURTH
	mov	ax,2
	jmp	short M007_@@EPILOGUE
M007_@@CHECK_FOURTH:
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	ds
	mov	ax,offset DGROUP:BCC_PREDEFINED_4
	push	ax
	db	9Ah
	dw	BCC_RF_1AA8_0007
	dw	seg BCC_RF_1AA8_0007
	or	ax,ax
	jne	short M007_@@CHECK_FIFTH
	mov	ax,3
	jmp	short M007_@@EPILOGUE
M007_@@CHECK_FIFTH:
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	ds
	mov	ax,offset DGROUP:BCC_PREDEFINED_5
	push	ax
	db	9Ah
	dw	BCC_RF_1AA8_0007
	dw	seg BCC_RF_1AA8_0007
	or	ax,ax
	jne	short M007_@@CHECK_SIXTH
	mov	ax,4
	jmp	short M007_@@EPILOGUE
M007_@@CHECK_SIXTH:
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	ds
	mov	ax,offset DGROUP:BCC_PREDEFINED_6
	push	ax
	db	9Ah
	dw	BCC_RF_1AA8_0007
	dw	seg BCC_RF_1AA8_0007
	or	ax,ax
	jne	short M007_@@RETURN_ZERO
	mov	ax,5
	jmp	short M007_@@EPILOGUE
M007_@@RETURN_ZERO:
	xor	ax,ax
M007_@@EPILOGUE:
	pop	bp
	retf	4
BCC_LEX_PREDEFINED	endp
CO031_TEXT	ends

CO031_TEXT	segment byte public 'CODE'
		assume	cs:CO031_TEXT
; Original-image layout stub: not recovered source


		db	045h,055h,08Bh,0ECh,083h,0ECh,010h,056h,057h,0A1h,054h,082h,08Bh,0F0h	; ovr_1c96_8000:0DA1
		db	089h,046h,0F8h,08Bh,01Eh,054h,082h,0C6h,007h,000h,033h,0FFh,0A1h,092h	; ovr_1c96_8000:0DAF
		db	082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h; ovr_1c96_8000:0DBD
		db	08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h	; ovr_1c96_8000:0DCB
		db	026h,08Ah,007h,0B4h,000h,089h,046h,0FEh,089h,046h,0F2h,0B9h,00Fh,000h	; ovr_1c96_8000:0DD9
		db	0BBh,050h,011h,02Eh,08Bh,007h,03Bh,046h,0F2h,074h,007h,043h,043h,0E2h	; ovr_1c96_8000:0DE7
		db	0F4h,0E9h,052h,001h,02Eh,0FFh,067h,01Eh,04Fh,00Bh,0FFh,07Dh,003h,0E9h	; ovr_1c96_8000:0DF5
		db	0E1h,001h,0E9h,0D1h,001h,00Bh,0FFh,075h,003h,0E9h,0D7h,001h,0E9h,0C7h	; ovr_1c96_8000:0E03
		db	001h,047h,0E9h,0C3h,001h,0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h	; ovr_1c96_8000:0E11
		db	09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh; ovr_1c96_8000:0E1F
		db	01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,03Ch,02Ah,074h,007h	; ovr_1c96_8000:0E2D
		db	0FFh,00Eh,092h,082h,0E9h,097h,001h,09Ah
		dw	043h
		dw	seg CO030_TEXT
		db	039h,036h; ovr_1c96_8000:0E3B
		db	054h,082h,076h,00Dh,08Bh,01Eh,054h,082h,080h,07Fh,0FFh,020h,075h,003h	; ovr_1c96_8000:0E49
		db	0E9h,061h,0FFh,0B0h,020h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0E9h,056h,0FFh; ovr_1c96_8000:0E57
		db	0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h	; ovr_1c96_8000:0E73
		db	092h,082h,026h,08Ah,007h,0B4h,000h,089h,046h,0FEh,083h,07Eh,0FEh,00Dh	; ovr_1c96_8000:0E81
		db	074h,006h,083h,07Eh,0FEh,00Ah,075h,027h,08Ah,046h,0FEh,050h,090h,00Eh	; ovr_1c96_8000:0E8F
		db	0E8h,0ECh,002h,039h,036h,054h,082h,076h,00Dh,08Bh,01Eh,054h,082h,080h	; ovr_1c96_8000:0E9D
		db	07Fh,0FFh,020h,075h,003h,0E9h,008h,0FFh,0B0h,020h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0E9h,0FDh,0FEh,0FFh,00Eh,092h,082h,0B0h,05Ch,0E9h,015h,001h; ovr_1c96_8000:0EAB
		db	08Ah,046h,0FEh,050h,0FFh,036h,03Eh,020h,0FFh,036h,03Ch,020h,0B8h,001h	; ovr_1c96_8000:0EC7
		db	000h,050h,09Ah
		dw	02Ah
		dw	seg CO032_TEXT
		db	00Bh,0C0h,074h,003h,0E9h,0D8h,0FEh; ovr_1c96_8000:0ED5
		db	08Ah,046h,0FEh,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0B8h,01Ah,000h,0E9h,055h; ovr_1c96_8000:0EE3
		db	002h,08Ah,046h,0FEh,050h,090h,00Eh,0E8h,091h,002h,039h,036h,054h,082h	; ovr_1c96_8000:0EF1
		db	076h,00Dh,08Bh,01Eh,054h,082h,080h,07Fh,0FFh,020h,075h,003h,0E9h,0ADh	; ovr_1c96_8000:0EFF
		db	0FEh,0B0h,020h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0E9h,0A2h,0FEh,08Ah,046h; ovr_1c96_8000:0F0D
		db	0FEh,050h,09Ah
		dw	02Ah
		dw	seg CO030_TEXT
		db	0E9h,0BDh,000h,0A1h,092h,082h,03Bh; ovr_1c96_8000:0F1B
		db	006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh; ovr_1c96_8000:0F29
		db	07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah	; ovr_1c96_8000:0F37
		db	007h,0B4h,000h,089h,046h,0FEh,080h,03Eh,0DAh,077h,000h,074h,00Dh,0B0h	; ovr_1c96_8000:0F45
		db	0FCh,050h,09Ah
		dw	02Ah
		dw	seg CO030_TEXT
		db	0C6h,006h,0DAh,077h,000h,08Bh,05Eh; ovr_1c96_8000:0F53
		db	0FEh,080h,0BFh,001h,021h,0F6h,075h,070h,08Ah,046h,0FEh,050h,090h,00Eh	; ovr_1c96_8000:0F61
		db	0E8h,084h,002h,01Eh,0FFh,036h,054h,082h,033h,0C0h,050h,09Ah
		dw	020h
		dw	seg CO02F_TEXT
		db	089h,046h,0F0h,08Bh,05Eh,0F0h,08Eh,006h,03Ah,078h,026h,083h; ovr_1c96_8000:0F6F
		db	07Fh,002h,000h,075h,038h,01Eh,0FFh,036h,054h,082h,00Eh,0E8h,046h,0FDh	; ovr_1c96_8000:0F8B
		db	00Bh,0C0h,075h,02Bh,081h,03Eh,054h,082h,09Dh,077h,073h,023h,01Eh,0A1h	; ovr_1c96_8000:0F99
		db	054h,082h,040h,050h,01Eh,0FFh,036h,054h,082h,01Eh,0FFh,036h,054h,082h	; ovr_1c96_8000:0FA7
		db	09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h,050h,09Ah
		dw	01h
		dw	seg BCC_FAR_B0F1
		db	08Bh,01Eh; ovr_1c96_8000:0FB5
		db	054h,082h,0C6h,007h,0FCh,01Eh,0FFh,036h,054h,082h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	001h,006h,054h,082h,0E9h,0E2h,0FDh,08Ah,046h,0FEh,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0E9h,0D6h,0FDh,046h,080h,03Ch,020h,074h,0FAh,0EBh,012h; ovr_1c96_8000:0FC3
		db	08Bh,01Eh,054h,082h,080h,07Fh,0FFh,020h,075h,00Eh,0C6h,047h,0FFh,000h	; ovr_1c96_8000:0FED
		db	0FFh,00Eh,054h,082h,039h,036h,054h,082h,077h,0E8h,0B0h,01Ah,050h,09Ah	; ovr_1c96_8000:0FFB
		dw	052h
		dw	seg CO030_TEXT
		db	01Eh,0B8h,046h,082h,050h,01Eh,056h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h,050h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	0C4h,05Eh,004h,026h,089h; ovr_1c96_8000:1009
		db	007h,0FFh,036h,046h,082h,026h,0FFh,037h,01Eh,056h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0A1h,0ACh,086h,089h,046h,0F6h,01Eh,056h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h,089h,046h,0FCh,025h,001h,000h,001h,046h,0FCh,01Eh,0B8h,0A8h,086h	; ovr_1c96_8000:1041
		db	050h,0FFh,076h,0FCh,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	089h,046h,0F4h,0FFh,036h; ovr_1c96_8000:104F
		db	0A8h,086h,040h,050h,01Eh,056h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0FFh,006h,0D7h; ovr_1c96_8000:105D
		db	077h,033h,0C0h,050h,050h,0FFh,076h,0F4h,09Ah
		dw	048h
		dw	seg CO032_TEXT
		db	0A1h; ovr_1c96_8000:106B
		db	052h,082h,089h,046h,0FAh,0C7h,006h,052h,082h,001h,023h,033h,0FFh,08Bh	; ovr_1c96_8000:1079
		db	046h,0F8h,0A3h,054h,082h,08Bh,01Eh,054h,082h,0C6h,007h,000h,00Eh,0E8h	; ovr_1c96_8000:1087
		db	06Ah,0F0h,03Dh,008h,000h,074h,04Dh,03Dh,031h,000h,074h,002h,0EBh,0F0h	; ovr_1c96_8000:1095
		db	080h,03Eh,0DBh,077h,000h,074h,02Fh,081h,03Eh,054h,082h,09Dh,077h,073h	; ovr_1c96_8000:10A3
		db	027h,01Eh,0A1h,054h,082h,040h,050h,01Eh,0FFh,036h,054h,082h,01Eh,0FFh	; ovr_1c96_8000:10B1
		db	036h,054h,082h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h,050h,09Ah
		dw	01h
		dw	seg BCC_FAR_B0F1
		db	08Bh,01Eh,054h,082h,0C6h,007h,0FCh,0FFh,006h,054h,082h,01Eh,0FFh; ovr_1c96_8000:10BF
		db	036h,054h,082h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	001h,006h,054h,082h,0EBh,0AAh; ovr_1c96_8000:10DB
		db	081h,03Eh,054h,082h,09Dh,077h,072h,00Ah,0B8h,043h,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,08Bh,046h,0FAh,0A3h,052h,082h,08Bh,01Eh,054h,082h; ovr_1c96_8000:10E9
		db	0C6h,007h,000h,08Bh,046h,0F8h,0A3h,054h,082h,0A1h,092h,082h,03Bh,006h	; ovr_1c96_8000:1105
		db	08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch; ovr_1c96_8000:1113
		db	082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h	; ovr_1c96_8000:1121
		db	0FFh,00Eh,092h,082h,0C6h,006h,0DAh,077h,000h,0C7h,006h,0AEh,086h,000h	; ovr_1c96_8000:112F
		db	000h,08Bh,046h,0F6h,0A3h,0ACh,086h,08Bh,046h,0FEh,05Fh,05Eh,08Bh,0E5h	; ovr_1c96_8000:113D
		db	05Dh,04Dh,0C2h,004h,000h,009h,000h,00Ah,000h,00Dh,000h,01Ah,000h,020h	; ovr_1c96_8000:114B
		db	000h,022h,000h,027h,000h,028h,000h,029h,000h,02Ch,000h,02Fh,000h,05Ch	; ovr_1c96_8000:1159
		db	000h,0FBh,000h,0FCh,000h,0FFh,000h,0FBh,00Eh,0F2h,00Eh,0F2h,00Eh,0E6h	; ovr_1c96_8000:1167
		db	00Fh,0FBh,00Eh,0C7h,00Eh,0C7h,00Eh,012h,00Eh,0FDh,00Dh,008h,00Eh,016h	; ovr_1c96_8000:1175
		db	00Eh,065h,00Eh,019h,00Fh,019h,00Fh,025h,00Fh	; ovr_1c96_8000:1183

CO031_TEXT	ends

	extrn	X032_06:far
	extrn	BCC_LINE_HOOK:far
	extrn	X032_01:far
	extrn	BCC_RD_828C_W:word
	extrn	BCC_RD_7C1E_W:word
	extrn	BCC_RD_77D3_W:word
	extrn	BCC_LOGICAL_LINE:word
	extrn	BCC_LINE_HOOK_FLAG:word
	extrn	BCC_TOKEN_POSITION:dword
		extrn	BCC_RD_8292_W:word
		extrn	BCC_RD_921E_W:word
		extrn	BCC_RD_920E_W:word


CO031_TEXT	segment byte public 'CODE'
	assume	cs:CO031_TEXT,ds:DGROUP

		public	X031_04
X031_04	label	far
BCC_LEX_NEWLINE	proc	far
	push	bp
	mov	bp,sp
	push	si
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M009_@@BUFFERED
	db	9Ah
	dw	X032_06
	dw	seg X032_06
	jmp	short M009_@@CHARACTER
M009_@@BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M009_@@CHARACTER:
	mov	ah,0
	mov	si,ax
	cmp	byte ptr [bp+6],13
	jne	short M009_@@FIRST_LF
	cmp	si,10
	je	short M009_@@COUNT_LINE
	dec	word ptr DGROUP:BCC_RD_920E_W
	jmp	short M009_@@COUNT_LINE
M009_@@FIRST_LF:
	cmp	si,13
	je	short M009_@@COUNT_LINE
	dec	word ptr DGROUP:BCC_RD_920E_W
M009_@@COUNT_LINE:
	inc	word ptr DGROUP:BCC_RD_77D3_W
	mov	ax,word ptr DGROUP:BCC_RD_77D3_W
	mov	word ptr DGROUP:BCC_LOGICAL_LINE,ax
	cmp	word ptr DGROUP:BCC_LINE_HOOK_FLAG,0
	je	short M009_@@SAVE_POSITION
	db	9Ah
	dw	BCC_LINE_HOOK
	dw	seg BCC_LINE_HOOK
M009_@@SAVE_POSITION:
	db	9Ah
	dw	X032_01
	dw	seg X032_01
	mov	word ptr DGROUP:BCC_TOKEN_POSITION+2,dx
	mov	word ptr DGROUP:BCC_TOKEN_POSITION,ax
	pop	si
	pop	bp
	retf	2
BCC_LEX_NEWLINE	endp
CO031_TEXT	ends


	extrn	X032_06:far
	extrn	BCC_RD_8292_W:word
	extrn	BCC_RD_8C0E_W:word
	extrn	BCC_RD_827C_W:word
	extrn	BCC_RD_FB1E_B:byte
		extrn	BCC_RD_543E_W:word
		extrn	BCC_RD_8254_W:word


CO031_TEXT	segment byte public 'CODE'
	assume	cs:CO031_TEXT,ds:DGROUP

		public	X031_0E
X031_0E	label	far
BCC_LEX_WHITESPACE	proc	far
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	di,word ptr DGROUP:BCC_RD_543E_W
	push	di
	push	ds
	pop	es
	mov	bx,2101h
	cld
	mov	dx,word ptr [bp+6]
M00A_@@STORE:
	cmp	di,779dh
	jnc	short M00A_@@LOAD
	mov	al,dl
	stosb
M00A_@@LOAD:
	mov	cx,word ptr DGROUP:BCC_RD_8C0E_W
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	mov	si,word ptr DGROUP:BCC_RD_827C_W
	mov	ds,word ptr [si]
	mov	si,ax
	sub	cx,si
	jcxz	short M00A_@@REFILL
M00A_@@BUFFER_LOOP:
	lodsb
	xor	ah,ah
	mov	dx,ax
	xlat	byte ptr es:[bx]
	cmp	al,0f6h
	jne	short M00A_@@NOT_SPACE
M00A_@@BUFFER_SPACE:
	cmp	di,779dh
	jnc	short M00A_@@BUFFER_NEXT
	mov	al,dl
	stosb
M00A_@@BUFFER_NEXT:
	loop	M00A_@@BUFFER_LOOP
M00A_@@REFILL:
	push	bx
	push	cx
	push	es
	pop	ds
	db	9Ah
	dw	X032_06
	dw	seg X032_06
	push	ds
	pop	es
	pop	cx
	pop	bx
	cld
	mov	dx,ax
	xlat	byte ptr [bx]
	cmp	al,0f6h
	je	short M00A_@@STORE
	cmp	al,0f5h
	je	short M00A_@@STORE
	mov	si,word ptr DGROUP:BCC_RD_8292_W
	jmp	short M00A_@@FINISH
M00A_@@NOT_SPACE:
	cmp	al,0f5h
	je	short M00A_@@BUFFER_SPACE
M00A_@@FINISH:
	push	es
	pop	ds
	dec	si
	mov	word ptr DGROUP:BCC_RD_8292_W,si
	pop	ax
	mov	word ptr DGROUP:BCC_RD_8254_W,ax
	mov	cx,di
	sub	cx,ax
	mov	bl,byte ptr DGROUP:BCC_RD_FB1E_B
	xor	bh,bh
	cmp	cx,bx
	jbe	short M00A_@@TERMINATE
	add	ax,bx
	mov	di,ax
M00A_@@TERMINATE:
	xor	al,al
	stosb
	pop	di
	pop	si
	pop	bp
	retf	2
BCC_LEX_WHITESPACE	endp
CO031_TEXT	ends


	extrn	X032_06:far
	extrn	BCC_RD_8254_W:word
	extrn	BCC_RD_16FB_B:byte
	extrn	BCC_RD_828C_W:word
	extrn	BCC_RD_7C1E_W:word
	extrn	BCC_RD_2101_B:byte
		extrn	BCC_RD_8292_W:word
		extrn	BCC_RD_921E_W:word
		extrn	BCC_RD_920E_W:word


CO031_TEXT	segment byte public 'CODE'
	assume	cs:CO031_TEXT,ds:DGROUP

		public	X031_0D
X031_0D	label	far
BCC_LEX_IDENTIFIER	proc	far
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	si,word ptr DGROUP:BCC_RD_8254_W
	mov	al,byte ptr DGROUP:BCC_RD_16FB_B
	cbw
	mov	di,ax
M00B_@@BODY:
	mov	al,byte ptr [bp+6]
	mov	byte ptr [si],al
	inc	si
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M00B_@@BUFFERED
	db	9Ah
	dw	X032_06
	dw	seg X032_06
	jmp	short M00B_@@CHARACTER
M00B_@@BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M00B_@@CHARACTER:
	mov	ah,0
	mov	word ptr [bp+6],ax
	dec	di
	or	di,di
	jz	short M00B_@@FINISH_NAME
	mov	bx,word ptr [bp+6]
	cmp	byte ptr DGROUP:BCC_RD_2101_B[bx+1],0f6h
	je	short M00B_@@BODY
	cmp	byte ptr DGROUP:BCC_RD_2101_B[bx+1],0f5h
	je	short M00B_@@BODY
	cmp	word ptr [bp+6],64
	je	short M00B_@@BODY
	cmp	word ptr [bp+6],36
	je	short M00B_@@BODY
M00B_@@FINISH_NAME:
	mov	byte ptr [si],0
	jmp	short M00B_@@SKIP_TEST
M00B_@@READ_EXTRA:
	mov	ax,word ptr DGROUP:BCC_RD_8292_W
	cmp	ax,word ptr DGROUP:BCC_RD_828C_W
	jc	short M00B_@@EXTRA_BUFFERED
	db	9Ah
	dw	X032_06
	dw	seg X032_06
	jmp	short M00B_@@EXTRA_CHARACTER
M00B_@@EXTRA_BUFFERED:
	mov	bx,word ptr DGROUP:BCC_RD_7C1E_W
	mov	es,word ptr [bx]
	mov	bx,word ptr DGROUP:BCC_RD_921E_W
	inc	word ptr DGROUP:BCC_RD_8292_W
	mov	al,byte ptr es:[bx]
M00B_@@EXTRA_CHARACTER:
	mov	ah,0
	mov	word ptr [bp+6],ax
M00B_@@SKIP_TEST:
	mov	bx,word ptr [bp+6]
	cmp	byte ptr DGROUP:BCC_RD_2101_B[bx+1],0f6h
	je	short M00B_@@READ_EXTRA
	cmp	byte ptr DGROUP:BCC_RD_2101_B[bx+1],0f5h
	je	short M00B_@@READ_EXTRA
	cmp	word ptr [bp+6],36
	je	short M00B_@@READ_EXTRA
	cmp	word ptr [bp+6],64
	je	short M00B_@@READ_EXTRA
	dec	word ptr DGROUP:BCC_RD_920E_W
	pop	di
	pop	si
	pop	bp
	retf	2
BCC_LEX_IDENTIFIER	endp
CO031_TEXT	ends

CO031_TEXT	segment byte public 'CODE'
		assume	cs:CO031_TEXT
; Original-image layout stub: not recovered source


X031_07	label	far
		db	055h,08Bh,0ECh,083h,0ECh,016h,056h,057h,0A0h,0DAh,077h,098h,089h,046h; ovr_1c96_8000:1333
		db	0FEh,0C6h,006h,0DAh,077h,000h,0C6h,006h,0DBh,077h,000h,083h,07Eh,0FEh	; ovr_1c96_8000:1341
		db	000h,074h,01Ah,080h,03Eh,0DCh,077h,000h,075h,013h,01Eh,0FFh,036h,054h	; ovr_1c96_8000:134F
		db	082h,033h,0C0h,050h,09Ah
		dw	020h
		dw	seg CO02F_TEXT
		db	0A3h,096h,082h,0E9h,0DEh; ovr_1c96_8000:135D
		db	001h,01Eh,0FFh,036h,054h,082h,00Eh,0E8h,06Ah,0F9h,048h,08Bh,0D8h,083h	; ovr_1c96_8000:136B
		db	0FBh,004h,076h,003h,0E9h,071h,001h,0D1h,0E3h,02Eh,0FFh,0A7h,058h,015h	; ovr_1c96_8000:1379
		db	08Bh,03Eh,054h,082h,0A1h,046h,078h,08Bh,016h,0C4h,066h,089h,046h,0FCh	; ovr_1c96_8000:1387
		db	089h,056h,0FAh,0EBh,020h,0C4h,05Eh,0FAh,026h,080h,03Fh,05Ch,075h,008h	; ovr_1c96_8000:1395
		db	0B0h,05Ch,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0C4h,05Eh,0FAh,026h,08Ah,007h; ovr_1c96_8000:13A3
		db	050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0FFh,046h,0FAh,0C4h,05Eh,0FAh,026h,080h; ovr_1c96_8000:13B1
		db	03Fh,000h,075h,0D7h,01Eh,0B8h,046h,082h,050h,01Eh,057h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h,050h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	08Bh,0F0h,0FFh,036h,046h; ovr_1c96_8000:13BF
		db	082h,056h,01Eh,057h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	089h,03Eh,054h,082h,089h; ovr_1c96_8000:13DB
		db	036h,056h,082h,0B8h,022h,000h,0E9h,060h,001h,0FFh,036h,0D3h,077h,01Eh	; ovr_1c96_8000:13E9
		db	0B8h,09Eh,077h,050h,09Ah
		dw	0CCh
		dw	seg BCC_FAR_AF0C
		db	01Eh,0B8h,09Fh,077h,050h; ovr_1c96_8000:13F7
		db	09Ah
		dw	057h
		dw	seg CO032_TEXT
		db	0A0h,09Eh,077h,098h,0E9h,041h,001h,0B8h,031h; ovr_1c96_8000:1405
		db	000h,0E9h,03Bh,001h,016h,08Dh,046h,0EAh,050h,01Eh,0A0h,0A3h,082h,098h	; ovr_1c96_8000:1413
		db	0BAh,003h,000h,0F7h,0EAh,005h,03Dh,020h,050h,0B8h,003h,000h,050h,09Ah	; ovr_1c96_8000:1421
		dw	01h
		dw	seg BCC_FAR_B0F1
		db	0C6h,046h,0EDh,020h,0A0h,0A2h,082h,098h,0BBh,00Ah; ovr_1c96_8000:142F
		db	000h,099h,0F7h,0FBh,004h,030h,088h,046h,0EEh,0A0h,0A2h,082h,098h,099h	; ovr_1c96_8000:143D
		db	0F7h,0FBh,080h,0C2h,030h,088h,056h,0EFh,0C6h,046h,0F0h,020h,0FFh,036h	; ovr_1c96_8000:144B
		db	0A0h,082h,016h,08Dh,046h,0F1h,050h,09Ah
		dw	0CCh
		dw	seg BCC_FAR_AF0C
		db	0EBh,060h; ovr_1c96_8000:1459
		db	0A0h,09Bh,082h,0B4h,000h,0BBh,00Ah,000h,099h,0F7h,0FBh,004h,030h,088h	; ovr_1c96_8000:1467
		db	046h,0EAh,0A0h,09Bh,082h,0B4h,000h,099h,0F7h,0FBh,080h,0C2h,030h,088h	; ovr_1c96_8000:1475
		db	056h,0EBh,0C6h,046h,0ECh,03Ah,0A0h,09Ah,082h,0B4h,000h,099h,0F7h,0FBh	; ovr_1c96_8000:1483
		db	004h,030h,088h,046h,0EDh,0A0h,09Ah,082h,0B4h,000h,099h,0F7h,0FBh,080h	; ovr_1c96_8000:1491
		db	0C2h,030h,088h,056h,0EEh,0C6h,046h,0EFh,03Ah,0A0h,09Dh,082h,0B4h,000h	; ovr_1c96_8000:149F
		db	099h,0F7h,0FBh,004h,030h,088h,046h,0F0h,0A0h,09Dh,082h,0B4h,000h,099h	; ovr_1c96_8000:14AD
		db	0F7h,0FBh,080h,0C2h,030h,088h,056h,0F1h,0C6h,046h,0F2h,000h,01Eh,0B8h	; ovr_1c96_8000:14BB
		db	046h,082h,050h,016h,08Dh,046h,0EAh,050h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h; ovr_1c96_8000:14C9
		db	050h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	08Bh,0F0h,0FFh,036h,046h,082h,056h,016h; ovr_1c96_8000:14D7
		db	08Dh,046h,0EAh,050h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0E9h,0F7h,0FEh,080h,03Eh; ovr_1c96_8000:14E5
		db	0D0h,077h,000h,074h,018h,01Eh,0FFh,036h,054h,082h,01Eh,0B8h,038h,024h	; ovr_1c96_8000:14F3
		db	050h,09Ah
		dw	07h
		dw	seg BCC_COMPARE_NAME
		db	00Bh,0C0h,075h,005h,0E8h,054h,000h,0EBh; ovr_1c96_8000:1501
		db	042h,09Ah
		dw	02Fh
		dw	seg CO033_TEXT
		db	00Bh,0C0h,074h,031h,0E8h,0F9h,0F5h,00Bh; ovr_1c96_8000:150F
		db	0C0h,075h,005h,0B8h,0FFh,0FFh,0EBh,02Dh,0A1h,092h,082h,03Bh,006h,08Ch	; ovr_1c96_8000:151D
		db	082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h; ovr_1c96_8000:152B
		db	08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h	; ovr_1c96_8000:1539
		db	000h,0EBh,008h,0C6h,006h,0DBh,077h,001h,0B8h,0FEh,0FFh,05Fh,05Eh,08Bh	; ovr_1c96_8000:1547
		db	0E5h,05Dh,0CBh,011h,014h,087h,013h,0F2h,013h,017h,014h,067h,014h	; ovr_1c96_8000:1555

CO031_TEXT	ends

	extrn	X030_01:far
	extrn	X030_08:far
	extrn	X033_00:far
	extrn	BCC_RF_15A7_011B:far
	extrn	BCC_RD_2101_B:byte
	extrn	BCC_RD_920E_W:word
	extrn	BCC_NAME_BUFFER:byte


CO031_TEXT	segment byte public 'CODE'
	assume	cs:CO031_TEXT,ds:DGROUP

BCC_LEX_DEFINED	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	ax,32
	push	ax
	db	9Ah
	dw	X030_01
	dw	seg X030_01
	mov	si,ax
	cmp	si,26
	jne	short M00D_@@CHECK_OPEN
M00D_@@SYNTAX_ERROR:
	mov	ax,43
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
	jmp	short M00D_@@RETURN_FALSE
M00D_@@CHECK_OPEN:
	cmp	si,40
	jne	short M00D_@@NO_PARENTHESES
	mov	di,1
	mov	ax,32
	push	ax
	db	9Ah
	dw	X030_01
	dw	seg X030_01
	mov	si,ax
	cmp	si,26
	jne	short M00D_@@CHECK_IDENTIFIER
	jmp	short M00D_@@SYNTAX_ERROR
M00D_@@NO_PARENTHESES:
	xor	di,di
M00D_@@CHECK_IDENTIFIER:
	cmp	byte ptr DGROUP:BCC_RD_2101_B[si+1],0f6h
	je	short M00D_@@READ_IDENTIFIER
	jmp	short M00D_@@SYNTAX_ERROR
M00D_@@READ_IDENTIFIER:
	push	si
	db	9Ah
	dw	X030_08
	dw	seg X030_08
	mov	si,ax
	or	di,di
	jz	short M00D_@@REWIND_IDENTIFIER
	push	si
	db	9Ah
	dw	X030_01
	dw	seg X030_01
	mov	si,ax
	cmp	si,41
	je	short M00D_@@LOOKUP
	mov	ax,43
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
	dec	word ptr DGROUP:BCC_RD_920E_W
	jmp	short M00D_@@LOOKUP
M00D_@@REWIND_IDENTIFIER:
	dec	word ptr DGROUP:BCC_RD_920E_W
M00D_@@LOOKUP:
	push	ds
	mov	ax,offset DGROUP:BCC_NAME_BUFFER
	push	ax
	db	9Ah
	dw	X033_00
	dw	seg X033_00
	or	ax,ax
	jz	short M00D_@@RETURN_FALSE
	mov	ax,49
	jmp	short M00D_@@EPILOGUE
M00D_@@RETURN_FALSE:
	mov	ax,48
M00D_@@EPILOGUE:
	pop	di
	pop	si
	pop	bp
	dec	bp
	ret
BCC_LEX_DEFINED	endp
CO031_TEXT	ends

CO031_TEXT	segment byte public 'CODE'
		assume	cs:CO031_TEXT
; Original-image layout stub: not recovered source


		db	045h,055h,08Bh,0ECh,083h,0ECh,004h,056h,057h,0C7h,046h,0FEh,000h,000h	; ovr_1c96_8000:15F1
		db	033h,0FFh,080h,07Eh,004h,030h,074h,003h,0E9h,0B4h,000h,0B0h,030h,050h	; ovr_1c96_8000:15FF
		db	09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h; ovr_1c96_8000:160D
		db	09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh; ovr_1c96_8000:161B
		db	01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,088h,046h,004h,080h	; ovr_1c96_8000:1629
		db	07Eh,004h,078h,074h,006h,080h,07Eh,004h,058h,075h,077h,0C6h,006h,0DAh	; ovr_1c96_8000:1637
		db	077h,000h,08Ah,046h,004h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0A1h,092h,082h; ovr_1c96_8000:1645
		db	03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh; ovr_1c96_8000:1653
		db	01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h	; ovr_1c96_8000:1661
		db	08Ah,007h,088h,046h,004h,098h,08Bh,0D8h,08Ah,087h,001h,021h,098h,089h	; ovr_1c96_8000:166F
		db	046h,0FCh,083h,07Eh,0FCh,0F5h,074h,02Fh,08Ch,0D8h,08Ch,0DAh,03Bh,0C2h	; ovr_1c96_8000:167D
		db	075h,027h,081h,03Eh,052h,082h,001h,021h,075h,01Fh,083h,07Eh,0FCh,0F6h	; ovr_1c96_8000:168B
		db	075h,00Fh,08Ah,046h,004h,098h,050h,09Ah
		dw	0Dh
		dw	seg BCC_FAR_AB51
		db	03Dh,066h; ovr_1c96_8000:1699
		db	000h,07Eh,00Ah,0B8h,04Ah,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,0BEh; ovr_1c96_8000:16A7
		db	010h,000h,0EBh,008h,0BEh,008h,000h,0EBh,003h,0BEh,00Ah,000h,08Ah,046h	; ovr_1c96_8000:16B5
		db	004h,098h,02Dh,02Eh,000h,08Bh,0D8h,083h,0FBh,047h,076h,003h,0E9h,077h	; ovr_1c96_8000:16C3
		db	002h,0D1h,0E3h,02Eh,0FFh,0A7h,094h,019h,083h,0FEh,008h,075h,029h,08Ch	; ovr_1c96_8000:16D1
		db	0D8h,08Ch,0DAh,03Bh,0C2h,075h,008h,081h,03Eh,052h,082h,001h,021h,074h	; ovr_1c96_8000:16DF
		db	00Ch,08Ah,046h,004h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0E9h,06Ah,002h,0B8h; ovr_1c96_8000:16ED
		db	04Ch,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,0E9h,05Dh,002h,0EBh,0E5h; ovr_1c96_8000:16FB
		db	08Ch,0D8h,08Ch,0DAh,03Bh,0C2h,075h,035h,081h,03Eh,052h,082h,001h,021h	; ovr_1c96_8000:1709
		db	075h,02Dh,083h,07Eh,0FEh,000h,074h,00Ah,0B8h,044h,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,00Bh,0FFh,074h,00Ah,0B8h,016h,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,083h,0FEh,010h,075h,00Ah,0B8h,04Ah,000h,050h,09Ah; ovr_1c96_8000:1717
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,0C7h,046h,0FEh,001h,000h,033h,0F6h,0EBh,09Fh; ovr_1c96_8000:1741
		db	0C6h,006h,0DAh,077h,000h,083h,0FEh,010h,075h,003h,0E9h,0C1h,000h,08Ch	; ovr_1c96_8000:174F
		db	0D8h,08Ch,0DAh,03Bh,0C2h,075h,016h,081h,03Eh,052h,082h,001h,021h,075h	; ovr_1c96_8000:175D
		db	00Eh,00Bh,0FFh,074h,00Ah,0B8h,045h,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,0BFh,001h,000h,033h,0F6h,08Ah,046h,004h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh; ovr_1c96_8000:1779
		db	006h,092h,082h,026h,08Ah,007h,088h,046h,004h,080h,07Eh,004h,02Dh,074h	; ovr_1c96_8000:17A3
		db	006h,080h,07Eh,004h,02Bh,075h,02Dh,08Ah,046h,004h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h; ovr_1c96_8000:17B1
		db	0FFh,006h,092h,082h,026h,08Ah,007h,088h,046h,004h,08Ah,046h,004h,098h	; ovr_1c96_8000:17DB
		db	08Bh,0D8h,080h,0BFh,001h,021h,0F5h,075h,003h,0E9h,0F9h,0FEh,08Ch,0D8h	; ovr_1c96_8000:17E9
		db	08Ch,0DAh,03Bh,0C2h,075h,012h,081h,03Eh,052h,082h,001h,021h,075h,00Ah	; ovr_1c96_8000:17F7
		db	0B8h,04Ah,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,0FFh,00Eh,092h,082h; ovr_1c96_8000:1805
		db	0C6h,006h,062h,082h,00Ah,033h,0C0h,0E9h,06Eh,001h,0E9h,0CEh,0FEh,083h	; ovr_1c96_8000:1813
		db	0FEh,010h,074h,003h,0E9h,02Eh,001h,0C6h,006h,0DAh,077h,000h,0E9h,0BEh	; ovr_1c96_8000:1821
		db	0FEh,08Ch,0D8h,08Ch,0DAh,03Bh,0C2h,075h,021h,081h,03Eh,052h,082h,001h	; ovr_1c96_8000:182F
		db	021h,075h,019h,083h,0FEh,010h,074h,014h,083h,07Eh,0FEh,000h,075h,00Eh	; ovr_1c96_8000:183D
		db	00Bh,0FFh,075h,00Ah,0B8h,04Ah,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h; ovr_1c96_8000:184B
		db	0C6h,006h,0DAh,077h,000h,08Ah,046h,004h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	083h,0FEh,010h,075h,003h,0E9h,0F5h,000h,0C6h,006h,062h,082h,009h,0EBh	; ovr_1c96_8000:1867
		db	0A2h,0C6h,006h,0DAh,077h,000h,08Ah,046h,004h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	083h,07Eh,0FEh,000h,075h,004h,00Bh,0FFh,074h,007h,0C6h,006h,062h; ovr_1c96_8000:1875
		db	082h,00Bh,0EBh,083h,0C6h,006h,062h,082h,007h,0A1h,092h,082h,03Bh,006h	; ovr_1c96_8000:1891
		db	08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch; ovr_1c96_8000:189F
		db	082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h	; ovr_1c96_8000:18AD
		db	088h,046h,004h,080h,07Eh,004h,075h,074h,006h,080h,07Eh,004h,055h,075h	; ovr_1c96_8000:18BB
		db	010h,0C6h,006h,062h,082h,008h,08Ah,046h,004h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0EBh,004h,0FFh,00Eh,092h,082h,0EBh,07Fh,090h,083h,07Eh,0FEh,000h; ovr_1c96_8000:18C9
		db	075h,004h,00Bh,0FFh,074h,003h,0E9h,021h,0FFh,0C6h,006h,0DAh,077h,000h	; ovr_1c96_8000:18E5
		db	08Ah,046h,004h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0C6h,006h,062h,082h,006h; ovr_1c96_8000:18F3
		db	0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h	; ovr_1c96_8000:190F
		db	092h,082h,026h,08Ah,007h,088h,046h,004h,080h,07Eh,004h,06Ch,074h,006h	; ovr_1c96_8000:191D
		db	080h,07Eh,004h,04Ch,075h,010h,0C6h,006h,062h,082h,008h,08Ah,046h,004h	; ovr_1c96_8000:192B
		db	050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0EBh,01Eh,0FFh,00Eh,092h,082h,0EBh,018h; ovr_1c96_8000:1939
		db	0EBh,016h,083h,07Eh,0FEh,000h,075h,004h,00Bh,0FFh,074h,003h,0E9h,0B9h	; ovr_1c96_8000:1947
		db	0FEh,0FFh,00Eh,092h,082h,0C6h,006h,062h,082h,005h,08Bh,0C6h,0E9h,0B6h	; ovr_1c96_8000:1955
		db	0FEh,0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh; ovr_1c96_8000:1963
		db	006h,092h,082h,026h,08Ah,007h,088h,046h,004h,0E9h,036h,0FDh,05Fh,05Eh	; ovr_1c96_8000:197F
		db	08Bh,0E5h,05Dh,04Dh,0C2h,002h,000h,009h,017h,049h,019h,007h,017h,007h	; ovr_1c96_8000:198D
		db	017h,007h,017h,007h,017h,007h,017h,007h,017h,007h,017h,007h,017h,0D9h	; ovr_1c96_8000:199B
		db	016h,0D9h,016h,049h,019h,049h,019h,049h,019h,049h,019h,049h,019h,049h	; ovr_1c96_8000:19A9
		db	019h,049h,019h,020h,018h,020h,018h,020h,018h,020h,018h,04Fh,017h,030h	; ovr_1c96_8000:19B7
		db	018h,049h,019h,049h,019h,049h,019h,049h,019h,049h,019h,076h,018h,049h	; ovr_1c96_8000:19C5
		db	019h,049h,019h,049h,019h,049h,019h,049h,019h,049h,019h,049h,019h,049h	; ovr_1c96_8000:19D3
		db	019h,0E1h,018h,049h,019h,049h,019h,049h,019h,049h,019h,049h,019h,049h	; ovr_1c96_8000:19E1
		db	019h,049h,019h,049h,019h,049h,019h,049h,019h,049h,019h,020h,018h,020h	; ovr_1c96_8000:19EF
		db	018h,020h,018h,020h,018h,04Fh,017h,030h,018h,049h,019h,049h,019h,049h	; ovr_1c96_8000:19FD
		db	019h,049h,019h,049h,019h,076h,018h,049h,019h,049h,019h,049h,019h,049h	; ovr_1c96_8000:1A0B
		db	019h,049h,019h,049h,019h,049h,019h,049h,019h,0E1h,018h	; ovr_1c96_8000:1A19

CO031_TEXT	ends
		extrn	BCC_RD_2401_B:byte
		extrn	BCC_RD_0BF2_B:byte


CO031_TEXT	segment byte public 'CODE'
	assume	cs:CO031_TEXT,ds:DGROUP

		public	X031_01
X031_01	label	far
BCC_LEX_COMPARE	proc	far
	push	bp
	mov	bp,sp
	sub	sp,8
	mov	ax,word ptr [bp+8]
	mov	dx,word ptr [bp+6]
	mov	word ptr [bp-6],ax
	mov	word ptr [bp-8],dx
	mov	word ptr [bp-2],ds
	mov	word ptr [bp-4],offset DGROUP:BCC_RD_2401_B
	jmp	short M00F_@@TEST
M00F_@@COMPARE:
	les	bx,dword ptr [bp-4]
	mov	al,byte ptr es:[bx]
	les	bx,dword ptr [bp-8]
	cmp	al,byte ptr es:[bx]
	jne	short M00F_@@RESULT
	inc	word ptr [bp-4]
	inc	word ptr [bp-8]
M00F_@@TEST:
	cmp	word ptr [bp-4],offset DGROUP:BCC_RD_0BF2_B+10
	jc	short M00F_@@COMPARE
M00F_@@RESULT:
	cmp	word ptr [bp-4],offset DGROUP:BCC_RD_0BF2_B+10
	jc	short M00F_@@DIFFERENT
	mov	ax,1
	jmp	short M00F_@@EPILOGUE
M00F_@@DIFFERENT:
	xor	ax,ax
M00F_@@EPILOGUE:
	mov	sp,bp
	pop	bp
	retf	4
BCC_LEX_COMPARE	endp
CO031_TEXT	ends

CO031_TEXT	segment byte public 'CODE'
		assume	cs:CO031_TEXT
; Original-image layout stub: not recovered source


		db	045h,055h,08Bh,0ECh,056h,057h,0C7h,006h,054h,082h,09Eh,067h,083h,07Eh	; ovr_1c96_8000:1A6F
		db	004h,000h,075h,068h,01Eh,0B8h,09Eh,067h,050h,01Eh,0B8h,069h,082h,050h	; ovr_1c96_8000:1A7D
		db	09Ah
		dw	08h
		dw	seg BCC_SEG_14
		db	080h,03Eh,062h,082h,009h,075h,00Ch,01Eh,0B8h; ovr_1c96_8000:1A8B
		db	069h,082h,050h,09Ah
		dw	06h
		dw	seg BCC_FAR_9E16
		db	0EBh,011h,080h,03Eh,062h,082h; ovr_1c96_8000:1A99
		db	00Ah,075h,00Ah,01Eh,0B8h,069h,082h,050h,09Ah
		dw	0D5h
		dw	seg BCC_FAR_9E16
		db	080h; ovr_1c96_8000:1AA7
		db	03Eh,0F5h,016h,001h,075h,028h,01Eh,0B8h,069h,082h,050h,00Eh,0E8h,060h	; ovr_1c96_8000:1AB5
		db	0FFh,00Bh,0C0h,074h,01Bh,0B8h,04Bh,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,01Eh,0B8h,069h,082h,050h,033h,0C0h,050h,0B8h,00Ah,000h,050h,09Ah	; ovr_1c96_8000:1AD1
		dw	03h
		dw	seg BCC_FAR_AF23
		db	0B8h,033h,000h,0E9h,06Eh,001h,0C7h,006h,06Bh,082h; ovr_1c96_8000:1ADF
		db	000h,000h,0C7h,006h,069h,082h,000h,000h,083h,07Eh,004h,010h,075h,005h	; ovr_1c96_8000:1AED
		db	0BFh,0A0h,067h,0EBh,051h,0BFh,09Eh,067h,0EBh,04Ch,08Ah,005h,098h,050h	; ovr_1c96_8000:1AFB
		db	09Ah
		dw	0Dh
		dw	seg BCC_FAR_AB51
		db	08Bh,0F0h,083h,0FEh,06Ch,074h,041h,083h,0FEh; ovr_1c96_8000:1B09
		db	075h,074h,03Ch,080h,0BCh,001h,021h,0F6h,075h,005h,083h,0C6h,0A9h,0EBh	; ovr_1c96_8000:1B17
		db	003h,083h,0EEh,030h,08Bh,046h,004h,099h,050h,052h,08Bh,016h,06Bh,082h	; ovr_1c96_8000:1B25
		db	0A1h,069h,082h,059h,05Bh,09Ah
		dw	03A9h
		dw	seg BCC_COPY_WORDS
		db	050h,08Bh,0C6h,052h; ovr_1c96_8000:1B33
		db	099h,05Bh,059h,003h,0C8h,013h,0DAh,089h,01Eh,06Bh,082h,089h,00Eh,069h	; ovr_1c96_8000:1B41
		db	082h,047h,080h,03Dh,000h,075h,0AFh,0A0h,062h,082h,098h,08Bh,0F0h,0A0h	; ovr_1c96_8000:1B4F
		db	062h,082h,098h,03Dh,005h,000h,074h,013h,03Dh,006h,000h,075h,003h,0E9h	; ovr_1c96_8000:1B5D
		db	09Bh,000h,03Dh,007h,000h,075h,003h,0E9h,0AFh,000h,0E9h,0C6h,000h,083h	; ovr_1c96_8000:1B6B
		db	07Eh,004h,00Ah,075h,03Bh,0A1h,06Bh,082h,08Bh,016h,069h,082h,03Bh,006h	; ovr_1c96_8000:1B79
		db	0B6h,039h,072h,00Bh,077h,006h,03Bh,016h,0B4h,039h,076h,003h,0E9h,0A3h	; ovr_1c96_8000:1B87
		db	000h,0A1h,06Bh,082h,08Bh,016h,069h,082h,03Bh,006h,0A6h,039h,073h,003h	; ovr_1c96_8000:1B95
		db	0E9h,098h,000h,077h,009h,03Bh,016h,0A4h,039h,077h,003h,0E9h,08Dh,000h	; ovr_1c96_8000:1BA3
		db	0C6h,006h,062h,082h,007h,0E9h,085h,000h,0A1h,06Bh,082h,08Bh,016h,069h	; ovr_1c96_8000:1BB1
		db	082h,03Bh,006h,0B6h,039h,072h,00Ah,077h,006h,03Bh,016h,0B4h,039h,076h	; ovr_1c96_8000:1BBF
		db	002h,0EBh,069h,0A1h,06Bh,082h,08Bh,016h,069h,082h,03Bh,006h,0AEh,039h	; ovr_1c96_8000:1BCD
		db	072h,00Fh,077h,006h,03Bh,016h,0ACh,039h,076h,007h,0C6h,006h,062h,082h	; ovr_1c96_8000:1BDB
		db	007h,0EBh,052h,0A1h,06Bh,082h,08Bh,016h,069h,082h,03Bh,006h,0A6h,039h	; ovr_1c96_8000:1BE9
		db	072h,045h,077h,006h,03Bh,016h,0A4h,039h,076h,03Dh,0C6h,006h,062h,082h	; ovr_1c96_8000:1BF7
		db	006h,0EBh,036h,0A1h,06Bh,082h,08Bh,016h,069h,082h,03Bh,006h,0AEh,039h	; ovr_1c96_8000:1C05
		db	072h,029h,077h,006h,03Bh,016h,0ACh,039h,076h,021h,0C6h,006h,062h,082h	; ovr_1c96_8000:1C13
		db	008h,0EBh,01Ah,0A1h,06Bh,082h,08Bh,016h,069h,082h,03Bh,006h,0B6h,039h	; ovr_1c96_8000:1C21
		db	072h,00Dh,077h,006h,03Bh,016h,0B4h,039h,076h,005h,0C6h,006h,062h,082h	; ovr_1c96_8000:1C2F
		db	008h,080h,03Eh,062h,082h,007h,07Ch,00Fh,083h,0FEh,007h,07Dh,00Ah,0B8h	; ovr_1c96_8000:1C3D
		db	069h,001h,050h,09Ah
		dw	017Dh
		dw	seg BCC_DIAGNOSTIC
		db	059h,0B8h,032h,000h,05Fh,05Eh; ovr_1c96_8000:1C4B
		db	05Dh,04Dh,0C2h,002h,000h	; ovr_1c96_8000:1C59

CO031_TEXT	ends

	extrn	BCC_RF_15A7_011B:far
	extrn	BCC_TOKEN_TYPE:word
	extrn	BCC_UNSIGNED_CHAR:byte
	extrn	BCC_TOKEN_VALUE:word
	extrn	BCC_TOKEN_AUX:byte
	extrn	BCC_TOKEN_CONVERT:dword


CO031_TEXT	segment byte public 'CODE'
	assume	cs:CO031_TEXT,ds:DGROUP

BCC_LEX_CHARACTER	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,6
	push	si
	mov	word ptr [bp-6],0
	xor	si,si
	jmp	short M011_@@READ_FIRST
M011_@@ACCUMULATE:
	cmp	si,2
	jge	short M011_@@SKIP_STORE
	mov	al,byte ptr [bp-2]
	mov	byte ptr [bp+si-6],al
M011_@@SKIP_STORE:
	inc	si
M011_@@READ_FIRST:
	mov	al,39
	push	ax
	nop
	push	cs
	call	near ptr BCC_LEX_ESCAPE
	mov	word ptr [bp-2],ax
	cmp	ax,0ffffh
	jne	short M011_@@ACCUMULATE
	cmp	si,2
	jle	short M011_@@CHECK_SINGLE
	mov	ax,28
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
M011_@@CHECK_SINGLE:
	cmp	si,1
	jne	short M011_@@CONVERT
	mov	word ptr DGROUP:BCC_TOKEN_TYPE,65h
	cmp	byte ptr DGROUP:BCC_UNSIGNED_CHAR,0
	je	short M011_@@SIGNED_CHAR
	mov	al,byte ptr [bp-6]
	mov	ah,0
	mov	word ptr [bp-4],0
	jmp	short M011_@@STORE_VALUE
M011_@@SIGNED_CHAR:
	mov	al,byte ptr [bp-6]
	cbw
	cwd
	mov	word ptr [bp-4],dx
M011_@@STORE_VALUE:
	mov	word ptr [bp-6],ax
M011_@@CONVERT:
	mov	ax,word ptr [bp-6]
	cwd
	push	dx
	push	ax
	mov	ax,5
	push	ax
	db	0ffh,01eh
	dw	BCC_TOKEN_CONVERT
	mov	word ptr DGROUP:BCC_TOKEN_VALUE+2,dx
	mov	word ptr DGROUP:BCC_TOKEN_VALUE,ax
	mov	byte ptr DGROUP:BCC_TOKEN_AUX,5
	cmp	si,1
	jne	short M011_@@RETURN_INTEGER
	mov	ax,65h
	jmp	short M011_@@EPILOGUE
M011_@@RETURN_INTEGER:
	mov	ax,32h
M011_@@EPILOGUE:
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret
BCC_LEX_ESCAPE	label	near
BCC_LEX_CHARACTER	endp
CO031_TEXT	ends

; Original-target semantic aliases (zero bytes)
CO031_TEXT	segment byte public 'CODE'
		assume	cs:CO031_TEXT
; Original-image layout stub: not recovered source


X031_05	label	far
		db	055h,08Bh,0ECh,083h,0ECh,006h,056h,057h,0C7h,046h,0FCh,000h,000h,0A1h; ovr_1c96_8000:1CF0
		db	092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh; ovr_1c96_8000:1CFE
		db	011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h	; ovr_1c96_8000:1D0C
		db	082h,026h,08Ah,007h,0B4h,000h,089h,046h,0FEh,083h,07Eh,0FEh,01Ah,074h	; ovr_1c96_8000:1D1A
		db	00Ch,083h,07Eh,0FEh,00Ah,074h,006h,083h,07Eh,0FEh,00Dh,075h,00Dh,0E8h	; ovr_1c96_8000:1D28
		db	074h,002h,0FFh,00Eh,092h,082h,0B8h,0FFh,0FFh,0E9h,016h,002h,08Ah,046h	; ovr_1c96_8000:1D36
		db	006h,098h,03Bh,046h,0FEh,075h,002h,0EBh,0EFh,083h,07Eh,0FEh,05Ch,074h	; ovr_1c96_8000:1D44
		db	003h,0E9h,0FFh,001h,0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah	; ovr_1c96_8000:1D52
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh; ovr_1c96_8000:1D60
		db	092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h,089h,046h,0FEh	; ovr_1c96_8000:1D6E
		db	089h,046h,0FAh,0B9h,013h,000h,0BBh,060h,01Fh,02Eh,08Bh,007h,03Bh,046h	; ovr_1c96_8000:1D7C
		db	0FAh,074h,007h,043h,043h,0E2h,0F4h,0E9h,0BFh,001h,02Eh,0FFh,067h,026h	; ovr_1c96_8000:1D8A
		db	0E8h,011h,002h,0EBh,09Fh,0B8h,007h,000h,0E9h,0B5h,001h,0B8h,009h,000h	; ovr_1c96_8000:1D98
		db	0E9h,0AFh,001h,0B8h,00Ah,000h,0E9h,0A9h,001h,0B8h,008h,000h,0E9h,0A3h	; ovr_1c96_8000:1DA6
		db	001h,0B8h,00Dh,000h,0E9h,09Dh,001h,0B8h,00Ch,000h,0E9h,097h,001h,0B8h	; ovr_1c96_8000:1DB4
		db	00Bh,000h,0E9h,091h,001h,0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h	; ovr_1c96_8000:1DC2
		db	09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh; ovr_1c96_8000:1DD0
		db	01Eh,092h,082h,0FFh,006h,092h,082h,026h,08Ah,007h,0B4h,000h,089h,046h	; ovr_1c96_8000:1DDE
		db	0FEh,08Bh,05Eh,0FEh,08Ah,087h,081h,05Bh,098h,0A9h,012h,000h,075h,00Ah	; ovr_1c96_8000:1DEC
		db	0FFh,00Eh,092h,082h,0B8h,078h,000h,0E9h,054h,001h,033h,0F6h,0BFh,001h	; ovr_1c96_8000:1DFA
		db	000h,0B1h,004h,0D3h,0E6h,08Bh,05Eh,0FEh,0F6h,087h,081h,05Bh,002h,074h	; ovr_1c96_8000:1E08
		db	008h,08Bh,046h,0FEh,005h,0D0h,0FFh,0EBh,00Bh,0FFh,076h,0FEh,09Ah
		dw	0Dh
		dw	seg BCC_FAR_AB51
		db	005h,0A9h,0FFh,003h,0F0h,083h,07Eh,0FCh,000h,075h,028h; ovr_1c96_8000:1E16
		db	08Bh,0C6h,099h,03Bh,016h,08Eh,039h,07Ch,01Fh,07Fh,006h,03Bh,006h,08Ch	; ovr_1c96_8000:1E32
		db	039h,076h,017h,0A1h,0D3h,077h,0A3h,0BEh,066h,0B8h,04Bh,000h,050h,09Ah	; ovr_1c96_8000:1E40
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,0C7h,046h,0FCh,001h,000h,033h,0F6h,0A1h,092h; ovr_1c96_8000:1E4E
		db	082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h; ovr_1c96_8000:1E5C
		db	08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh,006h,092h,082h	; ovr_1c96_8000:1E6A
		db	026h,08Ah,007h,0B4h,000h,089h,046h,0FEh,08Bh,05Eh,0FEh,08Ah,087h,081h	; ovr_1c96_8000:1E78
		db	05Bh,098h,0A9h,012h,000h,075h,019h,0FFh,00Eh,092h,082h,083h,0FFh,003h	; ovr_1c96_8000:1E86
		db	07Eh,00Dh,0B8h,07Ah,001h,050h,09Ah
		dw	017Dh
		dw	seg BCC_DIAGNOSTIC
		db	059h,0E9h,0ACh; ovr_1c96_8000:1E94
		db	000h,0E9h,0A9h,000h,047h,0E9h,05Fh,0FFh,08Ah,046h,0FEh,050h,00Eh,0E8h	; ovr_1c96_8000:1EA2
		db	0DAh,0F2h,0E9h,043h,0FEh,033h,0F6h,033h,0FFh,0EBh,06Fh,08Bh,0C6h,0D1h	; ovr_1c96_8000:1EB0
		db	0E0h,0D1h,0E0h,0D1h,0E0h,003h,046h,0FEh,005h,0D0h,0FFh,08Bh,0F0h,083h	; ovr_1c96_8000:1EBE
		db	07Eh,0FCh,000h,075h,026h,099h,03Bh,016h,08Eh,039h,07Ch,01Fh,07Fh,006h	; ovr_1c96_8000:1ECC
		db	03Bh,006h,08Ch,039h,076h,017h,0A1h,0D3h,077h,0A3h,0BEh,066h,0B8h,04Bh	; ovr_1c96_8000:1EDA
		db	000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,0C7h,046h,0FCh,001h,000h,033h; ovr_1c96_8000:1EE8
		db	0F6h,0A1h,092h,082h,03Bh,006h,08Ch,082h,072h,007h,09Ah
		dw	03Eh
		dw	seg CO032_TEXT
		db	0EBh,011h,08Bh,01Eh,07Ch,082h,08Eh,007h,08Bh,01Eh,092h,082h,0FFh; ovr_1c96_8000:1EF6
		db	006h,092h,082h,026h,08Ah,007h,0B4h,000h,089h,046h,0FEh,083h,07Eh,0FEh	; ovr_1c96_8000:1F12
		db	030h,07Ch,00Ch,083h,07Eh,0FEh,037h,07Fh,006h,047h,083h,0FFh,003h,07Ch	; ovr_1c96_8000:1F20
		db	08Ch,080h,07Eh,006h,027h,075h,016h,083h,07Eh,0FEh,027h,074h,010h,0A1h	; ovr_1c96_8000:1F2E
		db	0D3h,077h,0A3h,0BEh,066h,0B8h,01Ch,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,0FFh,00Eh,092h,082h,08Bh,0C6h,0EBh,005h,0EBh,000h,08Bh,046h,0FEh	; ovr_1c96_8000:1F4A
		db	05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h,00Ah,000h,00Dh,000h,01Ah,000h	; ovr_1c96_8000:1F58
		db	030h,000h,031h,000h,032h,000h,033h,000h,034h,000h,035h,000h,036h,000h	; ovr_1c96_8000:1F66
		db	037h,000h,061h,000h,062h,000h,066h,000h,06Eh,000h,072h,000h,074h,000h	; ovr_1c96_8000:1F74
		db	076h,000h,078h,000h,0AAh,01Eh,0AAh,01Eh,098h,01Dh,0B5h,01Eh,0B5h,01Eh	; ovr_1c96_8000:1F82
		db	0B5h,01Eh,0B5h,01Eh,0B5h,01Eh,0B5h,01Eh,0B5h,01Eh,0B5h,01Eh,09Dh,01Dh	; ovr_1c96_8000:1F90
		db	0AFh,01Dh,0BBh,01Dh,0A9h,01Dh,0B5h,01Dh,0A3h,01Dh,0C1h,01Dh,0C7h,01Dh	; ovr_1c96_8000:1F9E

CO031_TEXT	ends

	extrn	BCC_RF_15A7_011B:far


CO031_TEXT	segment byte public 'CODE'
	assume	cs:CO031_TEXT,ds:DGROUP

BCC_LEX_WARNING	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	mov	ax,86
	push	ax
	db	9Ah
	dw	BCC_RF_15A7_011B
	dw	seg BCC_RF_15A7_011B
	pop	cx
	pop	bp
	dec	bp
	ret
BCC_LEX_WARNING	endp
CO031_TEXT	ends

CO031_TEXT	segment byte public 'CODE'
		assume	cs:CO031_TEXT
; Original-image layout stub: not recovered source


		db	055h,08Bh,0ECh,083h,0ECh,006h,056h,057h,0C4h,05Eh,006h,026h,08Bh,037h	; ovr_1c96_8000:1FBD
		db	046h,08Eh,006h,046h,082h,026h,08Ah,004h,0B4h,000h,089h,046h,0FEh,08Eh	; ovr_1c96_8000:1FCB
		db	046h,008h,026h,089h,037h,089h,046h,0FAh,0B9h,010h,000h,0BBh,03Fh,021h	; ovr_1c96_8000:1FD9
		db	02Eh,08Bh,007h,03Bh,046h,0FAh,074h,007h,043h,043h,0E2h,0F4h,0E9h,03Eh	; ovr_1c96_8000:1FE7
		db	001h,02Eh,0FFh,067h,020h,0B0h,007h,0E9h,038h,001h,0B0h,009h,0E9h,033h	; ovr_1c96_8000:1FF5
		db	001h,0B0h,00Ah,0E9h,02Eh,001h,0B0h,008h,0E9h,029h,001h,0B0h,00Dh,0E9h	; ovr_1c96_8000:2003
		db	024h,001h,0B0h,00Ch,0E9h,01Fh,001h,0B0h,00Bh,0E9h,01Ah,001h,08Eh,006h	; ovr_1c96_8000:2011
		db	046h,082h,026h,08Ah,004h,0B4h,000h,089h,046h,0FEh,046h,08Bh,05Eh,0FEh	; ovr_1c96_8000:201F
		db	08Ah,087h,081h,05Bh,098h,0A9h,012h,000h,075h,005h,0B0h,078h,0E9h,0FBh	; ovr_1c96_8000:202D
		db	000h,0C7h,046h,0FCh,000h,000h,0BFh,001h,000h,0B1h,004h,0D3h,066h,0FCh	; ovr_1c96_8000:203B
		db	08Bh,05Eh,0FEh,0F6h,087h,081h,05Bh,002h,074h,008h,08Bh,046h,0FEh,005h	; ovr_1c96_8000:2049
		db	0D0h,0FFh,0EBh,00Bh,0FFh,076h,0FEh,09Ah
		dw	0Dh
		dw	seg BCC_FAR_AB51
		db	005h,0A9h; ovr_1c96_8000:2057
		db	0FFh,001h,046h,0FCh,08Bh,046h,0FCh,099h,03Bh,016h,08Eh,039h,07Ch,01Dh	; ovr_1c96_8000:2065
		db	07Fh,006h,03Bh,006h,08Ch,039h,076h,015h,0A1h,0D3h,077h,0A3h,0BEh,066h	; ovr_1c96_8000:2073
		db	0B8h,04Bh,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,0C7h,046h,0FCh,000h; ovr_1c96_8000:2081
		db	000h,08Eh,006h,046h,082h,026h,08Ah,004h,0B4h,000h,089h,046h,0FEh,08Bh	; ovr_1c96_8000:208F
		db	05Eh,0FEh,08Ah,087h,081h,05Bh,098h,0A9h,012h,000h,075h,01Ch,08Bh,0C6h	; ovr_1c96_8000:209D
		db	048h,0C4h,05Eh,006h,026h,089h,007h,083h,0FFh,002h,07Eh,00Ch,0B8h,07Ah	; ovr_1c96_8000:20AB
		db	001h,050h,09Ah
		dw	017Dh
		dw	seg BCC_DIAGNOSTIC
		db	059h,0EBh,06Ch,0EBh,06Ah,046h,047h; ovr_1c96_8000:20B9
		db	0E9h,07Ah,0FFh,046h,0C7h,046h,0FCh,000h,000h,033h,0FFh,0EBh,056h,08Bh	; ovr_1c96_8000:20C7
		db	046h,0FCh,0D1h,0E0h,0D1h,0E0h,0D1h,0E0h,003h,046h,0FEh,005h,0D0h,0FFh	; ovr_1c96_8000:20D5
		db	089h,046h,0FCh,099h,03Bh,016h,08Eh,039h,07Ch,01Dh,07Fh,006h,03Bh,006h	; ovr_1c96_8000:20E3
		db	08Ch,039h,076h,015h,0A1h,0D3h,077h,0A3h,0BEh,066h,0B8h,04Bh,000h,050h	; ovr_1c96_8000:20F1
		db	09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,0C7h,046h,0FCh,000h,000h,08Eh,006h,046h; ovr_1c96_8000:20FF
		db	082h,026h,08Ah,004h,0B4h,000h,089h,046h,0FEh,083h,07Eh,0FEh,030h,07Ch	; ovr_1c96_8000:210D
		db	013h,083h,07Eh,0FEh,037h,07Fh,00Dh,0C4h,05Eh,006h,026h,089h,037h,046h	; ovr_1c96_8000:211B
		db	047h,083h,0FFh,003h,07Ch,0A5h,08Ah,046h,0FCh,0EBh,003h,08Ah,046h,0FEh	; ovr_1c96_8000:2129
		db	05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,004h,000h,030h,000h,031h,000h,032h,000h	; ovr_1c96_8000:2137
		db	033h,000h,034h,000h,035h,000h,036h,000h,037h,000h,061h,000h,062h,000h	; ovr_1c96_8000:2145
		db	066h,000h,06Eh,000h,072h,000h,074h,000h,076h,000h,078h,000h,0CAh,020h	; ovr_1c96_8000:2153
		db	0CAh,020h,0CAh,020h,0CAh,020h,0CAh,020h,0CAh,020h,0CAh,020h,0CAh,020h	; ovr_1c96_8000:2161
		db	0FAh,01Fh,009h,020h,013h,020h,004h,020h,00Eh,020h,0FFh,01Fh,018h,020h	; ovr_1c96_8000:216F
		db	01Dh,020h; raw:217D
CO031_TEXT	ends
CO031_TEXT	segment byte public 'CODE'
		assume	cs:CO031_TEXT
X031_06	label	far
		db	055h,08Bh,0ECh,083h,0ECh,006h,056h,057h,08Bh,076h,006h,0C7h; ovr_1c96_8000:217D
		db	006h,069h,082h,000h,000h,033h,0FFh,083h,03Eh,056h,082h,000h,075h,003h	; ovr_1c96_8000:218B
		db	0E9h,041h,001h,0A1h,056h,082h,089h,046h,0FAh,0E9h,0FFh,000h,08Eh,006h	; ovr_1c96_8000:2199
		db	046h,082h,08Bh,05Eh,0FAh,026h,08Ah,007h,088h,046h,0FDh,080h,07Eh,0FDh	; ovr_1c96_8000:21A7
		db	0FCh,075h,003h,0E9h,0E6h,000h,080h,07Eh,0FDh,0FBh,075h,003h,0E9h,0DDh	; ovr_1c96_8000:21B5
		db	000h,080h,07Eh,0FDh,0FFh,075h,013h,0FFh,046h,0FAh,08Eh,006h,046h,082h	; ovr_1c96_8000:21C3
		db	08Bh,05Eh,0FAh,026h,08Ah,007h,088h,046h,0FDh,0E9h,0A3h,000h,08Eh,006h	; ovr_1c96_8000:21D1
		db	046h,082h,08Bh,05Eh,0FAh,026h,080h,03Fh,01Ah,075h,003h,0E9h,0C7h,000h	; ovr_1c96_8000:21DF
		db	08Eh,006h,046h,082h,08Bh,05Eh,0FAh,026h,080h,03Fh,05Ch,075h,04Dh,00Bh	; ovr_1c96_8000:21ED
		db	0FFh,075h,00Bh,016h,08Dh,046h,0FAh,050h,00Eh,0E8h,0B6h,0FDh,0EBh,0CEh	; ovr_1c96_8000:21FB
		db	08Bh,05Eh,0FAh,08Eh,006h,046h,082h,026h,08Ah,047h,001h,0B4h,000h,03Bh	; ovr_1c96_8000:2209
		db	0C7h,075h,066h,083h,0FEh,002h,075h,00Ah,0B0h,05Ch,050h,09Ah
		dw	02Ah
		dw	seg CO05A_TEXT
		db	0EBh,00Ch,083h,0FEh,001h,075h,007h,0B0h,05Ch,050h,0FFh,01Eh; ovr_1c96_8000:2217
		db	0E0h,087h,0FFh,046h,0FAh,08Eh,006h,046h,082h,08Bh,05Eh,0FAh,026h,08Ah	; ovr_1c96_8000:2233
		db	007h,088h,046h,0FDh,0EBh,039h,08Eh,006h,046h,082h,08Bh,05Eh,0FAh,026h	; ovr_1c96_8000:2241
		db	080h,03Fh,022h,074h,006h,026h,080h,03Fh,027h,075h,026h,00Bh,0FFh,075h	; ovr_1c96_8000:224F
		db	010h,08Eh,006h,046h,082h,08Bh,05Eh,0FAh,026h,08Ah,007h,0B4h,000h,08Bh	; ovr_1c96_8000:225D
		db	0F8h,0EBh,012h,08Eh,006h,046h,082h,08Bh,05Eh,0FAh,026h,08Ah,007h,0B4h	; ovr_1c96_8000:226B
		db	000h,03Bh,0C7h,075h,002h,033h,0FFh,0FFh,006h,069h,082h,083h,0FEh,002h	; ovr_1c96_8000:2279
		db	075h,00Bh,08Ah,046h,0FDh,050h,09Ah
		dw	02Ah
		dw	seg CO05A_TEXT
		db	0EBh,00Dh,083h; ovr_1c96_8000:2287
		db	0FEh,001h,075h,008h,08Ah,046h,0FDh,050h,0FFh,01Eh,0E0h,087h,0FFh,046h	; ovr_1c96_8000:2295
		db	0FAh,08Eh,006h,046h,082h,08Bh,05Eh,0FAh,026h,080h,03Fh,000h,074h,003h	; ovr_1c96_8000:22A3
		db	0E9h,0F1h,0FEh,0C7h,006h,056h,082h,000h,000h,0EBh,030h,0FFh,006h,069h	; ovr_1c96_8000:22B1
		db	082h,083h,0FEh,002h,075h,00Bh,08Ah,046h,0FEh,050h,09Ah
		dw	02Ah
		dw	seg CO05A_TEXT
		db	0EBh,00Dh,083h,0FEh,001h,075h,008h,08Ah,046h,0FEh,050h,0FFh,01Eh; ovr_1c96_8000:22BF
		db	0E0h,087h,0B0h,022h,050h,00Eh,0E8h,00Ch,0FAh,089h,046h,0FEh,03Dh,0FFh	; ovr_1c96_8000:22DB
		db	0FFh,075h,0D0h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h; raw:22E9
CO031_TEXT	ends
CO031_TEXT	segment byte public 'CODE'
		assume	cs:CO031_TEXT
X031_02	label	far
		db	055h,08Bh,0ECh; ovr_1c96_8000:22E9
		db	056h,057h,083h,03Eh,056h,082h,000h,075h,003h,0E9h,09Ch,000h,083h,07Eh	; ovr_1c96_8000:22F7
		db	006h,000h,075h,008h,033h,0FFh,0EBh,004h,0FFh,006h,056h,082h,08Eh,006h	; ovr_1c96_8000:2305
		db	046h,082h,08Bh,01Eh,056h,082h,026h,080h,03Fh,0FCh,074h,0EEh,026h,080h	; ovr_1c96_8000:2313
		db	03Fh,0FBh,074h,0E8h,026h,08Ah,007h,0B4h,000h,08Bh,0F0h,081h,0FEh,0FFh	; ovr_1c96_8000:2321
		db	000h,075h,011h,0FFh,006h,056h,082h,08Bh,01Eh,056h,082h,026h,08Ah,007h	; ovr_1c96_8000:232F
		db	0B4h,000h,08Bh,0F0h,0EBh,056h,083h,0FEh,05Ch,075h,025h,00Bh,0FFh,075h	; ovr_1c96_8000:233D
		db	00Bh,01Eh,0B8h,056h,082h,050h,00Eh,0E8h,068h,0FCh,0EBh,0E6h,08Bh,01Eh	; ovr_1c96_8000:234B
		db	056h,082h,08Eh,006h,046h,082h,026h,08Ah,047h,001h,0B4h,000h,03Bh,0C7h	; ovr_1c96_8000:2359
		db	075h,030h,033h,0FFh,0EBh,02Ch,083h,0FEh,01Ah,074h,004h,00Bh,0F6h,075h	; ovr_1c96_8000:2367
		db	00Bh,0C7h,006h,056h,082h,000h,000h,0B8h,0FFh,0FFh,0EBh,029h,083h,0FEh	; ovr_1c96_8000:2375
		db	022h,074h,005h,083h,0FEh,027h,075h,00Eh,00Bh,0FFh,075h,004h,08Bh,0FEh	; ovr_1c96_8000:2383
		db	0EBh,006h,03Bh,0FEh,075h,002h,033h,0FFh,0FFh,006h,056h,082h,0EBh,009h	; ovr_1c96_8000:2391
		db	0B0h,022h,050h,00Eh,0E8h,04Ah,0F9h,08Bh,0F0h,08Bh,0C6h,05Fh,05Eh,05Dh	; ovr_1c96_8000:239F
		db	0CAh,002h,000h; raw:23AD
CO031_TEXT	ends
CO031_TEXT	segment byte public 'CODE'
		assume	cs:CO031_TEXT
X031_0B	label	far
		db	055h,08Bh,0ECh,083h,0ECh,008h,056h,057h,033h,0F6h,033h; ovr_1c96_8000:23AD
		db	0F6h,08Bh,03Eh,054h,082h,0A1h,0C2h,077h,00Bh,006h,0C4h,077h,074h,049h	; ovr_1c96_8000:23BB
		db	0A1h,0C4h,077h,08Bh,016h,0C2h,077h,089h,046h,0FCh,089h,056h,0FAh,0EBh	; ovr_1c96_8000:23C9
		db	019h,0C4h,05Eh,0FAh,026h,080h,03Fh,0FCh,074h,00Dh,046h,0C4h,05Eh,0FAh	; ovr_1c96_8000:23D7
		db	026h,08Ah,007h,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0FFh,046h,0FAh,0C4h,05Eh; ovr_1c96_8000:23E5
		db	0FAh,026h,080h,03Fh,000h,075h,0DEh,0C7h,006h,0C4h,077h,000h,000h,0C7h	; ovr_1c96_8000:23F3
		db	006h,0C2h,077h,000h,000h,0EBh,019h,046h,08Ah,046h,0FEh,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	0B0h,022h,050h,00Eh,0E8h,0D7h,0F8h,089h,046h,0FEh,03Dh; ovr_1c96_8000:2401
		db	0FFh,0FFh,075h,0E7h,0B0h,03Bh,050h,09Ah
		dw	052h
		dw	seg CO030_TEXT
		db	01Eh,0B8h; ovr_1c96_8000:241D
		db	09Ch,078h,050h,01Eh,057h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	040h,050h,09Ah
		dw	02Fh
		dw	seg CO043_TEXT
		db	089h,046h,0F8h,0FFh,036h,09Ch,078h,0FFh,076h,0F8h,01Eh; ovr_1c96_8000:242B
		db	057h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	089h,03Eh,054h,082h,08Bh,046h,0F8h,05Fh; ovr_1c96_8000:2447
		db	05Eh,08Bh,0E5h,05Dh,0CBh	; ovr_1c96_8000:2455

CO031_TEXT	ends
; END C226UNIT
		end
