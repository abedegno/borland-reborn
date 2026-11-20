; Recovered FBOV far-pointer references
		extrn	BCC_COPY_WORDS:far
		extrn	BCC_FAR_245C:far
CO000_TEXT	segment byte public 'CODE'
CO000_TEXT	ends
CO00A_TEXT	segment byte public 'CODE'
CO00A_TEXT	ends
CO00F_TEXT	segment byte public 'CODE'
CO00F_TEXT	ends
CO010_TEXT	segment byte public 'CODE'
CO010_TEXT	ends
CO013_TEXT	segment byte public 'CODE'
CO013_TEXT	ends
CO019_TEXT	segment byte public 'CODE'
CO019_TEXT	ends
CO01E_TEXT	segment byte public 'CODE'
CO01E_TEXT	ends
CO023_TEXT	segment byte public 'CODE'
CO023_TEXT	ends
CO02C_TEXT	segment byte public 'CODE'
CO02C_TEXT	ends
CO02D_TEXT	segment byte public 'CODE'
CO02D_TEXT	ends
CO03D_TEXT	segment byte public 'CODE'
CO03D_TEXT	ends
CO043_TEXT	segment byte public 'CODE'
CO043_TEXT	ends
		public	X022_01
		public	X022_00
		public	X022_03
		public	X022_02
		public	X022_05
		public	X022_04
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1c41_6ccd
; BEGIN C232UNIT (listing ovr_1c41_6ccd:CCD0)
CO022_TEXT	segment byte public 'CODE'
		assume	cs:CO022_TEXT
