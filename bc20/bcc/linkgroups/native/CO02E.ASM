; Recovered FBOV far-pointer references
   	     extrn   BCC_COMPARE_NAME:far
   	     extrn   BCC_COPY_WORDS:far
   	     extrn   BCC_DEBUG_BUILD:far
   	     extrn   BCC_DIAGNOSTIC:far
   	     extrn   BCC_FAR_245C:far
   	     extrn   BCC_FAR_AB12:far
   	     extrn   BCC_FAR_B146:far
   	     extrn   BCC_RF_15C5_010D:far
   	     extrn   BCC_RF_1A47_0039:far
   	     extrn   BCC_RF_1AAA_0008:far
   	     extrn   BCC_SEG_15:far
CO01F_TEXT	     segment byte public 'CODE'
CO01F_TEXT	     ends
CO032_TEXT	     segment byte public 'CODE'
CO032_TEXT	     ends
CO033_TEXT	     segment byte public 'CODE'
CO033_TEXT	     ends
CO034_TEXT	     segment byte public 'CODE'
CO034_TEXT	     ends
CO043_TEXT	     segment byte public 'CODE'
CO043_TEXT	     ends
CO044_TEXT	     segment byte public 'CODE'
CO044_TEXT	     ends
CO045_TEXT	     segment byte public 'CODE'
CO045_TEXT	     ends
CO051_TEXT	     segment byte public 'CODE'
CO051_TEXT	     ends
CO067_TEXT	     segment byte public 'CODE'
CO067_TEXT	     ends
CO068_TEXT	     segment byte public 'CODE'
CO068_TEXT	     ends
CO069_TEXT	     segment byte public 'CODE'
CO069_TEXT	     ends
   	     public  X02E_0A
   	     public  X02E_03
   	     public  X02E_08
   	     public  X02E_09
   	     public  X02E_02
   	     public  X02E_00
   	     public  X02E_01
   	     public  X02E_06
   	     public  X02E_07
   	     public  X02E_04
   	     public  X02E_05
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
   	     extrn   BCC_INCLUDE_PATHS:dword
   	     extrn   BCC_LIBRARY_PATHS:dword
   	     extrn   BCC_INCLUDE_PATH:dword
   	     extrn   BCC_STRING_DATA:byte
DGROUP  group   _DATA,_BSS

; Consolidated original-order group ovr_1c87_7b96
; BEGIN LG08D (gap	ovr_1c87_7b96:B960)
CO02E_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO02E_TEXT
; Original-image layout stub: not recovered source


X02E_08 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,052h,056h,057h,0FFh,076h,008h,0FFh,076h,006h; ovr_1c87_7b96:B960
   	     db	     033h,0C0h,033h,0D2h,050h,052h,050h,052h,050h,052h,01Eh,0B8h,09Eh,067h  ; ovr_1c87_7b96:B96E
   	     db	     050h,09Ah
   	     dw	     039h
   	     dw	     seg BCC_RF_1A47_0039
   	     db	     0F6h,006h,062h,017h,001h,075h,013h,01Eh; ovr_1c87_7b96:B97C

   	     db	     0B8h,09Eh,067h,050h,01Eh,0B8h,014h,01Fh,050h,09Ah

   	     dw	     08h
   	     dw	     seg BCC_RF_1AAA_0008
   	     db	     00Bh,0C0h,075h,005h,0BFh,001h,000h,0EBh,002h,033h,0FFh,09Ah

   	     dw	     0F1h
   	     dw	     seg BCC_RF_15C5_010D
   	     db	     09Ah
   	     dw	     02BD3h
   	     dw	     seg BCC_FAR_245C
   	     db	     098h,0A3h,026h,078h,0B8h,09Eh,081h; ovr_1c87_7b96:B998
   	     db	     01Eh,050h,0B8h,0EEh,016h,01Eh,050h,0B9h,090h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     0A0h,076h,017h,008h,006h,012h,017h,09Ah

   	     dw	     02BC4h
   	     dw	     seg BCC_FAR_245C
   	     db	     0B4h; ovr_1c87_7b96:B9B4
   	     db	     000h,089h,046h,0FEh,01Eh,0B8h,08Eh,078h,050h,09Ah

   	     dw	     04E0Bh
   	     dw	     seg BCC_FAR_245C
   	     db	     08Bh,0F0h,00Bh,0F6h,075h,003h,0E9h,0ACh,000h,083h,03Eh,084h,082h,000h  ; ovr_1c87_7b96:B9DE
   	     db	     074h,00Dh,0B8h,001h,000h,050h,09Ah
   	     dw	     034h
   	     dw	     seg CO032_TEXT
   	     db	     00Bh,0C0h,075h; ovr_1c87_7b96:B9EC
   	     db	     0F3h,083h,0FEh,002h,074h,005h,083h,0FEh,004h,075h,01Eh,0B8h,001h,000h  ; ovr_1c87_7b96:B9FA
   	     db	     050h,0FFh,01Eh,0DCh,080h,09Ah
   	     dw	     0FCh
   	     dw	     seg BCC_RF_15C5_010D
   	     db	     083h,0FEh,002h,075h; ovr_1c87_7b96:BA08
   	     db	     006h,0BEh,002h,000h,0E9h,041h,001h,0BEh,003h,000h,0E9h,03Bh,001h,0B8h  ; ovr_1c87_7b96:BA16
   	     db	     001h,000h,050h,0FFh,01Eh,0DCh,080h,0B0h,001h,0A2h,015h,017h,0A2h,014h  ; ovr_1c87_7b96:BA24
   	     db	     017h,00Bh,0FFh,074h,00Dh,0FFh,076h,008h,0FFh,076h,006h,09Ah

   	     dw	     020h
   	     dw	     seg CO01F_TEXT
   	     db	     0EBh,00Bh,0FFh,076h,008h,0FFh,076h,006h,09Ah

   	     dw	     020h
   	     dw	     seg CO045_TEXT
   	     db	     083h,03Eh,044h,086h,000h,075h,016h,0FFh,01Eh,000h,081h,016h,08Dh;	    ovr_1c87_7b96:BA32
   	     db	     046h,0AEh,050h,0FFh,036h,046h,078h,0FFh,036h,046h,086h,09Ah

   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     0FFh,036h,044h,086h,0FFh,01Eh,0DCh,080h,083h,03Eh,044h,086h;	    ovr_1c87_7b96:BA5C
   	     db	     000h,074h,002h,0EBh,09Ah,033h,0F6h,016h,08Dh,046h,0AEh,050h,0B8h,001h  ; ovr_1c87_7b96:BA78
   	     db	     000h,050h,033h,0C0h,050h,09Ah
   	     dw	     025h
   	     dw	     seg CO034_TEXT
   	     db	     0E9h,0CBh,000h,080h; ovr_1c87_7b96:BA86
   	     db	     03Eh,077h,017h,000h,075h,023h,0B8h,001h,000h,0BAh,0A0h,086h,050h,052h  ; ovr_1c87_7b96:BA94
   	     db	     09Ah
   	     dw	     01EA0h
   	     dw	     seg BCC_FAR_245C
   	     db	     083h,0FAh,001h,077h,011h,072h,005h,03Dh,0A0h; ovr_1c87_7b96:BAA2

   	     db	     086h,073h,00Ah,0B8h,006h,000h,050h,09Ah

   	     dw	     0D4h
   	     dw	     seg BCC_DIAGNOSTIC
   	     db	     059h,09Ah;	ovr_1c87_7b96:BAB0
   	     dw	     01F34h
   	     dw	     seg BCC_FAR_245C
   	     db	     0BBh,001h,000h,0B9h,0A0h,086h,02Bh,0C8h,01Bh,0DAh;	ovr_1c87_7b96:BABE

   	     db	     089h,01Eh,024h,078h,089h,00Eh,022h,078h,0A1h,09Ah,067h,0FFh,006h,09Ah  ; ovr_1c87_7b96:BACC
   	     db	     067h,00Bh,0C0h,075h,01Ah,00Bh,0FFh,074h

   	     dw	     0B809h
   	     dw	     seg CO051_TEXT
   	     dw	     0B850h
   	     dw	     seg CO068_TEXT
   	     db	     0EBh
   	     dw	     0B807h
   	     dw	     seg CO044_TEXT
   	     dw	     0B850h
   	     dw	     seg CO067_TEXT
   	     db	     050h,09Ah
   	     dw	     02883h
   	     dw	     seg BCC_FAR_245C
   	     db	     00Bh,0FFh,074h,00Dh,0FFh,076h,008h,0FFh,076h,006h,09Ah;		    ovr_1c87_7b96:BADA
   	     dw	     020h
   	     dw	     seg CO01F_TEXT
   	     db	     0EBh,00Bh,0FFh,076h,008h,0FFh,076h,006h,09Ah

   	     dw	     020h
   	     dw	     seg CO045_TEXT
   	     db	     083h,03Eh,044h,086h,000h,075h,016h,0FFh,01Eh,000h,081h;		    ovr_1c87_7b96:BB04
   	     db	     016h,08Dh,046h,0AEh,050h,0FFh,036h,046h,078h,0FFh,036h,046h,086h,09Ah  ; ovr_1c87_7b96:BB20
   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     0FFh,036h,044h,086h,0FFh,01Eh,0DCh,080h,083h,03Eh;	ovr_1c87_7b96:BB2E

   	     db	     044h,086h,000h,074h,003h,0E9h,0D3h,0FEh,033h,0F6h,080h,03Eh,015h,017h  ; ovr_1c87_7b96:BB3C
   	     db	     000h,074h,011h,016h,08Dh,046h,0AEh,050h,0B8h,001h,000h,050h,033h,0C0h  ; ovr_1c87_7b96:BB4A
   	     db	     050h,09Ah
   	     dw	     025h
   	     dw	     seg CO034_TEXT
   	     db	     0C7h,006h,0E4h,014h,000h,000h,0B8h,0EEh; ovr_1c87_7b96:BB58

   	     db	     016h,01Eh,050h,0B8h,09Eh,081h,01Eh,050h,0B9h,090h,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     0C7h,006h,0C4h,066h,000h,000h,0C7h,006h,0D3h,077h,000h,000h;	    ovr_1c87_7b96:BB66
   	     db	     08Ah,046h,0FEh,050h,09Ah
   	     dw	     02BB0h
   	     dw	     seg BCC_FAR_245C
   	     db	     08Bh,0C6h,05Fh,05Eh,08Bh; ovr_1c87_7b96:BB82
   	     db	     0E5h,05Dh,0CAh,004h,000h; raw:BB90
