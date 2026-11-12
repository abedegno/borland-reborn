		public	X070_00
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1dc5_b0d9
; BEGIN C106UNIT (listing ovr_1dc5_b0d9:0D90)

CO070_TEXT	segment byte public 'CODE'
		assume	cs:CO070_TEXT,ds:DGROUP

M000_BCC_DATA_866E	equ	866Eh
M000_BCC_DATA_8680	equ	8680h
M000_BCC_DATA_8698	equ	8698h


BCC_NEAR_0D90	label	near
STAOV155	proc	far
M000_L_0D90:
		push	BP
		mov	BP,SP
		sub	SP,6
		push	SI
		push	DI
		cmp	word ptr [BP+8],0
		jne	short M000_L_0DB0
		cmp	word ptr [BP+6],0
		jne	short M000_L_0DAA
		mov	AX,1
		db	0E9h
		dw	00173h
M000_L_0DAA:
		db	0E9h
		dw	0016Eh
		db	0E9h
		dw	0016Dh
M000_L_0DB0:
		cmp	word ptr [BP+6],0
		jne	short M000_L_0DBB
		xor	AX,AX
		db	0E9h
		dw	00162h
M000_L_0DBB:
		mov	AX,word ptr [BP+8]
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		mov	AX,word ptr [BP+6]
		shl	AX,1
		shl	AX,1
		mov	DI,AX
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		test	byte ptr ES:[SI+1],1
		jne	short M000_L_0DF5
		test	byte ptr ES:[DI+1],1
		jne	short M000_L_0DF5
		mov	AL,byte ptr ES:[SI+2]
		cmp	AL,byte ptr ES:[DI+2]
		jne	short M000_L_0DEF
		mov	AX,1
		db	0E9h
		dw	0012Eh
M000_L_0DEF:
		db	0E9h
		dw	00129h
		db	0E9h
		dw	00128h
M000_L_0DF5:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		cmp	AL,byte ptr ES:[DI]
		jne	short M000_L_0E15
		mov	AL,byte ptr ES:[SI+1]
		cmp	AL,byte ptr ES:[DI+1]
		jne	short M000_L_0E15
		mov	AL,byte ptr ES:[SI+2]
		cmp	AL,byte ptr ES:[DI+2]
		je	short M000_L_0E1A
M000_L_0E15:
		xor	AX,AX
		db	0E9h
		dw	00103h
M000_L_0E1A:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		add	AX,3F98h
		mov	word ptr [BP-6],AX
		mov	BX,word ptr [BP-6]
		mov	AX,word ptr [BX+3]
		and	AX,1
		or	AX,0
		je	short M000_L_0EA0
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		mov	word ptr [BP-2],AX
		mov	AX,word ptr ES:[DI]
		mov	word ptr [BP-4],AX
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_866E
		test	byte ptr ES:[BX+0Eh],2
		je	short M000_L_0E80
		mov	BX,word ptr [BP-4]
		test	byte ptr ES:[BX+0Eh],2
		je	short M000_L_0E80
		mov	BX,word ptr [BP-2]
		mov	AL,byte ptr ES:[BX+7]
		mov	BX,word ptr [BP-4]
		cmp	AL,byte ptr ES:[BX+7]
		jne	short M000_L_0E7A
		mov	AX,1
		db	0E9h
		dw	000A3h
M000_L_0E7A:
		db	0E9h
		dw	0009Eh
		db	0E9h
		dw	0009Dh
M000_L_0E80:
		mov	AX,word ptr [BP-2]
		cmp	AX,word ptr [BP-4]
		jne	short M000_L_0E9C
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		cmp	AX,word ptr ES:[DI+2]
		jne	short M000_L_0E9C
		mov	AX,1
		db	0E9h
		dw	00081h
M000_L_0E9C:
		jmp	short M000_L_0F1B
		jmp	short M000_L_0F1D
M000_L_0EA0:
		mov	BX,word ptr [BP-6]
		mov	AX,word ptr [BX+3]
		and	AX,8
		or	AX,0
		je	short M000_L_0ECD
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		mov	DX,word ptr ES:[SI]
		cmp	AX,word ptr ES:[DI+2]
		jne	short M000_L_0EC9
		cmp	DX,word ptr ES:[DI]
		jne	short M000_L_0EC9
		mov	AX,1
		jmp	short M000_L_0F1D
M000_L_0EC9:
		jmp	short M000_L_0F1B
		jmp	short M000_L_0F1D
