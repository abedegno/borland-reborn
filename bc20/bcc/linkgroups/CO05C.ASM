		public	X05C_01
		public	X05C_00
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d6c_a3dc
; BEGIN C209UNIT (listing ovr_1d6c_a3dc:3DC0)

CO05C_TEXT	segment byte public 'CODE'
		assume	cs:CO05C_TEXT,ds:DGROUP

M000_BCC_DATA_8654	equ	8654h
M000_BCC_DATA_8B1A	equ	8B1Ah


BCC_NEAR_3DC0	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8654
		mov	AX,DGROUP:M000_BCC_DATA_8B1A
		mov	word ptr ES:[SI+0Ch],AX
		mov	word ptr DGROUP:M000_BCC_DATA_8B1A,SI
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_3DC0	endp
CO05C_TEXT	ends


		extrn	X057_13:far
		extrn	X057_10:far
		extrn	X058_01:far


CO05C_TEXT	segment byte public 'CODE'
		assume	cs:CO05C_TEXT,ds:DGROUP

M001_BCC_DATA_1702	equ	1702h
M001_BCC_DATA_5362	equ	5362h
M001_BCC_DATA_8654	equ	8654h
M001_BCC_DATA_8688	equ	8688h
M001_BCC_DATA_86F9	equ	86F9h

		public	X05C_00
X05C_00	label	far
BCC_FAR_3DDD	proc	far
		push	BP
		mov	BP,SP
		sub	SP,0Ah
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+12h]
		mov	word ptr [BP-0Ah],AX
		cmp	word ptr [BP-0Ah],0
		jne	short M001_L_3E01
		mov	word ptr ES:[SI],0
		db	0E9h
		dw	00109h
M001_L_3E01:
		mov	word ptr [BP-2],1
		mov	DI,word ptr [BP-0Ah]
		jmp	short M001_L_3E15
M001_L_3E0B:
		inc	word ptr [BP-2]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8688
		mov	DI,word ptr ES:[DI]
M001_L_3E15:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8688
		cmp	word ptr ES:[DI],0
		jne	short M001_L_3E0B
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8654
		test	word ptr ES:[SI+1Ch],4
		je	short M001_L_3E2E
		db	0E9h
		dw	000D2h
M001_L_3E2E:
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8688
		mov	AX,word ptr ES:[DI+2]
		mov	BX,word ptr [BP-0Ah]
		sub	AX,word ptr ES:[BX+2]
		push	AX
		mov	AX,word ptr [BP-2]
		mov	DX,3
		imul	DX
		pop	DX
		cmp	DX,AX
		jbe	short M001_L_3E5B
		cmp	byte ptr DGROUP:M001_BCC_DATA_1702,0
		jne	short M001_L_3E5B
		cmp	word ptr [BP-2],4
		jc	short M001_L_3E5B
		db	0E9h
		dw	000A5h
M001_L_3E5B:
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-8],AX
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+18h]
		mov	DX,word ptr ES:[SI+16h]
		mov	word ptr [BP-4],AX
		mov	word ptr [BP-6],DX
		mov	AX,99h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-6]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-6],AX
		cmp	word ptr [BP-4],0
		je	short M001_L_3EA5
		mov	AX,99h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-4],AX
M001_L_3EA5:
		mov	BX,word ptr [BP-8]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8654
		mov	AX,DGROUP:M001_BCC_DATA_86F9
		sub	AX,word ptr ES:[BX+4]
		mov	word ptr ES:[BX+6],AX
		mov	AX,word ptr [BP-4]
		mov	DX,word ptr [BP-6]
		mov	word ptr ES:[SI+18h],AX
		mov	word ptr ES:[SI+16h],DX
		mov	AX,word ptr ES:[SI+1Ch]
		and	AX,200h
		mov	DGROUP:M001_BCC_DATA_5362,AX
		push	SI
		push	word ptr [BP-2]
		push	word ptr [BP-0Ah]
		push	word ptr [BP-8]
		db	0E8h
		dw	003BEh
		mov	ES,word ptr DGROUP:M001_BCC_DATA_8654
		mov	word ptr ES:[SI],0
		mov	word ptr ES:[SI+8],0
		mov	word ptr ES:[SI+10h],0
		push	SI
		push	word ptr [BP-8]
		push	word ptr ES:[SI+24h]
		db	09Ah
		dw	X057_13
		dw	seg X057_13
		jmp	short M001_L_3F0A