; Original-image layout stub: not recovered source


		db	045h,055h,08Bh,0ECh,0C7h,006h,0D4h,066h,000h,000h,01Eh,0B8h,0CAh,066h	; ovr_1c41_6ccd:CCD0
		db	050h,0B8h,000h,001h,050h,09Ah
		dw	025h
		dw	seg CO043_TEXT
		db	0A3h,0C8h,066h,033h; ovr_1c41_6ccd:CCDE
		db	0C0h,050h,050h,09Ah
		dw	0CFh
		dw	seg CO023_TEXT
		db	0A3h,0C6h,066h,0FFh,036h,0C6h; ovr_1c41_6ccd:CCEC
		db	066h,033h,0C0h,050h,09Ah
		dw	0B6h
		dw	seg CO023_TEXT
		db	0A3h,0C6h,066h,0A3h,0D2h; ovr_1c41_6ccd:CCFA
		db	066h,05Dh,04Dh,0C3h,045h,055h,08Bh,0ECh,04Ch,04Ch,083h,03Eh,0D4h,066h	; ovr_1c41_6ccd:CD08
		db	000h,075h,00Eh,0A1h,0D2h,066h,03Bh,006h,0C6h,066h,075h,005h,0B8h,001h	; ovr_1c41_6ccd:CD16
		db	000h,0EBh,002h,033h,0C0h,088h,046h,0FFh,0C7h,006h,0D4h,066h,000h,000h	; ovr_1c41_6ccd:CD24
		db	01Eh,0B8h,0CAh,066h,050h,0FFh,036h,0C8h,066h,09Ah
		dw	034h
		dw	seg CO043_TEXT
		db	08Ah,046h,0FFh,08Bh,0E5h,05Dh,04Dh,0C3h,045h,055h,08Bh,0ECh,056h,057h	; ovr_1c41_6ccd:CD40
		db	08Bh,036h,0D2h,066h,03Bh,036h,0C6h,066h,075h,015h,0B8h,0E4h,000h,050h	; ovr_1c41_6ccd:CD4E
		db	033h,0C0h,050h,09Ah
		dw	0CFh
		dw	seg CO023_TEXT
		db	08Bh,0F8h,0C6h,006h,078h,064h; ovr_1c41_6ccd:CD5C
		db	001h,0EBh,015h,08Eh,006h,086h,081h,026h,08Bh,07Ch,00Ch,026h,08Bh,044h	; ovr_1c41_6ccd:CD6A
		db	00Ah,0A3h,0D2h,066h,056h,09Ah
		dw	06Bh
		dw	seg CO023_TEXT
		db	08Bh,0C7h,05Fh,05Eh; ovr_1c41_6ccd:CD78
		db	05Dh,04Dh,0C3h,045h,055h,08Bh,0ECh,081h,03Eh,0D4h,066h,080h,000h,07Ch	; ovr_1c41_6ccd:CD86
		db	010h,0B8h,0B4h,000h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0C6h,006h,078h,064h; ovr_1c41_6ccd:CD94
		db	001h,0EBh,019h,0A1h,0D4h,066h,0D1h,0E0h,08Bh,01Eh,0C8h,066h,003h,0D8h	; ovr_1c41_6ccd:CDA2
		db	08Eh,006h,0CAh,066h,08Bh,046h,004h,026h,089h,007h,0FFh,006h,0D4h,066h	; ovr_1c41_6ccd:CDB0
		db	05Dh,04Dh,0C2h,002h,000h,045h,055h,08Bh,0ECh,083h,03Eh,0D4h,066h,000h	; ovr_1c41_6ccd:CDBE
		db	07Fh,013h,0B8h,02Bh,000h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0C6h,006h,078h; ovr_1c41_6ccd:CDCC
		db	064h,001h,0B8h,082h,000h,0EBh,016h,0FFh,00Eh,0D4h,066h,0A1h,0D4h,066h	; ovr_1c41_6ccd:CDDA
		db	0D1h,0E0h,08Bh,01Eh,0C8h,066h,003h,0D8h,08Eh,006h,0CAh,066h,026h,08Bh	; ovr_1c41_6ccd:CDE8
		db	007h,05Dh,04Dh,0C3h,045h,055h,08Bh,0ECh,083h,0ECh,008h,056h,057h,0E8h	; ovr_1c41_6ccd:CDF6
		db	0BDh,0FFh,089h,046h,0FEh,033h,0F6h,08Bh,05Eh,0FEh,04Bh,081h,0FBh,081h	; ovr_1c41_6ccd:CE04
		db	000h,076h,003h,0E9h,0FBh,003h,0D1h,0E3h,02Eh,0FFh,0A7h,069h,005h,083h	; ovr_1c41_6ccd:CE12
		db	03Eh,0D4h,066h,000h,07Fh,005h,0B8h,082h,000h,0EBh,013h,0A1h,0D4h,066h	; ovr_1c41_6ccd:CE20
		db	048h,0D1h,0E0h,08Bh,01Eh,0C8h,066h,003h,0D8h,08Eh,006h,0CAh,066h,026h	; ovr_1c41_6ccd:CE2E
		db	08Bh,007h,03Dh,001h,000h,075h,005h,0E8h,07Dh,0FFh,0EBh,00Eh,0B8h,099h	; ovr_1c41_6ccd:CE3C
		db	000h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0C6h,006h,078h,064h,001h,0E8h,0EFh; ovr_1c41_6ccd:CE4A
		db	0FEh,08Bh,0F0h,08Eh,006h,086h,081h,026h,080h,04Ch,006h,008h,0E9h,0BAh	; ovr_1c41_6ccd:CE58
		db	003h,0E8h,059h,0FFh,089h,046h,0FCh,083h,07Eh,0FCh,003h,074h,00Fh,083h	; ovr_1c41_6ccd:CE66
		db	07Eh,0FCh,060h,074h,009h,0FFh,076h,0FCh,0E8h,00Ah,0FFh,0E9h,091h,003h	; ovr_1c41_6ccd:CE74
		db	0B8h,003h,000h,050h,033h,0C0h,050h,050h,09Ah
		dw	0BBh
		dw	seg CO023_TEXT
		db	08Bh; ovr_1c41_6ccd:CE82
		db	0F0h,083h,07Eh,0FCh,060h,075h,013h,08Eh,006h,086h,081h,026h,0C7h,004h	; ovr_1c41_6ccd:CE90
		db	043h,000h,0E8h,0A5h,0FEh,08Eh,006h,086h,081h,0E9h,085h,000h,0E8h,09Bh	; ovr_1c41_6ccd:CE9E
		db	0FEh,08Eh,006h,086h,081h,026h,089h,044h,00Ch,0E8h,090h,0FEh,08Eh,006h	; ovr_1c41_6ccd:CEAC
		db	086h,081h,026h,089h,044h,00Ah,0E9h,05Eh,003h,0E8h,082h,0FEh,08Bh,0F0h	; ovr_1c41_6ccd:CEBA
		db	08Bh,01Eh,0D2h,066h,08Eh,006h,086h,081h,026h,08Bh,05Fh,00Ch,026h,083h	; ovr_1c41_6ccd:CEC8
		db	03Fh,043h,075h,011h,08Bh,0FEh,0E8h,069h,0FEh,08Bh,0F0h,08Eh,006h,086h	; ovr_1c41_6ccd:CED6
		db	081h,026h,089h,07Ch,00Ch,0EBh,01Dh,0B8h,069h,000h,050h,0FFh,036h,0C8h	; ovr_1c41_6ccd:CEE4
		db	05Eh,033h,0C0h,0BAh,001h,000h,050h,052h,09Ah
		dw	0C5h
		dw	seg CO023_TEXT
		db	050h; ovr_1c41_6ccd:CEF2
		db	056h,09Ah
		dw	0BBh
		dw	seg CO023_TEXT
		db	08Bh,0F0h,083h,07Eh,0FEh,063h,074h,003h; ovr_1c41_6ccd:CF00
		db	0E9h,010h,003h,08Eh,006h,086h,081h,026h,080h,064h,006h,0DFh,0E9h,004h	; ovr_1c41_6ccd:CF0E
		db	003h,0E8h,028h,0FEh,089h,046h,0FAh,0E8h,022h,0FEh,08Bh,0F0h,08Eh,006h	; ovr_1c41_6ccd:CF1C
		db	086h,081h,08Bh,046h,0FAh,026h,089h,044h,00Ah,0E9h,0EBh,002h,083h,03Eh	; ovr_1c41_6ccd:CF2A
		db	0D4h,066h,000h,07Fh,005h,0B8h,082h,000h,0EBh,013h,0A1h,0D4h,066h,048h	; ovr_1c41_6ccd:CF38
		db	0D1h,0E0h,08Bh,01Eh,0C8h,066h,003h,0D8h,08Eh,006h,0CAh,066h,026h,08Bh	; ovr_1c41_6ccd:CF46
		db	007h,03Dh,020h,000h,074h,006h,0B8h,074h,000h,0E9h,0B6h,002h,0E8h,060h	; ovr_1c41_6ccd:CF54
		db	0FEh,0E8h,0E2h,0FDh,08Bh,0F8h,0E8h,0DDh,0FDh,089h,046h,0F8h,0E8h,0D7h	; ovr_1c41_6ccd:CF62
		db	0FDh,089h,046h,0FAh,0B8h,020h,000h,050h,0FFh,076h,0FAh,0FFh,076h,0F8h	; ovr_1c41_6ccd:CF70
		db	057h,09Ah
		dw	039h
		dw	seg CO023_TEXT
		db	08Bh,0F0h,0E9h,098h,002h,0FFh,076h,0FEh; ovr_1c41_6ccd:CF7E
		db	0E8h,0B9h,0FDh,050h,09Ah
		dw	02Fh
		dw	seg CO023_TEXT
		db	0E9h,055h,002h,0B8h,02Dh; ovr_1c41_6ccd:CF8C
		db	000h,0EBh,003h,0B8h,02Eh,000h,050h,0E8h,0A4h,0FDh,050h,09Ah
		dw	02Fh
		dw	seg CO023_TEXT
		db	08Bh,0F0h,08Eh,006h,086h,081h,026h,080h,04Ch,006h,002h,0E9h; ovr_1c41_6ccd:CF9A
		db	069h,002h,0B8h,016h,000h,0EBh,00Dh,0B8h,01Bh,000h,0EBh,008h,0B8h,018h	; ovr_1c41_6ccd:CFB6
		db	000h,0EBh,003h,0B8h,017h,000h,050h,0EBh,0BFh,0C7h,046h,0FEh,001h,000h	; ovr_1c41_6ccd:CFC4
		db	0E8h,073h,0FDh,08Bh,0F8h,0E8h,06Eh,0FDh,089h,046h,0F8h,0E9h,001h,002h	; ovr_1c41_6ccd:CFD2
		db	0E8h,065h,0FDh,08Bh,0F8h,0E8h,060h,0FDh,089h,046h,0F8h,08Eh,006h,086h	; ovr_1c41_6ccd:CFE0
		db	081h,026h,083h,03Dh,00Dh,074h,006h,026h,083h,03Dh,00Eh,075h,00Fh,08Eh	; ovr_1c41_6ccd:CFEE
		db	006h,086h,081h,026h,08Ah,045h,006h,0B4h,000h,0A9h,008h,000h,074h,025h	; ovr_1c41_6ccd:CFFC
		db	08Eh,006h,086h,081h,08Bh,05Eh,0F8h,026h,083h,03Fh,00Dh,074h,006h,026h	; ovr_1c41_6ccd:D00A
		db	083h,03Fh,00Eh,075h,01Bh,08Bh,05Eh,0F8h,08Eh,006h,086h,081h,026h,08Ah	; ovr_1c41_6ccd:D018
		db	047h,006h,0B4h,000h,0A9h,008h,000h,075h,009h,0B8h,061h,001h,050h,09Ah	; ovr_1c41_6ccd:D026
		dw	039h
		dw	seg CO019_TEXT
		db	0E9h,0A6h,001h,0E8h,00Ah,0FDh,08Bh,0F8h,0E8h,005h; ovr_1c41_6ccd:D034
		db	0FDh,089h,046h,0F8h,08Eh,006h,086h,081h,026h,083h,03Dh,008h,074h,044h	; ovr_1c41_6ccd:D042
		db	026h,083h,03Dh,009h,074h,03Eh,083h,07Eh,0FEh,032h,074h,047h,026h,08Bh	; ovr_1c41_6ccd:D050
		db	01Dh,08Ah,087h,0D5h,00Bh,0B4h,000h,03Bh,046h,0FEh,074h,039h,026h,08Bh	; ovr_1c41_6ccd:D05E
		db	01Dh,08Ah,087h,0D5h,00Bh,0B4h,000h,08Bh,0D8h,08Ah,087h,016h,012h,03Ah	; ovr_1c41_6ccd:D06C
		db	006h,034h,012h,072h,024h,026h,08Bh,01Dh,08Ah,087h,0D5h,00Bh,0B4h,000h	; ovr_1c41_6ccd:D07A
		db	08Bh,0D8h,08Ah,087h,016h,012h,03Ah,006h,032h,012h,077h,00Fh,08Eh,006h	; ovr_1c41_6ccd:D088
		db	086h,081h,026h,08Ah,045h,006h,0B4h,000h,0A9h,008h,000h,074h,069h,08Eh	; ovr_1c41_6ccd:D096
		db	006h,086h,081h,08Bh,05Eh,0F8h,026h,083h,03Fh,008h,074h,04Ah,026h,083h	; ovr_1c41_6ccd:D0A4
		db	03Fh,009h,074h,044h,083h,07Eh,0FEh,032h,074h,05Ch,026h,08Bh,01Fh,08Ah	; ovr_1c41_6ccd:D0B2
		db	087h,0D5h,00Bh,0B4h,000h,03Bh,046h,0FEh,074h,04Eh,08Bh,05Eh,0F8h,026h	; ovr_1c41_6ccd:D0C0
		db	08Bh,01Fh,08Ah,087h,0D5h,00Bh,0B4h,000h,08Bh,0D8h,08Ah,087h,016h,012h	; ovr_1c41_6ccd:D0CE
		db	03Ah,006h,034h,012h,072h,036h,08Bh,05Eh,0F8h,026h,08Bh,01Fh,08Ah,087h	; ovr_1c41_6ccd:D0DC
		db	0D5h,00Bh,0B4h,000h,08Bh,0D8h,08Ah,087h,016h,012h,03Ah,006h,032h,012h	; ovr_1c41_6ccd:D0EA
		db	077h,01Eh,08Bh,05Eh,0F8h,08Eh,006h,086h,081h,026h,08Ah,047h,006h,0B4h	; ovr_1c41_6ccd:D0F8
		db	000h,0A9h,008h,000h,075h,00Ch,0B8h,061h,001h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0E9h,0C9h,000h,0E9h,0C6h,000h,0E8h,02Ah,0FCh,08Bh,0F8h,0E8h,025h; ovr_1c41_6ccd:D106
		db	0FCh,089h,046h,0F8h,083h,07Eh,0FEh,032h,074h,04Dh,08Eh,006h,086h,081h	; ovr_1c41_6ccd:D122
		db	026h,08Bh,01Dh,08Ah,087h,0D5h,00Bh,0B4h,000h,03Bh,046h,0FEh,074h,03Bh	; ovr_1c41_6ccd:D130
		db	026h,08Bh,01Dh,08Ah,087h,0D5h,00Bh,0B4h,000h,08Bh,0D8h,08Ah,087h,016h	; ovr_1c41_6ccd:D13E
		db	012h,03Ah,006h,034h,012h,072h,026h,026h,08Bh,01Dh,08Ah,087h,0D5h,00Bh	; ovr_1c41_6ccd:D14C
		db	0B4h,000h,08Bh,0D8h,08Ah,087h,016h,012h,03Ah,006h,032h,012h,077h,011h	; ovr_1c41_6ccd:D15A
		db	026h,08Ah,045h,006h,0B4h,000h,0A9h,008h,000h,075h,006h,026h,083h,03Dh	; ovr_1c41_6ccd:D168
		db	032h,075h,05Fh,08Eh,006h,086h,081h,08Bh,05Eh,0F8h,026h,083h,03Fh,032h	; ovr_1c41_6ccd:D176
		db	074h,05Bh,083h,07Eh,0FEh,032h,074h,055h,026h,08Bh,01Fh,08Ah,087h,0D5h	; ovr_1c41_6ccd:D184
		db	00Bh,0B4h,000h,03Bh,046h,0FEh,074h,047h,08Bh,05Eh,0F8h,026h,08Bh,01Fh	; ovr_1c41_6ccd:D192
		db	08Ah,087h,0D5h,00Bh,0B4h,000h,08Bh,0D8h,08Ah,087h,016h,012h,03Ah,006h	; ovr_1c41_6ccd:D1A0
		db	034h,012h,072h,02Fh,08Bh,05Eh,0F8h,026h,08Bh,01Fh,08Ah,087h,0D5h,00Bh	; ovr_1c41_6ccd:D1AE
		db	0B4h,000h,08Bh,0D8h,08Ah,087h,016h,012h,03Ah,006h,032h,012h,077h,017h	; ovr_1c41_6ccd:D1BC
		db	08Bh,05Eh,0F8h,026h,08Ah,047h,006h,0B4h,000h,0A9h,008h,000h,075h,009h	; ovr_1c41_6ccd:D1CA
		db	0B8h,061h,001h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0FFh,076h,0FEh,0FFh,076h; ovr_1c41_6ccd:D1D8
		db	0F8h,057h,09Ah
		dw	0BBh
		dw	seg CO023_TEXT
		db	08Bh,0F0h,0EBh,030h,0B8h,0DDh,000h; ovr_1c41_6ccd:D1E6
		db	0EBh,020h,0B8h,0E5h,000h,050h,01Eh,0B8h,09Fh,013h,050h,033h,0C0h,033h	; ovr_1c41_6ccd:D1F4
		db	0D2h,050h,052h,09Ah
		dw	03Eh
		dw	seg CO019_TEXT
		db	0EBh,010h,0B8h,0C9h,000h,0EBh; ovr_1c41_6ccd:D202
		db	005h,0EBh,009h,0B8h,02Bh,000h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0C6h,006h; ovr_1c41_6ccd:D210
		db	078h,064h,001h,00Bh,0F6h,074h,00Dh,056h,0FFh,036h,0D2h,066h,09Ah
		dw	0B6h
		dw	seg CO023_TEXT
		db	0A3h,0D2h,066h,05Fh,05Eh,08Bh,0E5h,05Dh,04Dh,0C3h,021h; ovr_1c41_6ccd:D21E
		db	005h,04Fh,001h,026h,005h,097h,001h,043h,005h,043h,005h,043h,005h,002h	; ovr_1c41_6ccd:D23A
		db	003h,043h,005h,043h,005h,002h,003h,002h,003h,002h,003h,002h,003h,002h	; ovr_1c41_6ccd:D248
		db	003h,002h,003h,002h,003h,002h,003h,002h,003h,002h,003h,002h,003h,010h	; ovr_1c41_6ccd:D256
		db	003h,010h,003h,002h,003h,002h,003h,002h,003h,04Bh,004h,04Bh,004h,04Bh	; ovr_1c41_6ccd:D264
		db	004h,06Bh,003h,06Bh,003h,03Ch,005h,066h,002h,002h,003h,002h,003h,04Bh	; ovr_1c41_6ccd:D272
		db	004h,04Bh,004h,04Bh,004h,04Bh,004h,04Bh,004h,04Bh,004h,0B9h,002h,0B9h	; ovr_1c41_6ccd:D280
		db	002h,0B9h,002h,0B9h,002h,0B9h,002h,002h,003h,002h,003h,043h,005h,043h	; ovr_1c41_6ccd:D28E
		db	005h,043h,005h,043h,005h,043h,005h,043h,005h,043h,005h,043h,005h,043h	; ovr_1c41_6ccd:D29C
		db	005h,043h,005h,043h,005h,043h,005h,043h,005h,043h,005h,043h,005h,043h	; ovr_1c41_6ccd:D2AA
		db	005h,043h,005h,043h,005h,043h,005h,043h,005h,043h,005h,043h,005h,043h	; ovr_1c41_6ccd:D2B8
		db	005h,043h,005h,043h,005h,043h,005h,043h,005h,043h,005h,043h,005h,043h	; ovr_1c41_6ccd:D2C6
		db	005h,043h,005h,043h,005h,043h,005h,043h,005h,043h,005h,043h,005h,043h	; ovr_1c41_6ccd:D2D4
		db	005h,043h,005h,043h,005h,043h,005h,0C8h,002h,0CDh,002h,0E8h,002h,0EDh	; ovr_1c41_6ccd:D2E2
		db	002h,0F2h,002h,0F7h,002h,0FDh,002h,043h,005h,04Dh,002h,043h,005h,0F3h	; ovr_1c41_6ccd:D2F0
		db	001h,002h,003h,043h,005h,002h,003h,043h,005h,043h,005h,0F3h,001h,043h	; ovr_1c41_6ccd:D2FE
		db	005h,043h,005h,0B9h,002h,043h,005h,043h,005h,043h,005h,043h,005h,043h	; ovr_1c41_6ccd:D30C
		db	005h,043h,005h,043h,005h,043h,005h,043h,005h,043h,005h,043h,005h,043h	; ovr_1c41_6ccd:D31A
		db	005h,043h,005h,043h,005h,043h,005h,043h,005h,043h,005h,043h,005h,043h	; ovr_1c41_6ccd:D328
		db	005h,043h,005h,043h,005h,041h,005h,045h,055h,08Bh,0ECh,056h,057h,0E8h	; ovr_1c41_6ccd:D336
		db	002h,0FAh,08Bh,0F0h,0FFh,036h,0C2h,05Eh,056h,033h,0C0h,050h,09Ah
		dw	0BBh
		dw	seg CO023_TEXT
		db	08Bh,0F0h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	080h,03Eh,0A0h,062h; ovr_1c41_6ccd:D344
		db	000h,074h,008h,056h,09Ah
		dw	02Fh
		dw	seg CO013_TEXT
		db	0EBh,032h,083h,03Eh,0C2h; ovr_1c41_6ccd:D360
		db	05Eh,031h,075h,00Eh,0FFh,036h,08Bh,063h,033h,0C0h,050h,09Ah
		dw	07Ah
		dw	seg CO023_TEXT
		db	0EBh,00Ch,0B8h,0D0h,000h,050h,033h,0C0h,050h,09Ah
		dw	0CFh
		dw	seg CO023_TEXT
		db	08Bh,0F8h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	08Eh,006h,086h,081h,026h; ovr_1c41_6ccd:D36E
		db	089h,07Ch,00Ch,08Bh,0C6h,05Fh,05Eh,05Dh,04Dh,0C3h; raw:D398
