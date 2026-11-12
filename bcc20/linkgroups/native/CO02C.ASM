; Recovered FBOV far-pointer references
   	     extrn   BCC_COPY_WORDS:far
   	     extrn   BCC_FAR_AF23:far
   	     extrn   BCC_FAR_B0F1:far
CO00F_TEXT	     segment byte public 'CODE'
CO00F_TEXT	     ends
CO019_TEXT	     segment byte public 'CODE'
CO019_TEXT	     ends
CO02F_TEXT	     segment byte public 'CODE'
CO02F_TEXT	     ends
CO035_TEXT	     segment byte public 'CODE'
CO035_TEXT	     ends
CO043_TEXT	     segment byte public 'CODE'
CO043_TEXT	     ends
   	     public  X02C_1A
   	     public  X02C_1C
   	     public  X02C_1B
   	     public  X02C_1E
   	     public  X02C_1D
   	     public  X02C_1F
   	     public  X02C_21
   	     public  X02C_20
   	     public  X02C_23
   	     public  X02C_22
   	     public  X02C_25
   	     public  X02C_24
   	     public  X02C_26
   	     public  X02C_0B
   	     public  X02C_0E
   	     public  X02C_0A
   	     public  X02C_0C
   	     public  X02C_0D
   	     public  X02C_0F
   	     public  X02C_08
   	     public  X02C_00
   	     public  X02C_09
   	     public  X02C_01
   	     public  X02C_03
   	     public  X02C_02
   	     public  X02C_05
   	     public  X02C_04
   	     public  X02C_07
   	     public  X02C_06
   	     public  X02C_19
   	     public  X02C_18
   	     public  X02C_11
   	     public  X02C_10
   	     public  X02C_13
   	     public  X02C_12
   	     public  X02C_15
   	     public  X02C_14
   	     public  X02C_17
   	     public  X02C_16
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1c75_7a72
; BEGIN LG08B (gap	ovr_1c75_7a72:A720)
CO02C_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO02C_TEXT
; Original-image layout stub: not recovered source


X02C_21 label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,076h,006h,01Eh,0B8h,0A4h,078h,050h,08Ah; ovr_1c75_7a72:A720
   	     db	     084h,0CCh,014h,098h,050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F8h,0FFh,036h; ovr_1c75_7a72:A72E
   	     db	     0A4h,078h,057h,033h,0C0h,050h,08Ah,084h,0CCh,014h,098h,050h,09Ah

   	     dw	     03h
   	     dw	     seg BCC_FAR_AF23
   	     db	     08Bh,0C7h,05Fh,05Eh,05Dh,0CAh,002h,000h; ovr_1c75_7a72:A73C

X02C_26 label   far
   	     db	     055h,08Bh,0ECh; ovr_1c75_7a72:A74A
   	     db	     056h,057h,08Bh,076h,006h,01Eh,0B8h,09Ah,063h,050h,08Eh,006h,09Ah,063h  ; ovr_1c75_7a72:A758
   	     db	     026h,08Bh,01Ch,08Ah,087h,0B6h,014h,098h,050h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F8h,0FFh,036h,09Ah,063h,057h,0FFh,036h,09Ah,063h,056h,08Eh,006h  ; ovr_1c75_7a72:A774
   	     db	     09Ah,063h,026h,08Bh,01Ch,08Ah,087h,0B6h,014h,098h,050h,09Ah

   	     dw	     01h
   	     dw	     seg BCC_FAR_B0F1
   	     db	     08Bh,0C7h,05Fh,05Eh,05Dh,0CAh,002h,000h; ovr_1c75_7a72:A782

X02C_11 label   far
   	     db	     055h,08Bh,0ECh,056h; ovr_1c75_7a72:A790
   	     db	     057h,08Bh,046h,006h,00Bh,0C0h,074h,01Fh,08Eh,006h,09Ah,063h,08Bh,0F8h  ; ovr_1c75_7a72:A79E
   	     db	     026h,08Ah,01Dh,0B7h,000h,0F6h,087h,0CAh,009h,014h,074h,00Dh,026h,081h  ; ovr_1c75_7a72:A7AC
   	     db	     065h,00Dh,07Fh,0FFh,083h,03Eh,0C0h,05Eh,000h,074h,003h,0EBh,06Ah,090h  ; ovr_1c75_7a72:A7BA
   	     db	     01Eh,08Eh,01Eh,09Ah,063h,0B4h,000h,08Ah,0CBh,08Ah,06Dh,002h,08Bh,055h  ; ovr_1c75_7a72:A7C8
   	     db	     007h,0BEh,00Fh,000h,08Ah,01Ch,03Ah,0D9h,075h,005h,03Bh,054h,007h,074h  ; ovr_1c75_7a72:A7D6
   	     db	     018h,036h,08Ah,087h,0B6h,014h,003h,0F0h,036h,03Bh,036h,09Eh,063h,072h  ; ovr_1c75_7a72:A7E4
   	     db	     0E7h,01Fh,08Bh,046h,006h,0EBh,038h,0B4h,000h,0EBh,0E8h,08Ah,044h,00Dh  ; ovr_1c75_7a72:A7F2
   	     db	     03Ah,045h,00Dh,075h,0E0h,03Ah,06Ch,002h,075h,0DBh,08Bh,044h,003h,03Bh  ; ovr_1c75_7a72:A800
   	     db	     045h,003h,075h,0E7h,08Bh,045h,007h,03Bh,044h,007h,075h,0DFh,03Bh,0F7h  ; ovr_1c75_7a72:A80E
   	     db	     074h,0D5h,081h,04Dh,00Dh,080h,000h,01Fh,0A1h,0D0h,014h,026h,089h,045h  ; ovr_1c75_7a72:A81C
   	     db	     003h,089h,03Eh,0D0h,014h,08Bh,0C6h,05Fh,05Eh,05Dh,0CAh,002h,000h;	    raw:A82A
