; Recovered FBOV far-pointer references
   	     extrn   BCC_COPY_WORDS:far
CO00A_TEXT	     segment byte public 'CODE'
CO00A_TEXT	     ends
CO019_TEXT	     segment byte public 'CODE'
CO019_TEXT	     ends
CO02C_TEXT	     segment byte public 'CODE'
CO02C_TEXT	     ends
CO035_TEXT	     segment byte public 'CODE'
CO035_TEXT	     ends
CO049_TEXT	     segment byte public 'CODE'
CO049_TEXT	     ends
CO056_TEXT	     segment byte public 'CODE'
CO056_TEXT	     ends
   	     public  X011_01
   	     public  X011_00
   	     public  X011_02
   	     public  X011_03
   	     public  X011_04
DGROUP  group   _DATA,_BSS
_DATA   segment para public 'DATA'
_DATA   ends
_BSS    segment word public 'DATA'
_BSS    ends
; Consolidated original-order group ovr_1bf9_6410
; BEGIN LG070 (gap	ovr_1bf9_6410:4100)
CO011_TEXT	     segment byte public 'CODE'
   	     assume  cs:CO011_TEXT
; Original-image layout stub: not recovered source


   	     db	     055h,08Bh,0ECh,083h,0ECh,00Ch,056h,08Bh,076h,00Ah,0C7h,046h,0FAh,000h  ; ovr_1bf9_6410:4100
   	     db	     000h,0C7h,046h,0F8h,001h,000h,0EBh,025h,08Eh,006h,09Ah,063h,026h,08Bh  ; ovr_1bf9_6410:410E
   	     db	     04Ch,00Bh,026h,08Bh,05Ch,009h,08Bh,056h,0FAh,08Bh,046h,0F8h,09Ah

   	     dw	     03A9h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     089h,056h,0FAh,089h,046h,0F8h,08Eh,006h,09Ah,063h,026h;		    ovr_1bf9_6410:411C
   	     db	     08Bh,074h,007h,08Eh,006h,09Ah,063h,026h,083h,03Ch,011h,074h,0D1h,056h  ; ovr_1bf9_6410:4138
   	     db	     09Ah
   	     dw	     02Fh
   	     dw	     seg CO00A_TEXT
   	     db	     089h,056h,0FEh,089h,046h,0FCh,08Bh,04Eh,0FEh; ovr_1bf9_6410:4146

   	     db	     08Bh,05Eh,0FCh,08Bh,056h,0FAh,08Bh,046h,0F8h,09Ah

   	     dw	     03A9h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     089h,056h,0FAh,089h,046h,0F8h,0C4h,05Eh,006h,026h,0C7h,007h,000h,000h  ; ovr_1bf9_6410:4162
   	     db	     083h,07Eh,0FAh,001h,07Fh,00Ah,075h,006h,083h,07Eh,0F8h,000h,077h,002h  ; ovr_1bf9_6410:4170
   	     db	     0EBh,06Dh,0FFh,076h,0FEh,0FFh,076h,0FCh,09Ah

   	     dw	     020h
   	     dw	     seg CO049_TEXT
   	     db	     099h; ovr_1bf9_6410:417E
   	     db	     089h,056h,0F6h,089h,046h,0F4h,083h,07Eh,0F6h,000h,07Fh,055h,07Ch,006h  ; ovr_1bf9_6410:418C
   	     db	     083h,07Eh,0F4h,000h,073h,04Dh,0FFh,076h,0FEh,0FFh,076h,0FCh,0B8h,001h  ; ovr_1bf9_6410:419A
   	     db	     000h,033h,0D2h,050h,052h,09Ah
   	     dw	     02D2h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     089h,056h,0F6h,089h; ovr_1bf9_6410:41A8
   	     db	     046h,0F4h,08Bh,046h,0FAh,08Bh,056h,0F8h,003h,056h,0F4h,013h,046h,0F6h  ; ovr_1bf9_6410:41B6
   	     db	     03Dh,002h,000h,07Ch,00Fh,07Fh,004h,00Bh,0D2h,076h,009h,0B8h,00Ch,000h  ; ovr_1bf9_6410:41C4
   	     db	     050h,09Ah
   	     dw	     039h
   	     dw	     seg CO019_TEXT
   	     db	     08Bh,046h,0F6h,08Bh,056h,0F4h,001h,056h; ovr_1bf9_6410:41D2

   	     db	     0F8h,011h,046h,0FAh,0C4h,05Eh,006h,08Bh,046h,0F4h,026h,089h,007h,08Bh  ; ovr_1bf9_6410:41E0
   	     db	     056h,0FAh,08Bh,046h,0F8h,05Eh,08Bh,0E5h,05Dh,0CAh,006h,000h; raw:41EE