M001_L_3F00:
		push	SI
		push	word ptr [BP-2]
		push	word ptr [BP-0Ah]
		db	0E8h
		dw	00008h
M001_L_3F0A:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_3DDD	endp
CO05C_TEXT	ends


		extrn	X057_07:far
		extrn	X057_08:far
		extrn	X057_13:far
		extrn	X057_10:far
		extrn	X058_04:far
		extrn	X058_00:far
		extrn	X058_01:far
		extrn	X060_02:far


CO05C_TEXT	segment byte public 'CODE'
		assume	cs:CO05C_TEXT,ds:DGROUP

M002_BCC_DATA_8654	equ	8654h
M002_BCC_DATA_86F9	equ	86F9h

BCC_NEAR_3F12	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,16h
		push	SI
		push	DI
		mov	SI,word ptr [BP+8]
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-16h],AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	BX,word ptr [BP-16h]
		mov	word ptr ES:[BX],1
		mov	AX,word ptr [BP+4]
		mov	word ptr ES:[BX+12h],AX
		mov	AX,word ptr ES:[SI+1Ch]
		mov	word ptr ES:[BX+1Ch],AX
		mov	AX,word ptr [BP+6]
		mov	word ptr ES:[BX+14h],AX
		push	word ptr [BP-16h]
		db	0E8h
		dw	0FE72h
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,word ptr ES:[SI+18h]
		mov	DX,word ptr ES:[SI+16h]
		mov	word ptr [BP-10h],AX
		mov	word ptr [BP-12h],DX
		xor	AX,AX
		push	AX
		test	word ptr ES:[SI+1Ch],4
		je	short M002_L_3F6F
		mov	AL,8
		jmp	short M002_L_3F71
M002_L_3F6F:
		mov	AL,6
M002_L_3F71:
		push	AX
		mov	AL,0
		push	AX
		db	09Ah
		dw	X060_02
		dw	seg X060_02
		mov	word ptr [BP-14h],AX
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-2],AX
		mov	AX,10h
		push	AX
		push	word ptr [BP-14h]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Ch],AX
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-0Ch]
		push	word ptr [BP-12h]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		test	word ptr ES:[SI+1Ch],4
		je	short M002_L_3FDA
		mov	AX,10h
		push	AX
		push	word ptr [BP-14h]
		mov	AX,2
		push	AX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		mov	word ptr [BP-0Ch],AX
		mov	AX,9Ch
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-0Ch]
		push	word ptr [BP-10h]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
M002_L_3FDA:
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
		xor	AX,AX
		push	AX
		mov	AX,0Ah
		push	AX
		mov	AX,word ptr [BP+6]
		cwd
		push	DX
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,0B0h
		push	AX
		mov	AX,word ptr [BP-16h]
		cwd
		push	DX
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,DGROUP:M002_BCC_DATA_86F9
		sub	AX,word ptr ES:[BX+4]
		mov	word ptr ES:[BX+6],AX
		mov	word ptr ES:[BX],0
		mov	word ptr ES:[BX+8],1
		mov	word ptr ES:[BX+10h],0
		mov	word ptr ES:[SI+8],0
		mov	AX,word ptr ES:[SI+10h]
		mov	word ptr [BP-0Ah],AX
		mov	word ptr ES:[SI+10h],0
		mov	word ptr ES:[SI],0
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	DI,AX
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-6],AX
		mov	AX,16h
		push	AX
		mov	AL,0
		push	AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,4
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		push	AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,0Eh
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-0Ch],AX
		mov	AX,81h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		mov	AX,10h
		push	AX
		push	word ptr [BP-14h]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,DGROUP:M002_BCC_DATA_86F9
		sub	AX,word ptr ES:[DI+4]
		mov	word ptr ES:[DI+6],AX
		test	word ptr ES:[SI+1Ch],4
		jne	short M002_L_40D7
		mov	word ptr ES:[DI+8],0Ah
		mov	AX,word ptr [BP-6]
		mov	word ptr ES:[DI+10h],AX
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-8],AX
		db	0E9h
		dw	000C5h