X02E_09 label   far
   	     db	     055h,08Bh,0ECh,01Eh,0B8h,08Eh,078h,050h,0FFh; ovr_1c87_7b96:BB90

   	     db	     076h,006h,09Ah
   	     dw	     04E3Ch
   	     dw	     seg BCC_FAR_245C
   	     db	     05Dh,0CAh,002h,000h; raw:BB9E
X02E_06 label   far
   	     db	     055h,08Bh,0ECh; ovr_1c87_7b96:BB9E
   	     db	     056h,057h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO069_TEXT
   	     db	     083h,03Eh,0E4h,014h,002h,075h,01Dh; ovr_1c87_7b96:BBAC
   	     db	     01Eh,0B8h,050h,05Fh,050h,0FFh,036h,046h,078h,0FFh,036h,0C4h,066h,09Ah  ; ovr_1c87_7b96:BBBA
   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     01Eh,0B8h,050h,05Fh,050h,0FFh,01Eh,0CCh,087h,0EBh;	ovr_1c87_7b96:BBC8

   	     db	     061h,01Eh,0B8h,046h,078h,050h,0FFh,036h,046h,078h,0FFh,036h,0C4h,066h  ; ovr_1c87_7b96:BBD6
   	     db	     09Ah
   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     005h,003h,000h,050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F8h,08Eh,006h,046h,078h,026h,0C7h,005h,000h,000h,0FFh,036h,046h  ; ovr_1c87_7b96:BBF2
   	     db	     078h,040h,040h,050h,0FFh,036h,046h,078h,0FFh,036h,0C4h,066h,09Ah

   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     083h,03Eh,02Eh,082h,000h,075h,006h,089h,03Eh,02Eh,082h;		    ovr_1c87_7b96:BC00
   	     db	     0EBh,01Ah,08Bh,036h,02Eh,082h,0EBh,007h,08Eh,006h,046h,078h,026h,08Bh  ; ovr_1c87_7b96:BC1C
   	     db	     034h,08Eh,006h,046h,078h,026h,083h,03Ch,000h,075h,0EFh,026h,089h,03Ch  ; ovr_1c87_7b96:BC2A
   	     db	     05Fh,05Eh,05Dh,0CBh; raw:BC38
X02E_01 label   far
   	     db	     055h,08Bh,0ECh,056h,033h,0F6h,0EBh,00Fh,08Bh,0DEh;	ovr_1c87_7b96:BC38

   	     db	     0D1h,0E3h,0D1h,0E3h,08Ah,087h,0BCh,008h,088h,084h,03Ah,064h,046h,083h  ; ovr_1c87_7b96:BC46
   	     db	     0FEh,03Bh,07Eh,0ECh,05Eh,05Dh,0CBh; raw:BC54
X02E_00 label   far
   	     db	     055h,08Bh,0ECh,056h,033h,0F6h,0EBh; ovr_1c87_7b96:BC54
   	     db	     00Fh,08Bh,0DEh,0D1h,0E3h,0D1h,0E3h,08Ah,084h,03Ah,064h,088h,087h,0BCh  ; ovr_1c87_7b96:BC62
   	     db	     008h,046h,083h,0FEh,03Bh,07Eh,0ECh,05Eh,05Dh,0CBh;	raw:BC70