X02C_10 label   far
   	     db	     055h; ovr_1c75_7a72:A82A
   	     db	     08Bh,0ECh,083h,0ECh,006h,056h,057h,08Bh,036h,09Ah,063h,08Bh,07Eh,008h  ; ovr_1c75_7a72:A838
   	     db	     08Eh,0C6h,026h,08Bh,005h,089h,046h,0FCh,026h,08Ah,045h,002h,0B4h,000h  ; ovr_1c75_7a72:A846
   	     db	     025h,0FCh,0FFh,009h,046h,006h,0C7h,046h,0FEh,00Fh,000h,0E9h,0E3h,000h  ; ovr_1c75_7a72:A854
   	     db	     08Bh,046h,0FEh,08Bh,0C8h,08Eh,0C6h,08Bh,0D9h,026h,08Bh,007h,089h,046h  ; ovr_1c75_7a72:A862
   	     db	     0FAh,03Bh,046h,0FCh,074h,003h,0E9h,0C1h,000h,026h,08Ah,047h,002h,0B4h  ; ovr_1c75_7a72:A870
   	     db	     000h,03Bh,046h,006h,074h,003h,0E9h,0B3h,000h,026h,08Bh,047h,003h,026h  ; ovr_1c75_7a72:A87E
   	     db	     03Bh,045h,003h,074h,003h,0E9h,0A6h,000h,08Bh,05Eh,0FCh,083h,0EBh,011h  ; ovr_1c75_7a72:A88C
   	     db	     083h,0FBh,004h,077h,06Ch,0D1h,0E3h,02Eh,0FFh,0A7h,054h,002h,08Bh,0D9h  ; ovr_1c75_7a72:A89A
   	     db	     08Eh,0C6h,026h,08Bh,047h,005h,026h,03Bh,045h,005h,074h,003h,0E9h,083h  ; ovr_1c75_7a72:A8A8
   	     db	     000h,08Bh,046h,0FEh,0E9h,0AFh,000h,08Bh,0D9h,08Eh,0C6h,026h,08Bh,047h  ; ovr_1c75_7a72:A8B6
   	     db	     007h,026h,03Bh,045h,007h,075h,06Fh,026h,08Bh,047h,009h,026h,03Bh,045h  ; ovr_1c75_7a72:A8C4
   	     db	     009h,075h,065h,0EBh,0E0h,08Bh,0D9h,08Eh,0C6h,026h,08Bh,047h,005h,026h  ; ovr_1c75_7a72:A8D2
   	     db	     03Bh,045h,005h,075h,055h,0EBh,0D0h,08Bh,0D9h,08Eh,0C6h,026h,08Bh,047h  ; ovr_1c75_7a72:A8E0
   	     db	     007h,026h,03Bh,045h,007h,075h,045h,026h,08Bh,047h,00Bh,026h,08Bh,057h  ; ovr_1c75_7a72:A8EE
   	     db	     009h,026h,03Bh,045h,00Bh,075h,037h,026h,03Bh,055h,009h,075h,031h,0EBh  ; ovr_1c75_7a72:A8FC
   	     db	     0ACh,08Bh,0D9h,08Eh,0C6h,026h,08Bh,047h,007h,026h,03Bh,045h,007h,075h  ; ovr_1c75_7a72:A90A
   	     db	     021h,026h,08Ah,047h,00Dh,026h,03Ah,045h,00Dh,075h,017h,026h,08Bh,047h  ; ovr_1c75_7a72:A918
   	     db	     009h,026h,03Bh,045h,009h,075h,00Dh,026h,08Bh,047h,00Bh,026h,03Bh,045h  ; ovr_1c75_7a72:A926
   	     db	     00Bh,075h,003h,0E9h,07Dh,0FFh,08Bh,05Eh,0FAh,08Ah,087h,0B6h,014h,098h  ; ovr_1c75_7a72:A934
   	     db	     001h,046h,0FEh,08Bh,046h,0FEh,03Bh,006h,09Eh,063h,073h,003h,0E9h,011h  ; ovr_1c75_7a72:A942
   	     db	     0FFh,0FFh,076h,008h,00Eh,0E8h,0FDh,0FDh,089h,046h,008h,08Bh,05Eh,008h  ; ovr_1c75_7a72:A950
   	     db	     08Eh,006h,09Ah,063h,08Ah,046h,006h,026h,088h,047h,002h,08Bh,046h,008h  ; ovr_1c75_7a72:A95E
   	     db	     05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,004h,000h,0C7h,001h,09Dh,001h,086h,001h  ; ovr_1c75_7a72:A96C
   	     db	     086h,001h,0B7h,001h; raw:A97A
X02C_0F label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,004h,056h,08Bh,076h,006h;	ovr_1c75_7a72:A97A

   	     db	     089h,036h,0E0h,009h,0A1h,09Ah,00Bh,08Bh,016h,098h,00Bh,089h,046h,0FEh  ; ovr_1c75_7a72:A988
   	     db	     089h,056h,0FCh,0EBh,004h,083h,06Eh,0FCh,004h,0C4h,05Eh,0FCh,026h,039h  ; ovr_1c75_7a72:A996
   	     db	     037h,075h,0F4h,026h,08Bh,047h,002h,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h  ; ovr_1c75_7a72:A9A4
   	     db	     045h,055h,08Bh,0ECh,056h,057h,08Bh,076h,004h,083h,03Eh,0C0h,05Eh,000h  ; ovr_1c75_7a72:A9B2
   	     db	     075h,01Fh,0F6h,084h,0CAh,009h,014h,074h,018h,083h,03Eh,0D0h,014h,000h  ; ovr_1c75_7a72:A9C0
   	     db	     074h,011h,08Bh,03Eh,0D0h,014h,08Eh,006h,09Ah,063h,026h,08Bh,045h,003h  ; ovr_1c75_7a72:A9CE
   	     db	     0A3h,0D0h,014h,0EBh,012h,01Eh,0B8h,09Ah,063h,050h,08Ah,084h,0B6h,014h  ; ovr_1c75_7a72:A9DC
   	     db	     098h,050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F8h,0FFh,036h,09Ah,063h,057h; ovr_1c75_7a72:A9EA
   	     db	     033h,0C0h,050h,08Ah,084h,0B6h,014h,098h,050h,09Ah

   	     dw	     03h
   	     dw	     seg BCC_FAR_AF23
   	     db	     08Eh,006h,09Ah,063h,026h,089h,035h,08Bh,0C7h,05Fh,05Eh,05Dh,04Dh,0C2h  ; ovr_1c75_7a72:AA06
   	     db	     002h,000h,045h,055h,08Bh,0ECh,056h,01Eh,0B8h,03Eh,05Fh,050h,0B8h,008h  ; ovr_1c75_7a72:AA14
   	     db	     000h,050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F0h,0FFh,036h,03Eh,05Fh,056h; ovr_1c75_7a72:AA22
   	     db	     033h,0C0h,050h,0B8h,008h,000h,050h,09Ah

   	     dw	     03h
   	     dw	     seg BCC_FAR_AF23
   	     db	     08Bh,0C6h;	ovr_1c75_7a72:AA30
   	     db	     05Eh,05Dh,04Dh,0C3h,045h,055h,08Bh,0ECh,056h,057h,080h,03Eh,0A0h,062h  ; ovr_1c75_7a72:AA3E
   	     db	     000h,074h,005h,0B8h,01Ch,000h,0EBh,003h,0B8h,008h,000h,08Bh,0F0h,01Eh  ; ovr_1c75_7a72:AA4C
   	     db	     0B8h,03Eh,05Fh,050h,056h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F8h,0FFh,036h; ovr_1c75_7a72:AA5A
   	     db	     03Eh,05Fh,057h,033h,0C0h,050h,056h,09Ah

   	     dw	     03h
   	     dw	     seg BCC_FAR_AF23
   	     db	     08Bh,0C7h;	ovr_1c75_7a72:AA68
   	     db	     05Fh,05Eh,05Dh,04Dh,0C3h; raw:AA76
X02C_1E label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,07Eh,006h,057h; ovr_1c75_7a72:AA76

   	     db	     0E8h,02Bh,0FFh,08Bh,0F0h,08Eh,006h,09Ah,063h,026h,089h,03Ch,083h,0FFh  ; ovr_1c75_7a72:AA84
   	     db	     015h,075h,005h,0E8h,07Eh,0FFh,0EBh,00Dh,083h,0FFh,013h,074h,005h,083h  ; ovr_1c75_7a72:AA92
   	     db	     0FFh,014h,075h,00Bh,0E8h,09Bh,0FFh,08Eh,006h,09Ah,063h,026h,089h,044h  ; ovr_1c75_7a72:AAA0
   	     db	     005h,08Bh,0C6h,05Fh,05Eh,05Dh,0CAh,002h,000h; raw:AAAE

X02C_23 label   far
   	     db	     055h,08Bh,0ECh,056h,08Bh; ovr_1c75_7a72:AAAE
   	     db	     076h,006h,08Eh,006h,09Ah,063h,026h,08Bh,01Ch,083h,0EBh,00Dh,083h,0FBh  ; ovr_1c75_7a72:AABC
   	     db	     008h,077h,020h,0D1h,0E3h,02Eh,0FFh,0A7h,0DAh,003h,0EBh,017h,0EBh,015h  ; ovr_1c75_7a72:AACA
   	     db	     0EBh,013h,08Eh,006h,09Ah,063h,026h,08Bh,05Ch,005h,08Eh,006h,03Eh,05Fh  ; ovr_1c75_7a72:AAD8
   	     db	     026h,08Bh,007h,0EBh,00Ah,0EBh,0EDh,08Eh,006h,09Ah,063h,026h,08Bh,044h  ; ovr_1c75_7a72:AAE6
   	     db	     005h,05Eh,05Dh,0CAh,002h,000h,0B4h,003h,0B4h,003h,0CDh,003h,0B4h,003h  ; ovr_1c75_7a72:AAF4
   	     db	     0B6h,003h,0B8h,003h,0BAh,003h,0BAh,003h,0CBh,003h;	raw:AB02

