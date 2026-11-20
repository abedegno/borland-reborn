DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_37
; BEGIN LG015 (gap CODE_37:0000)
RACCESS_TEXT	segment byte public 'CODE'
		assume	cs:RACCESS_TEXT
; Original-image layout stub: not recovered source



RACCESS_TEXT	ends
; END LG015
; BEGIN RACCESS (listing CODE_37:0005)

		extrn	BCC_FAR_A45B:far


RACCESS_TEXT	segment byte public 'CODE'
		assume	cs:RACCESS_TEXT,ds:DGROUP
		public	BCC_FAR_AB75

BCC_FAR_AB75	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	AX,41h
		push	AX
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	BCC_FAR_A45B
		dw	seg BCC_FAR_A45B
		mov	SI,AX
		cmp	SI,-1
		je	short M001_L_DONE
		xor	SI,SI
M001_L_DONE:
		mov	AX,SI
		pop	SI
		pop	BP
		retf	4
BCC_FAR_AB75	endp
RACCESS_TEXT	ends

; END RACCESS
		end
