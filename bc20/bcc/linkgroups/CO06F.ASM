		public	X06F_03
		public	X06F_02
		public	X06F_01
		public	X06F_00
		public	X06F_04
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1dc1_b052
; BEGIN C105UNIT (listing ovr_1dc1_b052:0520)

		extrn	X043_04:far


CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP

M000_BCC_DATA_8654	equ	8654h
M000_BCC_DATA_8688	equ	8688h
M000_BCC_DATA_86E0	equ	86E0h
M000_BCC_DATA_8716	equ	8716h

		public	X06F_00
X06F_00	label	far
STAOV146	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr DGROUP:M000_BCC_DATA_86E0
		db	0E9h
		dw	00082h
M000_L_052E:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+0Ch]
		mov	word ptr [BP-2],AX
		mov	BX,word ptr ES:[SI]
		cmp	BX,5
		ja	short M000_L_05AD
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	117h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	word ptr ES:[SI+2],7FFFh
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		cmp	word ptr ES:[SI+8],0
		je	short M000_L_05AD
		push	word ptr ES:[SI+10h]
		db	0E8h
		dw	0051Dh
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	word ptr ES:[SI+10h],AX
		jmp	short M000_L_05AD
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		push	word ptr ES:[SI+10h]
		db	0E8h
		dw	00508h
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	word ptr ES:[SI+10h],AX
		mov	DI,word ptr ES:[SI+12h]
		jmp	short M000_L_059D
M000_L_0587:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8688
		push	word ptr ES:[DI+6]
		db	0E8h
		dw	004EFh
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8688
		mov	word ptr ES:[DI+6],AX
		mov	DI,word ptr ES:[DI]
M000_L_059D:
		or	DI,DI
		jne	short M000_L_0587
		jmp	short M000_L_05AD
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	word ptr ES:[SI+2],1
M000_L_05AD:
		mov	SI,word ptr [BP-2]
M000_L_05B0:
		or	SI,SI
		je	short M000_L_05B7
		db	0E9h
		dw	0FF77h
M000_L_05B7:
		mov	SI,word ptr DGROUP:M000_BCC_DATA_86E0
		jmp	short M000_L_062D
M000_L_05BD:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+0Ch]
		mov	word ptr [BP-2],AX
		cmp	word ptr ES:[SI],3
		jne	short M000_L_062A
		cmp	word ptr DGROUP:M000_BCC_DATA_8716,0
		jne	short M000_L_0631
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		cmp	word ptr ES:[SI+0Ch],0
		je	short M000_L_0605
		mov	AX,word ptr ES:[SI+0Eh]
		mov	BX,word ptr ES:[SI+0Ch]
		mov	word ptr ES:[BX+0Eh],AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		cmp	word ptr ES:[SI+0Eh],0
		je	short M000_L_0614
		mov	AX,word ptr ES:[SI+0Ch]
		mov	BX,word ptr ES:[SI+0Eh]
		mov	word ptr ES:[BX+0Ch],AX
		jmp	short M000_L_061F
M000_L_0605:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	word ptr ES:[SI],0
		inc	word ptr ES:[SI+2]
		jmp	short M000_L_0631
M000_L_0614:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+0Ch]
		mov	DGROUP:M000_BCC_DATA_86E0,AX
M000_L_061F:
		push	DS
		mov	AX,8654h
		push	AX
		push	SI
		db	09Ah
		dw	X043_04
		dw	seg X043_04
M000_L_062A:
		mov	SI,word ptr [BP-2]
M000_L_062D:
		or	SI,SI
		jne	short M000_L_05BD
M000_L_0631:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf
STAOV146	endp
CO06F_TEXT	ends

CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT

STOVT197	label	word
		dw	00032h
		dw	00083h
		dw	00083h
		dw	0008Dh
		dw	0004Eh
		dw	00028h

CO06F_TEXT	ends

		extrn	X034_02:far


CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP

M002_BCC_DATA_8654	equ	8654h
M002_BCC_DATA_8688	equ	8688h
M002_BCC_DATA_86E0	equ	86E0h
M002_BCC_DATA_8718	equ	8718h

		public	X06F_04
