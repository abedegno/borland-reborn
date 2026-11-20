; Recovered FBOV far-pointer references
		extrn	BCC_COPY_WORDS:far
CO00A_TEXT	segment byte public 'CODE'
CO00A_TEXT	ends
CO00F_TEXT	segment byte public 'CODE'
CO00F_TEXT	ends
CO010_TEXT	segment byte public 'CODE'
CO010_TEXT	ends
CO019_TEXT	segment byte public 'CODE'
CO019_TEXT	ends
CO01E_TEXT	segment byte public 'CODE'
CO01E_TEXT	ends
CO021_TEXT	segment byte public 'CODE'
CO021_TEXT	ends
CO022_TEXT	segment byte public 'CODE'
CO022_TEXT	ends
CO023_TEXT	segment byte public 'CODE'
CO023_TEXT	ends
CO02C_TEXT	segment byte public 'CODE'
CO02C_TEXT	ends
CO02D_TEXT	segment byte public 'CODE'
CO02D_TEXT	ends
CO03D_TEXT	segment byte public 'CODE'
CO03D_TEXT	ends
CO03F_TEXT	segment byte public 'CODE'
CO03F_TEXT	ends
CO06C_TEXT	segment byte public 'CODE'
CO06C_TEXT	ends
		public	X013_00
		public	X013_01
		public	X013_03
		public	X013_02
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1c02_65a6
; BEGIN C228UNIT (listing ovr_1c02_65a6:5A60)
CO013_TEXT	segment byte public 'CODE'
		assume	cs:CO013_TEXT
; Original-image layout stub: not recovered source