X022_05	label	far
		db	055h,08Bh,0ECh,083h; ovr_1c41_6ccd:D398
		db	0ECh,004h,056h,080h,03Eh,0D0h,077h,000h,074h,00Fh,080h,03Eh,0F5h,016h	; ovr_1c41_6ccd:D3A6
		db	000h,074h,008h,0C7h,046h,010h,000h,000h,0E9h,0CDh,000h,083h,07Eh,010h	; ovr_1c41_6ccd:D3B4
		db	000h,074h,003h,0E9h,0C4h,000h,0C4h,05Eh,00Ch,026h,083h,03Fh,031h,074h	; ovr_1c41_6ccd:D3C2
		db	003h,0E9h,0B8h,000h,083h,03Eh,0C2h,05Eh,001h,074h,003h,0E9h,0AEh,000h	; ovr_1c41_6ccd:D3D0
		db	080h,03Eh,0A0h,062h,000h,074h,005h,0B8h,022h,001h,0EBh,003h,0B8h,071h	; ovr_1c41_6ccd:D3DE
		db	001h,050h,0C4h,05Eh,00Ch,026h,0FFh,077h,009h,09Ah
		dw	02Ah
		dw	seg CO019_TEXT
		db	052h,050h,033h,0C0h,033h,0D2h,050h,052h,09Ah
		dw	03Eh
		dw	seg CO019_TEXT
		db	0A1h; ovr_1c41_6ccd:D3FA
		db	07Eh,064h,089h,046h,0FEh,0C7h,006h,07Eh,064h,002h,000h,0FFh,036h,0D6h	; ovr_1c41_6ccd:D408
		db	063h,0C4h,05Eh,00Ch,026h,0FFh,077h,009h,033h,0C0h,050h,0B8h,036h,000h	; ovr_1c41_6ccd:D416
		db	050h,016h,08Dh,046h,010h,050h,016h,08Dh,046h,0FDh,050h,09Ah
		dw	025h
		dw	seg CO000_TEXT
		db	08Bh,01Eh,098h,063h,08Eh,006h,02Ah,078h,026h,08Bh,047h,004h; ovr_1c41_6ccd:D424
		db	03Bh,006h,0DCh,063h,074h,040h,08Eh,006h,010h,064h,08Bh,05Eh,010h,026h	; ovr_1c41_6ccd:D440
		db	08Bh,007h,08Bh,01Eh,098h,063h,08Eh,006h,02Ah,078h,026h,089h,047h,004h	; ovr_1c41_6ccd:D44E
		db	08Bh,05Eh,010h,08Eh,006h,010h,064h,026h,08Bh,05Fh,002h,08Eh,006h,032h	; ovr_1c41_6ccd:D45C
		db	078h,026h,08Bh,007h,08Eh,006h,010h,064h,08Bh,05Eh,010h,026h,089h,007h	; ovr_1c41_6ccd:D46A
		db	026h,08Bh,05Fh,002h,08Eh,006h,032h,078h,08Bh,046h,010h,026h,089h,007h	; ovr_1c41_6ccd:D478
		db	08Bh,046h,0FEh,0A3h,07Eh,064h,083h,07Eh,010h,000h,075h,02Ch,080h,03Eh	; ovr_1c41_6ccd:D486
		db	0D0h,077h,000h,074h,012h,0FFh,036h,09Ch,062h,033h,0C0h,033h,0D2h,050h	; ovr_1c41_6ccd:D494
		db	052h,09Ah
		dw	0C5h
		dw	seg CO023_TEXT
		db	0E9h,09Dh,000h,0FFh,076h,00Eh,0FFh,076h; ovr_1c41_6ccd:D4A2
		db	00Ch,0B8h,05Ah,000h,050h,09Ah
		dw	034h
		dw	seg CO019_TEXT
		db	033h,0C0h,0EBh,03Ah; ovr_1c41_6ccd:D4B0
		db	08Bh,05Eh,010h,08Eh,006h,010h,064h,026h,08Ah,047h,007h,0B4h,000h,0D1h	; ovr_1c41_6ccd:D4BE
		db	0F8h,0D1h,0F8h,0D1h,0F8h,03Dh,008h,000h,074h,011h,026h,08Ah,047h,007h	; ovr_1c41_6ccd:D4CC
		db	0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,03Dh,00Bh,000h,075h,040h,08Bh	; ovr_1c41_6ccd:D4DA
		db	05Eh,010h,08Eh,006h,010h,064h,026h,083h,07Fh,002h,000h,075h,00Eh,0B8h	; ovr_1c41_6ccd:D4E8
		db	010h,000h,050h,033h,0C0h,050h,09Ah
		dw	0CFh
		dw	seg CO023_TEXT
		db	0EBh,045h,0B8h; ovr_1c41_6ccd:D4F6
		db	006h,001h,050h,08Bh,05Eh,010h,08Eh,006h,010h,064h,026h,0FFh,077h,002h	; ovr_1c41_6ccd:D504
		db	09Ah
		dw	02Ah
		dw	seg CO019_TEXT
		db	052h,050h,033h,0C0h,033h,0D2h,050h,052h,050h; ovr_1c41_6ccd:D512
		db	09Ah
		dw	03Eh
		dw	seg CO023_TEXT
		db	0EBh,021h,0FFh,076h,010h,09Ah
		dw	093h
		dw	seg CO023_TEXT
		db	08Bh,0F0h,005h,014h,000h,0FFh,036h,086h,081h,050h,08Dh,046h,006h; ovr_1c41_6ccd:D520
		db	016h,050h,0B9h,006h,000h,09Ah
		dw	0402h
		dw	seg BCC_COPY_WORDS
		db	08Bh,0C6h,05Eh,08Bh; ovr_1c41_6ccd:D53C
		db	0E5h,05Dh,0CAh,00Ch,000h,045h,055h,08Bh,0ECh,083h,0ECh,01Ch,083h,03Eh	; ovr_1c41_6ccd:D54A
		db	0C2h,05Eh,031h,074h,00Eh,0B8h,0D4h,000h,050h,033h,0C0h,050h,09Ah
		dw	0CFh
		dw	seg CO023_TEXT
		db	0EBh,04Eh,0FFh,036h,08Bh,063h,09Ah
		dw	0CAh
		dw	seg CO02C_TEXT
		db	089h,046h,0FEh,08Dh,046h,0E4h,016h,050h,0B8h,082h,063h,01Eh,050h,0B9h	; ovr_1c41_6ccd:D574
		db	013h,000h,09Ah
		dw	0402h
		dw	seg BCC_COPY_WORDS
		db	0A1h,085h,063h,089h,046h,0F8h,0A1h; ovr_1c41_6ccd:D582
		db	087h,063h,089h,046h,0FAh,0A1h,089h,063h,089h,046h,0FCh,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	0FFh,076h,0FEh,016h,08Dh,046h,0E4h,050h,08Dh,046h,0F8h,08Ch; ovr_1c41_6ccd:D590
		db	0D2h,0B9h,006h,000h,09Ah
		dw	03C2h
		dw	seg BCC_COPY_WORDS
		db	00Eh,0E8h,0E9h,0FDh,08Bh; ovr_1c41_6ccd:D5AC
		db	0E5h,05Dh,04Dh,0C3h,045h,055h,08Bh,0ECh,056h,0B8h,011h,000h,050h,09Ah	; ovr_1c41_6ccd:D5BA
		dw	02Fh
		dw	seg CO02C_TEXT
		db	08Bh,0F0h,08Eh,006h,09Ah,063h,0A1h,096h,063h,026h; ovr_1c41_6ccd:D5C8
		db	089h,044h,007h,08Bh,046h,004h,099h,026h,089h,054h,00Bh,026h,089h,044h	; ovr_1c41_6ccd:D5D6
		db	009h,08Bh,0C6h,05Eh,05Dh,04Dh,0C2h,002h,000h,045h,055h,08Bh,0ECh,083h	; ovr_1c41_6ccd:D5E4
		db	0ECh,006h,056h,0A1h,0C2h,05Eh,089h,046h,0FAh,0B9h,004h,000h,0BBh,0D8h	; ovr_1c41_6ccd:D5F2
		db	009h,02Eh,08Bh,007h,03Bh,046h,0FAh,074h,007h,043h,043h,0E2h,0F4h,0E9h	; ovr_1c41_6ccd:D600
		db	08Bh,000h,02Eh,0FFh,067h,008h,080h,03Eh,0A0h,062h,000h,074h,005h,0A1h	; ovr_1c41_6ccd:D60E
		db	096h,063h,0EBh,003h,0A1h,0C8h,05Eh,050h,0FFh,036h,08Dh,063h,0FFh,036h	; ovr_1c41_6ccd:D61C
		db	08Bh,063h,09Ah
		dw	0C5h
		dw	seg CO023_TEXT
		db	08Bh,0F0h,0EBh,066h,0A0h,084h,063h; ovr_1c41_6ccd:D62A
		db	098h,0D1h,0E0h,0C4h,01Eh,01Ch,064h,003h,0D8h,026h,0FFh,037h,0EBh,0DEh	; ovr_1c41_6ccd:D638
		db	0A0h,084h,063h,098h,0D1h,0E0h,0C4h,01Eh,01Ch,064h,003h,0D8h,026h,0FFh	; ovr_1c41_6ccd:D646
		db	037h,01Eh,0B8h,08Bh,063h,050h,09Ah
		dw	098h
		dw	seg CO023_TEXT
		db	0EBh,0D0h,016h; ovr_1c41_6ccd:D654
		db	08Dh,046h,0FEh,050h,016h,08Dh,046h,0FCh,050h,09Ah
		dw	039h
		dw	seg CO03D_TEXT
		db	0FFh,036h,0A4h,063h,09Ah
		dw	093h
		dw	seg CO023_TEXT
		db	08Bh,0F0h,08Eh,006h,086h; ovr_1c41_6ccd:D670
		db	081h,026h,080h,04Ch,006h,001h,0FFh,076h,0FCh,0E8h,034h,0FFh,08Eh,006h	; ovr_1c41_6ccd:D67E
		db	086h,081h,026h,089h,044h,008h,08Bh,046h,0FEh,026h,089h,044h,00Ch,0EBh	; ovr_1c41_6ccd:D68C
		db	005h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	08Bh,0C6h,05Eh,08Bh,0E5h,05Dh,04Dh,0C3h; ovr_1c41_6ccd:D69A
		db	032h,000h,033h,000h,034h,000h,065h,000h,065h,009h,076h,009h,091h,009h	; ovr_1c41_6ccd:D6A8
		db	044h,009h; raw:D6B6