M002_L_40D7:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	word ptr ES:[DI+8],0Bh
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-4],AX
		mov	AX,1Fh
		push	AX
		mov	AL,0
		push	AX
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,4
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		push	AX
		mov	AX,0Ah
		push	AX
		mov	AX,word ptr [BP+6]
		shl	AX,1
		cwd
		push	DX
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-0Eh],AX
		mov	AX,16h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Eh]
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,0Eh
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-0Ch],AX
		mov	AX,81h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		mov	AX,10h
		push	AX
		push	word ptr [BP-14h]
		mov	AX,2
		push	AX
		db	09Ah
		dw	X058_00
		dw	seg X058_00
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	word ptr ES:[BX+8],0Ah
		mov	AX,word ptr [BP-6]
		mov	word ptr ES:[BX+10h],AX
		mov	AX,DGROUP:M002_BCC_DATA_86F9
		sub	AX,word ptr ES:[BX+4]
		mov	word ptr ES:[BX+6],AX
		push	DI
		push	word ptr [BP-4]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-8],AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	word ptr ES:[DI+10h],AX
M002_L_419C:
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,4
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-0Ch],AX
		mov	AX,1Fh
		push	AX
		mov	AL,2
		push	AX
		push	word ptr [BP-0Ch]
		mov	AX,0Ah
		push	AX
		xor	AX,AX
		mov	DX,2
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	BX,word ptr [BP-8]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	word ptr ES:[BX+8],17h
		mov	word ptr ES:[BX+10h],DI
		mov	AX,DGROUP:M002_BCC_DATA_86F9
		sub	AX,word ptr ES:[BX+4]
		mov	word ptr ES:[BX+6],AX
		push	DI
		push	word ptr [BP-8]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		push	word ptr [BP-0Ah]
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		push	AX
		db	09Ah
		dw	X057_07
		dw	seg X057_07
		mov	word ptr [BP-4],AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	BX,word ptr [BP-4]
		mov	word ptr ES:[BX],4
		mov	AX,word ptr [BP+4]
		mov	word ptr ES:[BX+12h],AX
		push	DI
		push	word ptr [BP-4]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	AX,DGROUP:M002_BCC_DATA_86F9
		mov	word ptr ES:[BX+4],AX
		mov	AX,0AFh
		push	AX
		test	word ptr ES:[SI+1Ch],4
		je	short M002_L_4247
		mov	AX,word ptr [BP+6]
		shl	AX,1
		shl	AX,1
		jmp	short M002_L_424C
M002_L_4247:
		mov	AX,word ptr [BP+6]
		shl	AX,1
M002_L_424C:
		cwd
		push	DX
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	word ptr ES:[BX+6],1
		push	DI
		push	word ptr [BP-6]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		push	word ptr [BP-2]
		push	DI
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		push	SI
		push	word ptr [BP-2]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		push	word ptr ES:[SI+24h]
		db	09Ah
		dw	X057_13
		dw	seg X057_13
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8654
		mov	word ptr ES:[BX+8],0
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	6
BCC_NEAR_3F12	endp
CO05C_TEXT	ends


		extrn	X057_07:far
		extrn	X057_08:far
		extrn	X057_10:far
		extrn	X058_04:far
		extrn	X058_01:far


CO05C_TEXT	segment byte public 'CODE'
		assume	cs:CO05C_TEXT,ds:DGROUP

M003_BCC_DATA_5362	equ	5362h
M003_BCC_DATA_8654	equ	8654h
M003_BCC_DATA_8688	equ	8688h
M003_BCC_DATA_86F9	equ	86F9h

