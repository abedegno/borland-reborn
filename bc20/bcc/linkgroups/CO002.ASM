; Recovered FBOV far-pointer references
CO003_TEXT	segment byte public 'CODE'
CO003_TEXT	ends
CO00A_TEXT	segment byte public 'CODE'
CO00A_TEXT	ends
CO023_TEXT	segment byte public 'CODE'
CO023_TEXT	ends
CO029_TEXT	segment byte public 'CODE'
CO029_TEXT	ends
CO02A_TEXT	segment byte public 'CODE'
CO02A_TEXT	ends
CO02C_TEXT	segment byte public 'CODE'
CO02C_TEXT	ends
CO043_TEXT	segment byte public 'CODE'
CO043_TEXT	ends
CO057_TEXT	segment byte public 'CODE'
CO057_TEXT	ends
CO060_TEXT	segment byte public 'CODE'
CO060_TEXT	ends
CO064_TEXT	segment byte public 'CODE'
CO064_TEXT	ends
CO072_TEXT	segment byte public 'CODE'
CO072_TEXT	ends
		public	X002_0C
		public	X002_0A
		public	X002_0B
		public	X002_0E
		public	X002_0D
		public	X002_0F
		public	X002_01
		public	X002_00
		public	X002_03
		public	X002_02
		public	X002_05
		public	X002_04
		public	X002_07
		public	X002_06
		public	X002_09
		public	X002_08
		public	X002_11
		public	X002_10
		public	X002_13
		public	X002_12
		public	X002_15
		public	X002_14
		public	X002_17
		public	X002_16
		public	X002_18
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1baa_51df
; BEGIN C77UNIT (gap ovr_1baa_51df:1DF0)
CO002_TEXT	segment byte public 'CODE'
		assume	cs:CO002_TEXT
; Original-image layout stub: not recovered source


X002_04	label	far
		db	055h,08Bh,0ECh,080h,03Eh,0AEh,063h,000h,074h,007h,09Ah
		dw	039h
		dw	seg CO057_TEXT
		db	0EBh,002h,033h,0C0h,05Dh,0CBh; ovr_1baa_51df:1DF0
X002_0F	label	far
		db	055h,08Bh,0ECh,04Ch,04Ch,056h,057h; ovr_1baa_51df:1DFE
		db	080h,03Eh,0AEh,063h,000h,075h,003h,0E9h,088h,000h,08Bh,01Eh,0DCh,05Eh	; ovr_1baa_51df:1E0C
		db	08Eh,006h,010h,064h,026h,08Bh,077h,004h,0FFh,036h,0DCh,05Eh,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	089h,046h,0FEh,080h,03Eh,063h,017h,003h,075h,024h,0FFh; ovr_1baa_51df:1E1A
		db	076h,0FEh,0FFh,01Eh,034h,081h,08Bh,0F8h,083h,0FFh,0FFh,074h,016h,03Bh	; ovr_1baa_51df:1E36
		db	03Eh,064h,086h,074h,010h,089h,03Eh,064h,086h,0FFh,036h,024h,05Fh,09Ah	; ovr_1baa_51df:1E44
		dw	025h
		dw	seg CO064_TEXT
		db	0A3h,024h,05Fh,0FFh,076h,0FEh,08Eh,006h,09Ah,063h; ovr_1baa_51df:1E52
		db	026h,0FFh,074h,007h,026h,0FFh,074h,009h,026h,08Ah,044h,00Bh,050h,026h	; ovr_1baa_51df:1E60
		db	08Ah,044h,00Ch,050h,0FFh,036h,064h,086h,0FFh,036h,024h,05Fh,0FFh,036h	; ovr_1baa_51df:1E6E
		db	022h,05Fh,0FFh,036h,020h,05Fh,0FFh,036h,01Eh,05Fh,09Ah
		dw	020h
		dw	seg CO057_TEXT
		db	0A3h,00Eh,05Fh,01Eh,0B8h,074h,082h,050h,0B8h,064h,000h,050h,09Ah; ovr_1baa_51df:1E7C
		dw	02Ah
		dw	seg CO043_TEXT
		db	0EBh,006h,0C7h,006h,00Eh,05Fh,000h,000h,05Fh,05Eh; ovr_1baa_51df:1E98
		db	08Bh,0E5h,05Dh,0CBh; raw:1EA6
