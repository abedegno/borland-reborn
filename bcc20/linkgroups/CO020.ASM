; Recovered FBOV far-pointer references
		extrn	BCC_DEBUG_BUILD:far
		extrn	BCC_DIAGNOSTIC:far
		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_AB51:far
		extrn	BCC_FAR_AF0C:far
		extrn	BCC_FAR_B146:far
CO002_TEXT	segment byte public 'CODE'
CO002_TEXT	ends
CO00A_TEXT	segment byte public 'CODE'
CO00A_TEXT	ends
CO019_TEXT	segment byte public 'CODE'
CO019_TEXT	ends
CO022_TEXT	segment byte public 'CODE'
CO022_TEXT	ends
CO02C_TEXT	segment byte public 'CODE'
CO02C_TEXT	ends
CO02D_TEXT	segment byte public 'CODE'
CO02D_TEXT	ends
CO02F_TEXT	segment byte public 'CODE'
CO02F_TEXT	ends
CO031_TEXT	segment byte public 'CODE'
CO031_TEXT	ends
CO03C_TEXT	segment byte public 'CODE'
CO03C_TEXT	ends
CO03D_TEXT	segment byte public 'CODE'
CO03D_TEXT	ends
CO057_TEXT	segment byte public 'CODE'
CO057_TEXT	ends
CO060_TEXT	segment byte public 'CODE'
CO060_TEXT	ends
		public	X020_00
		public	X020_01
		public	X020_02
		public	X020_03
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1c37_6ba9
; BEGIN C227UNIT (listing ovr_1c37_6ba9:BA90)
CO020_TEXT	segment byte public 'CODE'
		assume	cs:CO020_TEXT
; Original-image layout stub: not recovered source


X020_02	label	far
		db	055h,08Bh,0ECh,083h,0ECh,006h,056h,057h,08Bh,03Eh,098h,063h,0EBh,03Bh; ovr_1c37_6ba9:BA90
		db	08Eh,006h,02Ah,078h,026h,08Bh,075h,006h,0EBh,026h,0FFh,076h,006h,08Eh	; ovr_1c37_6ba9:BA9E
		db	006h,010h,064h,026h,0FFh,074h,004h,09Ah
		dw	0C5h
		dw	seg CO02C_TEXT
		db	089h,046h; ovr_1c37_6ba9:BAAC
		db	0FEh,083h,07Eh,0FEh,000h,074h,006h,08Bh,046h,0FEh,0E9h,09Bh,000h,08Eh	; ovr_1c37_6ba9:BABA
		db	006h,010h,064h,026h,08Bh,034h,00Bh,0F6h,075h,0D6h,08Eh,006h,02Ah,078h	; ovr_1c37_6ba9:BAC8
		db	026h,08Bh,03Dh,03Bh,03Eh,0C0h,063h,075h,0BFh,0C7h,046h,0FCh,000h,000h	; ovr_1c37_6ba9:BAD6
		db	0EBh,073h,08Bh,05Eh,0FCh,0D1h,0E3h,08Bh,087h,0ACh,078h,0EBh,05Ch,08Eh	; ovr_1c37_6ba9:BAE4
		db	006h,032h,078h,08Bh,05Eh,0FAh,026h,08Bh,037h,0EBh,042h,08Eh,006h,010h	; ovr_1c37_6ba9:BAF2
		db	064h,026h,08Ah,044h,007h,0B4h,000h,025h,007h,000h,03Dh,002h,000h,075h	; ovr_1c37_6ba9:BB00
		db	029h,026h,08Bh,05Ch,004h,08Eh,006h,09Ah,063h,026h,083h,03Fh,015h,074h	; ovr_1c37_6ba9:BB0E
		db	01Bh,0FFh,076h,006h,08Eh,006h,010h,064h,026h,0FFh,074h,004h,09Ah
		dw	0C5h
		dw	seg CO02C_TEXT
		db	089h,046h,0FEh,083h,07Eh,0FEh,000h,074h,002h,0EBh,089h; ovr_1c37_6ba9:BB1C
		db	08Eh,006h,010h,064h,026h,08Bh,034h,00Bh,0F6h,075h,0BAh,08Eh,006h,03Ah	; ovr_1c37_6ba9:BB38
		db	078h,08Bh,05Eh,0FAh,026h,08Bh,007h,089h,046h,0FAh,083h,07Eh,0FAh,000h	; ovr_1c37_6ba9:BB46
		db	075h,09Bh,0FFh,046h,0FCh,081h,07Eh,0FCh,000h,004h,07Ch,086h,033h,0C0h	; ovr_1c37_6ba9:BB54
		db	05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h; raw:BB62