X02C_07 label   far
   	     db	     055h,08Bh,0ECh,056h; ovr_1c75_7a72:AB02
   	     db	     057h,08Bh,076h,008h,08Bh,07Eh,006h,08Eh,006h,09Ah,063h,026h,08Bh,01Ch  ; ovr_1c75_7a72:AB10
   	     db	     083h,0EBh,00Dh,083h,0FBh,008h,077h,020h,0D1h,0E3h,02Eh,0FFh,0A7h,034h  ; ovr_1c75_7a72:AB1E
   	     db	     004h,0EBh,017h,0EBh,015h,0EBh,013h,08Eh,006h,09Ah,063h,026h,08Bh,05Ch  ; ovr_1c75_7a72:AB2C
   	     db	     005h,08Eh,006h,03Eh,05Fh,026h,089h,03Fh,0EBh,00Ah,0EBh,0EDh,08Eh,006h  ; ovr_1c75_7a72:AB3A
   	     db	     09Ah,063h,026h,089h,07Ch,005h,05Fh,05Eh,05Dh,0CAh,004h,000h,00Dh,004h  ; ovr_1c75_7a72:AB48
   	     db	     00Dh,004h,026h,004h,00Dh,004h,00Fh,004h,011h,004h,013h,004h,013h,004h  ; ovr_1c75_7a72:AB56
   	     db	     024h,004h;	raw:AB64
X02C_18 label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,07Eh,006h,01Eh,0B8h,010h,064h;	    ovr_1c75_7a72:AB64
   	     db	     050h,08Bh,0DFh,0D1h,0E3h,0A0h,0A0h,062h,0B4h,000h,003h,0D8h,08Ah,087h  ; ovr_1c75_7a72:AB72
   	     db	     0D2h,014h,098h,050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F0h,0FFh,036h,010h; ovr_1c75_7a72:AB80
   	     db	     064h,056h,033h,0C0h,050h,08Bh,0DFh,0D1h,0E3h,0A0h,0A0h,062h,0B4h,000h  ; ovr_1c75_7a72:AB8E
   	     db	     003h,0D8h,08Ah,087h,0D2h,014h,098h,050h,09Ah

   	     dw	     03h
   	     dw	     seg BCC_FAR_AF23
   	     db	     08Eh; ovr_1c75_7a72:AB9C
   	     db	     006h,010h,064h,08Bh,046h,008h,026h,089h,044h,002h,08Bh,0C6h,05Fh,05Eh  ; ovr_1c75_7a72:ABAA
   	     db	     05Dh,0CAh,004h,000h; raw:ABB8
X02C_22 label   far
   	     db	     055h,08Bh,0ECh,04Ch,04Ch,056h,057h,08Bh,07Eh,008h;	ovr_1c75_7a72:ABB8

   	     db	     057h,0FFh,076h,006h,00Eh,0E8h,098h,0FFh,08Bh,0F0h,08Bh,01Eh,098h,063h  ; ovr_1c75_7a72:ABC6
   	     db	     08Eh,006h,02Ah,078h,026h,08Bh,047h,004h,089h,046h,0FEh,00Bh,0FFh,074h  ; ovr_1c75_7a72:ABD4
   	     db	     017h,057h,0FFh,076h,0FEh,090h,00Eh,0E8h,096h,001h,00Bh,0C0h,074h,00Ah  ; ovr_1c75_7a72:ABE2
   	     db	     0B8h,0ADh,000h,050h,057h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO019_TEXT
   	     db	     08Bh,046h,0FEh,03Bh; ovr_1c75_7a72:ABF0
   	     db	     006h,0DCh,063h,075h,033h,08Eh,006h,010h,064h,026h,08Bh,05Ch,002h,08Eh  ; ovr_1c75_7a72:ABFE
   	     db	     006h,032h,078h,026h,08Bh,007h,08Eh,006h,010h,064h,026h,089h,004h,026h  ; ovr_1c75_7a72:AC0C
   	     db	     08Bh,05Ch,002h,08Eh,006h,032h,078h,026h,089h,037h,08Eh,006h,010h,064h  ; ovr_1c75_7a72:AC1A
   	     db	     026h,08Ah,044h,007h,024h,0F8h,00Ch,001h,026h,088h,044h,007h,0EBh,016h  ; ovr_1c75_7a72:AC28
   	     db	     08Eh,006h,010h,064h,08Bh,046h,0FEh,026h,089h,004h,08Bh,01Eh,098h,063h  ; ovr_1c75_7a72:AC36
   	     db	     08Eh,006h,02Ah,078h,026h,089h,077h,004h,08Bh,0C6h,05Fh,05Eh,08Bh,0E5h  ; ovr_1c75_7a72:AC44
   	     db	     05Dh,0CAh,004h,000h; raw:AC52
X02C_02 label   far
   	     db	     055h,08Bh,0ECh,04Ch,04Ch,056h,057h,08Bh,07Eh,006h;	ovr_1c75_7a72:AC52

   	     db	     057h,0B8h,001h,000h,050h,00Eh,0E8h,0FDh,0FEh,08Bh,0F0h,08Bh,01Eh,098h  ; ovr_1c75_7a72:AC60
   	     db	     063h,08Eh,006h,02Ah,078h,026h,08Bh,047h,006h,089h,046h,0FEh,057h,0FFh  ; ovr_1c75_7a72:AC6E
   	     db	     076h,0FEh,090h,00Eh,0E8h,0FFh,000h,00Bh,0C0h,074h,00Ah,0B8h,0ADh,000h  ; ovr_1c75_7a72:AC7C
   	     db	     050h,057h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO019_TEXT
   	     db	     08Bh,046h,0FEh,03Bh,006h,0C6h,05Eh; ovr_1c75_7a72:AC8A
   	     db	     075h,033h,08Eh,006h,010h,064h,026h,08Bh,05Ch,002h,08Eh,006h,032h,078h  ; ovr_1c75_7a72:AC98
   	     db	     026h,08Bh,007h,08Eh,006h,010h,064h,026h,089h,004h,026h,08Bh,05Ch,002h  ; ovr_1c75_7a72:ACA6
   	     db	     08Eh,006h,032h,078h,026h,089h,037h,08Eh,006h,010h,064h,026h,08Ah,044h  ; ovr_1c75_7a72:ACB4
   	     db	     007h,024h,0F8h,00Ch,002h,026h,088h,044h,007h,0EBh,016h,08Eh,006h,010h  ; ovr_1c75_7a72:ACC2
   	     db	     064h,08Bh,046h,0FEh,026h,089h,004h,08Bh,01Eh,098h,063h,08Eh,006h,02Ah  ; ovr_1c75_7a72:ACD0
   	     db	     078h,026h,089h,077h,006h,08Bh,0C6h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h  ; ovr_1c75_7a72:ACDE
   	     db	     000h; raw:ACEC
X02C_06 label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,07Eh,008h,08Eh,006h,0A4h,078h,026h;	    ovr_1c75_7a72:ACEC
   	     db	     0FFh,075h,002h,0B8h,008h,000h,050h,00Eh,0E8h,0B7h,0FEh,08Bh,0F0h,08Eh  ; ovr_1c75_7a72:ACFA
   	     db	     006h,010h,064h,026h,08Ah,044h,007h,024h,007h,00Ch,070h,026h,088h,044h  ; ovr_1c75_7a72:AD08
   	     db	     007h,08Eh,006h,0A4h,078h,026h,08Bh,045h,008h,08Eh,006h,010h,064h,026h  ; ovr_1c75_7a72:AD16
   	     db	     089h,044h,004h,026h,089h,07Ch,008h,08Bh,046h,006h,026h,089h,044h,00Ah  ; ovr_1c75_7a72:AD24
   	     db	     05Fh,05Eh,05Dh,0CAh,004h,000h; raw:AD32