X022_04	label	far
		db	055h,08Bh,0ECh,083h,0ECh,014h,056h,08Bh,076h,006h,0A1h,0C8h; ovr_1c41_6ccd:D6B6
		db	05Eh,089h,046h,0FEh,056h,016h,08Dh,046h,0FAh,050h,016h,08Dh,046h,0EFh	; ovr_1c41_6ccd:D6C4
		db	050h,016h,08Dh,046h,0EEh,050h,016h,08Dh,046h,0FEh,050h,016h,08Dh,046h	; ovr_1c41_6ccd:D6D2
		db	0F0h,050h,016h,08Dh,046h,0EDh,050h,09Ah
		dw	034h
		dw	seg CO010_TEXT
		db	081h,07Eh; ovr_1c41_6ccd:D6E0
		db	0FAh,082h,000h,075h,00Ch,080h,07Eh,0EFh,000h,075h,006h,080h,07Eh,0EEh	; ovr_1c41_6ccd:D6EE
		db	000h,074h,039h,0B8h,002h,001h,050h,080h,07Eh,0EFh,000h,074h,007h,08Ch	; ovr_1c41_6ccd:D6FC
		db	0DAh,0B8h,0ACh,013h,0EBh,01Bh,080h,07Eh,0EEh,000h,074h,007h,08Ch,0DAh	; ovr_1c41_6ccd:D70A
		db	0B8h,0B3h,013h,0EBh,00Eh,08Bh,05Eh,0FAh,0D1h,0E3h,0FFh,0B7h,082h,061h	; ovr_1c41_6ccd:D718
		db	09Ah
		dw	02Ah
		dw	seg CO019_TEXT
		db	052h,050h,033h,0C0h,033h,0D2h,050h,052h,09Ah; ovr_1c41_6ccd:D726
		dw	03Eh
		dw	seg CO019_TEXT
		db	0FFh,076h,0FEh,056h,016h,08Dh,046h,0FCh,050h,016h; ovr_1c41_6ccd:D734
		db	08Dh,046h,0F8h,050h,016h,08Dh,046h,0F6h,050h,016h,08Dh,046h,0F4h,050h	; ovr_1c41_6ccd:D742
		db	016h,08Dh,046h,0F0h,050h,016h,050h,09Ah
		dw	03Eh
		dw	seg CO010_TEXT
		db	08Bh,046h; ovr_1c41_6ccd:D750
		db	0FCh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h,045h,055h,08Bh,0ECh,080h,03Eh	; ovr_1c41_6ccd:D75E
		db	0A0h,062h,000h,074h,029h,083h,03Eh,0C2h,05Eh,031h,075h,022h,09Ah
		dw	020h
		dw	seg CO02D_TEXT
		db	083h,03Eh,060h,082h,001h,075h,016h,0FFh,036h,08Bh,063h; ovr_1c41_6ccd:D76C
		db	09Ah
		dw	02Ah
		dw	seg CO03D_TEXT
		db	00Bh,0C0h,074h,005h,0B8h,001h,000h,0EBh,002h; ovr_1c41_6ccd:D788
		db	033h,0C0h,0EBh,002h,0B0h,000h,05Dh,04Dh,0C3h,055h,08Bh,0ECh,09Ah
		dw	020h
		dw	seg CO02D_TEXT
		db	01Eh,0B8h,060h,082h,050h,09Ah
		dw	025h
		dw	seg CO03D_TEXT
		db	0B4h; ovr_1c41_6ccd:D796
		db	000h,00Bh,0C0h,074h,007h,083h,03Eh,060h,082h,02Bh,075h,004h,0B0h,000h	; ovr_1c41_6ccd:D7B2
		db	0EBh,014h,080h,03Eh,0A0h,062h,000h,074h,00Bh,0B8h,003h,000h,050h,09Ah	; ovr_1c41_6ccd:D7C0
		dw	020h
		dw	seg CO01E_TEXT
		db	0EBh,002h,0B0h,001h,05Dh,0CBh,055h,08Bh,0ECh,04Ch; ovr_1c41_6ccd:D7CE
		db	04Ch,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	0B8h,003h,000h,050h,00Eh,0E8h,0CEh,0FEh; ovr_1c41_6ccd:D7DC
		db	050h,033h,0C0h,050h,09Ah
		dw	084h
		dw	seg CO023_TEXT
		db	089h,046h,0FEh,0B8h,002h; ovr_1c41_6ccd:D7EA
		db	000h,050h,0B8h,0DDh,000h,050h,09Ah
		dw	03Eh
		dw	seg CO03D_TEXT
		db	08Bh,046h,0FEh; ovr_1c41_6ccd:D7F8
		db	08Bh,0E5h,05Dh,0CBh,045h,055h,08Bh,0ECh,056h,057h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	09Ah
		dw	020h
		dw	seg CO02D_TEXT
		db	083h,03Eh,0C2h,05Eh,001h,075h,07Ch,01Eh; ovr_1c41_6ccd:D806
		db	0B8h,060h,082h,050h,09Ah
		dw	025h
		dw	seg CO03D_TEXT
		db	00Ah,0C0h,074h,06Eh,09Ah; ovr_1c41_6ccd:D822
		dw	025h
		dw	seg CO02D_TEXT
		db	0B8h,003h,000h,050h,00Eh,0E8h,07Ch,0FEh,08Bh,0F0h; ovr_1c41_6ccd:D830
		db	08Eh,006h,09Ah,063h,026h,08Bh,01Ch,0F6h,087h,0CAh,009h,014h,074h,00Bh	; ovr_1c41_6ccd:D83E
		db	026h,0F6h,044h,002h,020h,074h,004h,026h,08Bh,074h,007h,056h,09Ah
		dw	02Fh
		dw	seg CO00A_TEXT
		db	00Bh,0C2h,075h,009h,0B8h,00Ah,001h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0FFh,036h,098h,064h,056h,09Ah
		dw	02Fh
		dw	seg CO00A_TEXT
		db	052h,050h; ovr_1c41_6ccd:D84C
		db	08Eh,006h,09Ah,063h,08Bh,01Eh,098h,064h,026h,0FFh,037h,0FFh,01Eh,0F0h	; ovr_1c41_6ccd:D876
		db	080h,052h,050h,09Ah
		dw	0C5h
		dw	seg CO023_TEXT
		db	08Bh,0F8h,0B8h,002h,000h,050h; ovr_1c41_6ccd:D884
		db	0B8h,0E9h,000h,050h,09Ah
		dw	03Eh
		dw	seg CO03D_TEXT
		db	0EBh,002h,033h,0FFh,08Bh; ovr_1c41_6ccd:D892
		db	0C7h,05Fh,05Eh,05Dh,04Dh,0C3h,045h,055h,08Bh,0ECh,083h,0ECh,018h,056h	; ovr_1c41_6ccd:D8A0
		db	057h,08Bh,01Eh,0C2h,05Eh,0D1h,0E3h,0A1h,0FAh,063h,085h,087h,0B3h,007h	; ovr_1c41_6ccd:D8AE
		db	075h,017h,0B8h,0CFh,000h,050h,033h,0C0h,050h,09Ah
		dw	0CFh
		dw	seg CO023_TEXT
		db	089h,046h,0F6h,0C6h,006h,078h,064h,001h,0E9h,03Bh,005h,0A1h,0C8h,066h	; ovr_1c41_6ccd:D8CA
		db	089h,046h,0EEh,0A1h,0D2h,066h,089h,046h,0F0h,0A1h,0C6h,066h,089h,046h	; ovr_1c41_6ccd:D8D8
		db	0ECh,0A1h,0D4h,066h,089h,046h,0EAh,0E8h,0E0h,0F3h,0C7h,046h,0FEh,000h	; ovr_1c41_6ccd:D8E6
		db	000h,0C7h,046h,0FCh,000h,000h,0C7h,046h,0FAh,000h,000h,0C6h,046h,0F3h	; ovr_1c41_6ccd:D8F4
		db	001h,033h,0FFh,0C7h,046h,0F4h,003h,000h,08Bh,036h,0C2h,05Eh,0C6h,046h	; ovr_1c41_6ccd:D902
		db	0F2h,000h,0C6h,046h,0F9h,07Eh,08Bh,0DEh,04Bh,083h,0FBh,071h,076h,003h	; ovr_1c41_6ccd:D910
		db	0E9h,0CBh,003h,0D1h,0E3h,02Eh,0FFh,0A7h,0B4h,011h,080h,03Eh,0A0h,062h	; ovr_1c41_6ccd:D91E
		db	000h,074h,023h,09Ah
		dw	020h
		dw	seg CO02D_TEXT
		db	083h,03Eh,060h,082h,001h,075h; ovr_1c41_6ccd:D92C
		db	017h,09Ah
		dw	025h
		dw	seg CO013_TEXT
		db	08Bh,0F8h,0C7h,046h,0F4h,000h,000h,0C6h; ovr_1c41_6ccd:D93A
		db	046h,0F3h,000h,0C6h,046h,0F9h,002h,0E9h,0D0h,003h,0B8h,02Bh,000h,050h	; ovr_1c41_6ccd:D948
		db	09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	0C6h,006h,078h,064h; ovr_1c41_6ccd:D956
		db	001h,0E9h,0BAh,003h,09Ah
		dw	089h
		dw	seg CO023_TEXT
		db	08Bh,0F8h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	0EBh,0CCh,09Ah
		dw	020h
		dw	seg CO02D_TEXT
		db	083h,03Eh,060h,082h,069h; ovr_1c41_6ccd:D964
		db	075h,00Fh,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	0BEh,063h,000h,0C6h,046h,0F9h,00Ah; ovr_1c41_6ccd:D980
		db	0E9h,088h,003h,09Ah
		dw	020h
		dw	seg CO02D_TEXT
		db	083h,03Eh,060h,082h,06Ch,075h; ovr_1c41_6ccd:D98E
		db	017h,09Ah
		dw	020h
		dw	seg CO013_TEXT
		db	08Bh,0F8h,0C7h,046h,0F4h,000h,000h,0C6h; ovr_1c41_6ccd:D99C
		db	046h,0F9h,002h,0C6h,046h,0F3h,000h,0E9h,06Eh,003h,0E8h,0AFh,0FDh,00Ah	; ovr_1c41_6ccd:D9AA
		db	0C0h,074h,003h,0E9h,07Dh,0FFh,080h,03Eh,0A0h,062h,000h,074h,007h,09Ah	; ovr_1c41_6ccd:D9B8
		dw	02Ah
		dw	seg CO013_TEXT
		db	0EBh,003h,0E8h,080h,0FBh,0E9h,06Eh,0FFh,0E9h,06Bh; ovr_1c41_6ccd:D9C6
		db	0FFh,0E9h,06Ah,0FFh,0C7h,046h,0F4h,000h,000h,083h,03Eh,012h,05Fh,000h	; ovr_1c41_6ccd:D9D4
		db	075h,00Eh,0B8h,09Ah,000h,050h,033h,0C0h,050h,09Ah
		dw	0CFh
		dw	seg CO023_TEXT
		db	0EBh,009h,0FFh,036h,012h,05Fh,09Ah
		dw	0BBh
		dw	seg CO00F_TEXT
		db	08Bh,0F8h,09Ah; ovr_1c41_6ccd:D9F0
		dw	025h
		dw	seg CO02D_TEXT
		db	0E9h,042h,0FFh,0E8h,0E5h,0FBh,0E9h,035h,0FFh,09Ah; ovr_1c41_6ccd:D9FE
		dw	020h
		dw	seg CO013_TEXT
		db	0E9h,02Dh,0FFh,0C7h,046h,0F4h,001h,000h,0C6h,046h; ovr_1c41_6ccd:DA0C
		db	0F3h,000h,08Ah,084h,016h,012h,0E9h,09Ah,001h,08Ah,084h,016h,012h,088h	; ovr_1c41_6ccd:DA1A
		db	046h,0F9h,0A0h,0A0h,062h,0B4h,000h,00Bh,0C0h,075h,028h,0B8h,0F2h,000h	; ovr_1c41_6ccd:DA28
		db	050h,08Bh,0DEh,0D1h,0E3h,0FFh,0B7h,082h,061h,09Ah
		dw	02Ah
		dw	seg CO019_TEXT
		db	052h,050h,033h,0C0h,033h,0D2h,050h,052h,09Ah
		dw	03Eh
		dw	seg CO019_TEXT
		db	0C6h; ovr_1c41_6ccd:DA44
		db	006h,078h,064h,001h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	080h,07Eh,0F3h,000h,074h; ovr_1c41_6ccd:DA52
		db	01Ah,080h,03Eh,0A0h,062h,000h,074h,009h,0B8h,02Bh,000h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0C6h,006h,078h,064h,001h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	0E9h; ovr_1c41_6ccd:DA60
		db	09Bh,002h,0C6h,046h,0F3h,001h,0EBh,06Dh,0E8h,083h,0FDh,08Bh,0F8h,00Bh	; ovr_1c41_6ccd:DA7C
		db	0FFh,075h,006h,0C6h,046h,0F2h,001h,0EBh,0EBh,0C7h,046h,0F4h,000h,000h	; ovr_1c41_6ccd:DA8A
		db	0C6h,046h,0F3h,000h,0C6h,046h,0F9h,002h,0E9h,07Fh,002h,080h,07Eh,006h	; ovr_1c41_6ccd:DA98
		db	000h,075h,015h,083h,07Eh,0FEh,000h,075h,00Fh,083h,07Eh,0FCh,000h,075h	; ovr_1c41_6ccd:DAA6
		db	009h,083h,07Eh,0FAh,000h,075h,003h,0E9h,064h,002h,0C6h,046h,0F3h,001h	; ovr_1c41_6ccd:DAB4
		db	08Ah,084h,016h,012h,088h,046h,0F9h,0E9h,056h,002h,0FFh,046h,0FAh,0C6h	; ovr_1c41_6ccd:DAC2
		db	046h,0F3h,001h,0E9h,046h,0FFh,080h,07Eh,0F3h,000h,074h,01Ch,00Eh,0E8h	; ovr_1c41_6ccd:DAD0
		db	0BFh,0FCh,00Ah,0C0h,074h,014h,0BEh,061h,000h,00Eh,0E8h,0EDh,0FCh,08Bh	; ovr_1c41_6ccd:DADE
		db	0F8h,0C6h,046h,0F2h,001h,0C6h,046h,0F9h,00Ah,0E9h,02Ah,002h,080h,07Eh	; ovr_1c41_6ccd:DAEC
		db	0F3h,000h,074h,00Ch,0BEh,001h,000h,0FFh,046h,0FEh,0A0h,017h,012h,0E9h	; ovr_1c41_6ccd:DAFA
		db	0B3h,000h,0BEh,05Fh,000h,0B8h,001h,000h,050h,090h,00Eh,0E8h,072h,004h	; ovr_1c41_6ccd:DB08
		db	08Bh,0F8h,0C7h,046h,0F4h,002h,000h,0C6h,046h,0F9h,002h,0E9h,0FEh,001h	; ovr_1c41_6ccd:DB16
		db	083h,07Eh,0FEh,000h,075h,027h,083h,07Eh,004h,002h,074h,006h,083h,07Eh	; ovr_1c41_6ccd:DB24
		db	004h,004h,075h,007h,0C6h,046h,0F2h,001h,0E9h,0ACh,000h,0B8h,099h,000h	; ovr_1c41_6ccd:DB32
		db	050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0C6h,006h,078h,064h,001h,0E9h,09Bh,000h; ovr_1c41_6ccd:DB40
		db	0E9h,098h,000h,0FFh,04Eh,0FEh,0C6h,046h,0F3h,000h,08Ah,084h,016h,012h	; ovr_1c41_6ccd:DB4E
		db	088h,046h,0F9h,0E9h,0C0h,001h,0FFh,046h,0FCh,080h,07Eh,0F3h,000h,074h	; ovr_1c41_6ccd:DB5C
		db	04Bh,083h,03Eh,0D4h,066h,000h,07Fh,005h,0B8h,082h,000h,0EBh,013h,0A1h	; ovr_1c41_6ccd:DB6A
		db	0D4h,066h,048h,0D1h,0E0h,08Bh,01Eh,0C8h,066h,003h,0D8h,08Eh,006h,0CAh	; ovr_1c41_6ccd:DB78
		db	066h,026h,08Bh,007h,03Dh,069h,000h,074h,024h,083h,03Eh,0D4h,066h,000h	; ovr_1c41_6ccd:DB86
		db	07Fh,005h,0B8h,082h,000h,0EBh,013h,0A1h,0D4h,066h,048h,0D1h,0E0h,08Bh	; ovr_1c41_6ccd:DB94
		db	01Eh,0C8h,066h,003h,0D8h,08Eh,006h,0CAh,066h,026h,08Bh,007h,03Dh,063h	; ovr_1c41_6ccd:DBA2
		db	000h,075h,003h,0BEh,060h,000h,0C6h,046h,0F3h,001h,0A0h,019h,012h,088h	; ovr_1c41_6ccd:DBB0
		db	046h,0F9h,0E9h,05Fh,001h,083h,07Eh,0FCh,000h,075h,026h,083h,07Eh,004h	; ovr_1c41_6ccd:DBBE
		db	002h,074h,006h,083h,07Eh,004h,004h,075h,006h,0C6h,046h,0F2h,001h,0EBh	; ovr_1c41_6ccd:DBCC
		db	00Eh,0B8h,02Bh,000h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0C6h,006h,078h,064h; ovr_1c41_6ccd:DBDA
		db	001h,0BEh,082h,000h,0E9h,033h,001h,0FFh,04Eh,0FCh,083h,03Eh,0D4h,066h	; ovr_1c41_6ccd:DBE8
		db	000h,07Fh,005h,0B8h,082h,000h,0EBh,013h,0A1h,0D4h,066h,048h,0D1h,0E0h	; ovr_1c41_6ccd:DBF6
		db	08Bh,01Eh,0C8h,066h,003h,0D8h,08Eh,006h,0CAh,066h,026h,08Bh,007h,03Dh	; ovr_1c41_6ccd:DC04
		db	060h,000h,075h,005h,0B8h,001h,000h,0EBh,002h,033h,0C0h,088h,046h,0F3h	; ovr_1c41_6ccd:DC12
		db	08Ah,084h,016h,012h,088h,046h,0F9h,0E9h,0F8h,000h,083h,07Eh,0FAh,000h	; ovr_1c41_6ccd:DC20
		db	075h,01Eh,083h,07Eh,004h,021h,075h,007h,0C6h,046h,0F2h,001h,0E9h,0E5h	; ovr_1c41_6ccd:DC2E
		db	000h,0B8h,074h,000h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0C6h,006h,078h,064h; ovr_1c41_6ccd:DC3C
		db	001h,0E9h,0D4h,000h,0FFh,04Eh,0FAh,0C6h,046h,0F3h,001h,0A0h,037h,012h	; ovr_1c41_6ccd:DC4A
		db	088h,046h,0F9h,0E9h,0C4h,000h,08Ah,046h,0F3h,0B4h,000h,00Bh,0C0h,075h	; ovr_1c41_6ccd:DC58
		db	005h,0BEh,059h,000h,0EBh,013h,0C6h,046h,0F9h,00Ah,0E9h,0AFh,000h,08Ah	; ovr_1c41_6ccd:DC66
		db	046h,0F3h,0B4h,000h,00Bh,0C0h,075h,00Ah,0BEh,05Ah,000h,0C6h,046h,0F9h	; ovr_1c41_6ccd:DC74
		db	006h,0E9h,09Ch,000h,0C6h,046h,0F9h,00Ah,0E9h,095h,000h,080h,07Eh,0F3h	; ovr_1c41_6ccd:DC82
		db	000h,074h,009h,0BEh,05Bh,000h,0C6h,046h,0F9h,00Ah,0EBh,007h,08Ah,084h	; ovr_1c41_6ccd:DC90
		db	016h,012h,088h,046h,0F9h,0EBh,074h,080h,07Eh,0F3h,000h,074h,009h,0BEh	; ovr_1c41_6ccd:DC9E
		db	05Ch,000h,0C6h,046h,0F9h,00Ah,0EBh,007h,08Ah,084h,016h,012h,088h,046h	; ovr_1c41_6ccd:DCAC
		db	0F9h,0EBh,05Ch,080h,07Eh,0F3h,000h,074h,009h,0BEh,05Dh,000h,0C6h,046h	; ovr_1c41_6ccd:DCBA
		db	0F9h,00Ah,0EBh,007h,08Ah,084h,016h,012h,088h,046h,0F9h,0EBh,044h,080h	; ovr_1c41_6ccd:DCC8
		db	07Eh,0F3h,000h,074h,006h,0BEh,05Eh,000h,0E9h,0A9h,0FCh,08Ah,084h,016h	; ovr_1c41_6ccd:DCD6
		db	012h,088h,046h,0F9h,0EBh,02Fh,0EBh,02Dh,08Ah,084h,016h,012h,088h,046h	; ovr_1c41_6ccd:DCE4
		db	0F9h,080h,07Eh,0F3h,000h,074h,020h,08Ah,084h,01Ch,013h,088h,046h,0F9h	; ovr_1c41_6ccd:DCF2
		db	080h,07Eh,0F9h,07Ch,075h,013h,0B8h,02Bh,000h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0C6h,006h,078h,064h,001h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	0C6h,046h,0F3h; ovr_1c41_6ccd:DD00
		db	001h,0EBh,003h,0E8h,0D8h,0F0h,0A0h,078h,064h,0B4h,000h,00Bh,0C0h,075h	; ovr_1c41_6ccd:DD1C
		db	02Ah,083h,03Eh,0D4h,066h,000h,07Fh,005h,0B8h,082h,000h,0EBh,013h,0A1h	; ovr_1c41_6ccd:DD2A
		db	0D4h,066h,048h,0D1h,0E0h,08Bh,01Eh,0C8h,066h,003h,0D8h,08Eh,006h,0CAh	; ovr_1c41_6ccd:DD38
		db	066h,026h,08Bh,007h,08Bh,0D8h,08Ah,087h,099h,012h,03Ah,046h,0F9h,076h	; ovr_1c41_6ccd:DD46
		db	0CAh,080h,03Eh,078h,064h,000h,074h,006h,0C6h,046h,0F9h,07Eh,0EBh,05Dh	; ovr_1c41_6ccd:DD54
		db	08Bh,046h,0F4h,00Bh,0C0h,074h,00Ch,03Dh,001h,000h,074h,009h,03Dh,002h	; ovr_1c41_6ccd:DD62
		db	000h,074h,00Ah,0EBh,01Bh,0EBh,00Ah,0E8h,0C3h,0F5h,050h,0EBh,005h,056h	; ovr_1c41_6ccd:DD70
		db	0E8h,008h,0F0h,057h,0FFh,036h,0D2h,066h,09Ah
		dw	0B6h
		dw	seg CO023_TEXT
		db	0A3h; ovr_1c41_6ccd:DD7E
		db	0D2h,066h,0EBh,02Fh,080h,07Eh,0F9h,07Eh,074h,029h,081h,0FEh,082h,000h	; ovr_1c41_6ccd:DD8C
		db	074h,004h,056h,0E8h,0E9h,0EFh,00Bh,0FFh,074h,00Dh,057h,0FFh,036h,0D2h	; ovr_1c41_6ccd:DD9A
		db	066h,09Ah
		dw	0B6h
		dw	seg CO023_TEXT
		db	0A3h,0D2h,066h,08Ah,046h,0F2h,0B4h,000h; ovr_1c41_6ccd:DDA8
		db	00Bh,0C0h,075h,005h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	080h,07Eh,0F9h,07Eh,074h; ovr_1c41_6ccd:DDB6
		db	003h,0E9h,03Bh,0FBh,0E8h,07Dh,0EFh,089h,046h,0F6h,0E8h,03Bh,0EFh,0B4h	; ovr_1c41_6ccd:DDC4
		db	000h,00Bh,0C0h,075h,021h,08Eh,006h,086h,081h,08Bh,05Eh,0F6h,026h,083h	; ovr_1c41_6ccd:DDD2
		db	03Fh,000h,074h,00Fh,0B8h,02Bh,000h,050h,0FFh,076h,0F6h,09Ah
		dw	0CFh
		dw	seg CO023_TEXT
		db	089h,046h,0F6h,0C6h,006h,078h,064h,001h,08Bh,046h,0ECh,0A3h; ovr_1c41_6ccd:DDE0
		db	0C6h,066h,08Bh,046h,0EAh,0A3h,0D4h,066h,08Bh,046h,0EEh,0A3h,0C8h,066h	; ovr_1c41_6ccd:DDFC
		db	08Bh,046h,0F0h,0A3h,0D2h,066h,080h,03Eh,078h,064h,000h,074h,061h,0FFh	; ovr_1c41_6ccd:DE0A
		db	076h,004h,09Ah
		dw	020h
		dw	seg CO019_TEXT
		db	083h,03Eh,0C2h,05Eh,002h,075h,007h; ovr_1c41_6ccd:DE18
		db	08Bh,046h,0FEh,048h,089h,046h,0FEh,083h,03Eh,0C2h,05Eh,004h,075h,007h	; ovr_1c41_6ccd:DE26
		db	08Bh,046h,0FCh,048h,089h,046h,0FCh,0A1h,0C2h,05Eh,03Bh,046h,004h,075h	; ovr_1c41_6ccd:DE34
		db	01Fh,083h,03Eh,0C2h,05Eh,002h,075h,006h,083h,07Eh,0FEh,000h,07Fh,00Dh	; ovr_1c41_6ccd:DE42
		db	083h,03Eh,0C2h,05Eh,004h,075h,00Bh,083h,07Eh,0FCh,000h,07Eh,005h,0B8h	; ovr_1c41_6ccd:DE50
		db	001h,000h,0EBh,002h,033h,0C0h,088h,046h,0E9h,080h,07Eh,0E9h,000h,074h	; ovr_1c41_6ccd:DE5E
		db	005h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	080h,07Eh,0E9h,000h,075h,09Fh,08Bh,046h; ovr_1c41_6ccd:DE6C
		db	0F6h,05Fh,05Eh,08Bh,0E5h,05Dh,04Dh,0C2h,004h,000h,006h,00Eh,054h,00Eh	; ovr_1c41_6ccd:DE7A
		db	092h,00Eh,0F3h,00Eh,01Ch,010h,01Ch,010h,01Ch,010h,0D3h,00Dh,098h,00Ch	; ovr_1c41_6ccd:DE88
		db	01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h	; ovr_1c41_6ccd:DE96
		db	01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,0BDh,00Fh,005h,010h	; ovr_1c41_6ccd:DEA4
		db	0EDh,00Fh,01Ch,010h,01Ch,010h,0D5h,00Fh,01Ch,010h,01Ch,010h,01Ch,010h	; ovr_1c41_6ccd:DEB2
		db	01Ch,010h,0FCh,00Dh,05Ah,00Fh,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h	; ovr_1c41_6ccd:DEC0
		db	01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,0B4h,00Dh	; ovr_1c41_6ccd:DECE
		db	08Eh,00Fh,0A3h,00Fh,043h,00Dh,043h,00Dh,0E4h,00Ch,035h,00Dh,035h,00Dh	; ovr_1c41_6ccd:DEDC
		db	035h,00Dh,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,058h,00Ch	; ovr_1c41_6ccd:DEEA
		db	058h,00Ch,058h,00Ch,058h,00Ch,058h,00Ch,058h,00Ch,058h,00Ch,058h,00Ch	; ovr_1c41_6ccd:DEF8
		db	01Ch,010h,01Ch,010h,01Ch,010h,058h,00Ch,01Ch,010h,01Ch,010h,01Ch,010h	; ovr_1c41_6ccd:DF06
		db	01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h	; ovr_1c41_6ccd:DF14
		db	01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h	; ovr_1c41_6ccd:DF22
		db	01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h	; ovr_1c41_6ccd:DF30
		db	01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,053h,00Dh	; ovr_1c41_6ccd:DF3E
		db	035h,00Dh,053h,00Dh,0A6h,00Ch,01Ch,010h,0AEh,00Dh,01Ch,010h,01Ch,010h	; ovr_1c41_6ccd:DF4C
		db	03Bh,00Dh,0E4h,00Ch,01Ch,010h,01Ch,010h,01Ch,010h,01Ch,010h,008h,00Dh	; ovr_1c41_6ccd:DF5A