X013_02	label	far
		db	055h,08Bh,0ECh,083h,0ECh,018h,056h,057h,0C6h,046h,0FDh,000h,0C7h,046h; ovr_1c02_65a6:5A60
		db	0FEh,000h,000h,083h,03Eh,0C2h,05Eh,031h,075h,01Eh,09Ah
		dw	020h
		dw	seg CO02D_TEXT
		db	083h,03Eh,060h,082h,067h,075h,012h,09Ah
		dw	061h
		dw	seg CO03F_TEXT
		db	089h; ovr_1c02_65a6:5A6E
		db	046h,0FEh,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	083h,07Eh; ovr_1c02_65a6:5A8A
		db	0FEh,000h,075h,003h,0E9h,09Fh,000h,083h,03Eh,0C2h,05Eh,02Bh,074h,003h	; ovr_1c02_65a6:5A98
		db	0E9h,095h,000h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	083h,03Eh,0C2h,05Eh,031h,074h; ovr_1c02_65a6:5AA6
		db	00Fh,0B8h,02Bh,000h,050h,033h,0C0h,050h,09Ah
		dw	0CFh
		dw	seg CO023_TEXT
		db	0E9h; ovr_1c02_65a6:5AB4
		db	035h,002h,0FFh,036h,08Bh,063h,09Ah
		dw	039h
		dw	seg CO02C_TEXT
		db	08Bh,0F8h,00Bh; ovr_1c02_65a6:5AC2
		db	0FFh,075h,00Bh,0FFh,036h,08Bh,063h,09Ah
		dw	039h
		dw	seg CO02C_TEXT
		db	08Bh,0F8h; ovr_1c02_65a6:5AD0
		db	00Bh,0FFh,074h,040h,08Eh,006h,010h,064h,026h,08Ah,045h,007h,0B4h,000h	; ovr_1c02_65a6:5ADE
		db	0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,03Dh,00Bh,000h,074h,011h,026h,08Ah,045h	; ovr_1c02_65a6:5AEC
		db	007h,0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,03Dh,008h,000h,075h,01Ah	; ovr_1c02_65a6:5AFA
		db	08Eh,006h,010h,064h,026h,0FFh,075h,004h,0FFh,076h,0FEh,0B8h,001h,000h	; ovr_1c02_65a6:5B08
		db	050h,09Ah
		dw	020h
		dw	seg CO00A_TEXT
		db	0B4h,000h,00Bh,0C0h,075h,005h,0B8h,07Dh; ovr_1c02_65a6:5B16
		db	000h,0EBh,091h,0FFh,036h,08Eh,061h,0B8h,004h,000h,050h,09Ah
		dw	07Ah
		dw	seg CO023_TEXT
		db	08Bh,0F0h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	0E9h,0ADh,001h,083h,03Eh; ovr_1c02_65a6:5B24
		db	0C2h,05Eh,031h,074h,00Ah,083h,03Eh,0C2h,05Eh,06Dh,074h,003h,0E9h,08Eh	; ovr_1c02_65a6:5B40
		db	001h,083h,03Eh,0C2h,05Eh,031h,075h,011h,0FFh,036h,08Bh,063h,033h,0C0h	; ovr_1c02_65a6:5B4E
		db	050h,09Ah
		dw	07Ah
		dw	seg CO023_TEXT
		db	08Bh,0F0h,0E9h,058h,001h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	01Eh,0B8h,082h,063h,050h,09Ah
		dw	025h
		dw	seg CO03D_TEXT
		db	00Ah,0C0h; ovr_1c02_65a6:5B5C
		db	075h,003h,0E9h,0CBh,000h,09Ah
		dw	020h
		dw	seg CO02D_TEXT
		db	083h,03Eh,060h,082h; ovr_1c02_65a6:5B78
		db	067h,075h,003h,0E9h,0BCh,000h,0A1h,0C8h,05Eh,089h,046h,0FAh,0B8h,006h	; ovr_1c02_65a6:5B86
		db	000h,050h,016h,08Dh,046h,0F6h,050h,016h,08Dh,046h,0EBh,050h,016h,08Dh	; ovr_1c02_65a6:5B94
		db	046h,0EAh,050h,016h,08Dh,046h,0FAh,050h,016h,08Dh,046h,0ECh,050h,016h	; ovr_1c02_65a6:5BA2
		db	08Dh,046h,0E9h,050h,09Ah
		dw	034h
		dw	seg CO010_TEXT
		db	081h,07Eh,0F6h,082h,000h; ovr_1c02_65a6:5BB0
		db	075h,00Ch,080h,07Eh,0EBh,000h,075h,006h,080h,07Eh,0EAh,000h,074h,039h	; ovr_1c02_65a6:5BBE
		db	0B8h,002h,001h,050h,080h,07Eh,0EBh,000h,074h,007h,08Ch,0DAh,0B8h,0A2h	; ovr_1c02_65a6:5BCC
		db	00Fh,0EBh,01Bh,080h,07Eh,0EAh,000h,074h,007h,08Ch,0DAh,0B8h,0A9h,00Fh	; ovr_1c02_65a6:5BDA
		db	0EBh,00Eh,08Bh,05Eh,0F6h,0D1h,0E3h,0FFh,0B7h,082h,061h,09Ah
		dw	02Ah
		dw	seg CO019_TEXT
		db	052h,050h,033h,0C0h,033h,0D2h,050h,052h,09Ah
		dw	03Eh
		dw	seg CO019_TEXT
		db	0FFh,076h,0FAh,0B8h,006h,000h,050h,016h,08Dh,046h,0F8h,050h,016h; ovr_1c02_65a6:5BE8
		db	08Dh,046h,0F4h,050h,016h,08Dh,046h,0F2h,050h,016h,08Dh,046h,0F0h,050h	; ovr_1c02_65a6:5C12
		db	016h,08Dh,046h,0ECh,050h,016h,050h,09Ah
		dw	03Eh
		dw	seg CO010_TEXT
		db	0FFh,036h; ovr_1c02_65a6:5C20
		db	0F0h,061h,0B8h,002h,000h,050h,09Ah
		dw	07Ah
		dw	seg CO023_TEXT
		db	08Bh,0F0h,08Eh; ovr_1c02_65a6:5C2E
		db	006h,086h,081h,08Bh,046h,0F8h,026h,089h,044h,00Eh,0EBh,07Ch,08Bh,01Eh	; ovr_1c02_65a6:5C3C
		db	082h,063h,0D1h,0E3h,0FFh,0B7h,082h,061h,0B8h,001h,000h,050h,09Ah
		dw	07Ah
		dw	seg CO023_TEXT
		db	08Bh,0F0h,083h,03Eh,0C2h,05Eh,001h,075h,017h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	083h,03Eh,0C2h,05Eh,002h,074h,04Fh,0B8h,0E9h,000h,050h; ovr_1c02_65a6:5C4A
		db	09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0EBh,044h,083h,03Eh,0C2h,05Eh,003h,075h,022h; ovr_1c02_65a6:5C74
		db	09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	083h,03Eh,0C2h,05Eh,004h,074h,031h,0B8h,0E5h; ovr_1c02_65a6:5C82
		db	000h,050h,01Eh,0B8h,0B1h,00Fh,050h,033h,0C0h,033h,0D2h,050h,052h,09Ah	; ovr_1c02_65a6:5C90
		dw	03Eh
		dw	seg CO019_TEXT
		db	0EBh,01Bh,08Bh,01Eh,0C2h,05Eh,0D1h,0E3h,0F7h,087h; ovr_1c02_65a6:5C9E
		db	0B3h,007h,000h,004h,075h,00Dh,0B8h,09Fh,000h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	0C6h,046h,0FDh,001h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	080h,07Eh,0FDh,000h; ovr_1c02_65a6:5CAC
		db	074h,006h,033h,0C0h,050h,056h,0EBh,014h,08Eh,006h,086h,081h,08Bh,046h	; ovr_1c02_65a6:5CC8
		db	0FEh,026h,089h,044h,00Ch,0EBh,00Eh,0B8h,0D0h,000h,050h,033h,0C0h,050h	; ovr_1c02_65a6:5CD6
		db	09Ah
		dw	0CFh
		dw	seg CO023_TEXT
		db	08Bh,0F0h,08Bh,05Eh,006h,08Eh,006h,086h,081h; ovr_1c02_65a6:5CE4
		db	026h,089h,077h,00Ch,08Bh,046h,006h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h	; ovr_1c02_65a6:5CF2
		db	000h; raw:5D00