X06F_04	label	far
STAOV147	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		push	SI
		push	DI
M002_L_064B:
		mov	word ptr DGROUP:M002_BCC_DATA_8718,0
		mov	SI,word ptr DGROUP:M002_BCC_DATA_86E0
		db	0E9h
		dw	002CCh
M002_L_0658:
		db	09Ah
		dw	X034_02
		dw	seg X034_02
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+0Ch]
		mov	word ptr [BP-6],AX
		jmp	short M002_L_067A
M002_L_066A:
		push	SI
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	BX,word ptr ES:[SI+10h]
		push	word ptr ES:[BX+0Ch]
		db	0E8h
		dw	00617h
M002_L_067A:
		push	SI
		db	0E8h
		dw	0039Fh
		or	AX,AX
		jne	short M002_L_066A
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		cmp	word ptr ES:[SI],0
		je	short M002_L_0692
		cmp	word ptr ES:[SI],4
		jne	short M002_L_06C0
M002_L_0692:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		cmp	word ptr ES:[SI+8],0
		je	short M002_L_06C0
		push	word ptr ES:[SI+10h]
		db	0E8h
		dw	00297h
		or	AX,AX
		je	short M002_L_06C0
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		test	word ptr ES:[SI+1Ch],100h
		jne	short M002_L_06C0
		push	SI
		mov	BX,word ptr ES:[SI+10h]
		push	word ptr ES:[BX+10h]
		db	0E8h
		dw	005D1h
M002_L_06C0:
		push	SI
		db	0E8h
		dw	00662h
		mov	word ptr [BP-2],AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		cmp	word ptr ES:[SI+8],1
		jne	short M002_L_070A
		test	word ptr ES:[SI+1Ch],100h
		jne	short M002_L_070A
		jmp	short M002_L_06F6
M002_L_06DC:
		push	word ptr [BP-2]
		nop
		push	CS
		db	0E8h
		dw	005D4h
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+0Ch]
		mov	word ptr [BP-6],AX
		push	SI
		db	0E8h
		dw	00633h
		mov	word ptr [BP-2],AX
M002_L_06F6:
		cmp	word ptr [BP-2],0
		je	short M002_L_070A
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		cmp	word ptr ES:[BX+2],0
		je	short M002_L_06DC
M002_L_070A:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,word ptr ES:[SI]
		or	AX,AX
		je	short M002_L_0725
		cmp	AX,4
		jne	short M002_L_071D
		db	0E9h
		dw	0013Eh
M002_L_071D:
		cmp	AX,5
		je	short M002_L_0725
		db	0E9h
		dw	001FCh
M002_L_0725:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		cmp	word ptr ES:[SI+8],0
		je	short M002_L_0733
		db	0E9h
		dw	00089h
M002_L_0733:
		cmp	word ptr ES:[SI+6],0
		jne	short M002_L_0750
		cmp	word ptr ES:[SI],0
		jne	short M002_L_0750
		cmp	word ptr ES:[SI+2],0
		jne	short M002_L_0750
		push	SI
		nop
		push	CS
		db	0E8h
		dw	0056Bh
		db	0E9h
		dw	001D1h
M002_L_0750:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		cmp	word ptr ES:[SI],5
		jne	short M002_L_075D
		db	0E9h
		dw	001C4h
M002_L_075D:
		cmp	word ptr [BP-2],0
		jne	short M002_L_0766
		db	0E9h
		dw	001BBh
M002_L_0766:
		mov	BX,word ptr [BP-2]
		cmp	word ptr ES:[BX],0
		je	short M002_L_0772
		db	0E9h
		dw	001AFh
M002_L_0772:
		cmp	word ptr ES:[BX+6],0
		je	short M002_L_077C
		db	0E9h
		dw	001A5h
M002_L_077C:
		mov	AX,word ptr ES:[BX+10h]
		cmp	AX,word ptr [BP-2]
		jne	short M002_L_0788
		db	0E9h
		dw	00199h