X02C_0B label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,07Eh,008h; ovr_1c75_7a72:AD32

   	     db	     08Bh,056h,006h,08Eh,006h,032h,078h,026h,08Bh,035h,08Eh,006h,010h,064h  ; ovr_1c75_7a72:AD40
   	     db	     026h,08Ah,044h,007h,0B4h,000h,025h,007h,000h,03Bh,0C2h,075h,002h,0EBh  ; ovr_1c75_7a72:AD4E
   	     db	     01Dh,08Eh,006h,010h,064h,026h,08Bh,034h,026h,08Ah,044h,007h,0B4h,000h  ; ovr_1c75_7a72:AD5C
   	     db	     025h,007h,000h,03Bh,0C2h,075h,002h,0EBh,007h,08Eh,006h,010h,064h,026h  ; ovr_1c75_7a72:AD6A
   	     db	     08Bh,034h,08Bh,0C6h,05Fh,05Eh,05Dh,0CAh,004h,000h;	raw:AD78

X02C_08 label   far
   	     db	     055h,08Bh,0ECh,056h; ovr_1c75_7a72:AD78
   	     db	     057h,08Bh,07Eh,008h,08Bh,076h,006h,03Bh,036h,0DCh,063h,075h,00Bh,057h  ; ovr_1c75_7a72:AD86
   	     db	     0B8h,001h,000h,050h,00Eh,0E8h,09Ch,0FFh,0EBh,02Ah,03Bh,036h,0C6h,05Eh  ; ovr_1c75_7a72:AD94
   	     db	     075h,006h,057h,0B8h,002h,000h,0EBh,0EDh,08Eh,006h,010h,064h,026h,089h  ; ovr_1c75_7a72:ADA2
   	     db	     03Eh,002h,000h,0EBh,007h,08Eh,006h,010h,064h,026h,08Bh,034h,08Eh,006h  ; ovr_1c75_7a72:ADB0
   	     db	     010h,064h,026h,039h,07Ch,002h,075h,0EFh,08Bh,0C6h,05Fh,05Eh,05Dh,0CAh  ; ovr_1c75_7a72:ADBE
   	     db	     004h,000h;	raw:ADCC
X02C_19 label   far
   	     db	     055h,08Bh,0ECh,056h,057h,033h,0FFh,08Bh,036h,098h,063h,0EBh;	    ovr_1c75_7a72:ADCC
   	     db	     04Ah,0FFh,076h,006h,08Eh,006h,02Ah,078h,026h,0FFh,074h,004h,00Eh,0E8h  ; ovr_1c75_7a72:ADDA
   	     db	     098h,0FFh,08Bh,0F8h,080h,03Eh,0A0h,062h,000h,074h,015h,00Bh,0FFh,075h  ; ovr_1c75_7a72:ADE8
   	     db	     011h,0FFh,076h,006h,08Eh,006h,02Ah,078h,026h,0FFh,074h,006h,00Eh,0E8h  ; ovr_1c75_7a72:ADF6
   	     db	     07Ch,0FFh,08Bh,0F8h,00Bh,0FFh,075h,01Fh,080h,03Eh,0A0h,062h,000h,074h  ; ovr_1c75_7a72:AE04
   	     db	     00Bh,08Eh,006h,02Ah,078h,026h,080h,07Ch,014h,000h,075h,00Dh,08Eh,006h  ; ovr_1c75_7a72:AE12
   	     db	     02Ah,078h,026h,08Bh,034h,03Bh,036h,0C0h,063h,075h,0B0h,08Bh,0C7h,05Fh  ; ovr_1c75_7a72:AE20
   	     db	     05Eh,05Dh,0CAh,002h,000h; raw:AE2E
X02C_12 label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,07Eh,006h,057h; ovr_1c75_7a72:AE2E

   	     db	     00Eh,0E8h,08Eh,0FFh,08Bh,0F0h,00Bh,0F6h,075h,00Bh,057h,0FFh,036h,0DCh  ; ovr_1c75_7a72:AE3C
   	     db	     063h,00Eh,0E8h,033h,0FFh,08Bh,0F0h,080h,03Eh,0A0h,062h,000h,074h,00Fh  ; ovr_1c75_7a72:AE4A
   	     db	     00Bh,0F6h,075h,00Bh,057h,0FFh,036h,0C6h,05Eh,00Eh,0E8h,01Dh,0FFh,08Bh  ; ovr_1c75_7a72:AE58
   	     db	     0F0h,08Bh,0C6h,05Fh,05Eh,05Dh,0CAh,002h,000h; raw:AE66

X02C_03 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh; ovr_1c75_7a72:AE66
   	     db	     00Ch,08Ch,05Eh,0FEh,0C7h,046h,0FCh,0DAh,066h,08Ch,05Eh,0FAh,0C7h,046h  ; ovr_1c75_7a72:AE74
   	     db	     0F8h,01Ah,067h,08Ch,05Eh,0F6h,0C7h,046h,0F4h,05Ah,067h,0EBh,020h,0C4h  ; ovr_1c75_7a72:AE82
   	     db	     05Eh,0F4h,033h,0C0h,026h,089h,007h,0C4h,05Eh,0F8h,026h,089h,007h,0C4h  ; ovr_1c75_7a72:AE90
   	     db	     05Eh,0FCh,026h,089h,007h,083h,046h,0FCh,002h,083h,046h,0F8h,002h,083h  ; ovr_1c75_7a72:AE9E
   	     db	     046h,0F4h,002h,081h,07Eh,0FCh,01Ah,067h,072h,0D9h,08Bh,0E5h,05Dh,0CBh  ; ovr_1c75_7a72:AEAC
X02C_04 label   far
   	     db	     055h,08Bh,0ECh,04Ch,04Ch,056h,057h,08Bh,076h,00Ah,08Bh,07Eh,008h,08Bh; ovr_1c75_7a72:AEBA
   	     db	     0C6h,033h,0C7h,0B1h,004h,0D3h,0E8h,08Bh,0D6h,033h,0D7h,003h,0D0h,083h  ; ovr_1c75_7a72:AEC8
   	     db	     0E2h,01Fh,089h,056h,0FEh,08Bh,05Eh,0FEh,0D1h,0E3h,089h,0BFh,0DAh,066h  ; ovr_1c75_7a72:AED6
   	     db	     08Bh,05Eh,0FEh,0D1h,0E3h,089h,0B7h,01Ah,067h,08Bh,05Eh,0FEh,0D1h,0E3h  ; ovr_1c75_7a72:AEE4
   	     db	     08Bh,046h,006h,089h,087h,05Ah,067h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,006h  ; ovr_1c75_7a72:AEF2
   	     db	     000h; raw:AF00
X02C_13 label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,046h,008h,08Bh,0F8h,08Bh,076h,006h;	    ovr_1c75_7a72:AF00
   	     db	     033h,0C6h,08Bh,0D8h,0B1h,004h,0D3h,0E8h,003h,0D8h,083h,0E3h,01Fh,0D1h  ; ovr_1c75_7a72:AF0E
   	     db	     0E3h,03Bh,0BFh,01Ah,067h,075h,00Ch,03Bh,0B7h,0DAh,066h,075h,006h,08Bh  ; ovr_1c75_7a72:AF1C
   	     db	     087h,05Ah,067h,0EBh,034h,089h,0BFh,01Ah,067h,089h,0B7h,0DAh,066h,087h  ; ovr_1c75_7a72:AF2A
   	     db	     0DEh,08Eh,006h,09Ah,063h,026h,08Bh,05Fh,005h,08Eh,006h,03Eh,05Fh,026h  ; ovr_1c75_7a72:AF38
   	     db	     08Bh,05Fh,002h,08Eh,006h,0A4h,078h,026h,089h,03Eh,002h,000h,0EBh,003h  ; ovr_1c75_7a72:AF46
   	     db	     026h,08Bh,01Fh,026h,03Bh,07Fh,002h,075h,0F7h,08Bh,0C3h,089h,084h,05Ah  ; ovr_1c75_7a72:AF54
   	     db	     067h,05Fh,05Eh,05Dh,0CAh,004h,000h; raw:AF62