M000_L_0ECD:
		mov	BX,word ptr [BP-6]
		mov	AX,word ptr [BX+3]
		and	AX,20h
		or	AX,0
		je	short M000_L_0EF0
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		cmp	AX,word ptr ES:[DI]
		jne	short M000_L_0EEC
		mov	AX,1
		jmp	short M000_L_0F1D
M000_L_0EEC:
		jmp	short M000_L_0F1B
		jmp	short M000_L_0F1D
M000_L_0EF0:
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		push	word ptr ES:[SI]
		push	word ptr ES:[DI]
		push	CS
		db	0E8h
		dw	0FE92h
		or	AX,AX
		je	short M000_L_0F1B
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8698
		push	word ptr ES:[SI+2]
		push	word ptr ES:[DI+2]
		push	CS
		db	0E8h
		dw	0FE7Eh
		or	AX,AX
		je	short M000_L_0F1B
		mov	AX,1
		jmp	short M000_L_0F1D
M000_L_0F1B:
		xor	AX,AX
M000_L_0F1D:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
STAOV155	endp
CO070_TEXT	ends


CO070_TEXT	segment byte public 'CODE'
		assume	cs:CO070_TEXT,ds:DGROUP

M001_BCC_DATA_8654	equ	8654h
M001_BCC_DATA_8666	equ	8666h
M001_BCC_DATA_866A	equ	866Ah


BCC_NEAR_0F25	label	near
STAOV156	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	DX,word ptr [BP+6]
		mov	BX,DX
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+4]
		mov	CX,AX
		add	AX,word ptr ES:[BX+6]
		dec	AX
		mov	word ptr [BP-2],AX
		mov	SI,word ptr ES:[BX+0Ah]
		xor	DI,DI
		jmp	short M001_L_0F4F
M001_L_0F4B:
		add	SI,9
		inc	DI
M001_L_0F4F:
		cmp	SI,word ptr DGROUP:M001_BCC_DATA_866A
		jnc	short M001_L_0F6A
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8666
		mov	AX,word ptr ES:[SI+3]
		cmp	AX,CX
		jc	short M001_L_0F6A
		mov	AX,word ptr ES:[SI+3]
		cmp	AX,word ptr [BP-2]
		jbe	short M001_L_0F4B
M001_L_0F6A:
		mov	AX,DI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
STAOV156	endp
CO070_TEXT	ends


		extrn	X057_10:far


CO070_TEXT	segment byte public 'CODE'
		assume	cs:CO070_TEXT,ds:DGROUP

M002_BCC_DATA_8654	equ	8654h
M002_BCC_DATA_8666	equ	8666h
M002_BCC_DATA_866A	equ	866Ah
M002_BCC_DATA_866E	equ	866Eh
M002_BCC_DATA_8680	equ	8680h
M002_BCC_DATA_8698	equ	8698h
M002_BCC_DATA_875E	equ	875Eh

BCC_NEAR_0F74	label	near
STAOV157	proc	far
		push	BP
		mov	BP,SP
		sub	SP,18h
		push	SI
		push	DI
		mov	BX,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+6]
		mov	word ptr [BP-0Ah],AX
		mov	BX,word ptr [BP+6]
		mov	AX,word ptr ES:[BX+6]
		mov	word ptr [BP-0Ch],AX
		mov	BX,word ptr [BP+8]
		mov	AX,word ptr ES:[BX+4]
		add	AX,word ptr [BP-0Ah]
		dec	AX
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP+6]
		mov	AX,word ptr ES:[BX+4]
		add	AX,word ptr [BP-0Ch]
		dec	AX
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-4],AX
		push	word ptr [BP+8]
		push	CS
		db	0E8h
		dw	0FF66h
		mov	word ptr [BP-0Eh],AX
		push	word ptr [BP+6]
		push	CS
		db	0E8h
		dw	0FF5Ch
		mov	word ptr [BP-10h],AX
		mov	BX,word ptr [BP+8]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+0Ah]
		push	AX
		mov	AX,word ptr [BP-0Eh]
		mov	DX,9
		imul	DX
		pop	DX
		add	DX,AX
		add	DX,-9
		mov	DI,DX
		mov	BX,word ptr [BP+6]
		mov	AX,word ptr ES:[BX+0Ah]
		push	AX
		mov	AX,word ptr [BP-10h]
		mov	DX,9
		imul	DX
		pop	DX
		add	DX,AX
		add	DX,-9
		mov	SI,DX
		mov	word ptr [BP-6],0
		db	0E9h
		dw	00275h