BCC_NEAR_429A	proc	near
M003_L_429A:
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,16h
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		mov	BX,word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+18h]
		mov	DX,word ptr ES:[BX+16h]
		mov	word ptr [BP-2],AX
		mov	word ptr [BP-4],DX
M003_L_42BB:
		cmp	word ptr [BP+8],3
		jle	short M003_L_42C4
		db	0E9h
		dw	0010Dh
M003_L_42C4:
		mov	word ptr [BP-0Ch],0
		db	0E9h
		dw	000D3h
M003_L_42CC:
		cmp	word ptr [BP-2],0
		je	short M003_L_432A
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-16h],AX
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	SI,AX
		mov	AX,81h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-2]
		mov	AX,0Ah
		push	AX
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8688
		mov	AX,word ptr ES:[DI+4]
		cwd
		push	DX
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	AX,DGROUP:M003_BCC_DATA_86F9
		sub	AX,word ptr ES:[SI+4]
		mov	word ptr ES:[SI+6],AX
		mov	word ptr ES:[SI+8],0Bh
		mov	AX,word ptr [BP-16h]
		mov	word ptr ES:[SI+10h],AX
		push	word ptr [BP+4]
		push	SI
		db	09Ah
		dw	X057_08
		dw	seg X057_08
M003_L_432A:
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	SI,AX
		mov	AX,81h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		mov	AX,0Ah
		push	AX
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8688
		push	word ptr ES:[DI+4]
		push	word ptr ES:[DI+2]
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	AX,DGROUP:M003_BCC_DATA_86F9
		sub	AX,word ptr ES:[SI+4]
		mov	word ptr ES:[SI+6],AX
		mov	word ptr ES:[SI+8],0Ah
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8688
		mov	AX,word ptr ES:[DI+6]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	word ptr ES:[SI+10h],AX
		push	word ptr [BP+4]
		push	SI
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		cmp	word ptr [BP-2],0
		je	short M003_L_4395
		push	word ptr [BP+4]
		push	word ptr [BP-16h]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
M003_L_4395:
		inc	word ptr [BP-0Ch]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8688
		mov	DI,word ptr ES:[DI]
M003_L_439F:
		mov	AX,word ptr [BP-0Ch]
		cmp	AX,word ptr [BP+8]
		jge	short M003_L_43AA
		db	0E9h
		dw	0FF22h
M003_L_43AA:
		mov	BX,word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		push	word ptr ES:[BX+10h]
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		push	AX
		db	09Ah
		dw	X057_07
		dw	seg X057_07
		mov	word ptr [BP-12h],AX
		push	word ptr [BP+4]
		push	word ptr [BP-12h]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		db	0E9h
		dw	001C8h
M003_L_43D1:
		mov	AX,word ptr [BP+8]
		shr	AX,1
		mov	word ptr [BP-0Ch],AX
		mov	word ptr [BP-6],DI
		mov	word ptr [BP-0Ah],1
		jmp	short M003_L_4402
M003_L_43E3:
		mov	AX,word ptr [BP-0Ah]
		dec	AX
		cmp	AX,word ptr [BP-0Ch]
		jne	short M003_L_43F2
		mov	AX,word ptr [BP-6]
		mov	word ptr [BP-8],AX
M003_L_43F2:
		inc	word ptr [BP-0Ah]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8688
		mov	BX,word ptr [BP-6]
		mov	AX,word ptr ES:[BX]
		mov	word ptr [BP-6],AX
M003_L_4402:
		mov	AX,word ptr [BP-0Ah]
		cmp	AX,word ptr [BP+8]
		jc	short M003_L_43E3
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8688
		mov	AX,word ptr ES:[BX+2]
		sub	AX,word ptr ES:[DI+2]
		mov	word ptr [BP-0Ah],AX
		mov	AX,word ptr [BP+8]
		mov	DX,3
		imul	DX
		cmp	AX,word ptr [BP-0Ah]
		jnc	short M003_L_442C
		db	0E9h
		dw	00097h