X002_0C	label	far
		db	055h,08Bh,0ECh,080h,03Eh,0AEh,063h,000h,074h,011h; ovr_1baa_51df:1EA6
		db	0FFh,036h,00Eh,05Fh,0FFh,036h,085h,063h,0FFh,036h,087h,063h,09Ah
		dw	07Fh
		dw	seg CO057_TEXT
		db	05Dh,0CBh; ovr_1baa_51df:1EB4
X002_00	label	far
		db	055h,08Bh,0ECh,080h,03Eh,0AEh,063h,000h,074h; ovr_1baa_51df:1EC2
		db	037h,0FFh,036h,098h,063h,08Eh,006h,02Ah,078h,08Bh,01Eh,098h,063h,026h	; ovr_1baa_51df:1ED0
		db	08Bh,01Fh,026h,0FFh,077h,008h,09Ah
		dw	07Ah
		dw	seg CO057_TEXT
		db	08Bh,01Eh,098h; ovr_1baa_51df:1EDE
		db	063h,08Eh,006h,02Ah,078h,026h,089h,047h,008h,0FFh,036h,00Eh,05Fh,026h	; ovr_1baa_51df:1EEC
		db	0FFh,077h,008h,0FFh,036h,0E6h,05Eh,09Ah
		dw	043h
		dw	seg CO057_TEXT
		db	0EBh,00Eh; ovr_1baa_51df:1EFA
		db	08Bh,01Eh,098h,063h,08Eh,006h,02Ah,078h,026h,0C7h,047h,008h,000h,000h	; ovr_1baa_51df:1F08
		db	05Dh,0CBh; raw:1F16
X002_0D	label	far
		db	055h,08Bh,0ECh,080h,03Eh,0AEh,063h,000h,074h,01Fh,0FFh,036h; ovr_1baa_51df:1F16
		db	00Eh,05Fh,08Bh,01Eh,098h,063h,08Eh,006h,02Ah,078h,026h,0FFh,077h,008h	; ovr_1baa_51df:1F24
		db	09Ah
		dw	06Bh
		dw	seg CO057_TEXT
		db	050h,0FFh,036h,0E6h,05Eh,09Ah
		dw	043h
		dw	seg CO057_TEXT
		db	05Dh,0CBh; ovr_1baa_51df:1F32
X002_06	label	far
		db	055h,08Bh,0ECh,056h,080h,03Eh,0AEh,063h,000h,074h,02Eh; ovr_1baa_51df:1F40
		db	0FFh,076h,00Ch,09Ah
		dw	020h
		dw	seg CO029_TEXT
		db	050h,0FFh,076h,006h,0FFh,076h; ovr_1baa_51df:1F4E
		db	008h,0FFh,036h,085h,063h,0FFh,036h,087h,063h,09Ah
		dw	070h
		dw	seg CO057_TEXT
		db	08Bh,0F0h,0FFh,036h,00Eh,05Fh,056h,0FFh,036h,0E6h,05Eh,09Ah
		dw	043h
		dw	seg CO057_TEXT
		db	0EBh,007h,09Ah
		dw	070h
		dw	seg CO023_TEXT
		db	033h,0F6h,08Bh,0C6h,05Eh; ovr_1baa_51df:1F6A
		db	05Dh,0CAh,008h,000h; raw:1F86
X002_07	label	far
		db	055h,08Bh,0ECh,080h,03Eh,0AEh,063h,000h,074h,00Eh; ovr_1baa_51df:1F86
		db	0FFh,076h,00Ah,0FFh,076h,008h,0FFh,076h,006h,09Ah
		dw	066h
		dw	seg CO057_TEXT
		db	05Dh,0CAh,006h,000h; raw:1FA2