X020_03	label	far
		db	055h,08Bh,0ECh,083h,0ECh,00Ah; ovr_1c37_6ba9:BB62
		db	056h,057h,01Eh,0B8h,09Eh,067h,050h,0B8h,031h,000h,050h,09Ah
		dw	020h
		dw	seg CO02F_TEXT
		db	089h,046h,0FAh,0FFh,076h,0FAh,09Ah
		dw	0CAh
		dw	seg CO02C_TEXT
		db	08Bh; ovr_1c37_6ba9:BB70
		db	0F8h,00Bh,0FFh,075h,003h,0E9h,0C0h,002h,08Eh,006h,010h,064h,026h,080h	; ovr_1c37_6ba9:BB8C
		db	04Dh,006h,004h,026h,08Bh,05Dh,004h,08Eh,006h,09Ah,063h,026h,083h,03Fh	; ovr_1c37_6ba9:BB9A
		db	012h,074h,009h,08Eh,006h,010h,064h,026h,080h,04Dh,006h,002h,0C6h,006h	; ovr_1c37_6ba9:BBA8
		db	09Eh,067h,000h,0BEh,09Eh,067h,0A0h,014h,017h,098h,00Bh,0C0h,074h,003h	; ovr_1c37_6ba9:BBB6
		db	0E9h,0E8h,000h,08Eh,006h,010h,064h,026h,08Ah,045h,007h,0B4h,000h,0D1h	; ovr_1c37_6ba9:BBC4
		db	0F8h,0D1h,0F8h,0D1h,0F8h,048h,08Bh,0D8h,083h,0FBh,008h,076h,003h,0E9h	; ovr_1c37_6ba9:BBD2
		db	072h,002h,0D1h,0E3h,02Eh,0FFh,0A7h,0DCh,003h,0C6h,004h,040h,0C6h,044h	; ovr_1c37_6ba9:BBE0
		db	001h,053h,057h,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	0B1h,00Ch,0D3h,0E8h,024h,00Fh; ovr_1c37_6ba9:BBEE
		db	004h,061h,088h,044h,002h,057h,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	0B1h,008h,0D3h; ovr_1c37_6ba9:BBFC
		db	0E8h,024h,00Fh,004h,061h,088h,044h,003h,057h,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	0B1h,004h,0D3h,0E8h,024h,00Fh,004h,061h,088h,044h,004h,057h,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	024h,00Fh,004h,061h,088h,044h,005h,08Eh,006h,010h,064h; ovr_1c37_6ba9:BC18
		db	026h,0FFh,075h,004h,09Ah
		dw	02Fh
		dw	seg CO00A_TEXT
		db	004h,061h,088h,044h,006h; ovr_1c37_6ba9:BC34
		db	0C6h,044h,007h,000h,0E9h,00Bh,002h,057h,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	050h; ovr_1c37_6ba9:BC42
		db	0B0h,000h,050h,057h,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	050h,09Ah
		dw	089h
		dw	seg CO02C_TEXT
		db	050h,09Ah
		dw	02Ah
		dw	seg CO060_TEXT
		db	089h,046h,0F8h,08Bh,05Eh,0F8h,08Eh; ovr_1c37_6ba9:BC50
		db	006h,06Eh,086h,026h,0FFh,047h,011h,026h,080h,04Fh,00Eh,004h,0C6h,004h	; ovr_1c37_6ba9:BC6C
		db	040h,0C6h,044h,001h,056h,0B1h,00Ch,0D3h,0E8h,024h,00Fh,004h,061h,088h	; ovr_1c37_6ba9:BC7A
		db	044h,002h,08Bh,046h,0F8h,0B1h,008h,0D3h,0E8h,024h,00Fh,004h,061h,088h	; ovr_1c37_6ba9:BC88
		db	044h,003h,08Bh,046h,0F8h,0B1h,004h,0D3h,0E8h,024h,00Fh,004h,061h,088h	; ovr_1c37_6ba9:BC96
		db	044h,004h,08Bh,046h,0F8h,0E9h,07Dh,0FFh,0E9h,087h,001h,08Eh,006h,010h	; ovr_1c37_6ba9:BCA4
		db	064h,026h,08Ah,045h,007h,0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,048h	; ovr_1c37_6ba9:BCB2
		db	08Bh,0D8h,083h,0FBh,008h,076h,003h,0E9h,080h,001h,0D1h,0E3h,02Eh,0FFh	; ovr_1c37_6ba9:BCC0
		db	0A7h,0CAh,003h,08Eh,006h,010h,064h,026h,08Bh,05Dh,004h,08Eh,006h,09Ah	; ovr_1c37_6ba9:BCCE
		db	063h,026h,083h,03Fh,012h,074h,028h,083h,03Eh,006h,083h,000h,074h,021h	; ovr_1c37_6ba9:BCDC
		db	01Eh,0B8h,09Eh,067h,050h,0FFh,036h,046h,078h,0FFh,036h,006h,083h,09Ah	; ovr_1c37_6ba9:BCEA
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	01Eh,0B8h,09Eh,067h,050h,01Eh,0B8h,0A2h,010h,050h; ovr_1c37_6ba9:BCF8
		db	09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	01Eh,0B8h,09Eh,067h,050h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	005h,09Eh,067h,08Bh,0F0h,08Eh,006h,010h,064h,026h,08Bh,05Dh,002h; ovr_1c37_6ba9:BD06
		db	08Eh,006h,032h,078h,026h,08Bh,05Fh,004h,08Bh,007h,08Eh,006h,010h,064h	; ovr_1c37_6ba9:BD22
		db	026h,08Bh,05Dh,002h,08Eh,006h,032h,078h,026h,08Bh,057h,002h,089h,046h	; ovr_1c37_6ba9:BD30
		db	0FEh,089h,056h,0FCh,08Eh,006h,010h,064h,026h,0F6h,045h,006h,040h,074h	; ovr_1c37_6ba9:BD3E
		db	025h,0EBh,013h,0C4h,05Eh,0FCh,0FFh,046h,0FCh,026h,08Ah,007h,098h,050h	; ovr_1c37_6ba9:BD4C
		db	09Ah
		dw	031h
		dw	seg BCC_FAR_AB51
		db	088h,004h,046h,0C4h,05Eh,0FCh,026h,080h,03Fh; ovr_1c37_6ba9:BD5A
		db	000h,075h,0E4h,0C6h,004h,000h,046h,0E9h,0E2h,000h,080h,03Eh,016h,017h	; ovr_1c37_6ba9:BD68
		db	000h,074h,004h,0C6h,004h,05Fh,046h,01Eh,056h,0FFh,076h,0FEh,0FFh,076h	; ovr_1c37_6ba9:BD76
		db	0FCh,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0E9h,0C7h,000h,08Eh,006h,010h,064h,026h; ovr_1c37_6ba9:BD84
		db	08Bh,05Dh,004h,08Eh,006h,09Ah,063h,026h,083h,03Fh,012h,074h,02Bh,083h	; ovr_1c37_6ba9:BD92
		db	03Eh,006h,083h,000h,074h,024h,01Eh,056h,0FFh,036h,046h,078h,0FFh,036h	; ovr_1c37_6ba9:BDA0
		db	006h,083h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	01Eh,056h,01Eh,0B8h,0A2h,010h,050h; ovr_1c37_6ba9:BDAE
		db	09Ah
		dw	06h
		dw	seg BCC_FAR_B146
		db	01Eh,056h,09Ah
		dw	02h
		dw	seg BCC_FAR_AB12
		db	003h,0F0h; ovr_1c37_6ba9:BDBC
		db	057h,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	050h,0B0h,000h,050h,057h,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	050h,09Ah
		dw	089h
		dw	seg CO02C_TEXT
		db	050h,09Ah
		dw	02Ah
		dw	seg CO060_TEXT
		db	089h,046h,0F8h,08Bh,05Eh,0F8h,08Eh,006h,06Eh,086h,026h,0FFh,047h,011h	; ovr_1c37_6ba9:BDE6
		db	026h,080h,04Fh,00Eh,004h,089h,046h,0F6h,0C6h,004h,01Ah,0B1h,00Ch,0D3h	; ovr_1c37_6ba9:BDF4
		db	0E8h,024h,00Fh,004h,061h,088h,044h,001h,08Bh,046h,0F6h,0B1h,008h,0D3h	; ovr_1c37_6ba9:BE02
		db	0E8h,024h,00Fh,004h,061h,088h,044h,002h,08Bh,046h,0F6h,0B1h,004h,0D3h	; ovr_1c37_6ba9:BE10
		db	0E8h,024h,00Fh,004h,061h,088h,044h,003h,08Ah,046h,0F6h,024h,00Fh,004h	; ovr_1c37_6ba9:BE1E
		db	061h,088h,044h,004h,0C6h,044h,005h,000h,0EBh,01Eh,08Eh,006h,010h,064h	; ovr_1c37_6ba9:BE2C
		db	026h,0FFh,075h,008h,01Eh,0B8h,09Eh,067h,050h,09Ah
		dw	0CCh
		dw	seg BCC_FAR_AF0C
		db	0EBh,00Ah,0B8h,010h,000h,050h,09Ah
		dw	011Bh
		dw	seg BCC_DIAGNOSTIC
		db	059h,05Fh,05Eh; ovr_1c37_6ba9:BE48
		db	08Bh,0E5h,05Dh,0CBh,041h,002h,07Bh,002h,0FDh,002h,03Ah,003h,03Ah,003h	; ovr_1c37_6ba9:BE56
		db	03Ah,003h,0BAh,003h,0BAh,003h,0A6h,003h,059h,001h,059h,001h,059h,001h	; ovr_1c37_6ba9:BE64
		db	059h,001h,0B9h,001h,0B9h,001h,0C4h,003h,0C4h,003h,01Ch,002h; raw:BE72
