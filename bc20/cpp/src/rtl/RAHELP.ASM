; /* target: RAHELP */
; /* opts: /ml */
; /* CPP.EXE module RAHELP (11D7:0037..008D): source taken unchanged from the BCC.EXE
;    reconstruction (src/rtl/RAHELP.ASM); its code is the same in both programs. */
;
; Borland run-time library (hand-written assembly).
; RTL_ULTOA_CORE (near, 11D7:0037): unsigned DX:AX to decimal at ES:DI;
; RTL_LTOA_CORE (near, 11D7:0078): signed (writes '-' first).

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE_40	segment byte public 'CODE'
		assume	cs:CODE_40,ds:DGROUP
		public	RTL_ULTOA_CORE
		public	RTL_LTOA_CORE

RTL_ULTOA_CORE	proc	near
		mov	byte ptr ES:[DI],0
		xor	BP,BP
M002_L_NEXT:
		mov	BX,AX
		or	BX,DX
		je	short M002_L_REVERSE
		push	DI
		db	0E8h			; near call to RTL_ULDIV10 (ULDIV10, 11D7:000A) in another module (the
					; BCC.EXE reconstruction writes it as bytes with a fixed displacement)
		dw	0FFC3h
		pop	DI
		mov	BX,SI
		add	BL,30h
		mov	word ptr ES:[DI],BX
		inc	DI
		inc	BP
		jmp	short M002_L_NEXT
M002_L_REVERSE:
		or	BP,BP
		jne	short M002_L_ORDER
		mov	word ptr ES:[DI],30h
		inc	DI
		inc	BP
M002_L_ORDER:
		mov	BX,BP
		sub	DI,BX
		dec	BX
M002_L_TEST:
		jle	short M002_L_RETURN
		mov	AL,byte ptr ES:[DI]
		mov	AH,byte ptr ES:[BX+DI]
		mov	byte ptr ES:[DI],AH
		mov	byte ptr ES:[BX+DI],AL
		inc	DI
		dec	BX
		dec	BX
		jmp	short M002_L_TEST
M002_L_RETURN:
		ret
RTL_ULTOA_CORE	endp

RTL_LTOA_CORE	proc	near
		or	DX,DX
		jns	short M002_L_CONVERT
		mov	byte ptr ES:[DI],2Dh
		inc	DI
		not	DX
		not	AX
		add	AX,1
		adc	DX,0
M002_L_CONVERT:
		jmp	short RTL_ULTOA_CORE
RTL_LTOA_CORE	endp
CODE_40	ends
		end