M003_L_442C:
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	SI,AX
		mov	AX,99h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-10h],AX
		cmp	word ptr [BP-2],0
		je	short M003_L_4465
		mov	AX,99h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-2]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-0Eh],AX
		jmp	short M003_L_446A
M003_L_4465:
		mov	word ptr [BP-0Eh],0
M003_L_446A:
		mov	BX,word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	AX,word ptr [BP-0Eh]
		mov	DX,word ptr [BP-10h]
		mov	word ptr ES:[BX+18h],AX
		mov	word ptr ES:[BX+16h],DX
		mov	AX,DGROUP:M003_BCC_DATA_86F9
		sub	AX,word ptr ES:[SI+4]
		mov	word ptr ES:[SI+6],AX
		push	word ptr [BP+4]
		push	SI
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		push	DI
		push	word ptr [BP-6]
		db	0E8h
		dw	00102h
		mov	SI,AX
		mov	BX,word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	AX,word ptr [BP-2]
		mov	DX,word ptr [BP-4]
		mov	word ptr ES:[BX+18h],AX
		mov	word ptr ES:[BX+16h],DX
		push	word ptr [BP+4]
		push	SI
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		db	0E9h
		dw	000D6h
M003_L_44C3:
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	SI,AX
		mov	AX,81h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-4]
		mov	AX,0Ah
		push	AX
		mov	BX,word ptr [BP-8]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8688
		push	word ptr ES:[BX+4]
		push	word ptr ES:[BX+2]
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	word ptr ES:[SI+8],0Ah
		mov	BX,word ptr [BP-8]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8688
		mov	AX,word ptr ES:[BX+6]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	word ptr ES:[SI+10h],AX
		mov	AX,DGROUP:M003_BCC_DATA_86F9
		sub	AX,word ptr ES:[SI+4]
		mov	word ptr ES:[SI+6],AX
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-14h],AX
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-16h],AX
		cmp	word ptr DGROUP:M003_BCC_DATA_5362,0
		je	short M003_L_4540
		mov	BX,word ptr [BP-14h]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	word ptr ES:[BX+8],5
		jmp	short M003_L_454D
M003_L_4540:
		mov	BX,word ptr [BP-14h]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	word ptr ES:[BX+8],3
M003_L_454D:
		mov	BX,word ptr [BP-14h]
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8654
		mov	AX,word ptr [BP-16h]
		mov	word ptr ES:[BX+10h],AX
		push	SI
		push	word ptr [BP-14h]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		push	word ptr [BP+4]
		push	SI
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		push	word ptr [BP+0Ah]
		push	word ptr [BP-0Ch]
		push	DI
		push	word ptr [BP+4]
		db	0E8h
		dw	0FD20h
		push	word ptr [BP+4]
		push	word ptr [BP-16h]
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		mov	AX,word ptr [BP-0Ch]
		inc	AX
		sub	word ptr [BP+8],AX
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8688
		mov	BX,word ptr [BP-8]
		mov	DI,word ptr ES:[BX]
		db	0E9h
		dw	0FD22h
M003_L_4599:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	8
BCC_NEAR_429A	endp
CO05C_TEXT	ends


		extrn	X057_08:far
		extrn	X057_10:far
		extrn	X058_04:far
		extrn	X058_01:far


CO05C_TEXT	segment byte public 'CODE'
		assume	cs:CO05C_TEXT,ds:DGROUP

M004_BCC_DATA_8654	equ	8654h
M004_BCC_DATA_8688	equ	8688h
M004_BCC_DATA_86F9	equ	86F9h

BCC_NEAR_45A2	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,0Ch
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-8],AX
		mov	BX,word ptr [BP+0Ah]
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+18h]
		mov	DX,word ptr ES:[BX+16h]
		mov	word ptr [BP-0Ah],AX
		mov	word ptr [BP-0Ch],DX
		test	word ptr ES:[BX+1Ch],4
		jne	short M004_L_45D6
		db	0E9h
		dw	000AAh