X020_00	label	far
		db	055h,08Bh; ovr_1c37_6ba9:BE72
		db	0ECh,083h,0ECh,006h,056h,057h,09Ah
		dw	025h
		dw	seg CO03C_TEXT
		db	089h,046h,0FCh; ovr_1c37_6ba9:BE80
		db	083h,07Eh,0FCh,001h,074h,003h,0E9h,083h,000h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	01Eh,0B8h,082h,063h,050h,09Ah
		dw	025h
		dw	seg CO03D_TEXT
		db	0B4h,000h,00Bh,0C0h; ovr_1c37_6ba9:BE9C
		db	075h,00Fh,0B8h,02Bh,000h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0B8h,002h,000h; ovr_1c37_6ba9:BEAA
		db	0E9h,0F3h,000h,0B8h,003h,000h,050h,09Ah
		dw	039h
		dw	seg CO022_TEXT
		db	08Bh,0F0h; ovr_1c37_6ba9:BEB8
		db	09Ah
		dw	066h
		dw	seg CO031_TEXT
		db	00Bh,0F6h,075h,003h,0E9h,0D5h,000h,08Eh,006h; ovr_1c37_6ba9:BEC6
		db	09Ah,063h,026h,083h,03Ch,013h,074h,00Bh,0B8h,014h,000h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	033h,0F6h,083h,03Eh,060h,082h,031h,074h,005h,0B8h,018h; ovr_1c37_6ba9:BED4
		db	000h,0EBh,0BCh,01Eh,0B8h,09Eh,067h,050h,08Bh,01Eh,069h,082h,08Eh,006h	; ovr_1c37_6ba9:BEF0
		db	032h,078h,026h,08Bh,05Fh,004h,0FFh,037h,08Bh,01Eh,069h,082h,026h,0FFh	; ovr_1c37_6ba9:BEFE
		db	077h,002h,09Ah
		dw	02h
		dw	seg BCC_DEBUG_BUILD
		db	0C7h,046h,0FCh,031h,000h,0EBh,002h; ovr_1c37_6ba9:BF0C
		db	033h,0F6h,08Bh,046h,0FCh,089h,046h,0FAh,0B9h,00Eh,000h,0BBh,024h,005h	; ovr_1c37_6ba9:BF1A
		db	02Eh,08Bh,007h,03Bh,046h,0FAh,074h,006h,043h,043h,0E2h,0F4h,0EBh,05Bh	; ovr_1c37_6ba9:BF28
		db	02Eh,0FFh,067h,01Ch,01Eh,0B8h,09Eh,067h,050h,0B8h,031h,000h,050h,09Ah	; ovr_1c37_6ba9:BF36
		dw	020h
		dw	seg CO02F_TEXT
		db	089h,046h,0FEh,00Bh,0F6h,075h,009h,0FFh,076h,0FEh; ovr_1c37_6ba9:BF44
		db	00Eh,0E8h,03Ah,0FBh,0EBh,009h,0FFh,076h,0FEh,056h,09Ah
		dw	0C5h
		dw	seg CO02C_TEXT
		db	08Bh,0F8h,00Bh,0FFh,074h,020h,08Eh,006h,0A4h,078h,026h,0F6h,045h; ovr_1c37_6ba9:BF52
		db	004h,003h,075h,015h,0C6h,006h,09Eh,067h,02Bh,026h,0FFh,075h,006h,01Eh	; ovr_1c37_6ba9:BF6E
		db	0B8h,09Fh,067h,050h,09Ah
		dw	0CCh
		dw	seg BCC_FAR_AF0C
		db	0EBh,024h,0B0h,02Eh,050h; ovr_1c37_6ba9:BF7C
		db	09Ah
		dw	034h
		dw	seg CO03C_TEXT
		db	0EBh,01Ah,0B0h,02Eh,050h,09Ah
		dw	034h
		dw	seg CO03C_TEXT
		db	083h,07Eh,0FCh,07Ch,075h,002h,0EBh,006h,083h,07Eh,0FCh,007h,075h; ovr_1c37_6ba9:BF8A
		db	004h,033h,0C0h,0EBh,003h,0B8h,001h,000h,05Fh,05Eh,08Bh,0E5h,05Dh,0CBh	; ovr_1c37_6ba9:BFA6
		db	031h,000h,074h,000h,076h,000h,077h,000h,078h,000h,079h,000h,07Ah,000h	; ovr_1c37_6ba9:BFB4
		db	07Bh,000h,07Ch,000h,07Dh,000h,07Eh,000h,07Fh,000h,080h,000h,081h,000h	; ovr_1c37_6ba9:BFC2
		db	0AAh,004h,0AAh,004h,0AAh,004h,0AAh,004h,0AAh,004h,0AAh,004h,0AAh,004h	; ovr_1c37_6ba9:BFD0
		db	0AAh,004h,0AAh,004h,0AAh,004h,0AAh,004h,0AAh,004h,0AAh,004h,0AAh,004h	; ovr_1c37_6ba9:BFDE