X02E_04 label   far
   	     db	     055h,08Bh,0ECh,056h; ovr_1c87_7b96:BC70
   	     db	     08Bh,076h,006h,0C4h,05Eh,008h,026h,080h,03Fh,049h,074h,006h,026h,080h  ; ovr_1c87_7b96:BC7E
   	     db	     03Fh,04Ch,075h,009h,00Bh,0F6h,075h,00Ch,0B8h,001h,000h,0EBh,014h,083h  ; ovr_1c87_7b96:BC8C
   	     db	     0FEh,0FFh,075h,002h,0EBh,0F4h,0B8h,07Eh,017h,050h,0FFh,076h,00Ah,0FFh  ; ovr_1c87_7b96:BC9A
   	     db	     076h,008h,0E8h,005h,000h,05Eh,05Dh,0CAh,006h,000h,045h,055h,08Bh,0ECh  ; ovr_1c87_7b96:BCA8
   	     db	     056h,057h,08Bh,076h,008h,033h,0FFh,0EBh,02Eh,08Ah,004h,0C4h,05Eh,004h  ; ovr_1c87_7b96:BCB6
   	     db	     026h,03Ah,007h,075h,021h,08Ah,044h,001h,098h,03Bh,006h,0E4h,014h,07Ch  ; ovr_1c87_7b96:BCC4
   	     db	     017h,056h,08Bh,046h,004h,040h,0FFh,076h,006h,050h,0FFh,054h,002h,00Bh  ; ovr_1c87_7b96:BCD2
   	     db	     0C0h,075h,004h,033h,0C0h,0EBh,00Eh,0BFh,001h,000h,083h,0C6h,008h,083h  ; ovr_1c87_7b96:BCE0
   	     db	     07Ch,002h,000h,075h,0CCh,08Bh,0C7h,05Fh,05Eh,05Dh,04Dh,0C2h,006h,000h  ; ovr_1c87_7b96:BCEE
   	     db	     045h,055h,08Bh,0ECh,04Ch,04Ch,056h,057h,08Bh,076h,008h,0C4h,05Eh,004h  ; ovr_1c87_7b96:BCFC
   	     db	     026h,08Ah,007h,098h,089h,046h,0FEh,0B9h,004h,000h,0BBh,005h,004h,02Eh  ; ovr_1c87_7b96:BD0A
   	     db	     08Bh,007h,03Bh,046h,0FEh,074h,006h,043h,043h,0E2h,0F4h,0EBh,032h,02Eh  ; ovr_1c87_7b96:BD18
   	     db	     0FFh,067h,008h,08Bh,05Ch,004h,0C6h,007h,000h,0EBh,028h,08Bh,05Ch,004h  ; ovr_1c87_7b96:BD26
   	     db	     0C6h,007h,001h,0EBh,020h,083h,03Eh,0E4h,014h,000h,075h,004h,033h,0C0h  ; ovr_1c87_7b96:BD34
   	     db	     0EBh,018h,08Bh,044h,004h,02Dh,0EEh,016h,08Bh,0F8h,08Bh,05Ch,004h,08Ah  ; ovr_1c87_7b96:BD42
   	     db	     007h,088h,085h,09Eh,081h,0EBh,002h,0EBh,0E7h,0B8h,001h,000h,05Fh,05Eh  ; ovr_1c87_7b96:BD50
   	     db	     08Bh,0E5h,05Dh,04Dh,0C2h,006h,000h,000h,000h,02Bh,000h,02Dh,000h,02Eh  ; ovr_1c87_7b96:BD5E
   	     db	     000h,0D1h,003h,0D1h,003h,0C9h,003h,0D9h,003h,045h,055h,08Bh,0ECh,056h  ; ovr_1c87_7b96:BD6C
   	     db	     08Bh,076h,008h,0C4h,05Eh,004h,026h,08Ah,007h,098h,00Bh,0C0h,074h,014h  ; ovr_1c87_7b96:BD7A
   	     db	     03Dh,02Bh,000h,074h,00Fh,03Dh,02Dh,000h,074h,002h,0EBh,010h,08Bh,05Ch  ; ovr_1c87_7b96:BD88
   	     db	     004h,0C6h,007h,001h,0EBh,00Ch,08Bh,05Ch,004h,0C6h,007h,000h,0EBh,004h  ; ovr_1c87_7b96:BD96
   	     db	     033h,0C0h,0EBh,003h,0B8h,001h,000h,05Eh,05Dh,04Dh,0C2h,006h,000h,045h  ; ovr_1c87_7b96:BDA4
   	     db	     055h,08Bh,0ECh,083h,0ECh,008h,056h,0C4h,05Eh,004h,026h,08Ah,007h,088h  ; ovr_1c87_7b96:BDB2
   	     db	     046h,0F9h,026h,080h,03Fh,02Dh,075h,00Ah,0C7h,046h,0FAh,000h,000h,0FFh  ; ovr_1c87_7b96:BDC0
   	     db	     046h,004h,0EBh,028h,0C4h,05Eh,004h,026h,080h,03Fh,02Eh,075h,00Eh,083h  ; ovr_1c87_7b96:BDCE
   	     db	     03Eh,0E4h,014h,000h,075h,005h,033h,0C0h,0E9h,0A9h,000h,0EBh,0E4h,0C4h  ; ovr_1c87_7b96:BDDC
   	     db	     05Eh,004h,026h,080h,03Fh,02Bh,075h,003h,0FFh,046h,004h,0C7h,046h,0FAh  ; ovr_1c87_7b96:BDEA
   	     db	     001h,000h,0C4h,05Eh,004h,026h,080h,03Fh,000h,075h,02Fh,080h,07Eh,0F9h  ; ovr_1c87_7b96:BDF8
   	     db	     02Eh,075h,006h,00Eh,0E8h,02Fh,0FEh,0EBh,07Eh,033h,0F6h,08Ch,05Eh,0FEh  ; ovr_1c87_7b96:BE06
   	     db	     0C7h,046h,0FCh,0B9h,008h,0EBh,00Ch,08Ah,046h,0FAh,088h,084h,03Ah,064h  ; ovr_1c87_7b96:BE14
   	     db	     083h,046h,0FCh,004h,046h,0C4h,05Eh,0FCh,026h,080h,03Fh,000h,075h,0EBh  ; ovr_1c87_7b96:BE22
   	     db	     0EBh,05Bh,033h,0F6h,08Ch,05Eh,0FEh,0C7h,046h,0FCh,0B9h,008h,0EBh,046h  ; ovr_1c87_7b96:BE30
   	     db	     0C4h,05Eh,004h,026h,08Ah,007h,0C4h,05Eh,0FCh,026h,03Ah,007h,075h,033h  ; ovr_1c87_7b96:BE3E
   	     db	     0C4h,05Eh,004h,026h,08Ah,047h,001h,0C4h,05Eh,0FCh,026h,03Ah,047h,001h  ; ovr_1c87_7b96:BE4C
   	     db	     075h,023h,0C4h,05Eh,004h,026h,08Ah,047h,002h,0C4h,05Eh,0FCh,026h,03Ah  ; ovr_1c87_7b96:BE5A
   	     db	     047h,002h,075h,013h,080h,07Eh,0F9h,02Eh,075h,006h,026h,08Ah,047h,003h  ; ovr_1c87_7b96:BE68
   	     db	     0EBh,003h,08Ah,046h,0FAh,088h,084h,03Ah,064h,083h,046h,0FCh,004h,046h  ; ovr_1c87_7b96:BE76
   	     db	     0C4h,05Eh,0FCh,026h,080h,03Fh,000h,075h,0B1h,0B8h,001h,000h,05Eh,08Bh  ; ovr_1c87_7b96:BE84
   	     db	     0E5h,05Dh,04Dh,0C2h,006h,000h,045h,055h,08Bh,0ECh,056h,057h,08Bh,076h  ; ovr_1c87_7b96:BE92
   	     db	     008h,083h,03Eh,0E4h,014h,000h,075h,004h,033h,0C0h,0EBh,014h,08Bh,044h  ; ovr_1c87_7b96:BEA0
   	     db	     004h,02Dh,0EEh,016h,08Bh,0F8h,08Bh,05Ch,004h,08Ah,007h,088h,085h,09Eh  ; ovr_1c87_7b96:BEAE
   	     db	     081h,0B8h,001h,000h,05Fh,05Eh,05Dh,04Dh,0C2h,006h,000h,045h,055h,08Bh  ; ovr_1c87_7b96:BEBC
   	     db	     0ECh,056h,08Bh,076h,008h,0FFh,074h,004h,0FFh,076h,006h,0FFh,076h,004h  ; ovr_1c87_7b96:BECA
   	     db	     0E8h,0D7h,0FDh,05Eh,05Dh,04Dh,0C2h,006h,000h,045h,055h,08Bh,0ECh,056h  ; ovr_1c87_7b96:BED8
   	     db	     08Bh,076h,008h,08Ah,044h,006h,08Bh,05Ch,004h,088h,007h,0B8h,001h,000h  ; ovr_1c87_7b96:BEE6
   	     db	     05Eh,05Dh,04Dh,0C2h,006h,000h,045h,055h,08Bh,0ECh,0B8h,001h,000h,05Dh  ; ovr_1c87_7b96:BEF4
   	     db	     04Dh,0C2h,006h,000h,045h,055h,08Bh,0ECh,083h,0ECh,004h,056h,08Bh,076h  ; ovr_1c87_7b96:BF02
   	     db	     008h,0FFh,076h,006h,0FFh,076h,004h,09Ah

   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     040h,050h;	ovr_1c87_7b96:BF10
   	     db	     09Ah
   	     dw	     010Dh
   	     dw	     seg BCC_RF_15C5_010D
   	     db	     089h,056h,0FEh,089h,046h,0FCh,0FFh,076h,0FEh; ovr_1c87_7b96:BF1E

   	     db	     0FFh,076h,0FCh,0FFh,076h,006h,0FFh,076h,004h,09Ah

   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     08Bh,05Ch,004h,08Bh,046h,0FEh,08Bh,056h,0FCh,089h,047h,002h,089h,017h  ; ovr_1c87_7b96:BF3A
   	     db	     0B8h,001h,000h,05Eh,08Bh,0E5h,05Dh,04Dh,0C2h,006h,000h,045h,055h,08Bh  ; ovr_1c87_7b96:BF48
   	     db	     0ECh,04Ch,04Ch,056h,08Bh,076h,008h,0C4h,05Eh,004h,026h,08Ah,007h,098h  ; ovr_1c87_7b96:BF56
   	     db	     08Bh,0D8h,08Ah,087h,081h,05Bh,098h,0A9h,002h,000h,075h,004h,033h,0C0h  ; ovr_1c87_7b96:BF64
   	     db	     0EBh,02Bh,0FFh,076h,006h,0FFh,076h,004h,09Ah

   	     dw	     09h
   	     dw	     seg BCC_SEG_15
   	     db	     089h; ovr_1c87_7b96:BF72
   	     db	     046h,0FEh,08Bh,044h,006h,03Bh,046h,0FEh,073h,002h,0EBh,0E4h,0FFh,076h  ; ovr_1c87_7b96:BF80
   	     db	     006h,0FFh,076h,004h,09Ah
   	     dw	     09h
   	     dw	     seg BCC_SEG_15
   	     db	     08Bh,05Ch,004h,088h,007h; ovr_1c87_7b96:BF8E
   	     db	     0B8h,001h,000h,05Eh,08Bh,0E5h,05Dh,04Dh,0C2h,006h,000h,045h,055h,08Bh  ; ovr_1c87_7b96:BF9C
   	     db	     0ECh,04Ch,04Ch,056h,08Bh,076h,008h,0C4h,05Eh,004h,026h,08Ah,007h,098h  ; ovr_1c87_7b96:BFAA
   	     db	     08Bh,0D8h,08Ah,087h,081h,05Bh,098h,0A9h,002h,000h,075h,004h,033h,0C0h  ; ovr_1c87_7b96:BFB8
   	     db	     0EBh,02Bh,0FFh,076h,006h,0FFh,076h,004h,09Ah

   	     dw	     09h
   	     dw	     seg BCC_SEG_15
   	     db	     089h; ovr_1c87_7b96:BFC6
   	     db	     046h,0FEh,08Bh,044h,006h,03Bh,046h,0FEh,073h,002h,0EBh,0E4h,0FFh,076h  ; ovr_1c87_7b96:BFD4
   	     db	     006h,0FFh,076h,004h,09Ah
   	     dw	     09h
   	     dw	     seg BCC_SEG_15
   	     db	     08Bh,05Ch,004h,089h,007h; ovr_1c87_7b96:BFE2
   	     db	     0B8h,001h,000h,05Eh,08Bh,0E5h,05Dh,04Dh,0C2h,006h,000h,045h,055h,08Bh  ; ovr_1c87_7b96:BFF0
   	     db	     0ECh,083h,0ECh,004h,0C4h,05Eh,004h,026h,080h,03Fh,02Dh,075h,015h,026h  ; ovr_1c87_7b96:BFFE
   	     db	     080h,07Fh,001h,000h,075h,00Eh,0C7h,006h,056h,024h,000h,000h,0C7h,006h  ; ovr_1c87_7b96:C00C
   	     db	     054h,024h,000h,000h,0EBh,073h,0FFh,076h,006h,0FFh,076h,004h,09Ah

   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     005h,005h,000h,050h,09Ah
   	     dw	     010Dh
   	     dw	     seg BCC_RF_15C5_010D
   	     db	     089h,056h;	ovr_1c87_7b96:C01A
   	     db	     0FEh,089h,046h,0FCh,0A1h,054h,024h,00Bh,006h,056h,024h,074h,013h,0C4h  ; ovr_1c87_7b96:C036
   	     db	     01Eh,058h,024h,08Bh,046h,0FEh,08Bh,056h,0FCh,026h,089h,047h,002h,026h  ; ovr_1c87_7b96:C044
   	     db	     089h,017h,0EBh,00Dh,08Bh,046h,0FEh,08Bh,056h,0FCh,0A3h,056h,024h,089h  ; ovr_1c87_7b96:C052
   	     db	     016h,054h,024h,08Bh,046h,0FEh,08Bh,056h,0FCh,0A3h,05Ah,024h,089h,016h  ; ovr_1c87_7b96:C060
   	     db	     058h,024h,0C4h,05Eh,0FCh,026h,0C7h,047h,002h,000h,000h,026h,0C7h,007h  ; ovr_1c87_7b96:C06E
   	     db	     000h,000h,08Bh,046h,0FCh,005h,004h,000h,0FFh,076h,0FEh,050h,0FFh,076h  ; ovr_1c87_7b96:C07C
   	     db	     006h,0FFh,076h,004h,09Ah
   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     0B8h,001h,000h,08Bh,0E5h; ovr_1c87_7b96:C08A
   	     db	     05Dh,04Dh,0C2h,006h,000h,045h,055h,08Bh,0ECh,056h,0C6h,006h,062h,017h  ; ovr_1c87_7b96:C098
   	     db	     001h,01Eh,0B8h,0F9h,014h,050h,01Eh,0B8h,014h,01Fh,050h,09Ah

   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     0C4h,05Eh,004h,026h,080h,03Fh,000h,075h,002h,0EBh,05Ah,0C4h;	    ovr_1c87_7b96:C0A6
   	     db	     05Eh,004h,026h,080h,03Fh,02Dh,075h,013h,0C6h,006h,062h,017h,000h,0FFh  ; ovr_1c87_7b96:C0C2
   	     db	     046h,004h,0C4h,05Eh,004h,026h,080h,03Fh,000h,075h,002h,0EBh,03Eh,0C4h  ; ovr_1c87_7b96:C0D0
   	     db	     05Eh,004h,026h,080h,03Fh,02Eh,075h,003h,0FFh,046h,004h,0BEh,0FAh,014h  ; ovr_1c87_7b96:C0DE
   	     db	     0EBh,012h,081h,0FEh,0FDh,014h,073h,009h,0C4h,05Eh,004h,026h,08Ah,007h  ; ovr_1c87_7b96:C0EC
   	     db	     088h,004h,046h,0FFh,046h,004h,0C4h,05Eh,004h,026h,080h,03Fh,000h,075h  ; ovr_1c87_7b96:C0FA
   	     db	     0E5h,08Ch,0D8h,08Ch,0DAh,03Bh,0C2h,075h,007h,081h,0FEh,0FAh,014h,075h  ; ovr_1c87_7b96:C108
   	     db	     001h,04Eh,0C6h,004h,000h,0B8h,001h,000h,05Eh,05Dh,04Dh,0C2h,006h,000h  ; ovr_1c87_7b96:C116