X022_00	label	far
		db	055h,08Bh,0ECh,0B0h,000h,050h,0FFh,076h,006h,0E8h,032h,0F9h,05Dh,0CAh; ovr_1c41_6ccd:DF68
		db	002h,000h; raw:DF76
X022_01	label	far
		db	055h,08Bh,0ECh,0B0h,001h,050h,0FFh,076h,006h,0E8h,022h,0F9h; ovr_1c41_6ccd:DF76
		db	05Dh,0CAh,002h,000h; raw:DF84
X022_03	label	far
		db	055h,08Bh,0ECh,056h,057h,033h,0FFh,0B8h,001h,000h; ovr_1c41_6ccd:DF84
		db	050h,0B8h,0DAh,000h,050h,09Ah
		dw	03Eh
		dw	seg CO03D_TEXT
		db	083h,03Eh,0C2h,05Eh; ovr_1c41_6ccd:DF92
		db	002h,074h,04Eh,0B0h,000h,050h,0B8h,002h,000h,050h,0E8h,0F9h,0F8h,050h	; ovr_1c41_6ccd:DFA0
		db	033h,0C0h,050h,09Ah
		dw	0B6h
		dw	seg CO023_TEXT
		db	08Bh,0F8h,08Bh,0F7h,0EBh,024h; ovr_1c41_6ccd:DFAE
		db	09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	0B0h,000h,050h,0B8h,002h,000h,050h,0E8h,0DBh; ovr_1c41_6ccd:DFBC
		db	0F8h,050h,033h,0C0h,050h,09Ah
		dw	0B6h
		dw	seg CO023_TEXT
		db	08Eh,006h,086h,081h; ovr_1c41_6ccd:DFCA
		db	026h,089h,044h,00Ah,026h,08Bh,074h,00Ah,083h,03Eh,0C2h,05Eh,008h,074h	; ovr_1c41_6ccd:DFD8
		db	0D5h,08Eh,006h,086h,081h,026h,0C7h,044h,00Ah,000h,000h,0B8h,002h,000h	; ovr_1c41_6ccd:DFE6
		db	050h,083h,07Eh,006h,000h,074h,005h,0B8h,01Ah,000h,0EBh,003h,0B8h,0E9h	; ovr_1c41_6ccd:DFF4
		db	000h,050h,09Ah
		dw	03Eh
		dw	seg CO03D_TEXT
		db	08Bh,0C7h,05Fh,05Eh,05Dh,0CAh,002h; ovr_1c41_6ccd:E002
		db	000h; raw:E010
X022_02	label	far
		db	055h,08Bh,0ECh,033h,0C0h,0A3h,0CCh,066h,0A3h,0CEh,066h,0C7h,006h; ovr_1c41_6ccd:E010
		db	0D0h,066h,000h,000h,01Eh,0B8h,0CAh,066h,050h,033h,0C0h,050h,09Ah
		dw	01B1Ch
		dw	seg BCC_FAR_245C
		db	0C7h,006h,0C8h,066h,000h,000h,0C7h,006h,0D2h,066h,000h; ovr_1c41_6ccd:E01E
		db	000h,0C7h,006h,0C6h,066h,000h,000h,05Dh,0CBh	; ovr_1c41_6ccd:E03A

CO022_TEXT	ends
; END C232UNIT
		end