M002_L_0788:
		cmp	word ptr ES:[BX+8],1
		je	short M002_L_0792
		db	0E9h
		dw	0018Fh
M002_L_0792:
		mov	word ptr ES:[SI+8],1
		mov	AX,word ptr ES:[BX+1Ch]
		and	AX,100h
		or	word ptr ES:[SI+1Ch],AX
		mov	AX,word ptr ES:[BX+10h]
		mov	word ptr ES:[SI+10h],AX
		mov	BX,word ptr ES:[SI+10h]
		inc	word ptr ES:[BX+2]
		mov	word ptr DGROUP:M002_BCC_DATA_8718,1
		db	0E9h
		dw	00165h
M002_L_07BC:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		test	word ptr ES:[SI+1Ch],100h
		je	short M002_L_07CB
		db	0E9h
		dw	00156h
M002_L_07CB:
		cmp	word ptr [BP-2],0
		je	short M002_L_07F4
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+10h]
		cmp	AX,word ptr [BP-2]
		jne	short M002_L_07F4
		mov	BX,word ptr [BP-2]
		dec	word ptr ES:[BX+2]
		mov	word ptr ES:[SI+8],0
		mov	word ptr ES:[SI+10h],0
		db	0E9h
		dw	00127h
M002_L_07F4:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		cmp	word ptr ES:[SI+8],1
		jne	short M002_L_081D
		mov	AX,word ptr ES:[SI+10h]
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-2]
		cmp	word ptr ES:[BX+2],1
		je	short M002_L_0813
		db	0E9h
		dw	0010Eh
M002_L_0813:
		push	SI
		push	word ptr [BP-2]
		db	0E8h
		dw	00301h
		db	0E9h
		dw	00104h
M002_L_081D:
		cmp	word ptr [BP-2],0
		jne	short M002_L_0826
		db	0E9h
		dw	000FBh
M002_L_0826:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		cmp	word ptr ES:[BX+8],1
		je	short M002_L_0837
		db	0E9h
		dw	000EAh
M002_L_0837:
		push	word ptr [BP-2]
		nop
		push	CS
		db	0E8h
		dw	0013Ah
		or	AX,AX
		jne	short M002_L_0846
		db	0E9h
		dw	000DBh
M002_L_0846:
		push	SI
		push	word ptr [BP-2]
		db	0E8h
		dw	003D0h
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+0Ch]
		mov	word ptr [BP-6],AX
		db	0E9h
		dw	000C6h
M002_L_085B:
		mov	word ptr [BP-8],0
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	DI,word ptr ES:[SI+12h]
		db	0E9h
		dw	00093h
M002_L_086B:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8688
		mov	AX,word ptr ES:[DI+6]
		mov	word ptr [BP-4],AX
		push	word ptr [BP-4]
		db	0E8h
		dw	000BFh
		or	AX,AX
		je	short M002_L_08B4
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		dec	word ptr ES:[BX+2]
		mov	AX,word ptr ES:[BX+10h]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8688
		mov	word ptr ES:[DI+6],AX
		mov	BX,word ptr ES:[DI+6]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		inc	word ptr ES:[BX+2]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8688
		mov	AX,word ptr ES:[DI+6]
		mov	word ptr [BP-4],AX
		mov	word ptr DGROUP:M002_BCC_DATA_8718,1
M002_L_08B4:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+10h]
		cmp	AX,word ptr [BP-4]
		jne	short M002_L_08F4
		mov	BX,word ptr [BP-4]
		dec	word ptr ES:[BX+2]
		cmp	word ptr [BP-8],0
		je	short M002_L_08DD
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8688
		mov	AX,word ptr ES:[DI]
		mov	BX,word ptr [BP-8]
		mov	word ptr ES:[BX],AX
		jmp	short M002_L_08EC
M002_L_08DD:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8688
		mov	AX,word ptr ES:[DI]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	word ptr ES:[SI+12h],AX
M002_L_08EC:
		mov	word ptr DGROUP:M002_BCC_DATA_8718,1
		jmp	short M002_L_08F7
