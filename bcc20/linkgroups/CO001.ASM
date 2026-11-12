; Recovered FBOV far-pointer references
CO00A_TEXT	segment byte public 'CODE'
CO00A_TEXT	ends
CO023_TEXT	segment byte public 'CODE'
CO023_TEXT	ends
CO02C_TEXT	segment byte public 'CODE'
CO02C_TEXT	ends
CO02F_TEXT	segment byte public 'CODE'
CO02F_TEXT	ends
		public	X001_0B
		public	X001_0A
		public	X001_0C
		public	X001_0D
		public	X001_0E
		public	X001_0F
		public	X001_00
		public	X001_01
		public	X001_02
		public	X001_03
		public	X001_04
		public	X001_05
		public	X001_06
		public	X001_07
		public	X001_08
		public	X001_09
		public	X001_10
		public	X001_11
		public	X001_12
		public	X001_13
		public	X001_14
		public	X001_15
		public	X001_16
		public	X001_17
		public	X001_18
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1ba0_518b
; BEGIN C76UNIT (gap ovr_1ba0_518b:18B0)
CO001_TEXT	segment byte public 'CODE'
		assume	cs:CO001_TEXT
; Original-image layout stub: not recovered source


X001_0C	label	far
		db	055h,08Bh,0ECh,056h,08Bh,076h,006h,0F7h,0C6h,001h,000h,074h,010h,08Bh; ovr_1ba0_518b:18B0
		db	0DEh,081h,0E3h,0FEh,0FFh,08Eh,006h,08Ah,062h,026h,08Bh,047h,004h,0EBh	; ovr_1ba0_518b:18BE
		db	008h,08Eh,006h,0C2h,063h,026h,08Bh,044h,004h,05Eh,05Dh,0CAh,002h,000h	; ovr_1ba0_518b:18CC
X001_0E	label	far
		db	055h,08Bh,0ECh,056h,08Bh,076h,006h,0F7h,0C6h,001h,000h,074h,010h,08Bh; ovr_1ba0_518b:18DA
		db	0DEh,081h,0E3h,0FEh,0FFh,08Eh,006h,08Ah,062h,026h,08Bh,047h,002h,0EBh	; ovr_1ba0_518b:18E8
		db	008h,08Eh,006h,0C2h,063h,026h,08Bh,044h,002h,05Eh,05Dh,0CAh,002h,000h	; ovr_1ba0_518b:18F6
X001_15	label	far
		db	055h,08Bh,0ECh,0FFh,076h,006h,09Ah
		dw	06Bh
		dw	seg CO02C_TEXT
		db	08Eh,006h,010h; ovr_1ba0_518b:1904
		db	064h,08Bh,0D8h,026h,08Ah,047h,007h,0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h	; ovr_1ba0_518b:1912
		db	0F8h,05Dh,0CAh,002h,000h; raw:1920
X001_05	label	far
		db	055h,08Bh,0ECh,056h,08Bh,076h,006h,080h,03Eh; ovr_1ba0_518b:1920
		db	0A0h,062h,000h,074h,029h,08Eh,006h,09Ah,063h,026h,083h,03Ch,00Dh,075h	; ovr_1ba0_518b:192E
		db	01Fh,026h,080h,07Ch,00Dh,00Bh,075h,018h,026h,08Bh,01Ch,0F6h,087h,0CAh	; ovr_1ba0_518b:193C
		db	009h,014h,074h,00Eh,026h,08Bh,05Ch,007h,026h,083h,03Fh,012h,075h,004h	; ovr_1ba0_518b:194A
		db	0B0h,013h,0EBh,026h,08Eh,006h,09Ah,063h,026h,083h,03Ch,015h,075h,015h	; ovr_1ba0_518b:1958
		db	026h,08Bh,05Ch,005h,08Eh,006h,03Eh,05Fh,026h,08Bh,05Fh,004h,08Eh,006h	; ovr_1ba0_518b:1966
		db	09Ah,063h,026h,08Ah,007h,0EBh,007h,08Eh,006h,09Ah,063h,026h,08Ah,004h	; ovr_1ba0_518b:1974
		db	05Eh,05Dh,0CAh,002h,000h; raw:1982