X011_01 label   far
   	     db	     055h,08Bh;	ovr_1bf9_6410:41EE
   	     db	     0ECh,083h,0ECh,006h,0FFh,076h,006h,016h,08Dh,046h,0FAh,050h,00Eh,0E8h  ; ovr_1bf9_6410:41FC
   	     db	     0F4h,0FEh,089h,056h,0FEh,089h,046h,0FCh,09Ah

   	     dw	     02Ah
   	     dw	     seg CO035_TEXT
   	     db	     089h; ovr_1bf9_6410:420A
   	     db	     046h,0FAh,0EBh,00Dh,09Ah
   	     dw	     02Ah
   	     dw	     seg CO035_TEXT
   	     db	     083h,06Eh,0FCh,000h,083h; ovr_1bf9_6410:4218
   	     db	     05Eh,0FEh,001h,083h,07Eh,0FEh,001h,07Fh,0EDh,075h,006h,083h,07Eh,0FCh  ; ovr_1bf9_6410:4226
   	     db	     000h,077h,0E5h,08Bh,046h,0FAh,08Bh,0E5h,05Dh,0CAh,002h,000h; raw:4234

X011_00 label   far
   	     db	     055h,08Bh;	ovr_1bf9_6410:4234
   	     db	     0ECh,083h,0ECh,00Ch,056h,057h,08Bh,076h,006h,0A0h,0AEh,063h,0B4h,000h  ; ovr_1bf9_6410:4242
   	     db	     00Bh,0C0h,075h,003h,0E9h,0D5h,000h,056h,09Ah

   	     dw	     066h
   	     dw	     seg CO02C_TEXT
   	     db	     089h; ovr_1bf9_6410:4250
   	     db	     046h,0F4h,0FFh,076h,0F4h,0FFh,01Eh,034h,081h,050h,0FFh,01Eh,0D8h,087h  ; ovr_1bf9_6410:425E
   	     db	     08Eh,006h,010h,064h,026h,0FFh,074h,004h,016h,08Dh,046h,0FAh,050h,00Eh  ; ovr_1bf9_6410:426C
   	     db	     0E8h,083h,0FEh,089h,056h,0FEh,089h,046h,0FCh,083h,07Eh,0FAh,000h,074h  ; ovr_1bf9_6410:427A
   	     db	     024h,0FFh,076h,0FAh,0FFh,01Eh,0DCh,087h,0B8h,001h,000h,033h,0D2h,02Bh  ; ovr_1bf9_6410:4288
   	     db	     056h,0FAh,01Dh,000h,000h,089h,046h,0F8h,089h,056h,0F6h,08Bh,046h,0FAh  ; ovr_1bf9_6410:4296
   	     db	     029h,046h,0FCh,083h,05Eh,0FEh,000h,0EBh,00Ah,0C7h,046h,0F8h,001h,000h  ; ovr_1bf9_6410:42A4
   	     db	     0C7h,046h,0F6h,000h,000h,0FFh,076h,0F4h,0FFh,01Eh,0D0h,087h,0FFh,076h  ; ovr_1bf9_6410:42B2
   	     db	     0F4h,0FFh,01Eh,034h,081h,08Bh,0F8h,0EBh,05Bh,057h,0FFh,01Eh,0D8h,087h  ; ovr_1bf9_6410:42C0
   	     db	     08Bh,046h,0F8h,08Bh,056h,0F6h,03Bh,046h,0FEh,07Ch,013h,07Fh,005h,03Bh  ; ovr_1bf9_6410:42CE
   	     db	     056h,0FCh,076h,00Ch,08Bh,046h,0FEh,08Bh,056h,0FCh,089h,046h,0F8h,089h  ; ovr_1bf9_6410:42DC
   	     db	     056h,0F6h,083h,07Eh,0F8h,001h,075h,014h,083h,07Eh,0F6h,000h,075h,00Eh  ; ovr_1bf9_6410:42EA
   	     db	     0B8h,000h,080h,050h,0FFh,01Eh,0DCh,087h,0B8h,000h,080h,050h,0EBh,003h  ; ovr_1bf9_6410:42F8
   	     db	     0FFh,076h,0F6h,0FFh,01Eh,0DCh,087h,08Bh,046h,0F8h,08Bh,056h,0F6h,029h  ; ovr_1bf9_6410:4306
   	     db	     056h,0FCh,019h,046h,0FEh,0C7h,046h,0F8h,001h,000h,0C7h,046h,0F6h,000h  ; ovr_1bf9_6410:4314
   	     db	     000h,047h,08Bh,046h,0FCh,00Bh,046h,0FEh,075h,09Dh,05Fh,05Eh,08Bh,0E5h  ; ovr_1bf9_6410:4322
   	     db	     05Dh,0CAh,002h,000h; raw:4330