M002_L_1008:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[BX+1],40h
		je	short M002_L_1020
		sub	word ptr [BP-2],4
		dec	word ptr [BP-0Ah]
		db	0E9h
		dw	0025Dh
M002_L_1020:
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		test	byte ptr ES:[BX+1],40h
		je	short M002_L_1038
		sub	word ptr [BP-4],4
		dec	word ptr [BP-0Ch]
		db	0E9h
		dw	00245h
M002_L_1038:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	BX,word ptr [BP-2]
		mov	AL,byte ptr ES:[BX]
		mov	BX,word ptr [BP-4]
		cmp	AL,byte ptr ES:[BX]
		je	short M002_L_104D
		db	0E9h
		dw	0023Fh
M002_L_104D:
		mov	BX,word ptr [BP-2]
		mov	AL,byte ptr ES:[BX+1]
		mov	BX,word ptr [BP-4]
		cmp	AL,byte ptr ES:[BX+1]
		je	short M002_L_1060
		db	0E9h
		dw	0022Ch
M002_L_1060:
		mov	BX,word ptr [BP-2]
		mov	AL,byte ptr ES:[BX+2]
		mov	BX,word ptr [BP-4]
		cmp	AL,byte ptr ES:[BX+2]
		je	short M002_L_1073
		db	0E9h
		dw	00219h
M002_L_1073:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	BX,word ptr [BP-2]
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		mov	DX,13h
		imul	DX
		add	AX,3F98h
		mov	word ptr [BP-14h],AX
		mov	BX,word ptr [BP-14h]
		mov	AX,word ptr [BX+3]
		and	AX,1
		or	AX,0
		je	short M002_L_1101
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	BX,word ptr [BP-2]
		mov	AX,word ptr ES:[BX]
		mov	word ptr [BP-16h],AX
		mov	BX,word ptr [BP-4]
		mov	AX,word ptr ES:[BX]
		mov	word ptr [BP-18h],AX
		mov	BX,word ptr [BP-16h]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_866E
		test	byte ptr ES:[BX+0Eh],2
		je	short M002_L_10DC
		mov	BX,word ptr [BP-18h]
		test	byte ptr ES:[BX+0Eh],2
		je	short M002_L_10DC
		mov	BX,word ptr [BP-16h]
		mov	AL,byte ptr ES:[BX+7]
		mov	BX,word ptr [BP-18h]
		cmp	AL,byte ptr ES:[BX+7]
		jne	short M002_L_10D9
		db	0E9h
		dw	000B3h
M002_L_10D9:
		db	0E9h
		dw	001B0h
M002_L_10DC:
		mov	AX,word ptr [BP-16h]
		cmp	AX,word ptr [BP-18h]
		je	short M002_L_10E7
		db	0E9h
		dw	001A5h
M002_L_10E7:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	BX,word ptr [BP-2]
		mov	AX,word ptr ES:[BX+2]
		mov	BX,word ptr [BP-4]
		cmp	AX,word ptr ES:[BX+2]
		jne	short M002_L_10FE
		db	0E9h
		dw	0008Eh
M002_L_10FE:
		db	0E9h
		dw	0018Bh
M002_L_1101:
		mov	BX,word ptr [BP-14h]
		mov	AX,word ptr [BX+3]
		and	AX,8
		or	AX,0
		je	short M002_L_1131
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	BX,word ptr [BP-2]
		mov	AX,word ptr ES:[BX+2]
		mov	DX,word ptr ES:[BX]
		mov	BX,word ptr [BP-4]
		cmp	AX,word ptr ES:[BX+2]
		je	short M002_L_1129
		db	0E9h
		dw	00163h
M002_L_1129:
		cmp	DX,word ptr ES:[BX]
		je	short M002_L_118C
		db	0E9h
		dw	0015Bh
M002_L_1131:
		mov	BX,word ptr [BP-14h]
		mov	AX,word ptr [BX+3]
		and	AX,20h
		or	AX,0
		je	short M002_L_1154
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	BX,word ptr [BP-2]
		mov	AX,word ptr ES:[BX]
		mov	BX,word ptr [BP-4]
		cmp	AX,word ptr ES:[BX]
		je	short M002_L_118C
		db	0E9h
		dw	00138h
M002_L_1154:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	BX,word ptr [BP-2]
		push	word ptr ES:[BX]
		mov	BX,word ptr [BP-4]
		push	word ptr ES:[BX]
		push	CS
		db	0E8h
		dw	0FC28h
		or	AX,AX
		jne	short M002_L_116F
		db	0E9h
		dw	0011Dh