X001_0F	label	far
		db	055h,08Bh,0ECh,056h,0FFh,076h,006h,0FFh,01Eh; ovr_1ba0_518b:1982
		db	068h,081h,08Bh,0F0h,0EBh,008h,08Eh,006h,09Ah,063h,026h,08Bh,074h,007h	; ovr_1ba0_518b:1990
		db	08Eh,006h,09Ah,063h,026h,083h,03Ch,011h,074h,0EEh,080h,03Eh,0A0h,062h	; ovr_1ba0_518b:199E
		db	000h,074h,025h,026h,083h,03Ch,00Dh,075h,01Fh,026h,080h,07Ch,00Dh,00Bh	; ovr_1ba0_518b:19AC
		db	075h,018h,026h,08Bh,01Ch,0F6h,087h,0CAh,009h,014h,074h,00Eh,026h,08Bh	; ovr_1ba0_518b:19BA
		db	05Ch,007h,026h,083h,03Fh,012h,075h,004h,0B0h,013h,0EBh,026h,08Eh,006h	; ovr_1ba0_518b:19C8
		db	09Ah,063h,026h,083h,03Ch,015h,075h,015h,026h,08Bh,05Ch,005h,08Eh,006h	; ovr_1ba0_518b:19D6
		db	03Eh,05Fh,026h,08Bh,05Fh,004h,08Eh,006h,09Ah,063h,026h,08Ah,007h,0EBh	; ovr_1ba0_518b:19E4
		db	007h,08Eh,006h,09Ah,063h,026h,08Ah,004h,05Eh,05Dh,0CAh,002h,000h; raw:19F2
X001_06	label	far
		db	055h; ovr_1ba0_518b:19F2
		db	08Bh,0ECh,056h,08Bh,076h,006h,0F7h,0C6h,001h,000h,074h,00Fh,08Bh,0DEh	; ovr_1ba0_518b:1A00
		db	081h,0E3h,0FEh,0FFh,08Eh,006h,08Ah,062h,026h,08Bh,007h,0EBh,007h,08Eh	; ovr_1ba0_518b:1A0E
		db	006h,0C2h,063h,026h,08Bh,004h,05Eh,05Dh,0CAh,002h,000h; raw:1A1C
X001_04	label	far
		db	055h,08Bh,0ECh; ovr_1ba0_518b:1A1C
		db	056h,08Bh,076h,006h,0F7h,0C6h,001h,000h,074h,012h,08Bh,0DEh,081h,0E3h	; ovr_1ba0_518b:1A2A
		db	0FEh,0FFh,08Eh,006h,08Ah,062h,026h,081h,04Fh,008h,020h,000h,0EBh,00Ah	; ovr_1ba0_518b:1A38
		db	08Eh,006h,0C2h,063h,026h,081h,04Ch,008h,020h,000h,05Eh,05Dh,0CAh,002h	; ovr_1ba0_518b:1A46
		db	000h; raw:1A54
X001_08	label	far
		db	055h,08Bh,0ECh,056h,057h,08Bh,076h,008h,08Bh,07Eh,006h,0F7h,0C6h; ovr_1ba0_518b:1A54
		db	001h,000h,074h,010h,08Bh,0DEh,081h,0E3h,0FEh,0FFh,08Eh,006h,08Ah,062h	; ovr_1ba0_518b:1A62
		db	026h,089h,07Fh,004h,0EBh,008h,08Eh,006h,0C2h,063h,026h,089h,07Ch,004h	; ovr_1ba0_518b:1A70
		db	05Fh,05Eh,05Dh,0CAh,004h,000h; raw:1A7E
