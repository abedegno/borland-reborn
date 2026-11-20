; /* target: ULDIV10 */
; /* opts: /ml */
; /* CPP.EXE module ULDIV10 (11D7:000A..0037): source taken unchanged from the BCC.EXE
;    reconstruction (src/rtl/ULDIV10.ASM); its code is the same in both programs. */
;
; Borland run-time library (hand-written assembly).
; RTL_ULDIV10 (near): DX:AX /= 10, remainder in SI; uses BX, CX, DI.
; Its caller is RTL_ULTOA_CORE (RAHELP.ASM), through a near call.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

CODE_40	segment byte public 'CODE'
		assume	cs:CODE_40,ds:DGROUP


		public	RTL_ULDIV10

RTL_ULDIV10	proc	near
		xor	SI,SI
		xor	DI,DI
		mov	BX,0Ah
		cmp	DX,BX
		jnc	short ULDIV10_LONG_DIVIDE
		div	BX
		xchg	SI,DX
		jmp	short ULDIV10_RETURN
ULDIV10_LONG_DIVIDE:
		mov	CX,20h
ULDIV10_BIT_LOOP:
		shl	AX,1
		rcl	DX,1
		rcl	SI,1
		rcl	DI,1
		test	DI,DI
		jne	short ULDIV10_SUBTRACT
		cmp	SI,BX
		jc	short ULDIV10_NEXT_BIT
ULDIV10_SUBTRACT:
		sub	SI,BX
		sbb	DI,0
		inc	AX
ULDIV10_NEXT_BIT:
		loop	short ULDIV10_BIT_LOOP
ULDIV10_RETURN:
		ret
RTL_ULDIV10	endp
CODE_40	ends
		end