M002_L_116F:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	BX,word ptr [BP-2]
		push	word ptr ES:[BX+2]
		mov	BX,word ptr [BP-4]
		push	word ptr ES:[BX+2]
		push	CS
		db	0E8h
		dw	0FC0Bh
		or	AX,AX
		jne	short M002_L_118C
		db	0E9h
		dw	00100h
M002_L_118C:
		mov	word ptr [BP-8],1
M002_L_1191:
		cmp	word ptr [BP-0Eh],0
		je	short M002_L_11B2
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8666
		mov	BX,word ptr [BP+8]
		push	ES
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+4]
		add	AX,word ptr [BP-0Ah]
		dec	AX
		pop	ES
		cmp	word ptr ES:[DI+3],AX
		je	short M002_L_11E0
M002_L_11B2:
		cmp	word ptr [BP-10h],0
		je	short M002_L_11D3
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8666
		mov	BX,word ptr [BP+6]
		push	ES
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+4]
		add	AX,word ptr [BP-0Ch]
		dec	AX
		pop	ES
		cmp	word ptr ES:[SI+3],AX
		je	short M002_L_11D8
M002_L_11D3:
		mov	AX,1
		jmp	short M002_L_11DA
M002_L_11D8:
		xor	AX,AX
M002_L_11DA:
		mov	word ptr [BP-8],AX
		db	0E9h
		dw	00084h
M002_L_11E0:
		cmp	word ptr [BP-10h],0
		je	short M002_L_1201
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8666
		mov	BX,word ptr [BP+6]
		push	ES
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+4]
		add	AX,word ptr [BP-0Ch]
		dec	AX
		pop	ES
		cmp	word ptr ES:[SI+3],AX
		je	short M002_L_1208
M002_L_1201:
		mov	word ptr [BP-8],0
		jmp	short M002_L_1264
M002_L_1208:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8666
		mov	AL,byte ptr ES:[DI]
		cmp	AL,byte ptr ES:[SI]
		jne	short M002_L_124E
		mov	AL,byte ptr ES:[DI+1]
		cmp	AL,byte ptr ES:[SI+1]
		jne	short M002_L_124E
		mov	AL,byte ptr ES:[DI+2]
		cmp	AL,byte ptr ES:[SI+2]
		jne	short M002_L_124E
		mov	BX,word ptr ES:[DI+5]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[BX+2]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8666
		mov	BX,word ptr ES:[SI+5]
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		cmp	AL,byte ptr ES:[BX+2]
		je	short M002_L_1255
M002_L_124E:
		mov	word ptr [BP-8],0
		jmp	short M002_L_1264
M002_L_1255:
		sub	DI,9
		sub	SI,9
		dec	word ptr [BP-0Eh]
		dec	word ptr [BP-10h]
		db	0E9h
		dw	0FF2Dh
M002_L_1264:
		cmp	word ptr [BP-8],0
		je	short M002_L_128C
		dec	word ptr [BP-0Ah]
		sub	word ptr [BP-2],4
		dec	word ptr [BP-0Ch]
		sub	word ptr [BP-4],4
		mov	word ptr [BP-6],1
M002_L_127D:
		cmp	word ptr [BP-0Ah],0
		je	short M002_L_128C
		cmp	word ptr [BP-0Ch],0
		je	short M002_L_128C
		db	0E9h
		dw	0FD7Ch
M002_L_128C:
		cmp	word ptr [BP-6],0
		jne	short M002_L_1295
		db	0E9h
		dw	00102h