CO02E_TEXT	     ends
; END LG08D
; BEGIN OPTLIB (listing ovr_1c87_7b96:C124)

        extrn   MEMSET:far
        extrn   BCC_RF_1AB2_000D:far
        extrn   _CTYPE:byte
        extrn   BCC_LIBRARY_Y_MAP:byte
        extrn   BCC_LIBRARY_T_MAP:byte
   	     extrn   BCC_RD_24C4_B:byte
   	     extrn   BCC_RD_D032_B:byte
   	     extrn   BCC_RD_D62C_B:byte


CO02E_TEXT	     segment byte public 'CODE'
        assume  cs:CO02E_TEXT,ds:DGROUP

BCC_SET_OPTION_LIBRARY  proc    near
        inc     bp
        push    bp
        mov     bp,sp
        dec     sp
        dec     sp
        push    si
        les     bx,dword ptr [bp+4]
        cmp     byte ptr es:[bx],45
        je	     short M001_@@RESET_SECOND
        jmp     M001_@@LOOP_TEST
M001_@@RESET_SECOND:
        cmp     byte ptr es:[bx+1],0
        je	     short M001_@@RESET
        jmp     M001_@@LOOP_TEST
M001_@@RESET:
        push    ds
        mov     ax,offset DGROUP:BCC_RD_24C4_B
        push    ax
        xor     ax,ax
        push    ax
        mov     ax,62
        push    ax
        db	     9Ah
        dw	     MEMSET
        dw	     seg MEMSET
        push    ds
        mov     ax,offset DGROUP:BCC_LIBRARY_Y_MAP+97
        push    ax
        xor     ax,ax
        push    ax
        mov     ax,26
        push    ax
        db	     9Ah
        dw	     MEMSET
        dw	     seg MEMSET
        push    ds
        mov     ax,offset DGROUP:BCC_LIBRARY_T_MAP+97
        push    ax
        xor     ax,ax
        push    ax
        mov     ax,26
        push    ax
        db	     9Ah
        dw	     MEMSET
        dw	     seg MEMSET
        jmp     M001_@@SUCCESS

M001_@@LOOP_BODY:
        mov     word ptr [bp-2],1
        les     bx,dword ptr [bp+4]
        cmp     byte ptr es:[bx],45
        jne     short M001_@@CHECK_ALNUM
        mov     word ptr [bp-2],0
        inc     word ptr [bp+4]
M001_@@CHECK_ALNUM:
        les     bx,dword ptr [bp+4]
        mov     al,byte ptr es:[bx]
        cbw
        mov     bx,ax
        mov     al,byte ptr DGROUP:_CTYPE[bx+1]
        cbw
        test    ax,14
        jne     short M001_@@CHECK_ALPHA
        xor     ax,ax
        jmp     M001_@@EPILOGUE
M001_@@CHECK_ALPHA:
        les     bx,dword ptr [bp+4]
        mov     al,byte ptr es:[bx]
        cbw
        mov     bx,ax
        test    byte ptr DGROUP:_CTYPE[bx+1],12
        jne     short M001_@@ALPHA
        jmp     M001_@@DIGIT
M001_@@ALPHA:
        mov     bx,word ptr [bp+4]
        cmp     byte ptr es:[bx],121
        jne     short M001_@@CHECK_T
        inc     word ptr [bp+4]
        les     bx,dword ptr [bp+4]
        mov     al,byte ptr es:[bx]
        cbw
        mov     bx,ax
        test    byte ptr DGROUP:_CTYPE[bx+1],12
        je	     short M001_@@Y_DONE
        mov     bx,word ptr [bp+4]
        mov     al,byte ptr es:[bx]
        cbw
        push    ax
        db	     9Ah
        dw	     BCC_RF_1AB2_000D
        dw	     seg BCC_RF_1AB2_000D
        mov     dl,byte ptr [bp-2]
        mov     bx,ax
        mov     byte ptr DGROUP:BCC_LIBRARY_Y_MAP[bx],dl
        jmp     M001_@@NEXT_CHARACTER
M001_@@Y_DONE:
        jmp     M001_@@NEXT_CHARACTER