X02C_1F label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,03Eh; ovr_1c75_7a72:AF62
   	     db	     098h,063h,0EBh,01Eh,0FFh,076h,006h,08Eh,006h,02Ah,078h,026h,0FFh,075h  ; ovr_1c75_7a72:AF70
   	     db	     006h,00Eh,0E8h,0FFh,0FDh,08Bh,0F0h,00Bh,0F6h,074h,002h,0EBh,042h,08Eh  ; ovr_1c75_7a72:AF7E
   	     db	     006h,02Ah,078h,026h,08Bh,03Dh,03Bh,03Eh,0C0h,063h,075h,0DCh,08Eh,006h  ; ovr_1c75_7a72:AF8C
   	     db	     010h,064h,026h,0A0h,007h,000h,024h,0F8h,00Ch,002h,026h,0A2h,007h,000h  ; ovr_1c75_7a72:AF9A
   	     db	     08Eh,006h,032h,078h,08Bh,05Eh,006h,026h,08Bh,037h,0EBh,007h,08Eh,006h  ; ovr_1c75_7a72:AFA8
   	     db	     010h,064h,026h,08Bh,034h,08Eh,006h,010h,064h,026h,08Ah,044h,007h,0B4h  ; ovr_1c75_7a72:AFB6
   	     db	     000h,025h,007h,000h,03Dh,002h,000h,075h,0E7h,08Bh,0C6h,05Fh,05Eh,05Dh  ; ovr_1c75_7a72:AFC4
   	     db	     0CAh,002h,000h; raw:AFD2
X02C_01 label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,07Eh,008h,057h,0FFh,036h;		    ovr_1c75_7a72:AFD2
   	     db	     0E8h,062h,00Eh,0E8h,01Bh,0FFh,08Bh,0F0h,00Bh,0F6h,074h,019h,08Eh,006h  ; ovr_1c75_7a72:AFE0
   	     db	     0A4h,078h,026h,08Ah,044h,004h,0B4h,000h,0A9h,080h,000h,075h,00Ah,0B8h  ; ovr_1c75_7a72:AFEE
   	     db	     0ADh,000h,050h,057h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO019_TEXT
   	     db	     0FFh,076h,006h,00Eh,0E8h; ovr_1c75_7a72:AFFC
   	     db	     014h,0F7h,08Bh,0F0h,08Bh,01Eh,0E8h,062h,08Eh,006h,09Ah,063h,026h,08Bh  ; ovr_1c75_7a72:B00A
   	     db	     05Fh,005h,08Eh,006h,03Eh,05Fh,026h,08Bh,047h,002h,08Eh,006h,0A4h,078h  ; ovr_1c75_7a72:B018
   	     db	     026h,089h,004h,08Bh,01Eh,0E8h,062h,08Eh,006h,09Ah,063h,026h,08Bh,05Fh  ; ovr_1c75_7a72:B026
   	     db	     005h,08Eh,006h,03Eh,05Fh,026h,089h,077h,002h,08Eh,006h,0A4h,078h,026h  ; ovr_1c75_7a72:B034
   	     db	     089h,07Ch,002h,057h,0FFh,036h,0E8h,062h,056h,00Eh,0E8h,06Bh,0FEh,08Eh  ; ovr_1c75_7a72:B042
   	     db	     006h,0A4h,078h,026h,08Ah,044h,004h,024h,0FCh,08Ah,056h,006h,080h,0E2h  ; ovr_1c75_7a72:B050
   	     db	     003h,00Ah,0C2h,026h,088h,044h,004h,026h,08Ah,044h,004h,024h,0E3h,08Ah  ; ovr_1c75_7a72:B05E
   	     db	     016h,0F4h,062h,080h,0E2h,007h,0D0h,0E2h,0D0h,0E2h,00Ah,0C2h,026h,088h  ; ovr_1c75_7a72:B06C
   	     db	     044h,004h,08Bh,0C6h,05Fh,05Eh,05Dh,0CAh,004h,000h;	raw:B07A

X02C_05 label   far
   	     db	     055h,08Bh,0ECh,056h; ovr_1c75_7a72:B07A
   	     db	     0FFh,076h,00Eh,0FFh,076h,00Ch,033h,0C0h,050h,09Ah

   	     dw	     020h
   	     dw	     seg CO02F_TEXT
   	     db	     050h,0B8h,006h,000h,050h,00Eh,0E8h,0C7h,0FAh,08Bh,0F0h,08Eh,006h,010h  ; ovr_1c75_7a72:B096
   	     db	     064h,026h,08Ah,044h,007h,024h,0F8h,00Ch,001h,026h,088h,044h,007h,026h  ; ovr_1c75_7a72:B0A4
   	     db	     08Ah,044h,007h,024h,007h,00Ch,010h,026h,088h,044h,007h,026h,08Bh,05Ch  ; ovr_1c75_7a72:B0B2
   	     db	     002h,08Eh,006h,032h,078h,026h,08Bh,007h,08Eh,006h,010h,064h,026h,089h  ; ovr_1c75_7a72:B0C0
   	     db	     004h,026h,08Bh,05Ch,002h,08Eh,006h,032h,078h,026h,089h,037h,08Eh,006h  ; ovr_1c75_7a72:B0CE
   	     db	     010h,064h,08Bh,046h,00Ah,026h,089h,044h,004h,026h,0C7h,044h,008h,000h  ; ovr_1c75_7a72:B0DC
   	     db	     000h,08Bh,046h,008h,026h,089h,044h,00Ah,080h,03Eh,0A0h,062h,000h,074h  ; ovr_1c75_7a72:B0EA
   	     db	     017h,08Bh,046h,006h,026h,089h,044h,00Fh,026h,0C7h,044h,011h,001h,000h  ; ovr_1c75_7a72:B0F8
   	     db	     026h,08Ah,044h,00Ch,024h,0FCh,026h,088h,044h,00Ch,08Bh,0C6h,05Eh,05Dh  ; ovr_1c75_7a72:B106
   	     db	     0CAh,00Ah,000h; raw:B114
X02C_20 label   far
   	     db	     055h,08Bh,0ECh,056h,01Eh,0B8h,02Ah,078h,050h,0B8h,015h;		    ovr_1c75_7a72:B114
   	     db	     000h,050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F0h,08Eh,006h,02Ah,078h,026h; ovr_1c75_7a72:B122
   	     db	     0C7h,004h,000h,000h,026h,0C7h,044h,004h,000h,000h,026h,0C7h,044h,006h  ; ovr_1c75_7a72:B130
   	     db	     000h,000h,0A1h,014h,064h,026h,089h,044h,00Ah,0A1h,09Eh,063h,026h,089h  ; ovr_1c75_7a72:B13E
   	     db	     044h,00Ch,0A1h,00Ah,05Fh,026h,089h,044h,002h,026h,0C7h,044h,008h,000h  ; ovr_1c75_7a72:B14C
   	     db	     000h,026h,0C7h,044h,00Eh,000h,000h,0A1h,00Ch,05Fh,026h,089h,044h,012h  ; ovr_1c75_7a72:B15A
   	     db	     026h,0C7h,044h,010h,000h,000h,026h,0C6h,044h,014h,000h,08Bh,0C6h,05Eh  ; ovr_1c75_7a72:B168
   	     db	     05Dh,0CBh;	raw:B176
X02C_25 label   far
   	     db	     055h,08Bh,0ECh,056h,00Eh,0E8h,097h,0FFh,08Bh,0F0h,08Bh,01Eh;	    ovr_1c75_7a72:B176
   	     db	     098h,063h,08Eh,006h,02Ah,078h,026h,08Bh,047h,010h,026h,089h,044h,010h  ; ovr_1c75_7a72:B184
   	     db	     08Ah,046h,006h,026h,088h,044h,014h,0A1h,098h,063h,026h,089h,004h,089h  ; ovr_1c75_7a72:B192
   	     db	     036h,098h,063h,05Eh,05Dh,0CAh,002h,000h; raw:B1A0