X002_11	label	far
		db	055h,08Bh,0ECh,04Ch,04Ch,080h,03Eh,0AEh,063h,000h; ovr_1baa_51df:1FA2
		db	074h,037h,033h,0C0h,050h,0FFh,076h,00Eh,09Ah
		dw	020h
		dw	seg CO029_TEXT
		db	050h; ovr_1baa_51df:1FB0
		db	0FFh,076h,00Ch,0FFh,076h,006h,0FFh,076h,008h,0FFh,036h,085h,063h,0FFh	; ovr_1baa_51df:1FBE
		db	036h,087h,063h,09Ah
		dw	048h
		dw	seg CO057_TEXT
		db	089h,046h,0FEh,0FFh,036h,00Eh; ovr_1baa_51df:1FCC
		db	05Fh,0FFh,076h,0FEh,0FFh,036h,0E6h,05Eh,09Ah
		dw	043h
		dw	seg CO057_TEXT
		db	0EBh; ovr_1baa_51df:1FDA
		db	005h,09Ah
		dw	070h
		dw	seg CO023_TEXT
		db	08Bh,0E5h,05Dh,0CAh,00Ah,000h; raw:1FE8
X002_13	label	far
		db	055h,08Bh; ovr_1baa_51df:1FE8
		db	0ECh,056h,057h,08Bh,076h,00Ch,080h,03Eh,0AEh,063h,000h,074h,03Eh,0FFh	; ovr_1baa_51df:1FF6
		db	076h,00Eh,09Ah
		dw	020h
		dw	seg CO029_TEXT
		db	08Bh,0F8h,083h,07Eh,008h,000h,074h; ovr_1baa_51df:2004
		db	01Bh,0B8h,001h,000h,050h,057h,056h,0FFh,076h,006h,0FFh,076h,008h,0FFh	; ovr_1baa_51df:2012
		db	036h,085h,063h,0FFh,036h,087h,063h,09Ah
		dw	048h
		dw	seg CO057_TEXT
		db	0EBh,011h; ovr_1baa_51df:2020
		db	0B8h,001h,000h,050h,057h,056h,033h,0C0h,050h,050h,050h,050h,09Ah
		dw	048h
		dw	seg CO057_TEXT
		db	0EBh,007h,09Ah
		dw	070h
		dw	seg CO023_TEXT
		db	033h,0C0h,05Fh,05Eh; ovr_1baa_51df:202E
		db	05Dh,0CAh,00Ah,000h; raw:204A
X002_10	label	far
		db	055h,08Bh,0ECh,04Ch,04Ch,080h,03Eh,0AEh,063h,000h; ovr_1baa_51df:204A
		db	074h,038h,0B8h,001h,000h,050h,0FFh,076h,00Eh,09Ah
		dw	020h
		dw	seg CO029_TEXT
		db	050h,0FFh,076h,00Ch,0FFh,076h,006h,0FFh,076h,008h,0FFh,036h,085h,063h	; ovr_1baa_51df:2066
		db	0FFh,036h,087h,063h,09Ah
		dw	048h
		dw	seg CO057_TEXT
		db	089h,046h,0FEh,0FFh,036h; ovr_1baa_51df:2074
		db	00Eh,05Fh,0FFh,076h,0FEh,0FFh,036h,0E6h,05Eh,09Ah
		dw	043h
		dw	seg CO057_TEXT
		db	0EBh,005h,09Ah
		dw	070h
		dw	seg CO023_TEXT
		db	08Bh,0E5h,05Dh,0CAh,00Ah,000h; raw:2090
X002_09	label	far
		db	055h; ovr_1baa_51df:2090
		db	08Bh,0ECh,04Ch,04Ch,080h,03Eh,0AEh,063h,000h,074h,027h,0FFh,076h,00Ch	; ovr_1baa_51df:209E
		db	0FFh,076h,006h,0FFh,076h,008h,0FFh,076h,006h,0FFh,076h,008h,09Ah
		dw	034h
		dw	seg CO057_TEXT
		db	089h,046h,0FEh,0FFh,036h,00Eh,05Fh,0FFh,076h,0FEh,0FFh; ovr_1baa_51df:20AC
		db	036h,0E6h,05Eh,09Ah
		dw	043h
		dw	seg CO057_TEXT
		db	08Bh,0E5h,05Dh,0CAh,008h,000h; ovr_1baa_51df:20C8