M001_@@CHECK_T:
        les     bx,dword ptr [bp+4]
        cmp     byte ptr es:[bx],84
        jne     short M001_@@ORDINARY_ALPHA
        inc     word ptr [bp+4]
        les     bx,dword ptr [bp+4]
        mov     al,byte ptr es:[bx]
        cbw
        mov     bx,ax
        test    byte ptr DGROUP:_CTYPE[bx+1],12
        je	     short M001_@@T_DONE
        mov     bx,word ptr [bp+4]
        mov     al,byte ptr es:[bx]
        cbw
        push    ax
        db	     9Ah
        dw	     BCC_RF_1AB2_000D
        dw	     seg BCC_RF_1AB2_000D
        mov     dl,byte ptr [bp-2]
        mov     bx,ax
        mov     byte ptr DGROUP:BCC_LIBRARY_T_MAP[bx],dl
M001_@@T_DONE:
        jmp     short M001_@@NEXT_CHARACTER

M001_@@ORDINARY_ALPHA:
        les     bx,dword ptr [bp+4]
        mov     al,byte ptr es:[bx]
        cbw
        mov     bx,ax
        test    byte ptr DGROUP:_CTYPE[bx+1],8
        je	     short M001_@@UPPERCASE
        mov     ax,97
        jmp     short M001_@@ORDINARY_BASE
M001_@@UPPERCASE:
        mov     ax,39
M001_@@ORDINARY_BASE:
        les     bx,dword ptr [bp+4]
        push    ax
        mov     al,byte ptr es:[bx]
        cbw
        pop     dx
        sub     ax,dx
        jmp     short M001_@@SET_FLAG

M001_@@DIGIT:
        les     bx,dword ptr [bp+4]
        mov     al,byte ptr es:[bx]
        cbw
        add     ax,4
M001_@@SET_FLAG:
        mov     si,ax
        mov     al,byte ptr [bp-2]
        mov     byte ptr DGROUP:BCC_RD_24C4_B[si],al
        cmp     byte ptr DGROUP:BCC_RD_D032_B+12,0
        jne     short M001_@@CLEAR_LINKED_FLAG
        cmp     byte ptr DGROUP:BCC_RD_D62C_B+18,0
        je	     short M001_@@NEXT_CHARACTER
M001_@@CLEAR_LINKED_FLAG:
        mov     byte ptr DGROUP:BCC_RD_24C4_B+23,0
M001_@@NEXT_CHARACTER:
        inc     word ptr [bp+4]
M001_@@LOOP_TEST:
        les     bx,dword ptr [bp+4]
        cmp     byte ptr es:[bx],0
        je	     short M001_@@SUCCESS
        jmp     M001_@@LOOP_BODY
M001_@@SUCCESS:
        mov     ax,1
M001_@@EPILOGUE:
        pop     si
        mov     sp,bp
        pop     bp
        dec     bp
        ret     6
BCC_SET_OPTION_LIBRARY  endp
CO02E_TEXT	     ends

; END OPTLIB
; BEGIN LG08E (gap	ovr_1c87_7b96:C289)
CO02E_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO02E_TEXT
; Original-image layout stub: not recovered source


   	     db	     045h,055h,08Bh,0ECh,083h,0ECh,00Ch,08Bh,046h,006h,08Bh,056h,004h,089h  ; ovr_1c87_7b96:C289
   	     db	     046h,0F6h,089h,056h,0F4h,0E9h,091h,000h,0C4h,05Eh,0F4h,026h,080h,03Fh  ; ovr_1c87_7b96:C297
   	     db	     03Bh,075h,009h,026h,0C6h,007h,000h,0FFh,046h,0F4h,0EBh,022h,0C4h,05Eh  ; ovr_1c87_7b96:C2A5
   	     db	     0F4h,026h,080h,03Fh,05Ch,075h,00Dh,026h,080h,07Fh,001h,000h,074h,006h  ; ovr_1c87_7b96:C2B3
   	     db	     083h,046h,0F4h,002h,0EBh,003h,0FFh,046h,0F4h,0C4h,05Eh,0F4h,026h,080h  ; ovr_1c87_7b96:C2C1
   	     db	     03Fh,000h,075h,0CCh,08Ch,05Eh,0FAh,0C7h,046h,0F8h,000h,01Dh,08Bh,046h  ; ovr_1c87_7b96:C2CF
   	     db	     006h,08Bh,056h,004h,089h,046h,0FEh,089h,056h,0FCh,0EBh,021h,0C4h,05Eh  ; ovr_1c87_7b96:C2DD
   	     db	     004h,026h,080h,03Fh,03Dh,075h,015h,026h,0C6h,007h,000h,0FFh,046h,004h  ; ovr_1c87_7b96:C2EB
   	     db	     08Bh,046h,006h,08Bh,056h,004h,089h,046h,0FAh,089h,056h,0F8h,0EBh,00Ch  ; ovr_1c87_7b96:C2F9
   	     db	     0FFh,046h,004h,0C4h,05Eh,004h,026h,080h,03Fh,000h,075h,0D6h,0FFh,076h  ; ovr_1c87_7b96:C307
   	     db	     0FEh,0FFh,076h,0FCh,0FFh,076h,0FAh,0FFh,076h,0F8h,090h,00Eh,0E8h,012h  ; ovr_1c87_7b96:C315
   	     db	     001h,08Bh,046h,0F6h,08Bh,056h,0F4h,089h,046h,006h,089h,056h,004h,0C4h  ; ovr_1c87_7b96:C323
   	     db	     05Eh,0F4h,026h,080h,03Fh,000h,074h,003h,0E9h,063h,0FFh,0B8h,001h,000h  ; ovr_1c87_7b96:C331
   	     db	     08Bh,0E5h,05Dh,04Dh,0C2h,006h,000h,045h,055h,08Bh,0ECh,0FFh,076h,006h  ; ovr_1c87_7b96:C33F
   	     db	     0FFh,076h,004h,090h,00Eh,0E8h,068h,002h,0B8h,001h,000h,05Dh,04Dh,0C2h  ; ovr_1c87_7b96:C34D
   	     db	     006h,000h	     ; ovr_1c87_7b96:C35B

CO02E_TEXT	     ends
; END LG08E
; BEGIN PATHS (listing ovr_1c87_7b96:C35D)




CO02E_TEXT	     segment byte public 'CODE'
CO02E_TEXT	     ends

        assume  cs:CO02E_TEXT,ds:DGROUP
CO02E_TEXT	     segment byte public 'CODE'
   ;
   ;    int pascal	near bcc_set_option_include(Option near	*option, char far *argument)
   ;
        assume  cs:CO02E_TEXT
BCC_SET_OPTION_INCLUDE  proc    near
        inc     bp
        push    bp
        mov     bp,sp
   ;
   ;    {
   ;	 bcc_add_paths(argument, &bcc_include_paths);
   ;
        push    word ptr [bp+6]
        push    word ptr [bp+4]
        push    ds
        mov     ax,offset DGROUP:BCC_INCLUDE_PATHS
        push    ax
        db	     0E8h,02Ch,000h
   ;
   ;	 bcc_include_path = "";
   ;
        mov     word ptr DGROUP:BCC_INCLUDE_PATH+2,ds
        mov     word ptr DGROUP:BCC_INCLUDE_PATH,offset DGROUP:BCC_STRING_DATA
   ;
   ;	 return	1;
   ;
        mov     ax,1
   ;
   ;    }
   ;
        pop     bp
        dec     bp
        ret     6
BCC_SET_OPTION_INCLUDE  endp
   ;
   ;    int pascal	near bcc_set_option_library_path(Option	near *option, char far *argument)
   ;
        assume  cs:CO02E_TEXT
BCC_SET_OPTION_LIBRARY_PATH     proc    near
        inc     bp
        push    bp
        mov     bp,sp
   ;
   ;    {
   ;	 bcc_add_paths(argument, &bcc_library_paths);
   ;
        push    word ptr [bp+6]
        push    word ptr [bp+4]
        push    ds
        mov     ax,offset DGROUP:BCC_LIBRARY_PATHS
        push    ax
        db	     0E8h,008h,000h
   ;
   ;	 return	1;
   ;
        mov     ax,1
   ;
   ;    }
   ;
        pop     bp
        dec     bp
        ret     6
BCC_SET_OPTION_LIBRARY_PATH     endp
CO02E_TEXT	     ends


CO02E_TEXT	     segment byte public 'CODE'
CO02E_TEXT	     ends




; END PATHS
; BEGIN PATHLIB (listing ovr_1c87_7b96:C39B)

        extrn   BCC_RF_15C5_010D:far
        extrn   BCC_COPY_PATH:near


CO02E_TEXT	     segment byte public 'CODE'
        assume  cs:CO02E_TEXT,ds:DGROUP

BCC_ADD_PATHS   proc    near
        inc     bp
        push    bp
        mov     bp,sp
        sub     sp,8
        mov     ax,word ptr [bp+10]
        mov     dx,word ptr [bp+8]
        mov     word ptr [bp-6],ax
        mov     word ptr [bp-8],dx
        jmp     short M004_@@OUTER_CONDITION