M004_L_45D6:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8688
		mov	AX,word ptr ES:[DI+2]
		or	AX,word ptr ES:[DI+4]
		je	short M004_L_4639
		mov	AX,0Ah
		push	AX
		mov	AX,word ptr ES:[DI+4]
		cwd
		push	DX
		push	AX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-2],AX
		mov	AX,0Ah
		push	AX
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8688
		push	word ptr ES:[DI+4]
		push	word ptr ES:[DI+2]
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-4],AX
		mov	AX,28h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ah]
		push	word ptr [BP-2]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-0Ah],AX
		mov	AX,30h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		push	word ptr [BP-4]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-0Ch],AX
M004_L_4639:
		mov	AX,word ptr [BP-0Ah]
		mov	word ptr [BP-2],AX
		mov	AX,4Dh
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-2]
		push	word ptr [BP-2]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	BX,word ptr [BP-8]
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8654
		mov	AX,DGROUP:M004_BCC_DATA_86F9
		sub	AX,word ptr ES:[BX+4]
		mov	word ptr ES:[BX+6],AX
		mov	word ptr ES:[BX+8],0Bh
		mov	BX,word ptr [BP+0Ah]
		mov	AX,word ptr ES:[BX+10h]
		mov	BX,word ptr [BP-8]
		mov	word ptr ES:[BX+10h],AX
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	SI,AX
		jmp	short M004_L_46BA
M004_L_4680:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8688
		mov	AX,word ptr ES:[DI+2]
		or	AX,word ptr ES:[DI+4]
		je	short M004_L_46B7
		mov	AX,0Ah
		push	AX
		push	word ptr ES:[DI+4]
		push	word ptr ES:[DI+2]
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-2],AX
		mov	AX,28h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		push	word ptr [BP-2]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-0Ch],AX
M004_L_46B7:
		mov	SI,word ptr [BP-8]
M004_L_46BA:
		mov	AX,0B6h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	AX,8
		push	AX
		mov	AL,0
		push	AX
		mov	AX,4
		push	AX
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	word ptr [BP-0Ch],AX
		mov	AX,0Ah
		push	AX
		mov	BX,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8688
		mov	AX,word ptr ES:[BX+4]
		mov	DX,word ptr ES:[BX+2]
		sub	DX,word ptr ES:[DI+2]
		sbb	AX,word ptr ES:[DI+4]
		push	AX
		push	DX
		db	09Ah
		dw	X058_04
		dw	seg X058_04
		mov	word ptr [BP-2],AX
		mov	AX,81h
		push	AX
		mov	AL,0
		push	AX
		push	word ptr [BP-0Ch]
		push	word ptr [BP-2]
		db	09Ah
		dw	X058_01
		dw	seg X058_01
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8654
		mov	word ptr ES:[SI+8],5
		mov	AX,DGROUP:M004_BCC_DATA_86F9
		sub	AX,word ptr ES:[SI+4]
		mov	word ptr ES:[SI+6],AX
		mov	BX,word ptr [BP+0Ah]
		mov	AX,word ptr ES:[BX+10h]
		mov	word ptr ES:[SI+10h],AX
		cmp	SI,word ptr [BP-8]
		je	short M004_L_4747
		push	word ptr [BP-8]
		push	SI
		db	09Ah
		dw	X057_08
		dw	seg X057_08
