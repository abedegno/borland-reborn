; Recovered FBOV far-pointer references
   	     extrn   BCC_DIAGNOSTIC:far
CO021_TEXT	     segment byte public 'CODE'
CO021_TEXT	     ends
CO02D_TEXT	     segment byte public 'CODE'
CO02D_TEXT	     ends
   	     public  X019_0A
   	     public  X019_05
   	     public  X019_04
   	     public  X019_06
   	     public  X019_07
   	     public  X019_00
   	     public  X019_01
   	     public  X019_02
   	     public  X019_03
   	     public  X019_08
   	     public  X019_09
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1c18_6916
; BEGIN LG078 (gap	ovr_1c18_6916:9160)
CO019_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO019_TEXT
; Original-image layout stub: not recovered source


   	     db	     045h,055h,08Bh,0ECh,0C4h,05Eh,004h,026h,081h,03Fh,0FFh,001h,073h,00Fh  ; ovr_1c18_6916:9160
   	     db	     026h,08Bh,007h,026h,0FFh,007h,003h,0D8h,08Ah,046h,008h,026h,088h,047h  ; ovr_1c18_6916:916E
   	     db	     002h,05Dh,04Dh,0C2h,006h,000h,045h,055h,08Bh,0ECh,04Ch,04Ch,0EBh,00Dh  ; ovr_1c18_6916:917C
   	     db	     08Ah,046h,0FFh,050h,0FFh,076h,006h,0FFh,076h,004h,0E8h,0C9h,0FFh,0C4h  ; ovr_1c18_6916:918A
   	     db	     05Eh,008h,0FFh,046h,008h,026h,08Ah,007h,088h,046h,0FFh,00Ah,0C0h,075h  ; ovr_1c18_6916:9198
   	     db	     0E3h,08Bh,0E5h,05Dh,04Dh,0C2h,008h,000h; raw:91A6

X019_09 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,006h; ovr_1c18_6916:91A6
   	     db	     056h,08Bh,076h,012h,0A1h,0BEh,066h,089h,046h,0FEh,0A1h,0C2h,066h,08Bh  ; ovr_1c18_6916:91B4
   	     db	     016h,0C0h,066h,089h,046h,0FCh,089h,056h,0FAh,081h,0FEh,04Dh,001h,07Dh  ; ovr_1c18_6916:91C2
   	     db	     005h,0C6h,006h,0AEh,063h,000h,0A0h,078h,064h,0B4h,000h,00Bh,0C0h,074h  ; ovr_1c18_6916:91D0
   	     db	     008h,083h,0FEh,00Ah,07Ch,003h,0E9h,0A8h,000h,08Bh,046h,008h,0A3h,0BEh  ; ovr_1c18_6916:91DE
   	     db	     066h,083h,03Eh,0DCh,05Eh,000h,074h,02Dh,0A0h,026h,05Fh,0B4h,000h,00Bh  ; ovr_1c18_6916:91EC
   	     db	     0C0h,075h,024h,080h,03Eh,0A0h,062h,000h,074h,00Bh,0FFh,036h,0DCh,05Eh  ; ovr_1c18_6916:91FA
   	     db	     09Ah
   	     dw	     039h
   	     dw	     seg CO021_TEXT
   	     db	     0EBh,009h,0FFh,036h,0DCh,05Eh,090h,00Eh,0E8h; ovr_1c18_6916:9208

   	     db	     00Bh,002h,089h,016h,0C2h,066h,0A3h,0C0h,066h,0EBh,00Ch,0C7h,006h,0C2h  ; ovr_1c18_6916:9216
   	     db	     066h,000h,000h,0C7h,006h,0C0h,066h,000h,000h,083h,0FEh,00Ah,07Dh,014h  ; ovr_1c18_6916:9224
   	     db	     0FFh,076h,00Ch,0FFh,076h,00Ah,0FFh,076h,010h,0FFh,076h,00Eh,056h,09Ah  ; ovr_1c18_6916:9232
   	     dw	     0D4h
   	     dw	     seg BCC_DIAGNOSTIC
   	     db	     0EBh,033h,081h,0FEh,04Dh,001h,07Dh,014h,0FFh,076h;	ovr_1c18_6916:9240

   	     db	     00Ch,0FFh,076h,00Ah,0FFh,076h,010h,0FFh,076h,00Eh,056h,09Ah

   	     dw	     011Bh
   	     dw	     seg BCC_DIAGNOSTIC
   	     db	     0EBh,019h,083h,03Eh,0CAh,05Eh,000h,075h,015h,0FFh,076h,00Ch;	    ovr_1c18_6916:924E
   	     db	     0FFh,076h,00Ah,0FFh,076h,010h,0FFh,076h,00Eh,056h,09Ah

   	     dw	     017Dh
   	     dw	     seg BCC_DIAGNOSTIC
   	     db	     083h,0C4h,00Ah,08Bh,046h,0FEh,0A3h,0BEh,066h,08Bh,046h,0FCh,08Bh;	    ovr_1c18_6916:926A
   	     db	     056h,0FAh,0A3h,0C2h,066h,089h,016h,0C0h,066h,0C7h,006h,04Eh,05Fh,000h  ; ovr_1c18_6916:9286
   	     db	     000h,05Eh,08Bh,0E5h,05Dh,0CAh,00Eh,000h; raw:9294