X02C_0D label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,00Ah; ovr_1c75_7a72:B1A0
   	     db	     056h,057h,08Bh,03Eh,098h,063h,03Bh,03Eh,0E2h,05Eh,074h,012h,080h,03Eh  ; ovr_1c75_7a72:B1AE
   	     db	     0A0h,062h,000h,074h,010h,08Eh,006h,02Ah,078h,026h,080h,07Dh,014h,000h  ; ovr_1c75_7a72:B1BC
   	     db	     074h,005h,0B8h,001h,000h,0EBh,002h,033h,0C0h,088h,046h,0FBh,08Ah,046h  ; ovr_1c75_7a72:B1CA
   	     db	     006h,0B4h,000h,00Bh,0C0h,074h,003h,0E9h,0D7h,000h,08Eh,006h,02Ah,078h  ; ovr_1c75_7a72:B1D8
   	     db	     026h,08Bh,075h,004h,0E9h,0C5h,000h,08Eh,006h,010h,064h,026h,083h,07Ch  ; ovr_1c75_7a72:B1E6
   	     db	     002h,000h,075h,003h,0E9h,0B0h,000h,0C7h,046h,0F6h,000h,000h,026h,08Ah  ; ovr_1c75_7a72:B1F4
   	     db	     044h,007h,0B4h,000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,03Dh,004h,000h,074h  ; ovr_1c75_7a72:B202
   	     db	     022h,03Dh,005h,000h,074h,01Dh,03Dh,006h,000h,074h,002h,0EBh,06Bh,08Eh  ; ovr_1c75_7a72:B210
   	     db	     006h,010h,064h,026h,08Ah,044h,006h,0B4h,000h,0A9h,004h,000h,075h,05Ch  ; ovr_1c75_7a72:B21E
   	     db	     0C7h,046h,0F6h,063h,001h,0EBh,055h,08Eh,006h,010h,064h,026h,08Ah,044h  ; ovr_1c75_7a72:B22C
   	     db	     006h,0B4h,000h,0A9h,007h,000h,075h,007h,0C7h,046h,0F6h,07Ch,001h,0EBh  ; ovr_1c75_7a72:B23A
   	     db	     03Fh,08Eh,006h,010h,064h,026h,08Ah,044h,006h,0B4h,000h,0A9h,004h,000h  ; ovr_1c75_7a72:B248
   	     db	     075h,030h,026h,08Bh,05Ch,004h,08Eh,006h,09Ah,063h,026h,08Bh,01Fh,0F6h  ; ovr_1c75_7a72:B256
   	     db	     087h,0CAh,009h,014h,074h,018h,08Eh,006h,010h,064h,026h,08Bh,05Ch,004h  ; ovr_1c75_7a72:B264
   	     db	     08Eh,006h,09Ah,063h,026h,0F6h,047h,002h,020h,074h,005h,0B8h,07Ch,001h  ; ovr_1c75_7a72:B272
   	     db	     0EBh,003h,0B8h,073h,001h,089h,046h,0F6h,083h,07Eh,0F6h,000h,074h,01Dh  ; ovr_1c75_7a72:B280
   	     db	     0FFh,076h,0F6h,08Eh,006h,010h,064h,026h,0FFh,074h,002h,09Ah

   	     dw	     02Ah
   	     dw	     seg CO019_TEXT
   	     db	     052h,050h,033h,0C0h,033h,0D2h,050h,052h,09Ah

   	     dw	     03Eh
   	     dw	     seg CO019_TEXT
   	     db	     08Eh,006h,010h,064h,026h,08Bh,034h,00Bh,0F6h,074h,003h,0E9h,034h;	    ovr_1c75_7a72:B28E
   	     db	     0FFh,0A1h,008h,05Fh,0E9h,0B9h,000h,080h,07Eh,0FBh,000h,074h,050h,08Ah  ; ovr_1c75_7a72:B2B8
   	     db	     046h,006h,0B4h,000h,00Bh,0C0h,075h,047h,080h,03Eh,0A0h,062h,000h,075h  ; ovr_1c75_7a72:B2C6
   	     db	     003h,0E9h,096h,000h,0EBh,02Bh,08Bh,05Eh,0FCh,08Eh,006h,0B2h,063h,026h  ; ovr_1c75_7a72:B2D4
   	     db	     08Bh,047h,00Bh,089h,046h,0FEh,08Eh,006h,0A6h,063h,08Bh,05Eh,0FEh,026h  ; ovr_1c75_7a72:B2E2
   	     db	     08Bh,007h,08Bh,05Eh,0FCh,08Eh,006h,0B2h,063h,026h,089h,047h,00Bh,0FFh  ; ovr_1c75_7a72:B2F0
   	     db	     076h,0FEh,09Ah
   	     dw	     0F2h
   	     dw	     seg CO00F_TEXT
   	     db	     08Bh,05Eh,0FCh,08Eh,006h,0B2h,063h; ovr_1c75_7a72:B2FE
   	     db	     026h,083h,07Fh,00Bh,000h,075h,0C7h,0EBh,059h,08Bh,05Eh,0FCh,08Eh,006h  ; ovr_1c75_7a72:B30C
   	     db	     0B2h,063h,026h,08Bh,047h,008h,08Eh,006h,02Ah,078h,026h,03Bh,045h,012h  ; ovr_1c75_7a72:B31A
   	     db	     07Eh,00Eh,08Eh,006h,0B2h,063h,026h,08Bh,047h,008h,03Bh,006h,00Ch,05Fh  ; ovr_1c75_7a72:B328
   	     db	     07Eh,023h,08Bh,05Eh,0FCh,08Eh,006h,0B2h,063h,026h,08Bh,047h,006h,08Eh  ; ovr_1c75_7a72:B336
   	     db	     006h,02Ah,078h,026h,03Bh,045h,012h,07Eh,021h,08Eh,006h,0B2h,063h,026h  ; ovr_1c75_7a72:B344
   	     db	     08Bh,047h,006h,03Bh,006h,00Ch,05Fh,07Fh,013h,08Eh,006h,02Ah,078h,026h  ; ovr_1c75_7a72:B352
   	     db	     08Bh,045h,012h,08Bh,05Eh,0FCh,08Eh,006h,0B2h,063h,026h,089h,047h,008h  ; ovr_1c75_7a72:B360
   	     db	     08Eh,006h,0B2h,063h,08Bh,05Eh,0FCh,026h,08Bh,007h,089h,046h,0FCh,083h  ; ovr_1c75_7a72:B36E
   	     db	     07Eh,0FCh,000h,074h,003h,0E9h,03Bh,0FFh,08Eh,006h,02Ah,078h,026h,08Bh  ; ovr_1c75_7a72:B37C
   	     db	     045h,012h,0A3h,00Ch,05Fh,026h,08Bh,005h,0A3h,098h,063h,080h,07Eh,006h  ; ovr_1c75_7a72:B38A
   	     db	     000h,074h,00Eh,026h,08Bh,045h,010h,08Bh,01Eh,098h,063h,026h,089h,047h  ; ovr_1c75_7a72:B398
   	     db	     010h,0EBh,053h,08Eh,006h,02Ah,078h,026h,08Bh,075h,004h,0EBh,045h,08Eh  ; ovr_1c75_7a72:B3A6
   	     db	     006h,010h,064h,026h,08Bh,004h,089h,046h,0F8h,026h,08Ah,044h,007h,0B4h  ; ovr_1c75_7a72:B3B4
   	     db	     000h,0D1h,0F8h,0D1h,0F8h,0D1h,0F8h,03Dh,002h,000h,075h,027h,026h,08Ah  ; ovr_1c75_7a72:B3C2
   	     db	     044h,007h,024h,0F8h,026h,088h,044h,007h,026h,08Bh,05Ch,002h,08Eh,006h  ; ovr_1c75_7a72:B3D0
   	     db	     032h,078h,026h,08Bh,007h,08Eh,006h,010h,064h,026h,089h,004h,026h,08Bh  ; ovr_1c75_7a72:B3DE
   	     db	     05Ch,002h,08Eh,006h,032h,078h,026h,089h,037h,08Bh,076h,0F8h,00Bh,0F6h  ; ovr_1c75_7a72:B3EC
   	     db	     075h,0B7h,080h,07Eh,0FBh,000h,074h,027h,08Ah,046h,006h,0B4h,000h,00Bh  ; ovr_1c75_7a72:B3FA
   	     db	     0C0h,075h,01Eh,0C7h,006h,016h,064h,000h,000h,08Eh,006h,02Ah,078h,026h  ; ovr_1c75_7a72:B408
   	     db	     08Bh,045h,00Ah,0A3h,014h,064h,0C7h,006h,0A0h,063h,000h,000h,026h,08Bh  ; ovr_1c75_7a72:B416
   	     db	     045h,00Ch,0A3h,09Eh,063h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h;	    raw:B424