X002_0E	label	far
		db	055h,08Bh,0ECh,056h,057h,08Bh,076h,00Ch,080h,03Eh,0AEh,063h,000h,074h; ovr_1baa_51df:20D6
		db	036h,00Bh,0F6h,074h,032h,056h,09Ah
		dw	020h
		dw	seg CO029_TEXT
		db	08Bh,0F8h,083h; ovr_1baa_51df:20E4
		db	07Eh,008h,000h,074h,016h,057h,0FFh,076h,006h,0FFh,076h,008h,0FFh,036h	; ovr_1baa_51df:20F2
		db	085h,063h,0FFh,036h,087h,063h,09Ah
		dw	075h
		dw	seg CO057_TEXT
		db	0EBh,00Ch,057h; ovr_1baa_51df:2100
		db	033h,0C0h,050h,050h,050h,050h,09Ah
		dw	075h
		dw	seg CO057_TEXT
		db	0EBh,007h,09Ah; ovr_1baa_51df:210E
		dw	070h
		dw	seg CO023_TEXT
		db	033h,0C0h,05Fh,05Eh,05Dh,0CAh,008h,000h; raw:211C
X002_0B	label	far
		db	055h,08Bh; ovr_1baa_51df:211C
		db	0ECh,04Ch,04Ch,056h,08Bh,076h,00Ch,080h,03Eh,0AEh,063h,000h,074h,033h	; ovr_1baa_51df:212A
		db	00Bh,0F6h,074h,02Fh,056h,09Ah
		dw	020h
		dw	seg CO029_TEXT
		db	050h,0FFh,076h,006h; ovr_1baa_51df:2138
		db	0FFh,076h,008h,0FFh,036h,085h,063h,0FFh,036h,087h,063h,09Ah
		dw	075h
		dw	seg CO057_TEXT
		db	089h,046h,0FEh,0FFh,036h,00Eh,05Fh,0FFh,076h,0FEh,0FFh,036h; ovr_1baa_51df:2146
		db	0E6h,05Eh,09Ah
		dw	043h
		dw	seg CO057_TEXT
		db	0EBh,005h,09Ah
		dw	070h
		dw	seg CO023_TEXT
		db	05Eh,08Bh,0E5h,05Dh,0CAh,008h,000h; raw:2170
X002_01	label	far
		db	055h,08Bh,0ECh,080h,03Eh,0AEh,063h; ovr_1baa_51df:2170
		db	000h,074h,00Fh,0FFh,076h,006h,0FFh,076h,008h,0FFh,036h,0E6h,05Eh,09Ah	; ovr_1baa_51df:217E
		dw	057h
		dw	seg CO057_TEXT
		db	05Dh,0CAh,004h,000h; raw:218C
X002_17	label	far
		db	055h,08Bh,0ECh,056h,057h,08Bh; ovr_1baa_51df:218C
		db	076h,00Ch,056h,0FFh,036h,09Eh,062h,09Ah
		dw	020h
		dw	seg CO003_TEXT
		db	050h,0B0h; ovr_1baa_51df:219A
		db	000h,050h,09Ah
		dw	061h
		dw	seg CO02A_TEXT
		db	08Bh,0F0h,080h,03Eh,0AEh,063h,000h; ovr_1baa_51df:21A8
		db	074h,032h,056h,09Ah
		dw	020h
		dw	seg CO029_TEXT
		db	08Bh,0F8h,083h,07Eh,008h,000h; ovr_1baa_51df:21B6
		db	074h,016h,057h,0FFh,076h,006h,0FFh,076h,008h,0FFh,036h,085h,063h,0FFh	; ovr_1baa_51df:21C4
		db	036h,087h,063h,09Ah
		dw	05Ch
		dw	seg CO057_TEXT
		db	0EBh,00Ch,057h,033h,0C0h,050h; ovr_1baa_51df:21D2
		db	050h,050h,050h,09Ah
		dw	05Ch
		dw	seg CO057_TEXT
		db	0EBh,002h,033h,0C0h,05Fh,05Eh; ovr_1baa_51df:21E0
		db	05Dh,0CAh,008h,000h; raw:21EE