X013_03	label	far
		db	055h,08Bh,0ECh,083h,0ECh,03Ah,056h,057h,0C6h,046h,0F5h,000h,0C7h; ovr_1c02_65a6:5D00
		db	046h,0FCh,000h,000h,0C7h,046h,0F2h,000h,000h,0C7h,046h,0F8h,000h,000h	; ovr_1c02_65a6:5D0E
		db	083h,03Eh,0C2h,05Eh,031h,075h,019h,09Ah
		dw	020h
		dw	seg CO02D_TEXT
		db	083h,03Eh; ovr_1c02_65a6:5D1C
		db	060h,082h,067h,075h,00Dh,09Ah
		dw	061h
		dw	seg CO03F_TEXT
		db	089h,046h,0FCh,09Ah; ovr_1c02_65a6:5D2A
		dw	025h
		dw	seg CO02D_TEXT
		db	0C6h,046h,0FFh,000h,083h,03Eh,0C2h,05Eh,067h,075h; ovr_1c02_65a6:5D38
		db	009h,0C6h,046h,0FFh,001h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	0C7h,046h,0FAh,000h; ovr_1c02_65a6:5D46
		db	000h,083h,03Eh,0C2h,05Eh,06Dh,074h,003h,0E9h,0A6h,001h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	01Eh,0B8h,082h,063h,050h,09Ah
		dw	025h
		dw	seg CO03D_TEXT
		db	00Ah,0C0h; ovr_1c02_65a6:5D54
		db	075h,003h,0E9h,0E6h,000h,09Ah
		dw	020h
		dw	seg CO02D_TEXT
		db	083h,03Eh,060h,082h; ovr_1c02_65a6:5D70
		db	067h,075h,003h,0E9h,0D7h,000h,0C7h,046h,0F8h,002h,000h,08Dh,046h,0C6h	; ovr_1c02_65a6:5D7E
		db	016h,050h,0B8h,082h,063h,01Eh,050h,0B9h,013h,000h,09Ah
		dw	0402h
		dw	seg BCC_COPY_WORDS
		db	0A1h,085h,063h,089h,046h,0ECh,0A1h,087h,063h,089h,046h,0EEh,0A1h; ovr_1c02_65a6:5D8C
		db	089h,063h,089h,046h,0F0h,0C7h,046h,0C6h,037h,000h,0A1h,0F0h,061h,089h	; ovr_1c02_65a6:5DA8
		db	046h,0FAh,0A1h,0C8h,05Eh,089h,046h,0EAh,0B8h,006h,000h,050h,016h,08Dh	; ovr_1c02_65a6:5DB6
		db	046h,0E8h,050h,016h,08Dh,046h,0DDh,050h,016h,08Dh,046h,0DCh,050h,016h	; ovr_1c02_65a6:5DC4
		db	08Dh,046h,0EAh,050h,016h,08Dh,046h,0DEh,050h,016h,08Dh,046h,0DBh,050h	; ovr_1c02_65a6:5DD2
		db	09Ah
		dw	034h
		dw	seg CO010_TEXT
		db	081h,07Eh,0E8h,082h,000h,075h,00Ch,080h,07Eh; ovr_1c02_65a6:5DE0
		db	0DDh,000h,075h,006h,080h,07Eh,0DCh,000h,074h,039h,0B8h,002h,001h,050h	; ovr_1c02_65a6:5DEE
		db	080h,07Eh,0DDh,000h,074h,007h,08Ch,0DAh,0B8h,0A2h,00Fh,0EBh,01Bh,080h	; ovr_1c02_65a6:5DFC
		db	07Eh,0DCh,000h,074h,007h,08Ch,0DAh,0B8h,0A9h,00Fh,0EBh,00Eh,08Bh,05Eh	; ovr_1c02_65a6:5E0A
		db	0E8h,0D1h,0E3h,0FFh,0B7h,082h,061h,09Ah
		dw	02Ah
		dw	seg CO019_TEXT
		db	052h,050h; ovr_1c02_65a6:5E18
		db	033h,0C0h,033h,0D2h,050h,052h,09Ah
		dw	03Eh
		dw	seg CO019_TEXT
		db	0FFh,076h,0EAh; ovr_1c02_65a6:5E26
		db	0B8h,006h,000h,050h,016h,08Dh,046h,0F2h,050h,016h,08Dh,046h,0E6h,050h	; ovr_1c02_65a6:5E34
		db	016h,08Dh,046h,0E4h,050h,016h,08Dh,046h,0E2h,050h,016h,08Dh,046h,0DEh	; ovr_1c02_65a6:5E42
		db	050h,016h,050h,09Ah
		dw	03Eh
		dw	seg CO010_TEXT
		db	0E9h,0EBh,000h,0C7h,046h,0F8h; ovr_1c02_65a6:5E50
		db	001h,000h,08Bh,01Eh,082h,063h,0D1h,0E3h,08Bh,087h,082h,061h,089h,046h	; ovr_1c02_65a6:5E5E
		db	0FAh,08Dh,046h,0C6h,016h,050h,0B8h,082h,063h,01Eh,050h,0B9h,013h,000h	; ovr_1c02_65a6:5E6C
		db	09Ah
		dw	0402h
		dw	seg BCC_COPY_WORDS
		db	0A1h,085h,063h,089h,046h,0ECh,0A1h,087h,063h; ovr_1c02_65a6:5E7A
		db	089h,046h,0EEh,0A1h,089h,063h,089h,046h,0F0h,08Bh,01Eh,0C2h,05Eh,0D1h	; ovr_1c02_65a6:5E88
		db	0E3h,0F7h,087h,0B3h,007h,000h,004h,075h,00Bh,0B8h,09Fh,000h,050h,09Ah	; ovr_1c02_65a6:5E96
		dw	039h
		dw	seg CO019_TEXT
		db	0EBh,054h,083h,03Eh,0C2h,05Eh,003h,074h,007h,083h; ovr_1c02_65a6:5EA4
		db	03Eh,0C2h,05Eh,001h,075h,046h,083h,03Eh,0C2h,05Eh,003h,075h,022h,09Ah	; ovr_1c02_65a6:5EB2
		dw	020h
		dw	seg CO02D_TEXT
		db	083h,03Eh,060h,082h,004h,074h,016h,0B8h,0E5h,000h; ovr_1c02_65a6:5EC0
		db	050h,01Eh,0B8h,0BDh,00Fh,050h,033h,0C0h,033h,0D2h,050h,052h,09Ah
		dw	03Eh
		dw	seg CO019_TEXT
		db	0EBh,01Dh,083h,03Eh,0C2h,05Eh,001h,075h,011h,09Ah
		dw	020h
		dw	seg CO02D_TEXT
		db	083h,03Eh,060h,082h,002h,074h,005h,0B8h,0E9h,000h,0EBh; ovr_1c02_65a6:5ECE
		db	0A9h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	0EBh,041h,083h; ovr_1c02_65a6:5EF8
		db	03Eh,0C2h,05Eh,031h,075h,031h,0A1h,08Bh,063h,089h,046h,0FAh,08Dh,046h	; ovr_1c02_65a6:5F06
		db	0C6h,016h,050h,0B8h,082h,063h,01Eh,050h,0B9h,013h,000h,09Ah
		dw	0402h
		dw	seg BCC_COPY_WORDS
		db	0A1h,085h,063h,089h,046h,0ECh,0A1h,087h,063h,089h,046h,0EEh; ovr_1c02_65a6:5F14
		db	0A1h,089h,063h,089h,046h,0F0h,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	0EBh,009h,0B8h; ovr_1c02_65a6:5F30
		db	0D4h,000h,050h,09Ah
		dw	039h
		dw	seg CO019_TEXT
		db	033h,0FFh,033h,0F6h,083h,07Eh; ovr_1c02_65a6:5F3E
		db	0FAh,000h,075h,00Ch,033h,0C0h,050h,050h,09Ah
		dw	0CFh
		dw	seg CO023_TEXT
		db	0E9h; ovr_1c02_65a6:5F4C
		db	0DCh,002h,080h,07Eh,0FFh,000h,074h,030h,083h,07Eh,0FCh,000h,075h,002h	; ovr_1c02_65a6:5F5A
		db	0EBh,066h,0FFh,076h,0FAh,0FFh,076h,0FCh,09Ah
		dw	025h
		dw	seg CO06C_TEXT
		db	08Bh; ovr_1c02_65a6:5F68
		db	0F0h,083h,03Eh,038h,064h,000h,074h,068h,0FFh,076h,0FCh,0FFh,036h,038h	; ovr_1c02_65a6:5F76
		db	064h,0B0h,000h,050h,09Ah
		dw	0A2h
		dw	seg CO00F_TEXT
		db	088h,046h,0F5h,0EBh,054h; ovr_1c02_65a6:5F84
		db	0FFh,076h,0FAh,09Ah
		dw	0B1h
		dw	seg CO02C_TEXT
		db	08Bh,0F8h,00Bh,0FFh,075h,023h; ovr_1c02_65a6:5F92
		db	083h,03Eh,038h,064h,000h,074h,01Ch,0FFh,076h,0FAh,0FFh,036h,038h,064h	; ovr_1c02_65a6:5FA0
		db	09Ah
		dw	025h
		dw	seg CO06C_TEXT
		db	08Bh,0F0h,00Bh,0F6h,074h,005h,0B8h,001h,000h; ovr_1c02_65a6:5FAE
		db	0EBh,002h,033h,0C0h,088h,046h,0F5h,00Bh,0FFh,075h,01Fh,08Ah,046h,0F5h	; ovr_1c02_65a6:5FBC
		db	0B4h,000h,00Bh,0C0h,075h,016h,0FFh,076h,0FAh,08Bh,01Eh,0C0h,063h,08Eh	; ovr_1c02_65a6:5FCA
		db	006h,02Ah,078h,026h,0FFh,077h,004h,09Ah
		dw	07Fh
		dw	seg CO02C_TEXT
		db	08Bh,0F8h; ovr_1c02_65a6:5FD8
		db	080h,03Eh,0D0h,077h,000h,074h,009h,080h,03Eh,0F5h,016h,000h,074h,002h	; ovr_1c02_65a6:5FE6
		db	033h,0FFh,00Bh,0F6h,075h,021h,083h,07Eh,0FCh,000h,075h,01Bh,057h,016h	; ovr_1c02_65a6:5FF4
		db	08Dh,046h,0C6h,050h,08Dh,046h,0ECh,08Ch,0D2h,0B9h,006h,000h,09Ah
		dw	03C2h
		dw	seg BCC_COPY_WORDS
		db	09Ah
		dw	034h
		dw	seg CO022_TEXT
		db	0E9h,01Dh,002h,00Bh,0F6h,075h; ovr_1c02_65a6:6002
		db	025h,0B8h,05Ah,000h,050h,0FFh,076h,0FAh,0FFh,076h,0F8h,0FFh,076h,0FCh	; ovr_1c02_65a6:601E
		db	0FFh,076h,0F2h,09Ah
		dw	02Fh
		dw	seg CO021_TEXT
		db	052h,050h,033h,0C0h,033h,0D2h; ovr_1c02_65a6:602C
		db	050h,052h,09Ah
		dw	03Eh
		dw	seg CO019_TEXT
		db	0E9h,00Ch,0FFh,083h,07Eh,0F2h,000h; ovr_1c02_65a6:603A
		db	075h,003h,0E9h,0A0h,000h,08Eh,006h,0A4h,078h,026h,08Bh,07Ch,006h,0EBh	; ovr_1c02_65a6:6048
		db	008h,08Eh,006h,010h,064h,026h,08Bh,07Dh,013h,00Bh,0FFh,074h,015h,08Eh	; ovr_1c02_65a6:6056
		db	006h,010h,064h,026h,08Bh,05Dh,004h,08Eh,006h,09Ah,063h,026h,08Bh,047h	; ovr_1c02_65a6:6064
		db	007h,03Bh,046h,0F2h,075h,0DFh,00Bh,0FFh,075h,055h,083h,07Eh,0FCh,000h	; ovr_1c02_65a6:6072
		db	075h,005h,0A1h,038h,064h,0EBh,003h,08Bh,046h,0FCh,089h,046h,0EAh,0B8h	; ovr_1c02_65a6:6080
		db	012h,000h,050h,09Ah
		dw	02Fh
		dw	seg CO02C_TEXT
		db	089h,046h,0E8h,08Bh,05Eh,0E8h; ovr_1c02_65a6:608E
		db	08Eh,006h,09Ah,063h,08Bh,046h,0F2h,026h,089h,047h,007h,0B8h,0D1h,000h	; ovr_1c02_65a6:609C
		db	050h,08Eh,006h,0A4h,078h,026h,0FFh,074h,002h,0B8h,002h,000h,050h,0FFh	; ovr_1c02_65a6:60AA
		db	076h,0E8h,0FFh,076h,0EAh,09Ah
		dw	02Fh
		dw	seg CO021_TEXT
		db	052h,050h,0FFh,076h; ovr_1c02_65a6:60B8
		db	0EAh,09Ah
		dw	043h
		dw	seg CO021_TEXT
		db	052h,050h,0E9h,06Bh,0FFh,033h,0F6h,057h; ovr_1c02_65a6:60C6
		db	09Ah
		dw	093h
		dw	seg CO023_TEXT
		db	089h,046h,0F6h,08Bh,05Eh,0F6h,08Eh,006h,086h; ovr_1c02_65a6:60D4
		db	081h,08Bh,046h,0FCh,026h,089h,047h,00Eh,0E9h,016h,001h,08Eh,006h,0A4h	; ovr_1c02_65a6:60E2
		db	078h,026h,08Ah,044h,004h,0B4h,000h,025h,003h,000h,08Bh,0D8h,083h,0FBh	; ovr_1c02_65a6:60F0
		db	003h,076h,003h,0E9h,0FFh,000h,0D1h,0E3h,02Eh,0FFh,0A7h,0DEh,007h,083h	; ovr_1c02_65a6:60FE
		db	03Eh,012h,05Fh,000h,075h,021h,083h,03Eh,0DCh,05Eh,000h,074h,01Ah,080h	; ovr_1c02_65a6:610C
		db	07Eh,0F5h,000h,074h,014h,0B8h,0F9h,000h,050h,08Eh,006h,0A4h,078h,026h	; ovr_1c02_65a6:611A
		db	0FFh,074h,002h,09Ah
		dw	02Fh
		dw	seg CO019_TEXT
		db	0E9h,01Dh,0FEh,056h,09Ah
		dw	07Fh
		dw	seg CO023_TEXT
		db	089h,046h,0F6h,08Bh,05Eh,0F6h,08Eh,006h,086h,081h,08Bh; ovr_1c02_65a6:6128
		db	046h,0FCh,026h,089h,047h,00Ch,0E9h,0B6h,000h,08Eh,006h,0A4h,078h,026h	; ovr_1c02_65a6:6144
		db	0FFh,074h,008h,026h,08Bh,044h,006h,099h,052h,050h,09Ah
		dw	0C5h
		dw	seg CO023_TEXT
		db	089h,046h,0F6h,0C6h,046h,0F5h,000h,056h,0FFh,036h,038h,064h,09Ah; ovr_1c02_65a6:6152
		dw	034h
		dw	seg CO06C_TEXT
		db	0B4h,000h,00Bh,0C0h,074h,003h,0E9h,088h,000h,0B8h; ovr_1c02_65a6:616E
		db	0B6h,000h,050h,056h,09Ah
		dw	03Eh
		dw	seg CO021_TEXT
		db	052h,050h,033h,0C0h,033h; ovr_1c02_65a6:617C
		db	0D2h,050h,052h,09Ah
		dw	03Eh
		dw	seg CO019_TEXT
		db	0EBh,06Fh,0C6h,046h,0F5h,000h; ovr_1c02_65a6:618A
		db	08Eh,006h,0A4h,078h,026h,0FFh,074h,006h,09Ah
		dw	093h
		dw	seg CO023_TEXT
		db	089h; ovr_1c02_65a6:6198
		db	046h,0F6h,056h,0FFh,036h,038h,064h,09Ah
		dw	034h
		dw	seg CO06C_TEXT
		db	0B4h,000h; ovr_1c02_65a6:61A6
		db	00Bh,0C0h,075h,04Bh,0B8h,0B6h,000h,050h,056h,09Ah
		dw	03Eh
		dw	seg CO021_TEXT
		db	052h,050h,033h,0C0h,033h,0D2h,050h,052h,09Ah
		dw	03Eh
		dw	seg CO019_TEXT
		db	0EBh; ovr_1c02_65a6:61C2
		db	032h,083h,03Eh,012h,05Fh,000h,074h,009h,08Ah,046h,0F5h,0B4h,000h,00Bh	; ovr_1c02_65a6:61D0
		db	0C0h,075h,00Bh,08Eh,006h,0A4h,078h,026h,0FFh,074h,006h,0E9h,0E8h,0FEh	; ovr_1c02_65a6:61DE
		db	056h,09Ah
		dw	07Fh
		dw	seg CO023_TEXT
		db	089h,046h,0F6h,08Bh,05Eh,0F6h,08Eh,006h; ovr_1c02_65a6:61EC
		db	086h,081h,08Bh,046h,0FCh,026h,089h,047h,00Ch,080h,07Eh,0F5h,000h,074h	; ovr_1c02_65a6:61FA
		db	02Ch,083h,03Eh,012h,05Fh,000h,074h,025h,0B8h,02Fh,000h,050h,0FFh,036h	; ovr_1c02_65a6:6208
		db	012h,05Fh,09Ah
		dw	093h
		dw	seg CO023_TEXT
		db	050h,0FFh,076h,0F6h,09Ah
		dw	0BBh
		dw	seg CO023_TEXT
		db	089h,046h,0F6h,08Bh,05Eh,0F6h,08Eh,006h,086h,081h,026h,080h; ovr_1c02_65a6:6216
		db	04Fh,006h,002h,08Bh,046h,0F6h,05Fh,05Eh,08Bh,0E5h,05Dh,0CBh,0ABh,006h	; ovr_1c02_65a6:6232
		db	0EDh,006h,034h,007h,071h,007h; raw:6240