X02C_1C label   far
   	     db	     055h; ovr_1c75_7a72:B424
   	     db	     08Bh,0ECh,056h,01Eh,0B8h,0B2h,063h,050h,0B8h,00Dh,000h,050h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F0h,0FFh,036h,0B2h,063h,056h,033h,0C0h,050h,0B8h;		    ovr_1c75_7a72:B432
   	     db	     00Dh,000h,050h,09Ah
   	     dw	     03h
   	     dw	     seg BCC_FAR_AF23
   	     db	     08Eh,006h,0B2h,063h,0A1h,008h; ovr_1c75_7a72:B44E
   	     db	     05Fh,026h,089h,004h,089h,036h,008h,05Fh,026h,0C7h,044h,008h,0FFh,07Fh  ; ovr_1c75_7a72:B45C
   	     db	     08Bh,0C6h,05Eh,05Dh,0CBh; raw:B46A
X02C_1A label   far
   	     db	     055h,08Bh,0ECh,056h,01Eh,0B8h,0B2h,063h,050h; ovr_1c75_7a72:B46A

   	     db	     0B8h,00Ah,000h,050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F0h,0FFh,036h,0B2h; ovr_1c75_7a72:B478
   	     db	     063h,056h,033h,0C0h,050h,0B8h,00Ah,000h,050h,09Ah

   	     dw	     03h
   	     dw	     seg BCC_FAR_AF23
   	     db	     08Eh,006h,0B2h,063h,0A1h,006h,05Fh,026h,089h,004h,089h,036h,006h,05Fh  ; ovr_1c75_7a72:B494
   	     db	     08Bh,0C6h,05Eh,05Dh,0CBh; raw:B4A2
X02C_0E label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,010h,056h,057h,08Bh; ovr_1c75_7a72:B4A2

   	     db	     076h,006h,08Eh,006h,010h,064h,026h,08Ah,044h,007h,0B4h,000h,0D1h,0F8h  ; ovr_1c75_7a72:B4B0
   	     db	     0D1h,0F8h,0D1h,0F8h,03Dh,00Eh,000h,075h,00Bh,026h,0FFh,074h,00Ah,00Eh  ; ovr_1c75_7a72:B4BE
   	     db	     0E8h,0D8h,0FFh,0E9h,0A0h,001h,08Eh,006h,010h,064h,026h,083h,07Ch,008h  ; ovr_1c75_7a72:B4CC
   	     db	     000h,074h,003h,0E9h,08Ah,001h,08Eh,006h,010h,064h,026h,08Bh,07Ch,004h  ; ovr_1c75_7a72:B4DA
   	     db	     026h,08Ah,044h,006h,088h,046h,0FFh,026h,08Ah,044h,007h,0B4h,000h,0D1h  ; ovr_1c75_7a72:B4E8
   	     db	     0F8h,0D1h,0F8h,0D1h,0F8h,089h,046h,0FCh,016h,08Dh,046h,0F2h,050h,033h  ; ovr_1c75_7a72:B4F6
   	     db	     0C0h,050h,0B8h,00Ah,000h,050h,09Ah
   	     dw	     03h
   	     dw	     seg BCC_FAR_AF23
   	     db	     08Eh,006h,09Ah; ovr_1c75_7a72:B504
   	     db	     063h,026h,083h,03Dh,012h,075h,010h,0F6h,046h,0FFh,080h,074h,005h,0B8h  ; ovr_1c75_7a72:B512
   	     db	     0FFh,0FFh,0EBh,003h,0A1h,064h,086h,0EBh,05Ah,08Bh,05Eh,0FCh,04Bh,083h  ; ovr_1c75_7a72:B520
   	     db	     0FBh,003h,077h,04Eh,0D1h,0E3h,02Eh,0FFh,0A7h,05Ah,00Fh,0F6h,046h,0FFh  ; ovr_1c75_7a72:B52E
   	     db	     080h,075h,007h,083h,03Eh,0E6h,082h,000h,074h,007h,0C7h,046h,0F4h,0FFh  ; ovr_1c75_7a72:B53C
   	     db	     0FFh,0EBh,039h,08Eh,006h,09Ah,063h,026h,083h,03Dh,011h,075h,009h,026h  ; ovr_1c75_7a72:B54A
   	     db	     0F6h,045h,002h,040h,074h,002h,0EBh,0E6h,0F6h,046h,0FFh,080h,074h,007h  ; ovr_1c75_7a72:B558
   	     db	     09Ah
   	     dw	     02Ah
   	     dw	     seg CO035_TEXT
   	     db	     0EBh,016h,0F6h,046h,0FFh,001h,074h,005h,0A1h; ovr_1c75_7a72:B566

   	     db	     0C8h,086h,0EBh,003h,0A1h,052h,086h,089h,046h,0F4h,0EBh,006h,0A1h,052h  ; ovr_1c75_7a72:B574
   	     db	     086h,089h,046h,0F4h,08Eh,006h,09Ah,063h,026h,083h,03Dh,012h,075h,019h  ; ovr_1c75_7a72:B582
   	     db	     08Eh,006h,010h,064h,026h,08Ah,044h,00Ch,0B4h,000h,025h,003h,000h,03Dh  ; ovr_1c75_7a72:B590
   	     db	     003h,000h,075h,007h,026h,08Bh,044h,00Dh,089h,046h,0F6h,089h,076h,0F8h  ; ovr_1c75_7a72:B59E
   	     db	     0F6h,046h,0FFh,080h,074h,005h,0B8h,010h,000h,0EBh,003h,0B8h,004h,000h  ; ovr_1c75_7a72:B5AC
   	     db	     08Ah,056h,0FFh,0B6h,000h,083h,0E2h,040h,00Bh,0D0h,089h,056h,0FAh,08Eh  ; ovr_1c75_7a72:B5BA
   	     db	     006h,09Ah,063h,026h,0F6h,045h,002h,001h,074h,004h,083h,04Eh,0FAh,001h  ; ovr_1c75_7a72:B5C8
   	     db	     08Eh,006h,09Ah,063h,026h,0F6h,045h,002h,002h,074h,004h,083h,04Eh,0FAh  ; ovr_1c75_7a72:B5D6
   	     db	     002h,08Eh,006h,09Ah,063h,026h,083h,03Dh,012h,075h,00Ch,026h,0F6h,045h  ; ovr_1c75_7a72:B5E4
   	     db	     00Ch,080h,074h,005h,081h,04Eh,0FAh,000h,002h,083h,07Eh,0FCh,005h,074h  ; ovr_1c75_7a72:B5F2
   	     db	     006h,083h,07Eh,0FCh,006h,075h,032h,01Eh,0B8h,08Ah,062h,050h,0B8h,00Ah  ; ovr_1c75_7a72:B600
   	     db	     000h,050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     089h,046h,0F0h,08Eh,006h,010h,064h; ovr_1c75_7a72:B60E
   	     db	     00Dh,001h,000h,026h,089h,044h,008h,0FFh,036h,08Ah,062h,0FFh,076h,0F0h  ; ovr_1c75_7a72:B61C
   	     db	     08Dh,046h,0F2h,016h,050h,0B9h,00Ah,000h,09Ah

   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     0EBh; ovr_1c75_7a72:B62A
   	     db	     031h,01Eh,0B8h,0C2h,063h,050h,0B8h,00Ah,000h,050h,09Ah

   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     089h,046h,0F0h,0FFh,006h,080h,064h,08Eh,006h,010h,064h,026h,089h;	    ovr_1c75_7a72:B638
   	     db	     044h,008h,0FFh,036h,0C2h,063h,0FFh,076h,0F0h,08Dh,046h,0F2h,016h,050h  ; ovr_1c75_7a72:B654
   	     db	     0B9h,00Ah,000h,09Ah
   	     dw	     0402h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     08Eh,006h,010h,064h,026h,08Bh; ovr_1c75_7a72:B662
   	     db	     044h,008h,05Fh,05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h,02Dh,00Eh,019h,00Eh  ; ovr_1c75_7a72:B670
   	     db	     02Dh,00Eh,02Dh,00Eh; raw:B67E