M002_L_08F4:
		mov	word ptr [BP-8],DI
M002_L_08F7:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8688
		mov	DI,word ptr ES:[DI]
M002_L_08FE:
		or	DI,DI
		je	short M002_L_0905
		db	0E9h
		dw	0FF66h
M002_L_0905:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		cmp	word ptr ES:[SI+12h],0
		jne	short M002_L_0921
		mov	word ptr ES:[SI],0
		mov	word ptr ES:[SI+8],1
M002_L_091B:
		mov	word ptr DGROUP:M002_BCC_DATA_8718,1
M002_L_0921:
		mov	SI,word ptr [BP-6]
M002_L_0924:
		or	SI,SI
		je	short M002_L_092B
		db	0E9h
		dw	0FD2Dh
M002_L_092B:
		cmp	word ptr DGROUP:M002_BCC_DATA_8718,0
		je	short M002_L_0935
		db	0E9h
		dw	0FD16h
M002_L_0935:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf
STAOV147	endp
CO06F_TEXT	ends




CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP

M003_BCC_DATA_8654	equ	8654h

BCC_NEAR_093B	label	near
STAOV148	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		or	SI,SI
		je	short M003_L_0971
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		cmp	word ptr ES:[SI],0
		jne	short M003_L_0971
		cmp	word ptr ES:[SI+8],1
		jne	short M003_L_0971
		push	SI
		nop
		push	CS
		db	0E8h
		dw	0001Bh
		or	AX,AX
		je	short M003_L_0971
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		cmp	word ptr ES:[SI+10h],SI
		je	short M003_L_0971
		mov	AX,1
		jmp	short M003_L_0973
M003_L_0971:
		xor	AX,AX
M003_L_0973:
		pop	SI
		pop	BP
		dec	BP
		ret	2
STAOV148	endp
CO06F_TEXT	ends


CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP

M004_BCC_DATA_8654	equ	8654h
M004_BCC_DATA_8680	equ	8680h


		public	X06F_02
X06F_02	label	far
BCC_NEAR_0979	label	near
STAOV149	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8654
		cmp	word ptr ES:[SI],0
		je	short M004_L_0993
		xor	AX,AX
		db	0E9h
		dw	00082h
M004_L_0993:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8654
		cmp	word ptr ES:[SI+6],0
		jne	short M004_L_09A0
		jmp	short M004_L_0A12
M004_L_09A0:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8654
		cmp	word ptr ES:[SI+6],1
		jne	short M004_L_09E1
		cmp	word ptr ES:[SI+2],0
		jne	short M004_L_09E1
		mov	AX,word ptr ES:[SI+4]
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-2],AX
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8680
		mov	BX,word ptr [BP-2]
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		mov	DX,13h
		imul	DX
		add	AX,3F98h
		mov	word ptr [BP-4],AX
		mov	BX,word ptr [BP-4]
		mov	AX,word ptr [BX+3]
		or	AX,word ptr [BX+5]
		jne	short M004_L_09E1
		jmp	short M004_L_0A12
M004_L_09E1:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+6]
		mov	CX,AX
		mov	AX,word ptr ES:[SI+4]
		shl	AX,1
		shl	AX,1
		mov	DI,AX
		jmp	short M004_L_0A0E
M004_L_09F7:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8680
		mov	AL,byte ptr ES:[DI+1]
		mov	AH,0
		test	AX,40h
		jne	short M004_L_0A0A
		xor	AX,AX
		jmp	short M004_L_0A15
M004_L_0A0A:
		dec	CX
		add	DI,4
M004_L_0A0E:
		or	CX,CX
		jne	short M004_L_09F7
M004_L_0A12:
		mov	AX,1
M004_L_0A15:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
STAOV149	endp
CO06F_TEXT	ends




CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP

M005_BCC_DATA_8654	equ	8654h

BCC_NEAR_0A1D	label	near
STAOV14A	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		or	SI,SI
		je	short M005_L_0A34
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8654
		cmp	word ptr ES:[SI+8],0
		jne	short M005_L_0A36