X002_15	label	far
		db	055h,08Bh,0ECh,04Ch,04Ch,080h,03Eh,0AEh,063h,000h; ovr_1baa_51df:21EE
		db	074h,031h,0FFh,076h,00Ch,09Ah
		dw	020h
		dw	seg CO029_TEXT
		db	050h,0FFh,076h,006h; ovr_1baa_51df:21FC
		db	0FFh,076h,008h,0FFh,036h,085h,063h,0FFh,036h,087h,063h,09Ah
		dw	05Ch
		dw	seg CO057_TEXT
		db	089h,046h,0FEh,0FFh,036h,00Eh,05Fh,0FFh,076h,0FEh,0FFh,036h; ovr_1baa_51df:220A
		db	0E6h,05Eh,09Ah
		dw	043h
		dw	seg CO057_TEXT
		db	0EBh,005h,09Ah
		dw	070h
		dw	seg CO023_TEXT
		db	08Bh,0E5h,05Dh,0CAh,008h,000h; raw:2234
X002_05	label	far
		db	055h,08Bh,0ECh,056h,08Bh,076h,006h,080h; ovr_1baa_51df:2234
		db	03Eh,0AEh,063h,000h,074h,012h,00Bh,0F6h,074h,00Eh,0FFh,036h,00Eh,05Fh	; ovr_1baa_51df:2242
		db	056h,0FFh,036h,0E6h,05Eh,09Ah
		dw	043h
		dw	seg CO057_TEXT
		db	05Eh,05Dh,0CAh,002h; ovr_1baa_51df:2250
		db	000h; raw:225E
X002_18	label	far
		db	055h,08Bh,0ECh,056h,08Bh,076h,006h,080h,03Eh,0AEh,063h,000h,074h; ovr_1baa_51df:225E
		db	014h,0FFh,036h,00Eh,05Fh,056h,0FFh,036h,0E6h,05Eh,09Ah
		dw	043h
		dw	seg CO057_TEXT
		db	056h,09Ah
		dw	052h
		dw	seg CO057_TEXT
		db	05Eh,05Dh,0CAh,002h,000h; ovr_1baa_51df:226C
X002_16	label	far
		db	055h,08Bh; ovr_1baa_51df:227A
		db	0ECh,04Ch,04Ch,056h,08Bh,076h,006h,056h,0FFh,036h,09Eh,062h,09Ah
		dw	020h
		dw	seg CO003_TEXT
		db	050h,0B0h,001h,050h,09Ah
		dw	061h
		dw	seg CO02A_TEXT
		db	08Bh,0F0h; ovr_1baa_51df:2288
		db	080h,03Eh,0AEh,063h,000h,074h,035h,00Bh,0F6h,074h,031h,08Eh,006h,086h	; ovr_1baa_51df:22A4
		db	081h,026h,083h,03Ch,000h,074h,027h,056h,09Ah
		dw	020h
		dw	seg CO029_TEXT
		db	050h; ovr_1baa_51df:22B2
		db	033h,0C0h,050h,050h,050h,050h,09Ah
		dw	075h
		dw	seg CO057_TEXT
		db	089h,046h,0FEh; ovr_1baa_51df:22C0
		db	0FFh,036h,00Eh,05Fh,0FFh,076h,0FEh,0FFh,036h,0E6h,05Eh,09Ah
		dw	043h
		dw	seg CO057_TEXT
		db	0EBh,005h,09Ah
		dw	070h
		dw	seg CO023_TEXT
		db	05Eh,08Bh,0E5h,05Dh,0CAh; ovr_1baa_51df:22CE
		db	002h,000h; raw:22EA