X02C_09 label   far
   	     db	     055h,08Bh,0ECh,056h,08Bh,076h,006h,0F7h,0C6h,001h;	ovr_1c75_7a72:B67E

   	     db	     000h,074h,00Fh,08Bh,0DEh,083h,0E3h,0FEh,08Eh,006h,08Ah,062h,026h,08Bh  ; ovr_1c75_7a72:B68C
   	     db	     047h,008h,0EBh,008h,08Eh,006h,0C2h,063h,026h,08Bh,044h,008h,05Eh,05Dh  ; ovr_1c75_7a72:B69A
   	     db	     0CAh,002h,000h; raw:B6A8
X02C_00 label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,076h,008h,08Bh,07Eh,006h;		    ovr_1c75_7a72:B6A8
   	     db	     0F7h,0C6h,001h,000h,074h,00Fh,08Bh,0DEh,083h,0E3h,0FEh,08Eh,006h,08Ah  ; ovr_1c75_7a72:B6B6
   	     db	     062h,026h,009h,07Fh,008h,0EBh,008h,08Eh,006h,0C2h,063h,026h,009h,07Ch  ; ovr_1c75_7a72:B6C4
   	     db	     008h,05Fh,05Eh,05Dh,0CAh,004h,000h; raw:B6D2
X02C_0A label   far
   	     db	     055h,08Bh,0ECh,056h,08Bh,076h,006h; ovr_1c75_7a72:B6D2
   	     db	     0F7h,0C6h,001h,000h,074h,00Fh,08Bh,0DEh,083h,0E3h,0FEh,08Eh,006h,08Ah  ; ovr_1c75_7a72:B6E0
   	     db	     062h,026h,08Bh,047h,006h,0EBh,008h,08Eh,006h,0C2h,063h,026h,08Bh,044h  ; ovr_1c75_7a72:B6EE
   	     db	     006h,05Eh,05Dh,0CAh,002h,000h; raw:B6FC
X02C_0C label   far
   	     db	     055h,08Bh,0ECh,056h,057h,08Bh,076h,008h; ovr_1c75_7a72:B6FC

   	     db	     08Bh,07Eh,006h,0F7h,0C6h,001h,000h,074h,013h,08Bh,0DEh,083h,0E3h,0FEh  ; ovr_1c75_7a72:B70A
   	     db	     08Eh,006h,08Ah,062h,08Bh,0C7h,0F7h,0D0h,026h,021h,047h,008h,0EBh,00Ch  ; ovr_1c75_7a72:B718
   	     db	     08Eh,006h,0C2h,063h,08Bh,0C7h,0F7h,0D0h,026h,021h,044h,008h,05Fh,05Eh  ; ovr_1c75_7a72:B726
   	     db	     05Dh,0CAh,004h,000h; raw:B734
X02C_1D label   far
   	     db	     055h,08Bh,0ECh,0FFh,076h,008h,00Eh,0E8h,097h,0FFh;	ovr_1c75_7a72:B734

   	     db	     08Eh,006h,010h,064h,08Ah,056h,006h,08Bh,0D8h,026h,008h,057h,006h,05Dh  ; ovr_1c75_7a72:B742
   	     db	     0CAh,004h,000h; raw:B750
X02C_24 label   far
   	     db	     055h,08Bh,0ECh,0FFh,076h,006h,00Eh,0E8h,07Ch,0FFh,08Eh;		    ovr_1c75_7a72:B750
   	     db	     006h,010h,064h,08Bh,0D8h,026h,08Ah,047h,006h,0B4h,000h,05Dh,0CAh,002h  ; ovr_1c75_7a72:B75E
   	     db	     000h; raw:B76C
X02C_15 label   far
   	     db	     055h,08Bh,0ECh,056h,01Eh,0B8h,0EAh,063h,050h,0B8h,004h,000h,050h;	    ovr_1c75_7a72:B76C
   	     db	     09Ah
   	     dw	     025h
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F0h,08Eh,006h,0EAh,063h,08Bh,046h,008h; ovr_1c75_7a72:B77A

   	     db	     026h,089h,004h,08Bh,046h,006h,026h,089h,044h,002h,08Bh,0C6h,05Eh,05Dh  ; ovr_1c75_7a72:B788
   	     db	     0CAh,004h,000h; raw:B796
X02C_17 label   far
   	     db	     055h,08Bh,0ECh,01Eh,0B8h,0EAh,063h,050h,0FFh,076h,006h;		    ovr_1c75_7a72:B796
   	     db	     09Ah
   	     dw	     034h
   	     dw	     seg CO043_TEXT
   	     db	     05Dh,0CAh,002h,000h; raw:B7A4
X02C_1B label   far
   	     db	     055h,08Bh,0ECh,056h,01Eh; ovr_1c75_7a72:B7A4
   	     db	     0B8h,0E2h,063h,050h,0B8h,004h,000h,050h,09Ah

   	     dw	     025h
   	     dw	     seg CO043_TEXT
   	     db	     08Bh; ovr_1c75_7a72:B7B2
   	     db	     0F0h,08Eh,006h,0E2h,063h,08Bh,046h,008h,026h,089h,004h,08Bh,046h,006h  ; ovr_1c75_7a72:B7C0
   	     db	     026h,089h,044h,002h,08Bh,0C6h,05Eh,05Dh,0CAh,004h,000h; raw:B7CE

X02C_14 label   far
   	     db	     055h,08Bh,0ECh; ovr_1c75_7a72:B7CE
   	     db	     056h,08Bh,036h,098h,063h,0EBh,01Fh,08Eh,006h,02Ah,078h,0A1h,014h,064h  ; ovr_1c75_7a72:B7DC
   	     db	     026h,089h,044h,00Ah,080h,07Eh,006h,000h,074h,007h,0A1h,09Eh,063h,026h  ; ovr_1c75_7a72:B7EA
   	     db	     089h,044h,00Ch,08Eh,006h,02Ah,078h,026h,08Bh,034h,03Bh,036h,0C0h,063h  ; ovr_1c75_7a72:B7F8
   	     db	     075h,0DBh,05Eh,05Dh,0CAh,002h,000h; raw:B806
X02C_16 label   far
   	     db	     055h,08Bh,0ECh,056h,01Eh,0B8h,028h; ovr_1c75_7a72:B806
   	     db	     064h,050h,0B8h,00Ah,000h,050h,09Ah
   	     dw	     02Fh
   	     dw	     seg CO043_TEXT
   	     db	     08Bh,0F0h,0FFh; ovr_1c75_7a72:B814
   	     db	     036h,028h,064h,056h,033h,0C0h,050h,0B8h,00Ah,000h,050h,09Ah

   	     dw	     03h
   	     dw	     seg BCC_FAR_AF23
   	     db	     08Bh,0C6h,05Eh,05Dh,0CBh; ovr_1c75_7a72:B822

CO02C_TEXT	     ends
; END LG08B
   	     end