M005_L_0A34:
		jmp	short M005_L_0A79
M005_L_0A36:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8654
		mov	SI,word ptr ES:[SI+10h]
		cmp	word ptr ES:[SI],1
		je	short M005_L_0A4A
		cmp	word ptr ES:[SI],2
		jne	short M005_L_0A4F
M005_L_0A4A:
		mov	AX,1
		jmp	short M005_L_0A7B
M005_L_0A4F:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8654
		cmp	word ptr ES:[SI],0
		jne	short M005_L_0A79
		push	SI
		push	CS
		db	0E8h
		dw	0FF1Bh
		or	AX,AX
		je	short M005_L_0A79
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8654
		cmp	word ptr ES:[SI+8],0
		jne	short M005_L_0A79
		cmp	word ptr ES:[SI+0Ch],0
		je	short M005_L_0A79
		mov	AX,1
		jmp	short M005_L_0A7B
M005_L_0A79:
		xor	AX,AX
M005_L_0A7B:
		pop	SI
		pop	BP
		dec	BP
		ret	2
STAOV14A	endp
CO06F_TEXT	ends




CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP

M006_BCC_DATA_8654	equ	8654h
M006_BCC_DATA_86E2	equ	86E2h

BCC_NEAR_0A81	label	near
STAOV14B	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		jmp	short M006_L_0AC3
M006_L_0A8B:
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8654
		cmp	word ptr ES:[SI],3
		je	short M006_L_0ABB
		cmp	word ptr ES:[SI],1
		je	short M006_L_0ABB
		cmp	word ptr ES:[SI],2
		je	short M006_L_0ABB
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8654
		cmp	word ptr ES:[SI],0
		jne	short M006_L_0AC7
		cmp	word ptr ES:[SI+8],0
		jne	short M006_L_0AC7
		push	SI
		push	CS
		db	0E8h
		dw	0FEC2h
		or	AX,AX
		je	short M006_L_0AC7
M006_L_0ABB:
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8654
		mov	SI,word ptr ES:[SI+0Ch]
M006_L_0AC3:
		or	SI,SI
		jne	short M006_L_0A8B
M006_L_0AC7:
		or	SI,SI
		jne	short M006_L_0ACF
		mov	SI,word ptr DGROUP:M006_BCC_DATA_86E2
M006_L_0ACF:
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8654
		inc	word ptr ES:[SI+2]
		db	26h,81h,4Ch,1Ch,10h,00h
		mov	AX,SI
		pop	SI
		pop	BP
		dec	BP
		ret	2
STAOV14B	endp
CO06F_TEXT	ends


CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP

M007_BCC_DATA_8654	equ	8654h


BCC_NEAR_0AE5	label	near
STAOV14C	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8654
		mov	DI,word ptr ES:[SI+10h]
		inc	word ptr ES:[DI+2]
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	2
STAOV14C	endp
CO06F_TEXT	ends


CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP

M008_BCC_DATA_8654	equ	8654h


BCC_NEAR_0B01	label	near
STAOV14D	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8654
		mov	BX,word ptr ES:[SI+10h]
		dec	word ptr ES:[BX+2]
		pop	SI
		pop	BP
		dec	BP
		ret	2
STAOV14D	endp
CO06F_TEXT	ends




CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP

M009_BCC_DATA_8654	equ	8654h

BCC_NEAR_0B1B	label	near
STAOV14E	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		push	SI
		db	0E8h
		dw	0022Ch
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		jne	short M009_L_0B37
		db	0E9h
		dw	000DDh
M009_L_0B37:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8654
		cmp	word ptr ES:[BX+8],1
		je	short M009_L_0B48
		db	0E9h
		dw	000CCh
M009_L_0B48:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8654
		mov	DI,word ptr ES:[SI+0Ch]
		jmp	short M009_L_0B73
M009_L_0B52:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8654
		cmp	word ptr ES:[DI+2],0
		je	short M009_L_0B60
		db	0E9h
		dw	000B4h