X013_01	label	far
		db	055h,08Bh,0ECh,083h,0ECh,00Ch,056h,057h; ovr_1c02_65a6:6240
		db	0A1h,0C8h,05Eh,089h,046h,0FCh,0B8h,003h,000h,050h,016h,08Dh,046h,0FEh	; ovr_1c02_65a6:624E
		db	050h,016h,08Dh,046h,0F7h,050h,016h,08Dh,046h,0F6h,050h,016h,08Dh,046h	; ovr_1c02_65a6:625C
		db	0FCh,050h,016h,08Dh,046h,0F8h,050h,016h,08Dh,046h,0F5h,050h,09Ah
		dw	034h
		dw	seg CO010_TEXT
		db	081h,07Eh,0FEh,082h,000h,075h,00Ch,080h,07Eh,0F7h,000h; ovr_1c02_65a6:626A
		db	075h,006h,080h,07Eh,0F6h,000h,074h,039h,0B8h,002h,001h,050h,080h,07Eh	; ovr_1c02_65a6:6286
		db	0F7h,000h,074h,007h,08Ch,0DAh,0B8h,0A2h,00Fh,0EBh,01Bh,080h,07Eh,0F6h	; ovr_1c02_65a6:6294
		db	000h,074h,007h,08Ch,0DAh,0B8h,0A9h,00Fh,0EBh,00Eh,08Bh,05Eh,0FEh,0D1h	; ovr_1c02_65a6:62A2
		db	0E3h,0FFh,0B7h,082h,061h,09Ah
		dw	02Ah
		dw	seg CO019_TEXT
		db	052h,050h,033h,0C0h; ovr_1c02_65a6:62B0
		db	033h,0D2h,050h,052h,09Ah
		dw	03Eh
		dw	seg CO019_TEXT
		db	033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO022_TEXT
		db	08Bh,0F8h,0B8h,001h,000h,050h,033h,0C0h,050h,057h,09Ah; ovr_1c02_65a6:62BE
		dw	0BBh
		dw	seg CO023_TEXT
		db	08Bh,0F0h,08Eh,006h,086h,081h,026h,0C7h,004h,037h; ovr_1c02_65a6:62DA
		db	000h,08Bh,046h,0FCh,026h,089h,044h,008h,00Bh,0FFh,074h,020h,026h,083h	; ovr_1c02_65a6:62E8
		db	07Dh,00Ah,000h,075h,019h,026h,0C7h,004h,035h,000h,026h,08Bh,045h,00Ch	; ovr_1c02_65a6:62F6
		db	026h,089h,044h,00Ah,026h,0C7h,044h,00Ch,000h,000h,057h,09Ah
		dw	06Bh
		dw	seg CO023_TEXT
		db	08Bh,0C6h,05Fh,05Eh,08Bh,0E5h,05Dh,0CBh; ovr_1c02_65a6:6304