X019_01 label   far
   	     db	     055h,08Bh,0ECh,0FFh,076h,00Eh; ovr_1c18_6916:9294
   	     db	     0FFh,076h,00Ch,0FFh,076h,00Ah,0FFh,076h,008h,0FFh,076h,006h,0FFh,036h  ; ovr_1c18_6916:92A2
   	     db	     087h,063h,0FFh,036h,089h,063h,00Eh,0E8h,0F4h,0FEh,05Dh,0CAh,00Ah,000h  ; ovr_1c18_6916:92B0
X019_02 label   far
   	     db	     055h,08Bh,0ECh,0FFh,076h,00Eh,0FFh,076h,00Ch,0FFh,076h,00Ah,0FFh,076h; ovr_1c18_6916:92BE
   	     db	     008h,0FFh,076h,006h,0FFh,036h,087h,063h,033h,0C0h,050h,00Eh,0E8h,0D3h  ; ovr_1c18_6916:92CC
   	     db	     0FEh,05Dh,0CAh,00Ah,000h; raw:92DA
X019_06 label   far
   	     db	     055h,08Bh,0ECh,0FFh,076h,008h,0FFh,076h,006h; ovr_1c18_6916:92DA

   	     db	     090h,00Eh,0E8h,0DBh,000h,052h,050h,033h,0C0h,033h,0D2h,050h,052h,0FFh  ; ovr_1c18_6916:92E8
   	     db	     036h,087h,063h,0FFh,036h,089h,063h,00Eh,0E8h,0ADh,0FEh,05Dh,0CAh,004h  ; ovr_1c18_6916:92F6
   	     db	     000h; raw:9304
X019_07 label   far
   	     db	     055h,08Bh,0ECh,0FFh,076h,006h,0C4h,05Eh,008h,026h,083h,03Fh,031h;	    ovr_1c18_6916:9304
   	     db	     075h,006h,026h,08Bh,047h,009h,0EBh,00Ch,0C4h,05Eh,008h,026h,08Bh,01Fh  ; ovr_1c18_6916:9312
   	     db	     0D1h,0E3h,08Bh,087h,082h,061h,050h,090h,00Eh,0E8h,09Ch,000h,052h,050h  ; ovr_1c18_6916:9320
   	     db	     033h,0C0h,033h,0D2h,050h,052h,0C4h,05Eh,008h,026h,0FFh,077h,005h,026h  ; ovr_1c18_6916:932E
   	     db	     0FFh,077h,007h,00Eh,0E8h,06Bh,0FEh,05Dh,0CAh,006h,000h; raw:933C

X019_00 label   far
   	     db	     055h,08Bh,0ECh; ovr_1c18_6916:933C
   	     db	     01Eh,0B8h,082h,063h,050h,0FFh,076h,006h,00Eh,0E8h,0AFh,0FFh,05Dh,0CAh  ; ovr_1c18_6916:934A
   	     db	     002h,000h;	raw:9358