X002_03	label	far
		db	055h,08Bh,0ECh,056h,057h,08Bh,076h,006h,056h,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	08Bh,0F8h,057h,080h,03Eh,0AEh,063h,000h,074h,027h,057h,08Eh; ovr_1baa_51df:22EA
		db	006h,010h,064h,026h,08Bh,05Ch,004h,08Eh,006h,09Ah,063h,026h,08Ah,007h	; ovr_1baa_51df:2306
		db	050h,08Bh,0DFh,081h,0E3h,0FEh,0FFh,08Eh,006h,08Ah,062h,026h,08Ah,047h	; ovr_1baa_51df:2314
		db	008h,050h,09Ah
		dw	02Ah
		dw	seg CO060_TEXT
		db	0EBh,002h,033h,0C0h,050h,0FFh,01Eh; ovr_1baa_51df:2322
		db	048h,081h,05Fh,05Eh,05Dh,0CAh,002h,000h; raw:2330
X002_14	label	far
		db	055h,08Bh,0ECh,04Ch,04Ch,056h; ovr_1baa_51df:2330
		db	057h,08Bh,076h,006h,080h,03Eh,0AEh,063h,000h,074h,047h,056h,09Ah
		dw	066h
		dw	seg CO02C_TEXT
		db	089h,046h,0FEh,0FFh,076h,0FEh,0FFh,01Eh,034h,081h,050h; ovr_1baa_51df:233E
		db	0FFh,01Eh,0D8h,087h,08Bh,0F8h,08Eh,006h,010h,064h,026h,0FFh,074h,004h	; ovr_1baa_51df:235A
		db	09Ah
		dw	02Fh
		dw	seg CO00A_TEXT
		db	00Bh,0D2h,07Ch,016h,07Fh,005h,03Dh,001h,000h; ovr_1baa_51df:2368
		db	076h,00Fh,080h,03Eh,0F2h,016h,000h,074h,008h,0B8h,002h,000h,050h,0FFh	; ovr_1baa_51df:2376
		db	01Eh,0D4h,087h,0FFh,076h,0FEh,0FFh,01Eh,0D0h,087h,0EBh,002h,033h,0FFh	; ovr_1baa_51df:2384
		db	08Bh,0C7h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h; raw:2392
X002_0A	label	far
		db	055h,08Bh,0ECh,080h; ovr_1baa_51df:2392
		db	03Eh,0AEh,063h,000h,074h,007h,0FFh,076h,006h,0FFh,01Eh,0D8h,087h,05Dh	; ovr_1baa_51df:23A0
		db	0CAh,002h,000h; raw:23AE
X002_02	label	far
		db	055h,08Bh,0ECh,056h,080h,03Eh,0AEh,063h,000h,074h,011h; ovr_1baa_51df:23AE
		db	033h,0F6h,0EBh,008h,0B0h,000h,050h,0FFh,01Eh,0E0h,087h,046h,03Bh,076h	; ovr_1baa_51df:23BC
		db	006h,072h,0F3h,05Eh,05Dh,0CAh,002h,000h; raw:23CA
X002_08	label	far
		db	055h,08Bh,0ECh,056h,08Bh,076h; ovr_1baa_51df:23CA
		db	006h,080h,03Eh,0AEh,063h,000h,074h,015h,00Bh,0F6h,074h,011h,056h,09Ah	; ovr_1baa_51df:23D8
		dw	020h
		dw	seg CO029_TEXT
		db	050h,033h,0C0h,050h,09Ah
		dw	020h
		dw	seg CO072_TEXT
		db	0EBh; ovr_1baa_51df:23E6
		db	005h,09Ah
		dw	070h
		dw	seg CO023_TEXT
		db	05Eh,05Dh,0CAh,002h,000h; raw:23F4
X002_12	label	far
		db	055h,08Bh,0ECh; ovr_1baa_51df:23F4
		db	080h,03Eh,0AEh,063h,000h,074h,00Ah,08Ah,046h,006h,050h,0FFh,01Eh,0E0h	; ovr_1baa_51df:2402
		db	087h,0EBh,005h,09Ah
		dw	070h
		dw	seg CO023_TEXT
		db	05Dh,0CAh,002h,000h; ovr_1baa_51df:2410

CO002_TEXT	ends
; END C77UNIT
		end