X001_13	label	far
		db	055h,08Bh,0ECh,056h,057h,08Bh,076h,008h; ovr_1ba0_518b:1A7E
		db	08Bh,07Eh,006h,0F7h,0C6h,001h,000h,074h,010h,08Bh,0DEh,081h,0E3h,0FEh	; ovr_1ba0_518b:1A8C
		db	0FFh,08Eh,006h,08Ah,062h,026h,089h,07Fh,002h,0EBh,008h,08Eh,006h,0C2h	; ovr_1ba0_518b:1A9A
		db	063h,026h,089h,07Ch,002h,05Fh,05Eh,05Dh,0CAh,004h,000h; raw:1AA8
X001_0D	label	far
		db	055h,08Bh,0ECh; ovr_1ba0_518b:1AA8
		db	056h,057h,08Bh,076h,008h,08Bh,07Eh,006h,0F7h,0C6h,001h,000h,074h,01Ch	; ovr_1ba0_518b:1AB6
		db	08Bh,0DEh,081h,0E3h,0FEh,0FFh,08Eh,006h,08Ah,062h,026h,081h,04Fh,008h	; ovr_1ba0_518b:1AC4
		db	008h,000h,08Bh,0DEh,081h,0E3h,0FEh,0FFh,026h,089h,07Fh,002h,0EBh,00Eh	; ovr_1ba0_518b:1AD2
		db	08Eh,006h,0C2h,063h,026h,081h,04Ch,008h,008h,000h,026h,089h,07Ch,002h	; ovr_1ba0_518b:1AE0
		db	05Fh,05Eh,05Dh,0CAh,004h,000h; raw:1AEE
X001_14	label	far
		db	055h,08Bh,0ECh,056h,057h,08Bh,076h,008h; ovr_1ba0_518b:1AEE
		db	08Bh,07Eh,006h,0F7h,0C6h,001h,000h,074h,00Fh,08Bh,0DEh,081h,0E3h,0FEh	; ovr_1ba0_518b:1AFC
		db	0FFh,08Eh,006h,08Ah,062h,026h,089h,03Fh,0EBh,007h,08Eh,006h,0C2h,063h	; ovr_1ba0_518b:1B0A
		db	026h,089h,03Ch,05Fh,05Eh,05Dh,0CAh,004h,000h; raw:1B18
X001_0B	label	far
		db	055h,08Bh,0ECh,056h,08Bh; ovr_1ba0_518b:1B18
		db	076h,006h,08Eh,006h,09Ah,063h,026h,083h,03Ch,00Dh,075h,00Ch,026h,083h	; ovr_1ba0_518b:1B26
		db	07Ch,009h,000h,074h,005h,0B8h,001h,000h,0EBh,002h,033h,0C0h,05Eh,05Dh	; ovr_1ba0_518b:1B34
		db	0CAh,002h,000h; raw:1B42
X001_09	label	far
		db	055h,08Bh,0ECh,056h,08Bh,076h,006h,08Eh,006h,09Ah,063h; ovr_1ba0_518b:1B42
		db	026h,083h,03Ch,00Dh,075h,007h,026h,08Ah,044h,00Dh,098h,0EBh,002h,033h	; ovr_1ba0_518b:1B50
		db	0C0h,05Eh,05Dh,0CAh,002h,000h; raw:1B5E
X001_10	label	far
		db	055h,08Bh,0ECh,08Bh,05Eh,006h,08Eh,006h; ovr_1ba0_518b:1B5E
		db	09Ah,063h,026h,08Ah,047h,00Ch,0B4h,000h,05Dh,0CAh,002h,000h; raw:1B6C
X001_07	label	far
		db	055h,08Bh; ovr_1ba0_518b:1B6C
		db	0ECh,08Bh,05Eh,006h,08Eh,006h,09Ah,063h,026h,08Ah,047h,00Bh,0B4h,000h	; ovr_1ba0_518b:1B7A
		db	05Dh,0CAh,002h,000h; raw:1B88
X001_17	label	far
		db	055h,08Bh,0ECh,0FFh,076h,006h,09Ah
		dw	02Fh
		dw	seg CO00A_TEXT
		db	05Dh,0CAh,002h,000h; ovr_1ba0_518b:1B88