X019_0A label   far
   	     db	     055h,08Bh,0ECh,0EBh,005h,09Ah
   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     08Bh,01Eh;	ovr_1c18_6916:9358
   	     db	     0C2h,05Eh,0D1h,0E3h,0F7h,087h,0B3h,007h,000h,002h,075h,008h,0A1h,0C2h  ; ovr_1c18_6916:9366
   	     db	     05Eh,03Bh,046h,006h,075h,0E5h,05Dh,0CAh,002h,000h;	raw:9374

X019_05 label   far
   	     db	     055h,08Bh,0ECh,056h; ovr_1c18_6916:9374
   	     db	     033h,0F6h,0C6h,006h,078h,064h,001h,0EBh,005h,09Ah

   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     08Bh,01Eh,0C2h,05Eh,0D1h,0E3h,0F7h,087h,0B3h,007h,000h,010h,075h,0EDh  ; ovr_1c18_6916:9390
   	     db	     083h,03Eh,0C2h,05Eh,005h,075h,020h,083h,03Eh,0C2h,05Eh,005h,075h,001h  ; ovr_1c18_6916:939E
   	     db	     046h,083h,03Eh,0C2h,05Eh,006h,075h,001h,04Eh,09Ah

   	     dw	     025h
   	     dw	     seg CO02D_TEXT
   	     db	     00Bh,0F6h,074h,007h,083h,03Eh,0C2h,05Eh,000h,075h,0E0h,05Eh,05Dh,0CBh  ; ovr_1c18_6916:93BA
X019_04 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,008h,056h,08Bh,076h,006h,00Bh,0F6h,075h,007h; ovr_1c18_6916:93C8
   	     db	     08Ch,0DAh,0B8h,0D4h,00Fh,0EBh,03Fh,0A1h,04Eh,05Fh,005h,050h,05Fh,08Ch  ; ovr_1c18_6916:93D6
   	     db	     05Eh,0FEh,089h,046h,0FCh,08Eh,006h,032h,078h,026h,08Bh,05Ch,004h,08Bh  ; ovr_1c18_6916:93E4
   	     db	     007h,026h,08Bh,054h,002h,089h,046h,0FAh,089h,056h,0F8h,0FFh,076h,0FAh  ; ovr_1c18_6916:93F2
   	     db	     0FFh,076h,0F8h,01Eh,0B8h,04Eh,05Fh,050h,0E8h,077h,0FDh,0B0h,000h,050h  ; ovr_1c18_6916:9400
   	     db	     01Eh,0B8h,04Eh,05Fh,050h,0E8h,04Ah,0FDh,08Bh,056h,0FEh,08Bh,046h,0FCh  ; ovr_1c18_6916:940E
   	     db	     05Eh,08Bh,0E5h,05Dh,0CAh,002h,000h; raw:941C
X019_08 label   far
   	     db	     055h,08Bh,0ECh,056h,08Bh,076h,006h; ovr_1c18_6916:941C
   	     db	     08Eh,006h,010h,064h,026h,083h,07Ch,002h,000h,075h,007h,08Ch,0DAh,0B8h  ; ovr_1c18_6916:942A
   	     db	     0D4h,00Fh,0EBh,00Ch,08Eh,006h,010h,064h,026h,0FFh,074h,002h,00Eh,0E8h  ; ovr_1c18_6916:9438
   	     db	     080h,0FFh,05Eh,05Dh,0CAh,002h,000h; raw:9446
X019_03 label   far
   	     db	     055h,08Bh,0ECh,056h,08Bh,076h,006h; ovr_1c18_6916:9446
   	     db	     08Eh,006h,0A4h,078h,026h,083h,07Ch,002h,000h,075h,007h,08Ch,0DAh,0B8h  ; ovr_1c18_6916:9454
   	     db	     0D4h,00Fh,0EBh,00Ch,08Eh,006h,0A4h,078h,026h,0FFh,074h,002h,00Eh,0E8h  ; ovr_1c18_6916:9462
   	     db	     056h,0FFh,05Eh,05Dh,0CAh,002h,000h	     ; ovr_1c18_6916:9470

CO019_TEXT	     ends
; END LG078
   	     end
