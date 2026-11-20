DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_36
; BEGIN TOLOWER (derived raw span CODE_36:000D)
RTOUPPER_TEXT	segment byte public 'CODE'
		assume	cs:RTOUPPER_TEXT
; Derived owner for original initialized36-byte TOLOWER span; not an original standalone source file


		db	055h; CODE_36:0000
		db	08Bh,0ECh,08Ah,046h,006h,0B4h,000h,08Bh,0D8h,0F6h,087h,081h,05Bh,004h	; CODE_36:000E
		db	074h,00Ah,08Ah,046h,006h,0B4h,000h,005h,020h,000h,0EBh,005h,08Ah,046h	; CODE_36:001C
		db	006h,0B4h,000h,05Dh,0CAh,002h,000h	; CODE_36:002A

RTOUPPER_TEXT	ends
; END TOLOWER
; BEGIN RTOUPPER (listing CODE_36:0031)

RTOUPPER_TEXT	segment byte public 'CODE'
		assume	cs:RTOUPPER_TEXT,ds:DGROUP

M001_BCC_CTYPE	equ	5B81h

		public	BCC_FAR_AB51

		public	BCC_RF_1AB2_0031
BCC_RF_1AB2_0031	label	far
BCC_FAR_AB51	proc	far
		push	BP
		mov	BP,SP
		mov	AL,byte ptr [BP+6]
		mov	AH,0
		mov	BX,AX
		test	byte ptr [BX+M001_BCC_CTYPE],8
		je	short M001_L_UNCHANGED
		mov	AL,byte ptr [BP+6]
		mov	AH,0
		add	AX,0FFE0h
		jmp	short M001_L_DONE
M001_L_UNCHANGED:
		mov	AL,byte ptr [BP+6]
		mov	AH,0
M001_L_DONE:
		pop	BP
		retf	2
BCC_FAR_AB51	endp
RTOUPPER_TEXT	ends

; Target-qualified reference aliases (zero bytes)
		public	BCC_RF_1AB2_000D
BCC_RF_1AB2_000D	equ	BCC_FAR_AB51-24h
; END RTOUPPER
		end