M004_@@SCAN_ADVANCE:
        inc     word ptr [bp-8]
M004_@@SCAN_CONDITION:
        les     bx,dword ptr [bp-8]
        cmp     byte ptr es:[bx],0
        je	     short M004_@@SCAN_DONE
        cmp     byte ptr es:[bx],59
        jne     short M004_@@SCAN_ADVANCE
M004_@@SCAN_DONE:
        les     bx,dword ptr [bp-8]
        cmp     byte ptr es:[bx],0
        je	     short M004_@@ALLOCATE
        mov     byte ptr es:[bx],0
        inc     word ptr [bp-8]
M004_@@ALLOCATE:
        mov     ax,10
        push    ax
        db	     9Ah
        dw	     BCC_RF_15C5_010D
        dw	     seg BCC_RF_15C5_010D
        mov     word ptr [bp-2],dx
        mov     word ptr [bp-4],ax
        push    word ptr [bp+10]
        push    word ptr [bp+8]
        db	     0E8h,022h,003h
        les     bx,dword ptr [bp-4]
        mov     word ptr es:[bx+8],dx
        mov     word ptr es:[bx+6],ax
        les     bx,dword ptr [bp+4]
        mov     ax,word ptr es:[bx+2]
        mov     dx,word ptr es:[bx]
        les     bx,dword ptr [bp-4]
        mov     word ptr es:[bx+4],ax
        mov     word ptr es:[bx+2],dx
        les     bx,dword ptr [bp+4]
        mov     ax,word ptr [bp-2]
        mov     dx,word ptr [bp-4]
        mov     word ptr es:[bx+2],ax
        mov     word ptr es:[bx],dx
        mov     ax,word ptr [bp-6]
        mov     dx,word ptr [bp-8]
        mov     word ptr [bp+10],ax
        mov     word ptr [bp+8],dx
M004_@@OUTER_CONDITION:
        les     bx,dword ptr [bp+8]
        cmp     byte ptr es:[bx],0
        jne     short M004_@@SCAN_CONDITION
        mov     sp,bp
        pop     bp
        dec     bp
        ret     8
BCC_ADD_PATHS   endp
CO02E_TEXT	     ends

; END PATHLIB
; BEGIN LG08F (gap	ovr_1c87_7b96:C436)
CO02E_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO02E_TEXT
; Original-image layout stub: not recovered source


X02E_05 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,00Ch,0A1h,076h,081h,08Bh,016h,074h,081h,0E9h; ovr_1c87_7b96:C436
   	     db	     094h,000h,0FFh,076h,00Ch,0FFh,076h,00Ah,08Bh,046h,0FCh,005h,004h,000h  ; ovr_1c87_7b96:C444
   	     db	     0FFh,076h,0FEh,050h,09Ah
   	     dw	     07h
   	     dw	     seg BCC_COMPARE_NAME
   	     db	     00Bh,0C0h,075h,071h,08Bh; ovr_1c87_7b96:C452
   	     db	     046h,0FEh,08Bh,056h,0FCh,083h,0C2h,004h,089h,046h,0FAh,089h,056h,0F8h  ; ovr_1c87_7b96:C460
   	     db	     0FFh,076h,0FAh,0FFh,076h,0F8h,09Ah
   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     040h,001h,046h; ovr_1c87_7b96:C46E
   	     db	     0F8h,08Bh,046h,008h,08Bh,056h,006h,089h,046h,0F6h,089h,056h,0F4h,0EBh  ; ovr_1c87_7b96:C47C
   	     db	     006h,0FFh,046h,0F8h,0FFh,046h,0F4h,0C4h,05Eh,0F8h,026h,08Ah,007h,0C4h  ; ovr_1c87_7b96:C48A
   	     db	     05Eh,0F4h,026h,03Ah,007h,074h,0ECh,0C4h,05Eh,0F8h,026h,080h,03Fh,0FBh  ; ovr_1c87_7b96:C498
   	     db	     075h,013h,026h,080h,07Fh,001h,000h,075h,00Ch,0C4h,05Eh,0F4h,026h,080h  ; ovr_1c87_7b96:C4A6
   	     db	     03Fh,000h,075h,003h,0E9h,0FCh,000h,0FFh,076h,00Ch,0FFh,076h,00Ah,0B8h  ; ovr_1c87_7b96:C4B4
   	     db	     06Dh,001h,050h,09Ah
   	     dw	     017Dh
   	     dw	     seg BCC_DIAGNOSTIC
   	     db	     083h,0C4h,006h,0E9h,0E7h,000h; ovr_1c87_7b96:C4C2
   	     db	     0C4h,05Eh,0FCh,026h,08Bh,047h,002h,026h,08Bh,017h,089h,046h,0FEh,089h  ; ovr_1c87_7b96:C4D0
   	     db	     056h,0FCh,08Bh,046h,0FCh,00Bh,046h,0FEh,074h,003h,0E9h,05Bh,0FFh,0FFh  ; ovr_1c87_7b96:C4DE
   	     db	     076h,00Ch,0FFh,076h,00Ah,09Ah
   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     050h,0FFh,076h,008h; ovr_1c87_7b96:C4EC
   	     db	     0FFh,076h,006h,09Ah
   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     05Ah,003h,0D0h,083h,0C2h,007h; ovr_1c87_7b96:C4FA
   	     db	     052h,09Ah
   	     dw	     010Dh
   	     dw	     seg BCC_RF_15C5_010D
   	     db	     089h,056h,0FEh,089h,046h,0FCh,08Bh,046h; ovr_1c87_7b96:C508

   	     db	     0FEh,08Bh,056h,0FCh,083h,0C2h,004h,089h,046h,0FAh,089h,056h,0F8h,0FFh  ; ovr_1c87_7b96:C516
   	     db	     076h,0FAh,0FFh,076h,0F8h,0FFh,076h,00Ch,0FFh,076h,00Ah,09Ah

   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     0FFh,076h,0FAh,0FFh,076h,0F8h,09Ah
   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     040h; ovr_1c87_7b96:C524
   	     db	     001h,046h,0F8h,0FFh,076h,0FAh,0FFh,076h,0F8h,0FFh,076h,008h,0FFh,076h  ; ovr_1c87_7b96:C540
   	     db	     006h,09Ah
   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     0FFh,076h,0FAh,0FFh,076h,0F8h,09Ah
   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     001h,046h,0F8h,0C4h,05Eh,0F8h,026h,0C6h,007h,0FBh,0FFh;		    ovr_1c87_7b96:C54E
   	     db	     046h,0F8h,0C4h,05Eh,0F8h,026h,0C6h,007h,000h,0A1h,074h,081h,00Bh,006h  ; ovr_1c87_7b96:C56A
   	     db	     076h,081h,074h,013h,0C4h,01Eh,070h,081h,08Bh,046h,0FEh,08Bh,056h,0FCh  ; ovr_1c87_7b96:C578
   	     db	     026h,089h,047h,002h,026h,089h,017h,0EBh,00Dh,08Bh,046h,0FEh,08Bh,056h  ; ovr_1c87_7b96:C586
   	     db	     0FCh,0A3h,076h,081h,089h,016h,074h,081h,08Bh,046h,0FEh,08Bh,056h,0FCh  ; ovr_1c87_7b96:C594
   	     db	     0A3h,072h,081h,089h,016h,070h,081h,0C4h,05Eh,0FCh,026h,0C7h,047h,002h  ; ovr_1c87_7b96:C5A2
   	     db	     000h,000h,026h,0C7h,007h,000h,000h,08Bh,0E5h,05Dh,0CAh,008h,000h;	    raw:C5B0
X02E_02 label   far
   	     db	     055h; ovr_1c87_7b96:C5B0
   	     db	     08Bh,0ECh,083h,0ECh,008h,0C7h,046h,0FAh,000h,000h,0C7h,046h,0F8h,000h  ; ovr_1c87_7b96:C5BE
   	     db	     000h,0A1h,076h,081h,08Bh,016h,074h,081h,0EBh,060h,0FFh,076h,008h,0FFh  ; ovr_1c87_7b96:C5CC
   	     db	     076h,006h,08Bh,046h,0FCh,005h,004h,000h,0FFh,076h,0FEh,050h,09Ah

   	     dw	     07h
   	     dw	     seg BCC_COMPARE_NAME
   	     db	     00Bh,0C0h,075h,031h,08Bh,046h,0F8h,00Bh,046h,0FAh,074h;		    ovr_1c87_7b96:C5DA
   	     db	     016h,0C4h,05Eh,0FCh,026h,08Bh,047h,002h,026h,08Bh,017h,0C4h,05Eh,0F8h  ; ovr_1c87_7b96:C5F6
   	     db	     026h,089h,047h,002h,026h,089h,017h,0EBh,037h,0C4h,05Eh,0FCh,026h,08Bh  ; ovr_1c87_7b96:C604
   	     db	     047h,002h,026h,08Bh,017h,0A3h,076h,081h,089h,016h,074h,081h,0EBh,024h  ; ovr_1c87_7b96:C612
   	     db	     08Bh,046h,0FEh,08Bh,056h,0FCh,089h,046h,0FAh,089h,056h,0F8h,0C4h,05Eh  ; ovr_1c87_7b96:C620
   	     db	     0FCh,026h,08Bh,047h,002h,026h,08Bh,017h,089h,046h,0FEh,089h,056h,0FCh  ; ovr_1c87_7b96:C62E
   	     db	     08Bh,046h,0FCh,00Bh,046h,0FEh,075h,092h,08Bh,0E5h,05Dh,0CAh,004h,000h  ; ovr_1c87_7b96:C63C