M009_L_0B60:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8654
		cmp	word ptr ES:[DI+8],1
		je	short M009_L_0B77
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8654
		mov	DI,word ptr ES:[DI+0Ch]
M009_L_0B73:
		or	DI,DI
		jne	short M009_L_0B52
M009_L_0B77:
		or	DI,DI
		jne	short M009_L_0B7E
		db	0E9h
		dw	00096h
M009_L_0B7E:
		cmp	DI,word ptr [BP+6]
		jne	short M009_L_0BB2
M009_L_0B83:
		push	SI
		db	0E8h
		dw	0019Fh
		mov	DI,AX
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8654
		cmp	word ptr ES:[SI+8],0
		je	short M009_L_0BA3
		cmp	word ptr ES:[SI+8],1
		je	short M009_L_0BA3
		mov	BX,word ptr ES:[SI+10h]
		dec	word ptr ES:[BX+2]
M009_L_0BA3:
		push	SI
		nop
		push	CS
		db	0E8h
		dw	0010Fh
		cmp	SI,word ptr [BP+6]
		je	short M009_L_0C14
		mov	SI,DI
		jmp	short M009_L_0B83
M009_L_0BB2:
		mov	BX,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+0Ch]
		mov	word ptr [BP-6],AX
		mov	AX,word ptr ES:[DI+0Ch]
		mov	word ptr [BP-4],AX
		mov	AX,word ptr ES:[SI+0Eh]
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-2]
		mov	AX,word ptr [BP-4]
		mov	word ptr ES:[BX+0Ch],AX
		cmp	word ptr [BP-4],0
		je	short M009_L_0BE8
		mov	BX,word ptr [BP-4]
		mov	AX,word ptr [BP-2]
		mov	word ptr ES:[BX+0Eh],AX
M009_L_0BE8:
		mov	ES,word ptr DGROUP:M009_BCC_DATA_8654
		mov	AX,word ptr [BP-6]
		mov	word ptr ES:[DI+0Ch],AX
		mov	BX,word ptr [BP-6]
		mov	word ptr ES:[BX+0Eh],DI
		mov	BX,word ptr [BP+6]
		mov	word ptr ES:[BX+0Ch],SI
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[SI+0Eh],AX
		mov	word ptr ES:[BX+8],0
		mov	word ptr ES:[BX+10h],0
M009_L_0C14:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
STAOV14E	endp
CO06F_TEXT	ends




CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP

M00A_BCC_DATA_8654	equ	8654h

BCC_NEAR_0C1D	label	near
STAOV14F	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	DI,word ptr [BP+4]
		push	DI
		db	0E8h
		dw	000F7h
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		je	short M00A_L_0C77
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+10h]
		cmp	AX,word ptr [BP-2]
		jne	short M00A_L_0C77
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8654
		dec	word ptr ES:[BX+2]
		mov	AX,word ptr ES:[DI+10h]
		mov	word ptr ES:[SI+10h],AX
		mov	BX,word ptr ES:[SI+10h]
		inc	word ptr ES:[BX+2]
		push	word ptr ES:[SI+8]
		nop
		push	CS
		db	0E8h
		dw	00017h
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8654
		mov	word ptr ES:[SI+8],AX
		push	DI
		nop
		push	CS
		db	0E8h
		dw	00041h
M00A_L_0C77:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
STAOV14F	endp
CO06F_TEXT	ends


CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP



		public	X06F_01
X06F_01	label	far
BCC_NEAR_0C80	label	near
STAOV150	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		mov	AL,byte ptr [SI+3914h]
		cbw
		pop	SI
		pop	BP
		retf	2
STAOV150	endp
CO06F_TEXT	ends




CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP

M00C_BCC_DATA_8654	equ	8654h
M00C_BCC_DATA_8718	equ	8718h

BCC_NEAR_0C91	label	near
STAOV151	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		push	SI
		db	0E8h
		dw	0FE64h
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_8654
		mov	AX,word ptr [BP+4]
		mov	word ptr ES:[SI+10h],AX
		push	SI
		db	0E8h
		dw	0FE39h
		mov	word ptr DGROUP:M00C_BCC_DATA_8718,1
		pop	SI
		pop	BP
		dec	BP
		ret	4