X001_01	label	far
		db	055h,08Bh,0ECh,08Ah,046h,006h,0B4h,000h,0D1h; ovr_1ba0_518b:1B96
		db	0E0h,0C4h,01Eh,01Ch,064h,003h,0D8h,026h,08Bh,007h,05Dh,0CAh,002h,000h	; ovr_1ba0_518b:1BA4
X001_16	label	far
		db	055h,08Bh,0ECh,0FFh,076h,006h,09Ah
		dw	06Bh
		dw	seg CO02C_TEXT
		db	08Eh,006h,010h; ovr_1ba0_518b:1BB2
		db	064h,08Bh,0D8h,026h,08Bh,047h,004h,05Dh,0CAh,002h,000h; raw:1BC0
X001_00	label	far
		db	055h,08Bh,0ECh; ovr_1ba0_518b:1BC0
		db	056h,057h,08Bh,07Eh,008h,01Eh,057h,033h,0C0h,050h,09Ah
		dw	020h
		dw	seg CO02F_TEXT
		db	050h,0FFh,036h,0DCh,063h,09Ah
		dw	07Fh
		dw	seg CO02C_TEXT
		db	08Bh,0F0h,00Bh; ovr_1ba0_518b:1BCE
		db	0F6h,074h,00Bh,08Eh,006h,010h,064h,026h,080h,04Ch,006h,004h,0EBh,049h	; ovr_1ba0_518b:1BEA
		db	01Eh,057h,0FFh,036h,0DAh,063h,033h,0C0h,050h,050h,09Ah
		dw	09Dh
		dw	seg CO02C_TEXT
		db	08Bh,0F0h,08Eh,006h,010h,064h,026h,080h,04Ch,006h,004h,083h,07Eh; ovr_1ba0_518b:1BF8
		db	006h,000h,074h,007h,026h,080h,04Ch,006h,040h,0EBh,009h,08Eh,006h,010h	; ovr_1ba0_518b:1C14
		db	064h,026h,080h,064h,006h,0BFh,080h,03Eh,0A0h,062h,000h,074h,00Ah,08Eh	; ovr_1ba0_518b:1C22
		db	006h,010h,064h,026h,0C7h,044h,011h,002h,000h,0B0h,000h,050h,09Ah
		dw	0D4h
		dw	seg CO02C_TEXT
		db	056h,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	05Fh,05Eh,05Dh,0CAh,004h; ovr_1ba0_518b:1C30
		db	000h; raw:1C4C
X001_12	label	far
		db	055h,08Bh,0ECh,0FFh,036h,0A4h,063h,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	03Bh; ovr_1ba0_518b:1C4C
		db	046h,006h,075h,005h,0B8h,001h,000h,0EBh,002h,033h,0C0h,05Dh,0CAh,002h	; ovr_1ba0_518b:1C5A
		db	000h; raw:1C68
X001_0A	label	far
		db	055h,08Bh,0ECh,0FFh,036h,0A4h,063h,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	05Dh; ovr_1ba0_518b:1C68
		db	0CBh; raw:1C76
X001_11	label	far
		db	055h,08Bh,0ECh,083h,0ECh,006h,056h,057h,08Bh,076h,006h,08Eh,006h; ovr_1ba0_518b:1C76
		db	09Ah,063h,026h,08Bh,01Ch,0F6h,087h,0CAh,009h,014h,074h,004h,026h,08Bh	; ovr_1ba0_518b:1C84
		db	074h,007h,08Eh,006h,09Ah,063h,026h,0F6h,044h,00Ch,008h,074h,005h,0B8h	; ovr_1ba0_518b:1C92
		db	0FFh,07Fh,0EBh,063h,033h,0FFh,08Eh,006h,09Ah,063h,026h,08Bh,044h,009h	; ovr_1ba0_518b:1CA0
		db	089h,046h,0FEh,0EBh,00Eh,08Eh,006h,028h,064h,08Bh,05Eh,0FEh,026h,08Bh	; ovr_1ba0_518b:1CAE
		db	007h,089h,046h,0FEh,047h,083h,07Eh,0FEh,000h,075h,0ECh,08Eh,006h,09Ah	; ovr_1ba0_518b:1CBC
		db	063h,026h,08Bh,044h,007h,089h,046h,0FCh,0FFh,076h,0FCh,09Ah
		dw	02Fh
		dw	seg CO00A_TEXT
		db	089h,046h,0FAh,08Eh,006h,09Ah,063h,08Bh,05Eh,0FCh,026h,08Bh; ovr_1ba0_518b:1CCA
		db	01Fh,0F6h,087h,0CAh,009h,040h,074h,017h,083h,07Eh,0FAh,004h,077h,010h	; ovr_1ba0_518b:1CE6
		db	083h,07Eh,0FAh,003h,074h,00Ah,08Bh,05Eh,0FCh,026h,0F6h,047h,002h,004h	; ovr_1ba0_518b:1CF4
		db	074h,001h,047h,08Bh,0C7h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h; raw:1D02