M002_L_1295:
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-12h],AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	BX,word ptr [BP-12h]
		mov	word ptr ES:[BX],0
		mov	BX,word ptr [BP+6]
		mov	AX,word ptr ES:[BX+8]
		mov	BX,word ptr [BP-12h]
		mov	word ptr ES:[BX+8],AX
		mov	BX,word ptr [BP+6]
		mov	AX,word ptr ES:[BX+10h]
		mov	BX,word ptr [BP-12h]
		mov	word ptr ES:[BX+10h],AX
		mov	BX,word ptr [BP+6]
		mov	word ptr ES:[BX+8],0
		mov	word ptr ES:[BX+10h],0
		mov	AX,word ptr ES:[BX+6]
		sub	AX,word ptr [BP-0Ch]
		mov	BX,word ptr [BP-12h]
		mov	word ptr ES:[BX+6],AX
		mov	BX,word ptr [BP+6]
		mov	AX,word ptr ES:[BX+4]
		add	AX,word ptr [BP-0Ch]
		mov	BX,word ptr [BP-12h]
		mov	word ptr ES:[BX+4],AX
		mov	BX,word ptr [BP+6]
		mov	AX,word ptr [BP-0Ch]
		mov	word ptr ES:[BX+6],AX
		mov	BX,word ptr [BP+8]
		mov	AX,word ptr [BP-0Ah]
		mov	word ptr ES:[BX+6],AX
		mov	BX,word ptr [BP+6]
		mov	AX,word ptr ES:[BX+0Ch]
		mov	BX,word ptr [BP-12h]
		mov	word ptr ES:[BX+0Ch],AX
		mov	BX,word ptr [BP+6]
		mov	SI,word ptr ES:[BX+0Ah]
		jmp	short M002_L_1321
M002_L_131E:
		add	SI,9
M002_L_1321:
		cmp	SI,word ptr DGROUP:M002_BCC_DATA_866A
		jnc	short M002_L_1343
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8666
		cmp	word ptr ES:[SI+3],0
		je	short M002_L_1343
		mov	AX,word ptr ES:[SI+3]
		mov	BX,word ptr [BP-12h]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		cmp	AX,word ptr ES:[BX+4]
		jc	short M002_L_131E
M002_L_1343:
		mov	BX,word ptr [BP-12h]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	word ptr ES:[BX+0Ah],SI
		mov	BX,word ptr [BP+6]
		mov	AX,word ptr [BP-12h]
		mov	word ptr ES:[BX+0Ch],AX
		mov	BX,word ptr [BP-12h]
		mov	BX,word ptr ES:[BX+0Ch]
		mov	word ptr ES:[BX+0Eh],AX
		mov	BX,word ptr [BP-12h]
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[BX+0Eh],AX
		mov	BX,word ptr [BP+8]
		mov	AX,word ptr [BP-12h]
		mov	word ptr ES:[BX+10h],AX
		mov	BX,word ptr [BP-12h]
		mov	word ptr ES:[BX+1Ch],10h
		cmp	word ptr [BP-0Ah],0
		je	short M002_L_138C
		cmp	word ptr [BP-0Ch],0
		jne	short M002_L_1392
M002_L_138C:
		mov	word ptr DGROUP:M002_BCC_DATA_875E,1
M002_L_1392:
		mov	AX,word ptr [BP-12h]
		jmp	short M002_L_139A
M002_L_1397:
		mov	AX,word ptr [BP+6]
M002_L_139A:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
STAOV157	endp
CO070_TEXT	ends


		extrn	BCC_FAR_04CF:far


CO070_TEXT	segment byte public 'CODE'
		assume	cs:CO070_TEXT,ds:DGROUP

M003_BCC_DATA_1702	equ	1702h
M003_BCC_DATA_5CA2	equ	5CA2h
M003_BCC_DATA_8654	equ	8654h
M003_BCC_DATA_86E0	equ	86E0h
M003_BCC_DATA_875E	equ	875Eh

		public	X070_00
X070_00	label	far
STAOV158	proc	far
		push	BP
		mov	BP,SP
		sub	SP,8
		push	SI
		push	DI
M003_L_13AA:
		cmp	word ptr DGROUP:M003_BCC_DATA_5CA2,0
		je	short M003_L_13B6
		db	09Ah
		dw	BCC_FAR_04CF
		dw	seg BCC_FAR_04CF
M003_L_13B6:
		mov	word ptr DGROUP:M003_BCC_DATA_875E,0
		mov	AX,DGROUP:M003_BCC_DATA_86E0
		jmp	short M003_L_13D2
M003_L_13C1:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	word ptr ES:[BX+20h],0
		mov	AX,word ptr ES:[BX+0Ch]
M003_L_13D2:
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		jne	short M003_L_13C1
		mov	AX,DGROUP:M003_BCC_DATA_86E0
		db	0E9h
		dw	0010Fh
M003_L_13E1:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	BX,word ptr [BP-2]
		cmp	word ptr ES:[BX],0
		je	short M003_L_13F1
		db	0E9h
		dw	000F4h
M003_L_13F1:
		cmp	word ptr ES:[BX+6],0
		jne	short M003_L_13FB
		db	0E9h
		dw	000EAh