M004_L_4747:
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	SI,AX
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8654
		mov	word ptr ES:[SI],4
		mov	word ptr ES:[SI+12h],DI
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8688
		mov	BX,word ptr [BP+4]
		mov	word ptr ES:[BX],0
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8654
		mov	AX,DGROUP:M004_BCC_DATA_86F9
		sub	AX,word ptr ES:[SI+4]
		mov	word ptr ES:[SI+6],AX
		mov	word ptr ES:[SI+1Ch],2
		mov	word ptr ES:[SI+8],1
		mov	BX,word ptr [BP+0Ah]
		mov	AX,word ptr ES:[BX+10h]
		mov	word ptr ES:[SI+10h],AX
		push	word ptr [BP-8]
		push	SI
		db	09Ah
		dw	X057_08
		dw	seg X057_08
		db	09Ah
		dw	X057_10
		dw	seg X057_10
		mov	word ptr [BP-6],AX
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8654
		mov	BX,word ptr [BP-6]
		mov	word ptr ES:[BX],2
		mov	word ptr ES:[BX+12h],DI
		mov	AX,word ptr [BP+8]
		mov	word ptr ES:[BX+14h],AX
		mov	BX,word ptr [BP+0Ah]
		mov	AX,word ptr ES:[BX+10h]
		mov	BX,word ptr [BP-6]
		mov	word ptr ES:[BX+10h],AX
		push	word ptr [BP-6]
		db	0E8h
		dw	0F5F7h
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8654
		mov	AX,word ptr [BP-6]
		mov	word ptr ES:[SI+14h],AX
		mov	AX,word ptr [BP-8]
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	8
BCC_NEAR_45A2	endp
CO05C_TEXT	ends


		extrn	BCC_FAR_03E3:far


CO05C_TEXT	segment byte public 'CODE'
		assume	cs:CO05C_TEXT,ds:DGROUP

M005_BCC_OPTION_16F2	equ	16F2h
M005_BCC_DATA_8654	equ	8654h
M005_BCC_DATA_8688	equ	8688h
M005_BCC_DATA_87D4	equ	87D4h
M005_BCC_DATA_87E0	equ	87E0h
M005_BCC_DATA_8810	equ	8810h
M005_BCC_DATA_8814	equ	8814h

BCC_NEAR_47E0	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,8
		push	SI
		push	DI
		mov	BX,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+12h]
		mov	word ptr [BP-6],AX
		mov	AX,word ptr ES:[BX+14h]
		mov	word ptr [BP-8],AX
		cmp	byte ptr DGROUP:M005_BCC_OPTION_16F2,0
		je	short M005_L_480D
		mov	AX,2
		push	AX
		db	0FFh,01Eh
		dw	87D4h
M005_L_480D:
		push	word ptr [BP+4]
		db	0FFh,01Eh
		dw	8814h
		xor	DI,DI
		mov	SI,word ptr [BP-6]
		jmp	short M005_L_484F
M005_L_481B:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8688
		mov	AX,word ptr ES:[SI+4]
		mov	DX,word ptr ES:[SI+2]
		mov	word ptr [BP-2],AX
		mov	word ptr [BP-4],DX
		mov	AL,byte ptr [BP-4]
		push	AX
		db	0FFh,01Eh
		dw	87E0h
		mov	DX,word ptr [BP-2]
		mov	AX,word ptr [BP-4]
		mov	CL,8
		db	09Ah
		dw	BCC_FAR_03E3
		dw	seg BCC_FAR_03E3
		push	AX
		db	0FFh,01Eh
		dw	87E0h
		inc	DI
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8688
		mov	SI,word ptr ES:[SI]
M005_L_484F:
		cmp	DI,word ptr [BP-8]
		jl	short M005_L_481B
		mov	BX,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8654
		test	word ptr ES:[BX+1Ch],4
		je	short M005_L_48A3
		xor	DI,DI
		mov	SI,word ptr [BP-6]
		jmp	short M005_L_489E
M005_L_486A:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8688
		mov	AX,word ptr ES:[SI+4]
		mov	DX,word ptr ES:[SI+2]
		mov	word ptr [BP-2],AX
		mov	word ptr [BP-4],DX
		mov	AX,word ptr [BP-2]
		push	AX
		db	0FFh,01Eh
		dw	87E0h
		mov	DX,word ptr [BP-2]
		mov	AX,word ptr [BP-4]
		mov	CL,18h
		db	09Ah
		dw	BCC_FAR_03E3
		dw	seg BCC_FAR_03E3
		push	AX
		db	0FFh,01Eh
		dw	87E0h
		inc	DI
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8688
		mov	SI,word ptr ES:[SI]
M005_L_489E:
		cmp	DI,word ptr [BP-8]
		jl	short M005_L_486A
M005_L_48A3:
		xor	DI,DI
		mov	SI,word ptr [BP-6]
		jmp	short M005_L_48BE