X011_04 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,006h,056h,057h,08Bh,076h;	ovr_1bf9_6410:4330

   	     db	     006h,0A0h,0AEh,063h,0B4h,000h,00Bh,0C0h,075h,004h,033h,0C0h,0EBh,07Ah  ; ovr_1bf9_6410:433E
   	     db	     056h,09Ah
   	     dw	     066h
   	     dw	     seg CO02C_TEXT
   	     db	     08Bh,0F8h,057h,0FFh,01Eh,034h,081h,03Dh; ovr_1bf9_6410:434C

   	     db	     0FFh,0FFh,075h,012h,057h,08Eh,006h,010h,064h,026h,0FFh,074h,004h,00Eh  ; ovr_1bf9_6410:435A
   	     db	     0E8h,08Fh,0FEh,050h,0FFh,01Eh,040h,081h,057h,0FFh,01Eh,034h,081h,050h  ; ovr_1bf9_6410:4368
   	     db	     0FFh,01Eh,0D8h,087h,089h,046h,0FEh,057h,0FFh,01Eh,0D0h,087h,08Eh,006h  ; ovr_1bf9_6410:4376
   	     db	     010h,064h,026h,08Bh,05Ch,004h,08Eh,006h,09Ah,063h,026h,0FFh,077h,007h  ; ovr_1bf9_6410:4384
   	     db	     09Ah
   	     dw	     02Fh
   	     dw	     seg CO00A_TEXT
   	     db	     089h,056h,0FCh,089h,046h,0FAh,0FFh,076h,0FCh; ovr_1bf9_6410:4392

   	     db	     0FFh,076h,0FAh,09Ah
   	     dw	     020h
   	     dw	     seg CO049_TEXT
   	     db	     00Bh,0C0h,07Dh,017h,0FFh,076h; ovr_1bf9_6410:43A0
   	     db	     0FCh,0FFh,076h,0FAh,0B8h,001h,000h,033h,0D2h,050h,052h,09Ah

   	     dw	     02D2h
   	     dw	     seg BCC_COPY_WORDS
   	     db	     050h,0FFh,01Eh,0DCh,087h,08Bh,046h,0FEh,05Fh,05Eh,08Bh,0E5h;	    ovr_1bf9_6410:43AE
   	     db	     05Dh,0CAh,002h,000h; raw:43CA
X011_02 label   far
   	     db	     055h,08Bh,0ECh,04Ch,04Ch,09Ah
   	     dw	     05Ch
   	     dw	     seg CO056_TEXT
   	     db	     083h,0FAh,001h,075h,021h,00Bh,0C0h,075h,01Dh,080h,07Eh,006h,000h,074h  ; ovr_1bf9_6410:43D8
   	     db	     007h,09Ah
   	     dw	     02Ah
   	     dw	     seg CO035_TEXT
   	     db	     0EBh,00Bh,033h,0C0h,050h,0FFh,01Eh,0D8h; ovr_1bf9_6410:43E6

   	     db	     087h,089h,046h,0FEh,040h,050h,0FFh,01Eh,0D8h,087h,08Bh,0E5h,05Dh,0CAh  ; ovr_1bf9_6410:43F4
   	     db	     002h,000h;	raw:4402
X011_03 label   far
   	     db	     055h,08Bh,0ECh,083h,0ECh,004h,0A0h,0AEh,063h,0B4h,000h,00Bh;	    ovr_1bf9_6410:4402
   	     db	     0C0h,074h,07Bh,09Ah
   	     dw	     05Ch
   	     dw	     seg CO056_TEXT
   	     db	     0BBh,001h,000h,033h,0C9h,02Bh; ovr_1bf9_6410:4410
   	     db	     0C8h,01Bh,0DAh,089h,05Eh,0FEh,089h,04Eh,0FCh,08Bh,046h,0FEh,08Bh,056h  ; ovr_1bf9_6410:441E
   	     db	     0FCh,03Bh,046h,00Ah,07Ch,013h,07Fh,005h,03Bh,056h,008h,076h,00Ch,08Bh  ; ovr_1bf9_6410:442C
   	     db	     046h,00Ah,08Bh,056h,008h,089h,046h,0FEh,089h,056h,0FCh,083h,07Eh,0FEh  ; ovr_1bf9_6410:443A
   	     db	     001h,075h,014h,083h,07Eh,0FCh,000h,075h,00Eh,0B8h,000h,080h,050h,0FFh  ; ovr_1bf9_6410:4448
   	     db	     01Eh,0DCh,087h,0B8h,000h,080h,050h,0EBh,003h,0FFh,076h,0FCh,0FFh,01Eh  ; ovr_1bf9_6410:4456
   	     db	     0DCh,087h,08Bh,046h,0FEh,08Bh,056h,0FCh,029h,056h,008h,019h,046h,00Ah  ; ovr_1bf9_6410:4464
   	     db	     08Bh,046h,008h,00Bh,046h,00Ah,074h,014h,0C7h,046h,0FEh,001h,000h,0C7h  ; ovr_1bf9_6410:4472
   	     db	     046h,0FCh,000h,000h,08Ah,046h,006h,050h,00Eh,0E8h,042h,0FFh,0EBh,099h  ; ovr_1bf9_6410:4480
   	     db	     08Bh,0E5h,05Dh,0CAh,006h,000h   ; ovr_1bf9_6410:448E

CO011_TEXT	     ends
; END LG070
   	     end