STAOV151	endp
CO06F_TEXT	ends




CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP

M00D_BCC_DATA_8654	equ	8654h
M00D_BCC_DATA_86E0	equ	86E0h
M00D_BCC_DATA_86E2	equ	86E2h
M00D_BCC_DATA_8718	equ	8718h

		public	X06F_03
X06F_03	label	far
BCC_NEAR_0CB8	label	near
STAOV152	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+6]
		cmp	SI,word ptr DGROUP:M00D_BCC_DATA_86E0
		jne	short M00D_L_0CD0
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+0Ch]
		mov	DGROUP:M00D_BCC_DATA_86E0,AX
M00D_L_0CD0:
		cmp	SI,word ptr DGROUP:M00D_BCC_DATA_86E2
		jne	short M00D_L_0CE1
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+0Eh]
		mov	DGROUP:M00D_BCC_DATA_86E2,AX
M00D_L_0CE1:
		push	SI
		db	0E8h
		dw	0FC56h
		or	AX,AX
		je	short M00D_L_0CED
		push	SI
		db	0E8h
		dw	0FE14h
M00D_L_0CED:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8654
		cmp	word ptr ES:[SI+0Eh],0
		je	short M00D_L_0D04
		mov	AX,word ptr ES:[SI+0Ch]
		mov	BX,word ptr ES:[SI+0Eh]
		mov	word ptr ES:[BX+0Ch],AX
M00D_L_0D04:
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8654
		cmp	word ptr ES:[SI+0Ch],0
		je	short M00D_L_0D1B
		mov	AX,word ptr ES:[SI+0Eh]
		mov	BX,word ptr ES:[SI+0Ch]
		mov	word ptr ES:[BX+0Eh],AX
M00D_L_0D1B:
		mov	word ptr DGROUP:M00D_BCC_DATA_8718,1
		pop	SI
		pop	BP
		retf	2
STAOV152	endp
CO06F_TEXT	ends


CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP

M00E_BCC_DATA_8654	equ	8654h


BCC_NEAR_0D26	label	near
STAOV153	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
M00E_L_0D2E:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8654
		mov	SI,word ptr ES:[SI+0Ch]
		or	SI,SI
		jne	short M00E_L_0D3C
		jmp	short M00E_L_0D4F
M00E_L_0D3C:
		mov	ES,word ptr DGROUP:M00E_BCC_DATA_8654
		mov	AX,word ptr ES:[SI]
		cmp	AX,1
		je	short M00E_L_0D2E
		cmp	AX,2
		je	short M00E_L_0D2E
		jmp	short M00E_L_0D4F
M00E_L_0D4F:
		mov	AX,SI
		pop	SI
		pop	BP
		dec	BP
		ret	2
STAOV153	endp
CO06F_TEXT	ends


CO06F_TEXT	segment byte public 'CODE'
		assume	cs:CO06F_TEXT,ds:DGROUP

M00F_BCC_DATA_8654	equ	8654h


BCC_NEAR_0D57	label	near
STAOV154	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
M00F_L_0D5F:
		mov	ES,word ptr DGROUP:M00F_BCC_DATA_8654
		mov	SI,word ptr ES:[SI+0Eh]
		or	SI,SI
		jne	short M00F_L_0D6D
		jmp	short M00F_L_0D80
M00F_L_0D6D:
		mov	ES,word ptr DGROUP:M00F_BCC_DATA_8654
		mov	AX,word ptr ES:[SI]
		cmp	AX,1
		je	short M00F_L_0D5F
		cmp	AX,2
		je	short M00F_L_0D5F
		jmp	short M00F_L_0D80
M00F_L_0D80:
		mov	AX,SI
		pop	SI
		pop	BP
		dec	BP
		ret	2
STAOV154	endp
CO06F_TEXT	ends

; END C105UNIT
		end