M005_L_48AA:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8688
		push	word ptr ES:[SI+6]
		db	0FFh,01Eh
		dw	8810h
		inc	DI
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8688
		mov	SI,word ptr ES:[SI]
M005_L_48BE:
		cmp	DI,word ptr [BP-8]
		jl	short M005_L_48AA
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_47E0	endp
CO05C_TEXT	ends


CO05C_TEXT	segment byte public 'CODE'
		assume	cs:CO05C_TEXT,ds:DGROUP

M006_BCC_OPTION_16F2	equ	16F2h
M006_BCC_DATA_8654	equ	8654h
M006_BCC_DATA_8688	equ	8688h
M006_BCC_DATA_87D4	equ	87D4h
M006_BCC_DATA_8810	equ	8810h
M006_BCC_DATA_8814	equ	8814h


BCC_NEAR_48CC	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,0Ah
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8654
		mov	DI,word ptr ES:[SI+12h]
		mov	AX,word ptr ES:[SI+14h]
		mov	word ptr [BP-0Ah],AX
		cmp	byte ptr DGROUP:M006_BCC_OPTION_16F2,0
		je	short M006_L_48F6
		mov	AX,2
		push	AX
		db	0FFh,01Eh
		dw	87D4h
M006_L_48F6:
		push	SI
		db	0FFh,01Eh
		dw	8814h
		mov	word ptr [BP-6],0
		mov	word ptr [BP-8],0
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8688
		mov	AX,word ptr ES:[DI+4]
		mov	DX,word ptr ES:[DI+2]
		mov	word ptr [BP-2],AX
		mov	word ptr [BP-4],DX
		jmp	short M006_L_4968
M006_L_4919:
		add	word ptr [BP-4],1
		adc	word ptr [BP-2],0
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8654
		push	word ptr ES:[SI+10h]
		db	0FFh,01Eh
		dw	8810h
M006_L_492D:
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8688
		mov	AX,word ptr ES:[DI+4]
		mov	DX,word ptr ES:[DI+2]
		cmp	AX,word ptr [BP-2]
		jg	short M006_L_4919
		jne	short M006_L_4945
		cmp	DX,word ptr [BP-4]
		ja	short M006_L_4919
M006_L_4945:
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8688
		push	word ptr ES:[DI+6]
		db	0FFh,01Eh
		dw	8810h
		add	word ptr [BP-4],1
		adc	word ptr [BP-2],0
		add	word ptr [BP-8],1
		adc	word ptr [BP-6],0
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8688
		mov	DI,word ptr ES:[DI]
M006_L_4968:
		mov	AX,word ptr [BP-0Ah]
		cwd
		cmp	DX,word ptr [BP-6]
		jg	short M006_L_492D
		jne	short M006_L_4978
		cmp	AX,word ptr [BP-8]
		ja	short M006_L_492D
M006_L_4978:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_48CC	endp
CO05C_TEXT	ends




CO05C_TEXT	segment byte public 'CODE'
		assume	cs:CO05C_TEXT,ds:DGROUP

M007_BCC_DATA_8654	equ	8654h
M007_BCC_DATA_8B1A	equ	8B1Ah

		public	X05C_01
X05C_01	label	far
BCC_FAR_4981	proc	far
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr DGROUP:M007_BCC_DATA_8B1A
		jmp	short M007_L_49A7
M007_L_498B:
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8654
		cmp	word ptr ES:[SI],1
		jne	short M007_L_499B
		push	SI
		db	0E8h
		dw	0FE47h
		jmp	short M007_L_499F
M007_L_499B:
		push	SI
		db	0E8h
		dw	0FF2Dh
M007_L_499F:
		mov	ES,word ptr DGROUP:M007_BCC_DATA_8654
		mov	SI,word ptr ES:[SI+0Ch]
M007_L_49A7:
		or	SI,SI
		jne	short M007_L_498B
		pop	SI
		pop	BP
		retf
BCC_FAR_4981	endp
CO05C_TEXT	ends

; END C209UNIT
		end