CO02E_TEXT	     ends
; END LG08F
; BEGIN PATHREV (listing ovr_1c87_7b96:C64A)




CO02E_TEXT	     segment byte public 'CODE'
CO02E_TEXT	     ends

        assume  cs:CO02E_TEXT,ds:DGROUP
CO02E_TEXT	     segment byte public 'CODE'
   ;
   ;    void pascal far bcc_reverse_paths(void)
   ;
        assume  cs:CO02E_TEXT
   	     public  X02E_03
X02E_03 label   far
BCC_REVERSE_PATHS	     proc    far
        push    bp
        mov     bp,sp
        sub     sp,8
   ;
   ;    {
   ;	 PathNode far *node;
   ;	 PathNode far *next;
   ;
   ;	 node =	bcc_include_paths;
   ;
        mov     ax,word ptr DGROUP:BCC_INCLUDE_PATHS+2
        mov     dx,word ptr DGROUP:BCC_INCLUDE_PATHS
        mov     word ptr [bp-2],ax
        mov     word ptr [bp-4],dx
   ;
   ;	 bcc_include_paths = 0;
   ;
        mov     word ptr DGROUP:BCC_INCLUDE_PATHS+2,0
        mov     word ptr DGROUP:BCC_INCLUDE_PATHS,0
        jmp     short M006_@1@74
M006_@1@50:
   ;
   ;	 while (node !=	0) {
   ;	     next = node->next;
   ;
        les     bx,dword ptr [bp-4]
        mov     ax,word ptr es:[bx+4]
        mov     dx,word ptr es:[bx+2]
        mov     word ptr [bp-6],ax
        mov     word ptr [bp-8],dx
   ;
   ;	     node->next	= bcc_include_paths;
   ;
        mov     ax,word ptr DGROUP:BCC_INCLUDE_PATHS+2
        mov     dx,word ptr DGROUP:BCC_INCLUDE_PATHS
        mov     word ptr es:[bx+4],ax
        mov     word ptr es:[bx+2],dx
   ;
   ;	     bcc_include_paths = node;
   ;
        mov     ax,word ptr [bp-2]
        mov     dx,word ptr [bp-4]
        mov     word ptr DGROUP:BCC_INCLUDE_PATHS+2,ax
        mov     word ptr DGROUP:BCC_INCLUDE_PATHS,dx
   ;
   ;	     node = next;
   ;
        mov     ax,word ptr [bp-6]
        mov     dx,word ptr [bp-8]
        mov     word ptr [bp-2],ax
        mov     word ptr [bp-4],dx
M006_@1@74:
        mov     ax,word ptr [bp-4]
        or	     ax,word ptr [bp-2]
        jne     short M006_@1@50
   ;
   ;	 }
   ;	 node =	bcc_library_paths;
   ;
        mov     ax,word ptr DGROUP:BCC_LIBRARY_PATHS+2
        mov     dx,word ptr DGROUP:BCC_LIBRARY_PATHS
        mov     word ptr [bp-2],ax
        mov     word ptr [bp-4],dx
   ;
   ;	 bcc_library_paths = 0;
   ;
        mov     word ptr DGROUP:BCC_LIBRARY_PATHS+2,0
        mov     word ptr DGROUP:BCC_LIBRARY_PATHS,0
        jmp     short M006_@1@146
M006_@1@122:
   ;
   ;	 while (node !=	0) {
   ;	     next = node->next;
   ;
        les     bx,dword ptr [bp-4]
        mov     ax,word ptr es:[bx+4]
        mov     dx,word ptr es:[bx+2]
        mov     word ptr [bp-6],ax
        mov     word ptr [bp-8],dx
   ;
   ;	     node->next	= bcc_library_paths;
   ;
        mov     ax,word ptr DGROUP:BCC_LIBRARY_PATHS+2
        mov     dx,word ptr DGROUP:BCC_LIBRARY_PATHS
        mov     word ptr es:[bx+4],ax
        mov     word ptr es:[bx+2],dx
   ;
   ;	     bcc_library_paths = node;
   ;
        mov     ax,word ptr [bp-2]
        mov     dx,word ptr [bp-4]
        mov     word ptr DGROUP:BCC_LIBRARY_PATHS+2,ax
        mov     word ptr DGROUP:BCC_LIBRARY_PATHS,dx
   ;
   ;	     node = next;
   ;
        mov     ax,word ptr [bp-6]
        mov     dx,word ptr [bp-8]
        mov     word ptr [bp-2],ax
        mov     word ptr [bp-4],dx
M006_@1@146:
        mov     ax,word ptr [bp-4]
        or	     ax,word ptr [bp-2]
        jne     short M006_@1@122
   ;
   ;	 }
   ;    }
   ;
        mov     sp,bp
        pop     bp
        ret
BCC_REVERSE_PATHS	     endp

CO02E_TEXT	     ends

CO02E_TEXT	     segment byte public 'CODE'
CO02E_TEXT	     ends

; END PATHREV
; BEGIN LG090 (gap	ovr_1c87_7b96:C70C)
CO02E_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO02E_TEXT
; Original-image layout stub: not recovered source


   	     db	     045h,055h,08Bh,0ECh,083h,0ECh,004h,056h,0FFh,076h,006h,0FFh,076h,004h  ; ovr_1c87_7b96:C70C
   	     db	     09Ah
   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     08Bh,056h,006h,08Bh,05Eh,004h,003h,0D8h,089h; ovr_1c87_7b96:C71A

   	     db	     056h,0FEh,089h,05Eh,0FCh,08Bh,046h,0FEh,08Bh,056h,0FCh,03Bh,046h,006h  ; ovr_1c87_7b96:C728
   	     db	     075h,005h,03Bh,056h,004h,074h,018h,0C4h,05Eh,0FCh,026h,080h,07Fh,0FFh  ; ovr_1c87_7b96:C736
   	     db	     02Fh,074h,00Eh,026h,080h,07Fh,0FFh,05Ch,074h,007h,026h,080h,07Fh,0FFh  ; ovr_1c87_7b96:C744
   	     db	     03Ah,075h,004h,033h,0F6h,0EBh,003h,0BEh,001h,000h,0FFh,076h,006h,0FFh  ; ovr_1c87_7b96:C752
   	     db	     076h,004h,09Ah
   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     003h,0C6h,040h,050h,09Ah
   	     dw	     010Dh
   	     dw	     seg BCC_RF_15C5_010D
   	     db	     089h,056h,0FEh,089h,046h,0FCh,0FFh,076h,0FEh,0FFh,076h,0FCh;	    ovr_1c87_7b96:C760
   	     db	     0FFh,076h,006h,0FFh,076h,004h,09Ah
   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     00Bh,0F6h,074h; ovr_1c87_7b96:C77C
   	     db	     010h,0FFh,076h,0FEh,0FFh,076h,0FCh,01Eh,0B8h,019h,01Fh,050h,09Ah

   	     dw	     06h
   	     dw	     seg BCC_FAR_B146
   	     db	     08Bh,056h,0FEh,08Bh,046h,0FCh,05Eh,08Bh,0E5h,05Dh,04Dh;		    ovr_1c87_7b96:C78A
   	     db	     0C2h,004h,000h; raw:C7A6