X001_18	label	far
		db	055h; ovr_1ba0_518b:1D02
		db	08Bh,0ECh,04Ch,04Ch,056h,057h,08Bh,07Eh,008h,0C7h,046h,0FEh,000h,000h	; ovr_1ba0_518b:1D10
		db	0B8h,01Bh,000h,050h,057h,09Ah
		dw	02Fh
		dw	seg CO023_TEXT
		db	08Bh,0F0h,08Eh,006h; ovr_1ba0_518b:1D1E
		db	086h,081h,026h,0C6h,044h,006h,000h,026h,0C6h,044h,007h,000h,026h,083h	; ovr_1ba0_518b:1D2C
		db	03Dh,001h,075h,013h,026h,0FFh,075h,00Ah,09Ah
		dw	089h
		dw	seg CO02C_TEXT
		db	0A9h; ovr_1ba0_518b:1D3A
		db	010h,000h,074h,005h,0C7h,046h,0FEh,00Fh,000h,0FFh,076h,00Ah,083h,07Eh	; ovr_1ba0_518b:1D48
		db	006h,000h,074h,005h,0B8h,010h,000h,0EBh,003h,08Bh,046h,0FEh,050h,0B0h	; ovr_1ba0_518b:1D56
		db	000h,050h,09Ah
		dw	025h
		dw	seg CO00A_TEXT
		db	08Eh,006h,086h,081h,026h,089h,044h; ovr_1ba0_518b:1D64
		db	008h,026h,083h,03Dh,005h,074h,00Ch,026h,083h,03Dh,004h,074h,006h,026h	; ovr_1ba0_518b:1D72
		db	083h,03Dh,007h,075h,01Fh,080h,03Eh,0D2h,077h,000h,075h,018h,080h,03Eh	; ovr_1ba0_518b:1D80
		db	013h,017h,000h,074h,011h,08Eh,006h,086h,081h,026h,08Bh,05Ch,008h,08Eh	; ovr_1ba0_518b:1D8E
		db	006h,09Ah,063h,026h,0C6h,047h,00Dh,003h,08Eh,006h,086h,081h,026h,0FFh	; ovr_1ba0_518b:1D9C
		db	074h,008h,0FFh,01Eh,05Ch,081h,0B4h,000h,08Eh,006h,086h,081h,026h,089h	; ovr_1ba0_518b:1DAA
		db	044h,002h,08Bh,0C6h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,006h,000h; raw:1DB8
X001_02	label	far
		db	055h,08Bh; ovr_1ba0_518b:1DB8
		db	0ECh,0FFh,076h,006h,09Ah
		dw	0C0h
		dw	seg CO023_TEXT
		db	050h,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	05Dh,0CAh,002h,000h; ovr_1ba0_518b:1DC6
X001_03	label	far
		db	055h,08Bh,0ECh,08Bh,046h,006h,05Dh,0CAh,002h; ovr_1ba0_518b:1DD4
		db	000h	; ovr_1ba0_518b:1DE2

CO001_TEXT	ends
; END C76UNIT
		end