X013_00	label	far
		db	055h,08Bh,0ECh,04Ch; ovr_1c02_65a6:6312
		db	04Ch,056h,057h,0B8h,06Ch,000h,050h,033h,0C0h,050h,050h,09Ah
		dw	0BBh
		dw	seg CO023_TEXT
		db	089h,046h,0FEh,0B8h,06Ch,000h,050h,033h,0C0h,050h,0FFh,076h; ovr_1c02_65a6:6320
		db	0FEh,09Ah
		dw	0BBh
		dw	seg CO023_TEXT
		db	08Bh,0F8h,083h,03Eh,0C2h,05Eh,067h,075h; ovr_1c02_65a6:633C
		db	00Eh,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	08Eh,006h,086h,081h,026h,080h,065h,006h; ovr_1c02_65a6:634A
		db	0DFh,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	083h,03Eh,0C2h,05Eh,001h,075h,022h,0B8h; ovr_1c02_65a6:6358
		db	004h,000h,050h,09Ah
		dw	020h
		dw	seg CO01E_TEXT
		db	0B4h,000h,00Bh,0C0h,075h,013h; ovr_1c02_65a6:6366
		db	033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO022_TEXT
		db	08Bh,05Eh,0FEh,08Eh,006h,086h; ovr_1c02_65a6:6374
		db	081h,026h,089h,047h,00Ah,083h,03Eh,0C2h,05Eh,001h,075h,01Fh,09Ah
		dw	025h
		dw	seg CO02D_TEXT
		db	0B8h,005h,000h,050h,09Ah
		dw	039h
		dw	seg CO022_TEXT
		db	08Bh,0F0h; ovr_1c02_65a6:6382
		db	0B8h,002h,000h,050h,0B8h,0E9h,000h,050h,09Ah
		dw	03Eh
		dw	seg CO03D_TEXT
		db	0EBh; ovr_1c02_65a6:639E
		db	00Bh,0B8h,004h,000h,050h,09Ah
		dw	039h
		dw	seg CO022_TEXT
		db	08Bh,0F0h,08Eh,006h; ovr_1c02_65a6:63AC
		db	09Ah,063h,026h,083h,03Ch,011h,075h,034h,026h,0F6h,044h,002h,020h,074h	; ovr_1c02_65a6:63BA
		db	006h,026h,08Bh,044h,00Dh,0EBh,015h,0FFh,036h,0C8h,05Eh,08Eh,006h,09Ah	; ovr_1c02_65a6:63C8
		db	063h,026h,0FFh,074h,00Bh,026h,0FFh,074h,009h,09Ah
		dw	0C5h
		dw	seg CO023_TEXT
		db	08Eh,006h,086h,081h,026h,089h,045h,00Ah,08Eh,006h,09Ah,063h,026h,08Bh	; ovr_1c02_65a6:63E4
		db	074h,007h,0EBh,00Ah,08Eh,006h,086h,081h,026h,0C7h,045h,00Ah,000h,000h	; ovr_1c02_65a6:63F2
		db	08Eh,006h,086h,081h,026h,089h,075h,008h,083h,03Eh,0C2h,05Eh,001h,075h	; ovr_1c02_65a6:6400
		db	00Ah,033h,0C0h,050h,09Ah
		dw	02Ah
		dw	seg CO022_TEXT
		db	0EBh,002h,033h,0C0h,08Bh; ovr_1c02_65a6:640E
		db	05Eh,0FEh,08Eh,006h,086h,081h,026h,089h,047h,00Ch,08Bh,0C7h,05Fh,05Eh	; ovr_1c02_65a6:641C
		db	08Bh,0E5h,05Dh,0CBh	; ovr_1c02_65a6:642A

CO013_TEXT	ends
; END C228UNIT
		end