X02E_07 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,004h,0A1h,07Ah,081h,08Bh,016h;		    ovr_1c87_7b96:C7A6
   	     db	     078h,081h,0EBh,043h,01Eh,0B8h,09Eh,067h,050h,0C4h,05Eh,0FCh,026h,0FFh  ; ovr_1c87_7b96:C7B4
   	     db	     077h,008h,026h,0FFh,077h,006h,09Ah
   	     dw	     02h
   	     dw	     seg BCC_DEBUG_BUILD
   	     db	     01Eh,0B8h,09Eh; ovr_1c87_7b96:C7C2
   	     db	     067h,050h,0FFh,076h,008h,0FFh,076h,006h,09Ah

   	     dw	     06h
   	     dw	     seg BCC_FAR_B146
   	     db	     01Eh; ovr_1c87_7b96:C7D0
   	     db	     0B8h,09Eh,067h,050h,09Ah
   	     dw	     043h
   	     dw	     seg CO032_TEXT
   	     db	     00Bh,0C0h,074h,005h,0B8h; ovr_1c87_7b96:C7DE
   	     db	     001h,000h,0EBh,01Bh,0C4h,05Eh,0FCh,026h,08Bh,047h,004h,026h,08Bh,057h  ; ovr_1c87_7b96:C7EC
   	     db	     002h,089h,046h,0FEh,089h,056h,0FCh,08Bh,046h,0FCh,00Bh,046h,0FEh,075h  ; ovr_1c87_7b96:C7FA
   	     db	     0AFh,033h,0C0h,08Bh,0E5h,05Dh,0CAh,004h,000h; raw:C808

X02E_0A label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh; ovr_1c87_7b96:C808
   	     db	     008h,0A1h,076h,081h,08Bh,016h,074h,081h,0EBh,03Fh,08Bh,046h,0FEh,08Bh  ; ovr_1c87_7b96:C816
   	     db	     056h,0FCh,083h,0C2h,004h,089h,046h,0FAh,089h,056h,0F8h,0FFh,076h,0FAh  ; ovr_1c87_7b96:C824
   	     db	     0FFh,076h,0F8h,0FFh,076h,0FAh,0FFh,076h,0F8h,09Ah

   	     dw	     02h
   	     dw	     seg BCC_FAR_AB12
   	     db	     08Bh,056h,0F8h,003h,0D0h,042h,0FFh,076h,0FAh,052h,0B0h,0FFh,050h,033h  ; ovr_1c87_7b96:C840
   	     db	     0C0h,050h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO033_TEXT
   	     db	     0C4h,05Eh,0FCh,026h,08Bh,047h,002h; ovr_1c87_7b96:C84E
   	     db	     026h,08Bh,017h,089h,046h,0FEh,089h,056h,0FCh,08Bh,046h,0FCh,00Bh,046h  ; ovr_1c87_7b96:C85C
   	     db	     0FEh,075h,0B3h,08Bh,0E5h,05Dh,0CBh,045h,055h,08Bh,0ECh,083h,0ECh,004h  ; ovr_1c87_7b96:C86A
   	     db	     0C4h,05Eh,004h,026h,08Ah,007h,098h,00Bh,0C0h,074h,014h,03Dh,02Dh,000h  ; ovr_1c87_7b96:C878
   	     db	     074h,007h,03Dh,03Dh,000h,074h,012h,0EBh,064h,0C7h,006h,06Ah,017h,0FFh  ; ovr_1c87_7b96:C886
   	     db	     0FFh,0EBh,05Eh,0C7h,006h,06Ah,017h,000h,000h,0EBh,056h,0FFh,046h,004h  ; ovr_1c87_7b96:C894
   	     db	     0C4h,05Eh,004h,026h,08Ah,007h,098h,08Bh,0D8h,0F6h,087h,081h,05Bh,002h  ; ovr_1c87_7b96:C8A2
   	     db	     074h,03Dh,0FFh,076h,006h,0FFh,076h,004h,09Ah

   	     dw	     09h
   	     dw	     seg BCC_SEG_15
   	     db	     089h; ovr_1c87_7b96:C8B0
   	     db	     056h,0FEh,089h,046h,0FCh,00Bh,046h,0FEh,074h,01Fh,033h,0C0h,0BAh,010h  ; ovr_1c87_7b96:C8BE
   	     db	     000h,050h,052h,08Bh,046h,0FEh,08Bh,056h,0FCh,083h,0C2h,00Fh,015h,000h  ; ovr_1c87_7b96:C8CC
   	     db	     000h,050h,052h,09Ah
   	     dw	     02C9h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     0A3h,06Ah,017h,0EBh,00Eh,0C7h; ovr_1c87_7b96:C8DA
   	     db	     006h,06Ah,017h,0FFh,0FFh,0EBh,006h,033h,0C0h,0EBh,005h,0EBh,0FAh,0B8h  ; ovr_1c87_7b96:C8E8
   	     db	     001h,000h,08Bh,0E5h,05Dh,04Dh,0C2h,006h,000h,045h,055h,08Bh,0ECh,0C4h  ; ovr_1c87_7b96:C8F6
   	     db	     05Eh,004h,026h,08Ah,007h,098h,00Bh,0C0h,075h,003h,0E9h,0F2h,000h,03Dh  ; ovr_1c87_7b96:C904
   	     db	     02Dh,000h,075h,003h,0E9h,0DCh,000h,03Dh,03Dh,000h,074h,003h,0E9h,0FCh  ; ovr_1c87_7b96:C912
   	     db	     000h,0FFh,046h,004h,0C4h,05Eh,004h,026h,08Ah,007h,098h,08Bh,0D8h,0F6h  ; ovr_1c87_7b96:C920
   	     db	     087h,081h,05Bh,002h,074h,04Fh,0FFh,076h,006h,0FFh,076h,004h,09Ah

   	     dw	     09h
   	     dw	     seg BCC_SEG_15
   	     db	     005h,000h,004h,083h,0D2h,000h,0B1h,00Ah,09Ah

   	     dw	     036Ch
   	     dw	     seg BCC_COPY_WORDS
   	     db	     089h,016h,06Eh,017h,0A3h,06Ch,017h,0C7h,006h,072h,017h,0FFh;	    ovr_1c87_7b96:C92E
   	     db	     0FFh,0C7h,006h,070h,017h,0FFh,0FFh,0EBh,003h,0FFh,046h,004h,0C4h,05Eh  ; ovr_1c87_7b96:C958
   	     db	     004h,026h,08Ah,007h,098h,08Bh,0D8h,08Ah,087h,081h,05Bh,098h,0A9h,002h  ; ovr_1c87_7b96:C966
   	     db	     000h,075h,0EAh,08Bh,05Eh,004h,026h,080h,03Fh,000h,075h,003h,0E9h,09Ch  ; ovr_1c87_7b96:C974
   	     db	     000h,0C4h,05Eh,004h,026h,080h,03Fh,02Ch,075h,067h,0FFh,046h,004h,0C4h  ; ovr_1c87_7b96:C982
   	     db	     05Eh,004h,026h,08Ah,007h,098h,08Bh,0D8h,08Ah,087h,081h,05Bh,098h,0A9h  ; ovr_1c87_7b96:C990
   	     db	     002h,000h,075h,004h,033h,0C0h,0EBh,07Ch,0FFh,076h,006h,0FFh,076h,004h  ; ovr_1c87_7b96:C99E
   	     db	     09Ah
   	     dw	     09h
   	     dw	     seg BCC_SEG_15
   	     db	     0B1h,00Ah,09Ah
   	     dw	     036Ch
   	     dw	     seg BCC_COPY_WORDS
   	     db	     089h,016h;	ovr_1c87_7b96:C9AC
   	     db	     072h,017h,0A3h,070h,017h,083h,03Eh,06Eh,017h,0FFh,075h,018h,083h,03Eh  ; ovr_1c87_7b96:C9BA
   	     db	     06Ch,017h,0FFh,075h,011h,0C7h,006h,06Eh,017h,010h,000h,0C7h,006h,06Ch  ; ovr_1c87_7b96:C9C8
   	     db	     017h,000h,000h,0EBh,003h,0FFh,046h,004h,0C4h,05Eh,004h,026h,08Ah,007h  ; ovr_1c87_7b96:C9D6
   	     db	     098h,08Bh,0D8h,08Ah,087h,081h,05Bh,098h,0A9h,002h,000h,075h,0EAh,0EBh  ; ovr_1c87_7b96:C9E4
   	     db	     02Ch,0EBh,0ADh,0C7h,006h,06Eh,017h,0FFh,0FFh,0C7h,006h,06Ch,017h,0FFh  ; ovr_1c87_7b96:C9F2
   	     db	     0FFh,0EBh,01Ch,0C7h,006h,06Eh,017h,000h,000h,0C7h,006h,06Ch,017h,000h  ; ovr_1c87_7b96:CA00
   	     db	     000h,0C7h,006h,072h,017h,000h,000h,0C7h,006h,070h,017h,000h,000h,0EBh  ; ovr_1c87_7b96:CA0E
   	     db	     002h,0EBh,083h,0B8h,001h,000h,05Dh,04Dh,0C2h,006h,000h  ;		    ovr_1c87_7b96:CA1C

CO02E_TEXT	     ends
; END LG090
   	     end
