DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group CODE_33
; BEGIN LG012 (gap CODE_33:0000)
RSCMP_TEXT	segment byte public 'CODE'
		assume	cs:RSCMP_TEXT
; Original-image layout stub: not recovered source



RSCMP_TEXT	ends
; END LG012
; BEGIN RSCMP (listing CODE_33:0007)

RSCMP_TEXT	segment byte public 'CODE'
		assume	cs:RSCMP_TEXT,ds:DGROUP

		public	BCC_FAR_AA87

		public	BCC_COMPARE_NAME
BCC_COMPARE_NAME	label	far
		public	BCC_RF_1AA8_0007
BCC_RF_1AA8_0007	label	far
		public	STRCMP
STRCMP	label	far
BCC_FAR_AA87	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		cld
		push	DS
		les	DI,[BP+6]
		lds	SI,[BP+0Ah]
M001_L_COMPARE:
		lodsb
		scasb
		jne	short M001_L_DIFFER
		or	AL,AL
		jne	short M001_L_COMPARE
M001_L_DIFFER:
		sub	AL,byte ptr ES:[DI-1]
		cbw
		pop	DS
		pop	DI
		pop	SI
		pop	BP
		retf	8
BCC_FAR_AA87	endp
RSCMP_TEXT	ends

; Original-target semantic aliases (zero bytes)
; Target-qualified reference aliases (zero bytes)
; END RSCMP
		end
