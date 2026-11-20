		public	X05E_00
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d76_a56a
; BEGIN STAOV087 (listing ovr_1d76_a56a:56A0)

CO05E_TEXT	segment byte public 'CODE'
		assume	cs:CO05E_TEXT,ds:DGROUP

M000_BCC_DATA_5356	equ	5356h
M000_BCC_DATA_535A	equ	535Ah
M000_BCC_DATA_8654	equ	8654h
M000_BCC_DATA_866E	equ	866Eh
M000_BCC_DATA_8680	equ	8680h
M000_BCC_DATA_8698	equ	8698h
M000_BCC_DATA_86E0	equ	86E0h


		public	X05E_00
X05E_00	label	far
BCC_FAR_56A0	proc	far
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		mov	AX,DGROUP:M000_BCC_DATA_86E0
		db	0E9h
		dw	00291h
M000_L_56AE:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	BX,word ptr [BP-2]
		cmp	word ptr ES:[BX],0
		je	short M000_L_56C4
		cmp	word ptr ES:[BX],4
		je	short M000_L_56C4
		db	0E9h
		dw	00270h
M000_L_56C4:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+4]
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		mov	word ptr [BP-6],0
		db	0E9h
		dw	00244h
M000_L_56DD:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		test	byte ptr ES:[SI+1],40h
		je	short M000_L_56EB
		db	0E9h
		dw	0022Ch
M000_L_56EB:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,401h
		xor	DX,DX
		or	DX,DX
		jne	short M000_L_5749
		cmp	AX,1
		jne	short M000_L_5749
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+24h]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_866E
		add	word ptr ES:[BX+11h],AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		cmp	byte ptr ES:[SI],0Fh
		je	short M000_L_5734
		db	0E9h
		dw	001E3h
M000_L_5734:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_866E
		mov	AX,DGROUP:M000_BCC_DATA_535A
		or	word ptr ES:[BX+1Bh],AX
		db	0E9h
		dw	001CEh
M000_L_5749:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		cmp	byte ptr ES:[SI],15h
		jnc	short M000_L_5756
		db	0E9h
		dw	000F9h
M000_L_5756:
		cmp	byte ptr ES:[SI],1Ah
		jbe	short M000_L_575F
		db	0E9h
		dw	000F0h
M000_L_575F:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		cmp	word ptr ES:[SI+2],0
		je	short M000_L_57B4
		mov	AX,word ptr ES:[SI+2]
		shl	AX,1
		shl	AX,1
		mov	CX,AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		mov	BX,CX
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,401h
		xor	DX,DX
		or	DX,DX
		jne	short M000_L_57B4
		cmp	AX,1
		jne	short M000_L_57B4
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+24h]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	BX,CX
		mov	BX,word ptr ES:[BX]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_866E
		add	word ptr ES:[BX+13h],AX
M000_L_57B4:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		shl	AX,1
		shl	AX,1
		mov	DI,AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		cmp	byte ptr ES:[DI],1Fh
		jne	short M000_L_580A
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	AX,word ptr ES:[DI+2]
		shl	AX,1
		shl	AX,1
		mov	CX,AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		mov	BX,CX
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,408h
		xor	DX,DX
		or	DX,DX
		jne	short M000_L_580A
		cmp	AX,8
		jne	short M000_L_580A
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	AX,word ptr ES:[DI]
		shl	AX,1
		shl	AX,1
		mov	DI,AX
M000_L_580A:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		mov	AL,byte ptr ES:[DI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,401h
		xor	DX,DX
		or	DX,DX
		je	short M000_L_582A
		db	0E9h
		dw	000EDh
M000_L_582A:
		cmp	AX,1
		je	short M000_L_5832
		db	0E9h
		dw	000E5h
M000_L_5832:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+24h]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	BX,word ptr ES:[DI]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_866E
		add	word ptr ES:[BX+15h],AX
		db	0E9h
		dw	000C8h
M000_L_584F:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		cmp	byte ptr ES:[SI],44h
		jc	short M000_L_58AA
		cmp	byte ptr ES:[SI],49h
		ja	short M000_L_58AA
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		shl	AX,1
		shl	AX,1
		mov	CX,AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		mov	BX,CX
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,401h
		xor	DX,DX
		or	DX,DX
		je	short M000_L_588F
		db	0E9h
		dw	00088h
M000_L_588F:
		cmp	AX,1
		je	short M000_L_5897
		db	0E9h
		dw	00080h
M000_L_5897:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	BX,CX
		mov	BX,word ptr ES:[BX]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_866E
		inc	word ptr ES:[BX+17h]
		jmp	short M000_L_5917
M000_L_58AA:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		test	byte ptr ES:[SI+1],2
		je	short M000_L_5917
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		shl	AX,1
		shl	AX,1
		mov	DI,AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		test	byte ptr ES:[DI+1],4
		jne	short M000_L_5917
		mov	AL,byte ptr ES:[DI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,401h
		xor	DX,DX
		or	DX,DX
		jne	short M000_L_5917
		cmp	AX,1
		jne	short M000_L_5917
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	BX,word ptr ES:[DI]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_866E
		mov	AX,DGROUP:M000_BCC_DATA_5356
		or	word ptr ES:[BX+1Bh],AX
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+24h]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	BX,word ptr ES:[DI]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_866E
		add	word ptr ES:[BX+11h],AX
M000_L_5917:
		add	SI,4
		inc	word ptr [BP-6]
		add	word ptr [BP-4],2
M000_L_5921:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+6]
		cmp	AX,word ptr [BP-6]
		jbe	short M000_L_5934
		db	0E9h
		dw	0FDA9h
M000_L_5934:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+0Ch]
M000_L_593F:
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		je	short M000_L_594B
		db	0E9h
		dw	0FD63h
M000_L_594B:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf
BCC_FAR_56A0	endp
CO05E_TEXT	ends

; END STAOV087
		end