M003_L_13FB:
		cmp	word ptr ES:[BX+8],1
		jne	short M003_L_140D
		mov	SI,word ptr ES:[BX+10h]
		mov	word ptr [BP-8],0
		jmp	short M003_L_147C
M003_L_140D:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		cmp	word ptr ES:[BX+8],0
		je	short M003_L_141E
		db	0E9h
		dw	000C7h
M003_L_141E:
		mov	SI,word ptr ES:[BX+0Ch]
		mov	word ptr [BP-8],1
		or	SI,SI
		jne	short M003_L_147C
		db	0E9h
		dw	000B7h
M003_L_142E:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		cmp	word ptr ES:[SI],1
		je	short M003_L_143E
		cmp	word ptr ES:[SI],2
		jne	short M003_L_1448
M003_L_143E:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	SI,word ptr ES:[SI+0Ch]
		jmp	short M003_L_147C
M003_L_1448:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		cmp	word ptr ES:[SI],0
		jne	short M003_L_1487
		cmp	word ptr ES:[SI+6],0
		jne	short M003_L_1487
		cmp	word ptr ES:[SI+8],0
		jne	short M003_L_1466
		mov	SI,word ptr ES:[SI+0Ch]
		jmp	short M003_L_147C
M003_L_1466:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		cmp	word ptr ES:[SI+8],1
		jne	short M003_L_1487
		mov	SI,word ptr ES:[SI+10h]
		mov	word ptr [BP-8],0
		jmp	short M003_L_1487
M003_L_147C:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		cmp	word ptr ES:[SI+0Ch],0
		jne	short M003_L_142E
M003_L_1487:
		cmp	word ptr [BP-8],0
		jne	short M003_L_149E
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	word ptr ES:[BX+8],1
		mov	word ptr ES:[BX+10h],SI
M003_L_149E:
		cmp	word ptr [BP-8],0
		jne	short M003_L_14AF
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		cmp	word ptr ES:[SI+20h],0
		jne	short M003_L_14C7
M003_L_14AF:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+20h]
		mov	BX,word ptr [BP-2]
		mov	word ptr ES:[BX+22h],AX
		mov	AX,word ptr [BP-2]
		mov	word ptr ES:[SI+20h],AX
		jmp	short M003_L_14E5
M003_L_14C7:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	BX,word ptr ES:[SI+20h]
		mov	AX,word ptr ES:[BX+22h]
		mov	BX,word ptr [BP-2]
		mov	word ptr ES:[BX+22h],AX
		mov	BX,word ptr ES:[SI+20h]
		mov	AX,word ptr [BP-2]
		mov	word ptr ES:[BX+22h],AX
M003_L_14E5:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+0Ch]
M003_L_14F0:
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		je	short M003_L_14FC
		db	0E9h
		dw	0FEE5h
M003_L_14FC:
		mov	AX,DGROUP:M003_BCC_DATA_86E0
		jmp	short M003_L_1577
M003_L_1501:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	SI,word ptr ES:[BX+20h]
		jmp	short M003_L_1568
M003_L_150E:
		cmp	byte ptr DGROUP:M003_BCC_DATA_1702,0
		je	short M003_L_1520
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		cmp	word ptr ES:[SI+8],0
		jne	short M003_L_156C
M003_L_1520:
		mov	word ptr [BP-4],SI
		mov	word ptr [BP-6],SI
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	DI,word ptr ES:[SI+22h]
		jmp	short M003_L_155C
M003_L_1530:
		push	DI
		push	word ptr [BP-4]
		push	CS
		db	0E8h
		dw	0FA3Ch
		mov	word ptr [BP-4],AX
		cmp	word ptr [BP-4],SI
		je	short M003_L_1551
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	DI,word ptr ES:[DI+22h]
		mov	BX,word ptr [BP-6]
		mov	word ptr ES:[BX+22h],DI
		jmp	short M003_L_155C
M003_L_1551:
		mov	word ptr [BP-6],DI
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	DI,word ptr ES:[DI+22h]
M003_L_155C:
		or	DI,DI
		jne	short M003_L_1530
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	SI,word ptr ES:[SI+22h]
M003_L_1568:
		or	SI,SI
		jne	short M003_L_150E
M003_L_156C:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+0Ch]
M003_L_1577:
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		jne	short M003_L_1501
		cmp	word ptr DGROUP:M003_BCC_DATA_875E,0
		je	short M003_L_158A
		db	0E9h
		dw	0FE20h
M003_L_158A:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf
STAOV158	endp
CO070_TEXT	ends

; END C106UNIT
		end
