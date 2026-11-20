		public	BCC_SEG_21
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_21
; BEGIN RCHMOD (CODE_21:000A)
CODE_21	segment byte public 'CODE'
BCC_SEG_21	label far
		assume	cs:CODE_21
; Original-image layout stub: not recovered source


		db	055h,08Bh,0ECh,08Bh
		db	04Eh,00Ch,08Ah,046h,00Ah,01Eh,0C5h,056h,006h,0B4h,043h,0CDh,021h,01Fh	; CODE_21:000E
		db	073h,008h,0A3h,000h,000h,0B8h,0FFh,0FFh,0EBh,00Ch,083h,07Eh,00Ah,001h	; CODE_21:001C
		db	075h,004h,033h,0C0h,0EBh,002h,08Bh,0C1h,05Dh,0CBh	; CODE_21:002A

CODE_21	ends
; END RCHMOD
		end