X020_01	label	far
		db	055h,08Bh,0ECh,04Ch,04Ch,056h,057h,0B0h,040h,050h,09Ah
		dw	034h
		dw	seg CO03C_TEXT
		db	01Eh,0B8h,09Eh,067h,050h,0B8h,031h,000h,050h,09Ah
		dw	020h
		dw	seg CO02F_TEXT
		db	089h,046h,0FEh,08Eh,006h,0B2h,063h,026h,0A3h,002h,000h,08Bh,036h; ovr_1c37_6ba9:BFEC
		db	008h,05Fh,0EBh,007h,08Eh,006h,0B2h,063h,026h,08Bh,034h,08Eh,006h,0B2h	; ovr_1c37_6ba9:C016
		db	063h,026h,08Bh,044h,002h,03Bh,046h,0FEh,075h,0ECh,00Bh,0F6h,075h,031h	; ovr_1c37_6ba9:C024
		db	09Ah
		dw	025h
		dw	seg CO02C_TEXT
		db	08Bh,0F0h,08Eh,006h,0B2h,063h,08Bh,046h,0FEh; ovr_1c37_6ba9:C032
		db	026h,089h,044h,002h,09Ah
		dw	057h
		dw	seg CO002_TEXT
		db	08Eh,006h,0B2h,063h,026h; ovr_1c37_6ba9:C040
		db	089h,044h,004h,026h,0C7h,044h,00Bh,000h,000h,026h,0C7h,044h,006h,000h	; ovr_1c37_6ba9:C04E
		db	000h,026h,0C7h,044h,008h,0FFh,07Fh,080h,03Eh,0AEh,063h,000h,074h,03Eh	; ovr_1c37_6ba9:C05C
		db	08Eh,006h,0B2h,063h,026h,0FFh,074h,004h,0FFh,036h,063h,082h,0FFh,036h	; ovr_1c37_6ba9:C06A
		db	065h,082h,0FFh,036h,063h,082h,0FFh,036h,065h,082h,09Ah
		dw	034h
		dw	seg CO057_TEXT
		db	08Bh,0F8h,08Eh,006h,054h,086h,08Bh,046h,006h,026h,089h,045h,008h; ovr_1c37_6ba9:C078
		db	026h,081h,04Dh,01Ch,000h,001h,0FFh,036h,00Eh,05Fh,057h,0FFh,036h,0E6h	; ovr_1c37_6ba9:C094
		db	05Eh,09Ah
		dw	043h
		dw	seg CO057_TEXT
		db	05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h; ovr_1c37_6ba9:C0A2

CO020_TEXT	ends
; END C227UNIT
		end
