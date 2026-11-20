		public	X04B_00
		public	X04B_01
		public	X04B_02
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d10_982e
; BEGIN C122UNIT (listing ovr_1d10_982e:82E0)

		extrn	BCC_FAR_5B8B:far
		extrn	X031_09:far
		extrn	X046_03:far
		extrn	X046_01:far
		extrn	X046_09:far
		extrn	X04A_16:far
		extrn	X04A_0D:far
		extrn	X057_04:far
		extrn	X057_0B:far
		extrn	X057_0E:far


CO04B_TEXT	segment byte public 'CODE'
		assume	cs:CO04B_TEXT,ds:DGROUP

M000_BCC_DATA_5EDC	equ	5EDCh
M000_BCC_DATA_5EE1	equ	5EE1h
M000_BCC_DATA_6398	equ	6398h
M000_BCC_DATA_639E	equ	639Eh
M000_BCC_DATA_63A0	equ	63A0h
M000_BCC_DATA_66BE	equ	66BEh
M000_BCC_DATA_679C	equ	679Ch
M000_BCC_DATA_77D3	equ	77D3h
M000_BCC_DATA_77DD	equ	77DDh
M000_BCC_DATA_77EC	equ	77ECh
M000_BCC_TOKEN_SAVED	equ	77FDh
M000_BCC_DATA_782A	equ	782Ah
M000_BCC_STMT_TYPE_CURRENT	equ	8260h

		public	X04B_00
X04B_00	label	far
BCC_NEAR_82E0	label	near
BCC_FAR_82E0	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	DI,word ptr DGROUP:M000_BCC_DATA_679C
		xor	SI,SI
		mov	AX,DGROUP:M000_BCC_DATA_5EE1
		mov	word ptr [BP-2],AX
		cmp	byte ptr DGROUP:M000_BCC_TOKEN_SAVED,0
		je	short M000_L_8304
		mov	byte ptr DGROUP:M000_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M000_BCC_STMT_TYPE_CURRENT
		jmp	short M000_L_8309
M000_L_8304:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M000_L_8309:
		push	AX
		db	09Ah
		dw	X046_03
		dw	seg X046_03
		or	AX,AX
		je	short M000_L_838E
		cmp	word ptr [BP+8],0
		jne	short M000_L_8350
		push	word ptr DGROUP:M000_BCC_DATA_679C
		db	09Ah
		dw	X04A_0D
		dw	seg X04A_0D
		mov	DGROUP:M000_BCC_DATA_679C,AX
		mov	DGROUP:M000_BCC_DATA_6398,AX
		mov	DI,AX
		mov	word ptr [BP+8],1
		push	word ptr DGROUP:M000_BCC_DATA_679C
		push	word ptr DGROUP:M000_BCC_DATA_5EE1
		db	09Ah
		dw	X057_0E
		dw	seg X057_0E
		mov	SI,AX
		mov	word ptr DGROUP:M000_BCC_DATA_5EE1,SI
		push	word ptr DGROUP:M000_BCC_DATA_5EDC
		push	SI
		push	word ptr DGROUP:M000_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
M000_L_8350:
		db	09Ah
		dw	X046_01
		dw	seg X046_01
		cmp	word ptr DGROUP:M000_BCC_STMT_TYPE_CURRENT,7
		je	short M000_L_836E
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,1Fh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
M000_L_836E:
		cmp	byte ptr DGROUP:M000_BCC_TOKEN_SAVED,0
		je	short M000_L_837F
		mov	byte ptr DGROUP:M000_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M000_BCC_STMT_TYPE_CURRENT
		jmp	short M000_L_8384
M000_L_837F:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M000_L_8384:
		push	AX
		db	09Ah
		dw	X046_03
		dw	seg X046_03
		or	AX,AX
		jne	short M000_L_8350
M000_L_838E:
		mov	AX,DGROUP:M000_BCC_DATA_639E
		mov	DGROUP:M000_BCC_DATA_77DD,AX
		jmp	short M000_L_83C5
M000_L_8396:
		mov	byte ptr DGROUP:M000_BCC_TOKEN_SAVED,1
		push	SS
		lea	AX,[BP+6]
		push	AX
		db	0E8h
		dw	000D7h
		mov	word ptr DGROUP:M000_BCC_DATA_63A0,0
		mov	AX,DGROUP:M000_BCC_DATA_77DD
		mov	DGROUP:M000_BCC_DATA_639E,AX
		cmp	byte ptr DGROUP:M000_BCC_TOKEN_SAVED,0
		je	short M000_L_83C0
		mov	byte ptr DGROUP:M000_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M000_BCC_STMT_TYPE_CURRENT
		jmp	short M000_L_83C5
M000_L_83C0:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M000_L_83C5:
		cmp	word ptr DGROUP:M000_BCC_STMT_TYPE_CURRENT,6
		je	short M000_L_83D3
		cmp	word ptr DGROUP:M000_BCC_STMT_TYPE_CURRENT,0
		jne	short M000_L_8396
M000_L_83D3:
		mov	AX,DGROUP:M000_BCC_DATA_77D3
		mov	DGROUP:M000_BCC_DATA_66BE,AX
		cmp	word ptr DGROUP:M000_BCC_STMT_TYPE_CURRENT,6
		je	short M000_L_83EB
		mov	AX,1Dh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M000_L_83EB:
		cmp	word ptr [BP+8],0
		je	short M000_L_8423
		mov	ES,word ptr DGROUP:M000_BCC_DATA_782A
		mov	AX,word ptr ES:[DI+4]
		mov	DGROUP:M000_BCC_DATA_679C,AX
		mov	DGROUP:M000_BCC_DATA_6398,AX
		push	DI
		db	09Ah
		dw	X04A_16
		dw	seg X04A_16
		or	SI,SI
		je	short M000_L_841D
		push	word ptr DGROUP:M000_BCC_DATA_5EDC
		push	SI
		db	09Ah
		dw	X057_0B
		dw	seg X057_0B
		push	AX
		push	word ptr DGROUP:M000_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
M000_L_841D:
		mov	AX,word ptr [BP-2]
		mov	DGROUP:M000_BCC_DATA_5EE1,AX
M000_L_8423:
		mov	AX,word ptr [BP+6]
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
BCC_FAR_82E0	endp
CO04B_TEXT	ends


CO04B_TEXT	segment byte public 'CODE'
		assume	cs:CO04B_TEXT,ds:DGROUP

M001_BCC_DATA_1702	equ	1702h
M001_BCC_DATA_77EC	equ	77ECh


BCC_NEAR_842E	proc	near
		cmp	byte ptr DGROUP:M001_BCC_DATA_1702,0
		je	short M001_L_8448
		cmp	word ptr DGROUP:M001_BCC_DATA_77EC,1FFFh
		jg	short M001_L_8448
		mov	DX,3
		mov	AX,DGROUP:M001_BCC_DATA_77EC
		imul	DX
		mov	DGROUP:M001_BCC_DATA_77EC,AX
M001_L_8448:
		ret
BCC_NEAR_842E	endp
CO04B_TEXT	ends


CO04B_TEXT	segment byte public 'CODE'
		assume	cs:CO04B_TEXT,ds:DGROUP

M002_BCC_DATA_77EC	equ	77ECh


BCC_NEAR_8449	proc	near
		cmp	word ptr DGROUP:M002_BCC_DATA_77EC,1
		jle	short M002_L_845C
		mov	BX,3
		mov	AX,DGROUP:M002_BCC_DATA_77EC
		cwd
		idiv	BX
		mov	DGROUP:M002_BCC_DATA_77EC,AX
M002_L_845C:
		ret
BCC_NEAR_8449	endp
CO04B_TEXT	ends



		extrn	BCC_FAR_5BED:far


CO04B_TEXT	segment byte public 'CODE'
		assume	cs:CO04B_TEXT,ds:DGROUP

BCC_NEAR_845D	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		les	BX,[BP+4]
		cmp	word ptr ES:[BX],0
		jne	short M003_L_8475
		mov	AX,176h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
M003_L_8475:
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_845D	endp
CO04B_TEXT	ends


		extrn	BCC_FAR_5B8B:far
		extrn	BCC_FAR_5BED:far
		extrn	X019_04:far
		extrn	X031_09:far
		extrn	X034_02:far
		extrn	X03C_02:far
		extrn	X043_00:far
		extrn	X046_09:far
		extrn	X047_02:far
		extrn	X047_01:far
		extrn	X047_0C:far
		extrn	X049_02:far
		extrn	X049_03:far
		extrn	X04A_12:far
		extrn	X04A_0B:far
		extrn	X057_06:far
		extrn	X057_04:far
		extrn	X057_09:far
		extrn	X057_11:far
		extrn	X057_12:far
		extrn	X057_0C:far
		extrn	X057_0A:far
		extrn	X057_0F:far


CO04B_TEXT	segment byte public 'CODE'
		assume	cs:CO04B_TEXT,ds:DGROUP

M004_BCC_DATA_5EDC	equ	5EDCh
M004_BCC_DATA_5EDE	equ	5EDEh
M004_BCC_DATA_5EE0	equ	5EE0h
M004_BCC_DATA_5F4E	equ	5F4Eh
M004_BCC_EXPR_SEGMENT	equ	639Ah
M004_BCC_STMT_RECORD_SEG	equ	63C2h
M004_BCC_DATA_6458	equ	6458h
M004_BCC_DATA_66BE	equ	66BEh
M004_BCC_DATA_77D3	equ	77D3h
M004_BCC_DATA_77E2	equ	77E2h
M004_BCC_DATA_77EC	equ	77ECh
M004_BCC_DATA_77EE	equ	77EEh
M004_BCC_DATA_77F0	equ	77F0h
M004_BCC_DATA_77F2	equ	77F2h
M004_BCC_DATA_77F4	equ	77F4h
M004_BCC_DATA_77F6	equ	77F6h
M004_BCC_DATA_77F8	equ	77F8h
M004_BCC_DATA_77FA	equ	77FAh
M004_BCC_TOKEN_SAVED	equ	77FDh
M004_BCC_DATA_8186	equ	8186h
M004_BCC_STMT_TYPE_CURRENT	equ	8260h
M004_BCC_DATA_8263	equ	8263h
M004_BCC_DATA_8265	equ	8265h
M004_BCC_DATA_8269	equ	8269h
M004_BCC_DATA_826B	equ	826Bh
M004_BCC_DATA_8618	equ	8618h
M004_BCC_DATA_8688	equ	8688h

BCC_NEAR_847A	proc	near
M004_L_847A:
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,40h
		push	SI
		push	DI
M004_L_8483:
		db	09Ah
		dw	X034_02
		dw	seg X034_02
		mov	word ptr [BP-0Eh],0
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_849E
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_84A3
M004_L_849E:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_84A3:
		mov	AX,DGROUP:M004_BCC_DATA_77D3
		mov	DGROUP:M004_BCC_DATA_66BE,AX
		mov	AX,DGROUP:M004_BCC_DATA_8263
		mov	word ptr [BP-22h],AX
		mov	AX,DGROUP:M004_BCC_DATA_8265
		mov	word ptr [BP-24h],AX
		mov	AX,DGROUP:M004_BCC_DATA_77F6
		mov	word ptr [BP-12h],AX
		mov	AX,DGROUP:M004_BCC_DATA_77FA
		mov	word ptr [BP-1Ah],AX
		mov	AX,DGROUP:M004_BCC_DATA_77F8
		mov	word ptr [BP-16h],AX
		mov	BX,word ptr DGROUP:M004_BCC_STMT_TYPE_CURRENT
		cmp	BX,5Bh
		jne	short M004_L_84D3
		db	0E9h
		dw	0039Bh
M004_L_84D3:
		jg	short M004_L_8500
		cmp	BX,31h
		jne	short M004_L_84DD
		db	0E9h
		dw	00FD4h
M004_L_84DD:
		jg	short M004_L_84EE
		cmp	BX,7
		jbe	short M004_L_84E7
		db	0E9h
		dw	0109Bh
M004_L_84E7:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	1333h
M004_L_84EE:
		sub	BX,57h
		cmp	BX,3
		jbe	short M004_L_84F9
		db	0E9h
		dw	01089h
M004_L_84F9:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	132Bh
M004_L_8500:
		sub	BX,5Ch
		cmp	BX,7
		jbe	short M004_L_850B
		db	0E9h
		dw	01077h
M004_L_850B:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	131Bh
		les	BX,[BP+4]
		mov	word ptr ES:[BX],1
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_852B
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_8530
M004_L_852B:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_8530:
		mov	AX,3
		push	AX
		db	09Ah
		dw	X047_02
		dw	seg X047_02
		or	AX,AX
		jne	short M004_L_8540
		db	0E9h
		dw	010B2h
M004_L_8540:
		mov	AX,DGROUP:M004_BCC_DATA_77F2
		or	AX,word ptr DGROUP:M004_BCC_DATA_77F4
		jne	short M004_L_8557
		mov	AX,0F5h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	0FF2Ch
M004_L_8557:
		mov	word ptr [BP-10h],0
		mov	DI,word ptr DGROUP:M004_BCC_DATA_77F6
		jmp	short M004_L_85AF
M004_L_8562:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8688
		mov	AX,word ptr ES:[DI+4]
		mov	DX,word ptr ES:[DI+2]
		cmp	AX,word ptr DGROUP:M004_BCC_DATA_826B
		jne	short M004_L_8587
		cmp	DX,word ptr DGROUP:M004_BCC_DATA_8269
		jne	short M004_L_8587
		mov	AX,0ABh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		jmp	short M004_L_85B3
M004_L_8587:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8688
		mov	AX,word ptr ES:[DI+4]
		mov	DX,word ptr ES:[DI+2]
		cmp	AX,word ptr DGROUP:M004_BCC_DATA_826B
		jl	short M004_L_85A5
		jg	short M004_L_85A1
		cmp	DX,word ptr DGROUP:M004_BCC_DATA_8269
		jbe	short M004_L_85A5
M004_L_85A1:
		xor	DI,DI
		jmp	short M004_L_85B3
M004_L_85A5:
		mov	word ptr [BP-10h],DI
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8688
		mov	DI,word ptr ES:[DI]
M004_L_85AF:
		or	DI,DI
		jne	short M004_L_8562
M004_L_85B3:
		or	DI,DI
		je	short M004_L_85BA
		db	0E9h
		dw	0FEC9h
M004_L_85BA:
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-4],AX
		push	DS
		mov	AX,8688h
		push	AX
		mov	AX,8
		push	AX
		db	09Ah
		dw	X043_00
		dw	seg X043_00
		mov	DI,AX
		cmp	word ptr [BP-10h],0
		jne	short M004_L_85E8
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8688
		mov	AX,DGROUP:M004_BCC_DATA_77F6
		mov	word ptr ES:[DI],AX
		mov	word ptr DGROUP:M004_BCC_DATA_77F6,DI
		jmp	short M004_L_85F8
M004_L_85E8:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8688
		mov	BX,word ptr [BP-10h]
		mov	AX,word ptr ES:[BX]
		mov	word ptr ES:[DI],AX
		mov	word ptr ES:[BX],DI
M004_L_85F8:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8688
		mov	AX,word ptr [BP-4]
		mov	word ptr ES:[DI+6],AX
		mov	AX,DGROUP:M004_BCC_DATA_826B
		mov	DX,word ptr DGROUP:M004_BCC_DATA_8269
		mov	word ptr ES:[DI+4],AX
		mov	word ptr ES:[DI+2],DX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-4]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		db	0E9h
		dw	0FE5Eh
		les	BX,[BP+4]
		mov	word ptr ES:[BX],1
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
M004_L_8632:
		je	short M004_L_863E
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_8643
M004_L_863E:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_8643:
		cmp	AX,21h
		je	short M004_L_865B
		mov	AX,17h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,1
		db	0E9h
		dw	0FE28h
M004_L_865B:
		mov	AX,DGROUP:M004_BCC_DATA_77F2
		or	AX,word ptr DGROUP:M004_BCC_DATA_77F4
		jne	short M004_L_8672
		mov	AX,42h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	0FE11h
M004_L_8672:
		cmp	word ptr DGROUP:M004_BCC_DATA_77F8,0
		je	short M004_L_8687
		mov	AX,0A8h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	0FDFCh
M004_L_8687:
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	DGROUP:M004_BCC_DATA_77F8,AX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr DGROUP:M004_BCC_DATA_77F8
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		db	0E9h
		dw	0FDE0h
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,1
		mov	AX,0EAh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	00F3Ch
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0FD9Eh
		db	09Ah
		dw	X03C_02
		dw	seg X03C_02
		db	0E9h
		dw	00F2Bh
		mov	AX,7Fh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		db	0E9h
		dw	0FDAEh
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0FD7Fh
		mov	word ptr [BP-1Ch],DS
		mov	word ptr [BP-1Eh],361Dh
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_86F7
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_86FC
M004_L_86F7:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_86FC:
		cmp	AX,1
		je	short M004_L_8716
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Eh]
		mov	AX,3Eh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	00EDCh
M004_L_8716:
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_8727
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_872C
M004_L_8727:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_872C:
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-4],AX
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X047_01
		dw	seg X047_01
		mov	SI,AX
		or	SI,SI
		jne	short M004_L_8746
		db	0E9h
		dw	00EACh
M004_L_8746:
		push	SI
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	SI,AX
		push	SI
		nop
		push	CS
		db	0E8h
		dw	01158h
		push	SI
		push	word ptr [BP-4]
		push	word ptr [BP-22h]
		push	word ptr [BP-24h]
		push	word ptr DGROUP:M004_BCC_DATA_8263
		push	word ptr DGROUP:M004_BCC_DATA_8265
		db	0E8h
		dw	00F22h
		mov	word ptr [BP-2Eh],AX
		cmp	word ptr [BP-2Eh],0
		jl	short M004_L_8777
		mov	AX,1
		jmp	short M004_L_8779
M004_L_8777:
		xor	AX,AX
M004_L_8779:
		les	BX,[BP+4]
		mov	word ptr ES:[BX],AX
		cmp	word ptr DGROUP:M004_BCC_STMT_TYPE_CURRENT,2
		je	short M004_L_879B
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Eh]
		mov	AX,3Fh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	00E57h
M004_L_879B:
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0FCD6h
		mov	AX,DGROUP:M004_BCC_DATA_8263
		mov	word ptr [BP-22h],AX
		mov	AX,DGROUP:M004_BCC_DATA_8265
		mov	word ptr [BP-24h],AX
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_87C1
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_87C6
M004_L_87C1:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_87C6:
		cmp	AX,5Ah
		jne	short M004_L_8848
		les	BX,[BP+4]
		mov	AX,word ptr ES:[BX]
		mov	word ptr [BP-30h],AX
		cmp	word ptr [BP-2Eh],0
		jle	short M004_L_87E1
		mov	word ptr ES:[BX],0
		jmp	short M004_L_87E9
M004_L_87E1:
		les	BX,[BP+4]
		mov	word ptr ES:[BX],1
M004_L_87E9:
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-6],AX
		push	word ptr [BP-6]
		push	word ptr [BP-22h]
		push	word ptr [BP-24h]
		xor	AX,AX
		push	AX
		push	AX
		db	0E8h
		dw	00F77h
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-4]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0FC60h
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-6]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		cmp	word ptr [BP-2Eh],0
		jle	short M004_L_883C
		les	BX,[BP+4]
		mov	AX,word ptr [BP-30h]
		mov	word ptr ES:[BX],AX
		db	0E9h
		dw	00DB6h
M004_L_883C:
		les	BX,[BP+4]
		mov	AX,word ptr [BP-30h]
		or	word ptr ES:[BX],AX
		db	0E9h
		dw	00DAAh
M004_L_8848:
		cmp	word ptr [BP-2Eh],0
		jg	short M004_L_8856
		les	BX,[BP+4]
		mov	word ptr ES:[BX],1
M004_L_8856:
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,1
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-4]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		db	0E9h
		dw	00D84h
M004_L_886E:
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0FBE6h
		mov	word ptr [BP-1Ch],DS
		mov	word ptr [BP-1Eh],3620h
		mov	AX,DGROUP:M004_BCC_DATA_77F0
		mov	DX,word ptr DGROUP:M004_BCC_DATA_77EE
		mov	word ptr [BP-3Eh],AX
		mov	word ptr [BP-40h],DX
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-38h],AX
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-36h],AX
		mov	byte ptr [BP-34h],5Bh
		mov	byte ptr [BP-33h],0
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-6],AX
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_88BD
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_88C2
M004_L_88BD:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_88C2:
		cmp	AX,1
		je	short M004_L_88DC
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Eh]
		mov	AX,3Eh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	00D16h
M004_L_88DC:
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_88ED
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_88F2
M004_L_88ED:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_88F2:
		cmp	AX,7
		je	short M004_L_8966
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X047_01
		dw	seg X047_01
		mov	SI,AX
		or	SI,SI
		jne	short M004_L_8909
		db	0E9h
		dw	00CE9h
M004_L_8909:
		push	SI
		nop
		push	CS
		db	0E8h
		dw	00E94h
		push	SI
		db	09Ah
		dw	X049_03
		dw	seg X049_03
		mov	SI,AX
		push	SI
		push	word ptr [BP-22h]
		push	word ptr [BP-24h]
		push	word ptr DGROUP:M004_BCC_DATA_8263
		push	word ptr DGROUP:M004_BCC_DATA_8265
		db	09Ah
		dw	X057_0F
		dw	seg X057_0F
		mov	word ptr [BP-4],AX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-4]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		mov	AX,DGROUP:M004_BCC_DATA_8263
		mov	word ptr [BP-22h],AX
		mov	AX,DGROUP:M004_BCC_DATA_8265
		mov	word ptr [BP-24h],AX
		cmp	word ptr DGROUP:M004_BCC_STMT_TYPE_CURRENT,7
		je	short M004_L_896B
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Eh]
		mov	AX,40h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	00C8Ch
M004_L_8966:
		mov	word ptr [BP-22h],0
M004_L_896B:
		db	0E8h
		dw	0FAC0h
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_897F
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_8984
M004_L_897F:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_8984:
		cmp	AX,7
		jne	short M004_L_898C
		db	0E9h
		dw	000A8h
M004_L_898C:
		mov	AX,DGROUP:M004_BCC_DATA_8263
		mov	word ptr [BP-26h],AX
		mov	AX,DGROUP:M004_BCC_DATA_8265
		mov	word ptr [BP-28h],AX
		mov	AX,word ptr [BP-24h]
		cmp	AX,word ptr [BP-28h]
		jne	short M004_L_89AD
		mov	AX,word ptr [BP-22h]
		cmp	AX,word ptr [BP-26h]
		jne	short M004_L_89AD
		mov	word ptr [BP-26h],0
M004_L_89AD:
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X047_01
		dw	seg X047_01
		mov	SI,AX
		or	SI,SI
		jne	short M004_L_89BF
		db	0E9h
		dw	00C33h
M004_L_89BF:
		cmp	word ptr DGROUP:M004_BCC_STMT_TYPE_CURRENT,7
		je	short M004_L_89DB
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Eh]
		mov	AX,40h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	00C17h
M004_L_89DB:
		cmp	word ptr [BP-26h],0
		je	short M004_L_89EF
		mov	AX,DGROUP:M004_BCC_DATA_8263
		mov	word ptr [BP-2Ah],AX
		mov	AX,DGROUP:M004_BCC_DATA_8265
		mov	word ptr [BP-2Ch],AX
		jmp	short M004_L_89F4
M004_L_89EF:
		mov	word ptr [BP-2Ah],0
M004_L_89F4:
		push	SI
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	SI,AX
		push	SI
		db	0E8h
		dw	00C23h
		mov	word ptr [BP-2],AX
		push	SI
		nop
		push	CS
		db	0E8h
		dw	00EA3h
		cmp	word ptr [BP-2],0
		jne	short M004_L_8A2D
		mov	AX,1
		push	AX
		push	SI
		push	word ptr [BP-6]
		push	word ptr [BP-26h]
		push	word ptr [BP-28h]
		push	word ptr [BP-2Ah]
		push	word ptr [BP-2Ch]
		db	09Ah
		dw	X057_09
		dw	seg X057_09
		mov	word ptr [BP-8],AX
		jmp	short M004_L_8A3E
M004_L_8A2D:
		mov	word ptr [BP-8],0
		jmp	short M004_L_8A3E
M004_L_8A34:
		mov	word ptr [BP-2],1
		mov	word ptr [BP-8],0
M004_L_8A3E:
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_8A4F
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_8A54
M004_L_8A4F:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_8A54:
		cmp	AX,2
		jne	short M004_L_8A5C
		db	0E9h
		dw	00096h
M004_L_8A5C:
		mov	AX,word ptr [BP-24h]
		cmp	AX,word ptr DGROUP:M004_BCC_DATA_8265
		jne	short M004_L_8A6E
		mov	AX,word ptr [BP-22h]
		cmp	AX,word ptr DGROUP:M004_BCC_DATA_8263
		je	short M004_L_8A7C
M004_L_8A6E:
		mov	AX,DGROUP:M004_BCC_DATA_8263
		mov	word ptr [BP-22h],AX
		mov	AX,DGROUP:M004_BCC_DATA_8265
		mov	word ptr [BP-24h],AX
		jmp	short M004_L_8A81
M004_L_8A7C:
		mov	word ptr [BP-22h],0
M004_L_8A81:
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X047_01
		dw	seg X047_01
		mov	word ptr [BP-0Ch],AX
		cmp	word ptr [BP-0Ch],0
		jne	short M004_L_8A96
		db	0E9h
		dw	00B5Ch
M004_L_8A96:
		cmp	word ptr DGROUP:M004_BCC_STMT_TYPE_CURRENT,2
		je	short M004_L_8AB2
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Eh]
		mov	AX,3Fh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	00B40h
M004_L_8AB2:
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	word ptr [BP-0Ch],AX
		mov	AL,DGROUP:M004_BCC_DATA_6458
		cbw
		mov	word ptr [BP-32h],AX
		mov	byte ptr DGROUP:M004_BCC_DATA_6458,0
		push	word ptr [BP-0Ch]
		nop
		push	CS
		db	0E8h
		dw	00CD2h
		mov	AL,byte ptr [BP-32h]
		mov	DGROUP:M004_BCC_DATA_6458,AL
		push	word ptr [BP-0Ch]
		push	word ptr [BP-22h]
		push	word ptr [BP-24h]
		push	word ptr DGROUP:M004_BCC_DATA_8263
		push	word ptr DGROUP:M004_BCC_DATA_8265
		db	09Ah
		dw	X057_0F
		dw	seg X057_0F
		mov	word ptr [BP-0Ah],AX
		jmp	short M004_L_8AF7
M004_L_8AF2:
		mov	word ptr [BP-0Ah],0
M004_L_8AF7:
		lea	AX,[BP-40h]
		mov	word ptr DGROUP:M004_BCC_DATA_77F0,SS
		mov	DGROUP:M004_BCC_DATA_77EE,AX
		cmp	word ptr [BP-2],0
		jge	short M004_L_8B11
		les	BX,[BP+4]
		mov	word ptr ES:[BX],0
		jmp	short M004_L_8B3B
M004_L_8B11:
		cmp	word ptr [BP-2],0
		jne	short M004_L_8B2B
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-4],AX
		push	word ptr [BP-4]
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		push	AX
		db	0E8h
		dw	00C4Dh
M004_L_8B2B:
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-6]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
M004_L_8B3B:
		mov	word ptr DGROUP:M004_BCC_DATA_77FA,0
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0F930h
		cmp	word ptr [BP-2],0
		jl	short M004_L_8B71
		mov	AX,word ptr [BP-12h]
		cmp	AX,word ptr DGROUP:M004_BCC_DATA_77F6
		jne	short M004_L_8B71
		cmp	word ptr DGROUP:M004_BCC_DATA_77FA,0
		jne	short M004_L_8B71
		mov	AX,word ptr [BP-16h]
		cmp	AX,word ptr DGROUP:M004_BCC_DATA_77F8
		jne	short M004_L_8B71
		push	word ptr [BP-6]
		db	09Ah
		dw	X057_11
		dw	seg X057_11
M004_L_8B71:
		mov	AX,word ptr [BP-1Ah]
		or	word ptr DGROUP:M004_BCC_DATA_77FA,AX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-36h]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		cmp	word ptr [BP-0Ah],0
		je	short M004_L_8B9E
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-0Ah]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
M004_L_8B9E:
		cmp	word ptr [BP-2],0
		jne	short M004_L_8BC6
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-4]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-8]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		jmp	short M004_L_8BDA
M004_L_8BC6:
		cmp	word ptr [BP-2],0
		jle	short M004_L_8BDA
		push	word ptr [BP-6]
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		push	AX
		db	0E8h
		dw	00BA0h
		jmp	short M004_L_8BDE
M004_L_8BDA:
		mov	byte ptr [BP-33h],1
M004_L_8BDE:
		db	0E8h
		dw	0F868h
		mov	AL,byte ptr [BP-33h]
		cbw
		les	BX,[BP+4]
		mov	word ptr ES:[BX],AX
		mov	AX,word ptr [BP-3Eh]
		mov	DX,word ptr [BP-40h]
		mov	DGROUP:M004_BCC_DATA_77F0,AX
		mov	word ptr DGROUP:M004_BCC_DATA_77EE,DX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-38h]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		db	0E9h
		dw	009E7h
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0F849h
		mov	word ptr [BP-1Ch],DS
		mov	word ptr [BP-1Eh],3624h
		mov	AX,DGROUP:M004_BCC_DATA_77F0
		mov	DX,word ptr DGROUP:M004_BCC_DATA_77EE
		mov	word ptr [BP-3Eh],AX
		mov	word ptr [BP-40h],DX
		mov	byte ptr [BP-34h],5Dh
		lea	AX,[BP-40h]
		mov	word ptr DGROUP:M004_BCC_DATA_77F0,SS
		mov	DGROUP:M004_BCC_DATA_77EE,AX
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-36h],AX
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-38h],AX
		mov	byte ptr [BP-33h],0
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-4],AX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-4]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		db	0E8h
		dw	0F7C8h
		les	BX,[BP+4]
		mov	word ptr ES:[BX],1
		mov	word ptr DGROUP:M004_BCC_DATA_77FA,0
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0F7FDh
		mov	AX,word ptr [BP-12h]
		cmp	AX,word ptr DGROUP:M004_BCC_DATA_77F6
		jne	short M004_L_8C9E
		cmp	word ptr DGROUP:M004_BCC_DATA_77FA,0
		jne	short M004_L_8C9E
		mov	AX,word ptr [BP-16h]
		cmp	AX,word ptr DGROUP:M004_BCC_DATA_77F8
		jne	short M004_L_8C9E
		push	word ptr [BP-4]
		db	09Ah
		dw	X057_11
		dw	seg X057_11
M004_L_8C9E:
		mov	AX,word ptr [BP-1Ah]
		or	word ptr DGROUP:M004_BCC_DATA_77FA,AX
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_8CB6
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_8CBB
M004_L_8CB6:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_8CBB:
		cmp	AX,5Ch
		je	short M004_L_8CD5
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,0FBh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	0091Dh
M004_L_8CD5:
		mov	AX,DGROUP:M004_BCC_DATA_8263
		mov	word ptr [BP-22h],AX
		mov	AX,DGROUP:M004_BCC_DATA_8265
		mov	word ptr [BP-24h],AX
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_8CF2
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_8CF7
M004_L_8CF2:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_8CF7:
		cmp	AX,1
		je	short M004_L_8D11
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Eh]
		mov	AX,3Eh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	008E1h
M004_L_8D11:
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_8D22
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_8D27
M004_L_8D22:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_8D27:
		mov	AX,word ptr [BP-3Eh]
		mov	DX,word ptr [BP-40h]
		mov	DGROUP:M004_BCC_DATA_77F0,AX
		mov	word ptr DGROUP:M004_BCC_DATA_77EE,DX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-36h]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X047_01
		dw	seg X047_01
		mov	SI,AX
		or	SI,SI
		jne	short M004_L_8D56
		db	0E9h
		dw	0089Ch
M004_L_8D56:
		push	SI
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	SI,AX
		push	SI
		nop
		push	CS
		db	0E8h
		dw	00B48h
		push	SI
		push	word ptr [BP-4]
		push	word ptr [BP-22h]
		push	word ptr [BP-24h]
		push	word ptr DGROUP:M004_BCC_DATA_8263
		push	word ptr DGROUP:M004_BCC_DATA_8265
		db	0E8h
		dw	0098Bh
		or	AX,AX
		jg	short M004_L_8D81
		mov	byte ptr [BP-33h],1
M004_L_8D81:
		db	0E8h
		dw	0F6C5h
		mov	AL,byte ptr [BP-33h]
		cbw
		les	BX,[BP+4]
		mov	word ptr ES:[BX],AX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-38h]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		cmp	word ptr DGROUP:M004_BCC_STMT_TYPE_CURRENT,2
		je	short M004_L_8DBA
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Eh]
		mov	AX,3Fh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	00838h
M004_L_8DBA:
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_8DCB
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_8DD0
M004_L_8DCB:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_8DD0:
		cmp	AX,7
		jne	short M004_L_8DD8
		db	0E9h
		dw	0081Ah
M004_L_8DD8:
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Eh]
		mov	AX,40h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	00805h
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0F667h
		mov	word ptr [BP-1Ch],DS
		mov	word ptr [BP-1Eh],362Dh
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
M004_L_8E03:
		je	short M004_L_8E0F
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_8E14
M004_L_8E0F:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_8E14:
		cmp	AX,1
		je	short M004_L_8E2E
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Eh]
		mov	AX,3Eh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	007C4h
M004_L_8E2E:
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_8E3F
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_8E44
M004_L_8E3F:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_8E44:
		mov	AX,DGROUP:M004_BCC_DATA_77F0
		mov	DX,word ptr DGROUP:M004_BCC_DATA_77EE
		mov	word ptr [BP-3Eh],AX
		mov	word ptr [BP-40h],DX
		mov	byte ptr [BP-34h],5Ch
		lea	AX,[BP-40h]
		mov	word ptr DGROUP:M004_BCC_DATA_77F0,SS
		mov	DGROUP:M004_BCC_DATA_77EE,AX
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-36h],AX
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-38h],AX
		mov	byte ptr [BP-33h],0
		les	BX,[BP+4]
		mov	word ptr ES:[BX],1
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X047_01
		dw	seg X047_01
		mov	SI,AX
		or	SI,SI
		jne	short M004_L_8E8D
		db	0E9h
		dw	00765h
M004_L_8E8D:
		cmp	word ptr DGROUP:M004_BCC_STMT_TYPE_CURRENT,2
		je	short M004_L_8EA9
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Eh]
		mov	AX,3Fh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	00749h
M004_L_8EA9:
		db	0E8h
		dw	0F582h
		push	SI
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	SI,AX
		push	SI
		db	0E8h
		dw	0076Bh
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		jg	short M004_L_8ECD
		push	word ptr [BP-36h]
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		push	AX
		db	0E8h
		dw	008ABh
M004_L_8ECD:
		cmp	word ptr [BP-2],0
		jl	short M004_L_8EEB
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-4],AX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-4]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
M004_L_8EEB:
		push	SI
		nop
		push	CS
		db	0E8h
		dw	009BBh
		cmp	word ptr [BP-2],0
		jne	short M004_L_8F17
		mov	AX,1
		push	AX
		push	SI
		push	word ptr [BP-4]
		push	word ptr [BP-22h]
		push	word ptr [BP-24h]
		push	word ptr DGROUP:M004_BCC_DATA_8263
		push	word ptr DGROUP:M004_BCC_DATA_8265
		db	09Ah
		dw	X057_09
		dw	seg X057_09
		mov	word ptr [BP-8],AX
		jmp	short M004_L_8F1C
M004_L_8F17:
		mov	word ptr [BP-8],0
M004_L_8F1C:
		cmp	word ptr [BP-2],0
		jge	short M004_L_8F2E
		les	BX,[BP+4]
		mov	word ptr ES:[BX],0
		mov	byte ptr [BP-33h],1
M004_L_8F2E:
		mov	word ptr DGROUP:M004_BCC_DATA_77FA,0
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0F53Dh
		mov	AX,word ptr [BP-12h]
		cmp	AX,word ptr DGROUP:M004_BCC_DATA_77F6
		jne	short M004_L_8F5E
		cmp	word ptr DGROUP:M004_BCC_DATA_77FA,0
		jne	short M004_L_8F5E
		mov	AX,word ptr [BP-16h]
		cmp	AX,word ptr DGROUP:M004_BCC_DATA_77F8
		jne	short M004_L_8F5E
		push	word ptr [BP-36h]
		db	09Ah
		dw	X057_11
		dw	seg X057_11
M004_L_8F5E:
		mov	AX,word ptr [BP-1Ah]
		or	word ptr DGROUP:M004_BCC_DATA_77FA,AX
		db	0E8h
		dw	0F4E1h
		mov	AX,word ptr [BP-3Eh]
		mov	DX,word ptr [BP-40h]
		mov	DGROUP:M004_BCC_DATA_77F0,AX
		mov	word ptr DGROUP:M004_BCC_DATA_77EE,DX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-36h]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		cmp	word ptr [BP-2],0
		jne	short M004_L_8FA1
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-8]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		mov	byte ptr [BP-33h],1
		jmp	short M004_L_8FB3
M004_L_8FA1:
		cmp	word ptr [BP-2],0
		jle	short M004_L_8FB3
		push	word ptr [BP-4]
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		push	AX
		db	0E8h
		dw	007C5h
M004_L_8FB3:
		mov	AL,byte ptr [BP-33h]
		cbw
		les	BX,[BP+4]
		mov	word ptr ES:[BX],AX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-38h]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		db	0E9h
		dw	00622h
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0F484h
		mov	word ptr [BP-1Ch],DS
		mov	word ptr [BP-1Eh],3633h
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_8FF2
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_8FF7
M004_L_8FF2:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_8FF7:
		cmp	AX,1
		je	short M004_L_9011
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Eh]
		mov	AX,3Eh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	005E1h
M004_L_9011:
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_9022
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_9027
M004_L_9022:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_9027:
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X047_01
		dw	seg X047_01
		mov	SI,AX
		or	SI,SI
		jne	short M004_L_9039
		db	0E9h
		dw	005B9h
M004_L_9039:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],7
		je	short M004_L_905E
		cmp	word ptr ES:[SI+2],8
		je	short M004_L_905E
		cmp	word ptr ES:[SI+2],6
		je	short M004_L_905E
		push	SI
		push	word ptr DGROUP:M004_BCC_DATA_77E2
		db	09Ah
		dw	X047_0C
		dw	seg X047_0C
		mov	SI,AX
M004_L_905E:
		mov	AX,DGROUP:M004_BCC_DATA_77F6
		mov	word ptr [BP-14h],AX
		mov	AX,DGROUP:M004_BCC_DATA_77F8
		mov	word ptr [BP-18h],AX
		mov	word ptr DGROUP:M004_BCC_DATA_77F8,0
		mov	word ptr DGROUP:M004_BCC_DATA_77F6,0
		push	SI
		nop
		push	CS
		db	0E8h
		dw	00830h
		push	SI
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	SI,AX
		push	SI
		push	word ptr [BP-22h]
		push	word ptr [BP-24h]
		push	word ptr DGROUP:M004_BCC_DATA_8263
		push	word ptr DGROUP:M004_BCC_DATA_8265
		db	09Ah
		dw	X057_0A
		dw	seg X057_0A
		mov	word ptr [BP-4],AX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-4]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		cmp	word ptr DGROUP:M004_BCC_STMT_TYPE_CURRENT,2
		je	short M004_L_90C7
		push	word ptr [BP-1Ch]
		push	word ptr [BP-1Eh]
		mov	AX,3Fh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	0052Bh
M004_L_90C7:
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	word ptr [BP-38h],AX
		mov	AX,DGROUP:M004_BCC_DATA_77EE
		or	AX,word ptr DGROUP:M004_BCC_DATA_77F0
		je	short M004_L_90E5
		les	BX,DGROUP:M004_BCC_DATA_77EE
		mov	AX,word ptr ES:[BX+0Ah]
		mov	word ptr [BP-36h],AX
		jmp	short M004_L_90EA
M004_L_90E5:
		mov	word ptr [BP-36h],0
M004_L_90EA:
		mov	AX,DGROUP:M004_BCC_DATA_77F0
		mov	DX,word ptr DGROUP:M004_BCC_DATA_77EE
		mov	word ptr [BP-3Eh],AX
		mov	word ptr [BP-40h],DX
		mov	AX,DGROUP:M004_BCC_DATA_77F4
		mov	DX,word ptr DGROUP:M004_BCC_DATA_77F2
		mov	word ptr [BP-3Ah],AX
		mov	word ptr [BP-3Ch],DX
		mov	byte ptr [BP-34h],5Eh
		mov	byte ptr [BP-33h],0
		lea	AX,[BP-40h]
		mov	word ptr DGROUP:M004_BCC_DATA_77F0,SS
		mov	DGROUP:M004_BCC_DATA_77EE,AX
		lea	AX,[BP-40h]
		mov	word ptr DGROUP:M004_BCC_DATA_77F4,SS
		mov	DGROUP:M004_BCC_DATA_77F2,AX
		les	BX,[BP+4]
		mov	word ptr ES:[BX],0
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0F349h
		cmp	word ptr DGROUP:M004_BCC_DATA_77F8,0
		jne	short M004_L_9153
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	DGROUP:M004_BCC_DATA_77F8,AX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr DGROUP:M004_BCC_DATA_77F8
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		jmp	short M004_L_9159
M004_L_9153:
		cmp	byte ptr [BP-33h],0
		je	short M004_L_9161
M004_L_9159:
		les	BX,[BP+4]
		mov	word ptr ES:[BX],1
M004_L_9161:
		push	word ptr [BP-4]
		push	word ptr DGROUP:M004_BCC_DATA_77F8
		push	word ptr DGROUP:M004_BCC_DATA_77F6
		db	09Ah
		dw	X057_0C
		dw	seg X057_0C
		mov	AX,word ptr [BP-14h]
		mov	DGROUP:M004_BCC_DATA_77F6,AX
		mov	AX,word ptr [BP-18h]
		mov	DGROUP:M004_BCC_DATA_77F8,AX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-38h]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		mov	AX,word ptr [BP-3Eh]
		mov	DX,word ptr [BP-40h]
		mov	DGROUP:M004_BCC_DATA_77F0,AX
		mov	word ptr DGROUP:M004_BCC_DATA_77EE,DX
		mov	AX,word ptr [BP-3Ah]
		mov	DX,word ptr [BP-3Ch]
		mov	DGROUP:M004_BCC_DATA_77F4,AX
		mov	word ptr DGROUP:M004_BCC_DATA_77F2,DX
		db	0E9h
		dw	00448h
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0F2AAh
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_91C4
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_91C9
M004_L_91C4:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_91C9:
		cmp	AX,7
		je	short M004_L_91E2
		push	DS
		mov	AX,363Ah
		push	AX
		mov	AX,40h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	00410h
M004_L_91E2:
		mov	AX,DGROUP:M004_BCC_DATA_77EE
		or	AX,word ptr DGROUP:M004_BCC_DATA_77F0
		je	short M004_L_91F6
		les	BX,DGROUP:M004_BCC_DATA_77EE
		cmp	word ptr ES:[BX+8],0
		jne	short M004_L_9203
M004_L_91F6:
		mov	AX,71h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		jmp	short M004_L_9225
M004_L_9203:
		les	BX,DGROUP:M004_BCC_DATA_77EE
		push	word ptr ES:[BX+8]
		push	word ptr [BP-22h]
		push	word ptr [BP-24h]
		push	word ptr DGROUP:M004_BCC_DATA_8263
		push	word ptr DGROUP:M004_BCC_DATA_8265
		db	0E8h
		dw	0055Ch
		les	BX,DGROUP:M004_BCC_DATA_77EE
		mov	byte ptr ES:[BX+0Dh],1
M004_L_9225:
		les	BX,[BP+4]
		mov	word ptr ES:[BX],0
		db	0E9h
		dw	003C2h
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0F224h
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_924A
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_924F
M004_L_924A:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_924F:
		cmp	AX,7
		je	short M004_L_9268
		push	DS
		mov	AX,3640h
		push	AX
		mov	AX,40h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	0038Ah
M004_L_9268:
		mov	AX,DGROUP:M004_BCC_DATA_77EE
		or	AX,word ptr DGROUP:M004_BCC_DATA_77F0
		je	short M004_L_927C
		les	BX,DGROUP:M004_BCC_DATA_77EE
		cmp	word ptr ES:[BX+0Ah],0
		jne	short M004_L_9289
M004_L_927C:
		mov	AX,77h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
		jmp	short M004_L_92A2
M004_L_9289:
		les	BX,DGROUP:M004_BCC_DATA_77EE
		push	word ptr ES:[BX+0Ah]
		push	word ptr [BP-22h]
		push	word ptr [BP-24h]
		push	word ptr DGROUP:M004_BCC_DATA_8263
		push	word ptr DGROUP:M004_BCC_DATA_8265
		db	0E8h
		dw	004D6h
M004_L_92A2:
		les	BX,[BP+4]
		mov	word ptr ES:[BX],0
		db	0E9h
		dw	00345h
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0F1A7h
		les	BX,[BP+4]
		mov	word ptr ES:[BX],0
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_92CF
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_92D4
M004_L_92CF:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_92D4:
		cmp	AX,7
		je	short M004_L_9343
		xor	AX,AX
		push	AX
		push	AX
		db	09Ah
		dw	X047_01
		dw	seg X047_01
		mov	SI,AX
		or	SI,SI
		jne	short M004_L_92EB
		db	0E9h
		dw	00307h
M004_L_92EB:
		mov	ES,word ptr DGROUP:M004_BCC_EXPR_SEGMENT
		mov	BX,word ptr DGROUP:M004_BCC_DATA_5EDE
		cmp	byte ptr ES:[BX],0Ch
		jne	short M004_L_9306
		mov	AX,179h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		jmp	short M004_L_9312
M004_L_9306:
		push	SI
		push	word ptr DGROUP:M004_BCC_DATA_5EDE
		db	09Ah
		dw	X047_0C
		dw	seg X047_0C
		mov	SI,AX
M004_L_9312:
		cmp	byte ptr DGROUP:M004_BCC_DATA_5EE0,1
		jne	short M004_L_9324
		mov	AX,157h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
M004_L_9324:
		mov	byte ptr DGROUP:M004_BCC_DATA_5EE0,2
		cmp	word ptr DGROUP:M004_BCC_STMT_TYPE_CURRENT,7
		je	short M004_L_9378
		push	DS
		mov	AX,3649h
		push	AX
		mov	AX,40h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		jmp	short M004_L_9378
M004_L_9343:
		mov	AX,DGROUP:M004_BCC_DATA_5EDE
		cmp	AX,word ptr DGROUP:M004_BCC_DATA_77E2
		je	short M004_L_935F
		mov	ES,word ptr DGROUP:M004_BCC_EXPR_SEGMENT
		mov	BX,word ptr DGROUP:M004_BCC_DATA_5EDE
		cmp	byte ptr ES:[BX],0Ch
		je	short M004_L_935F
		mov	AX,16Fh
		jmp	short M004_L_9369
M004_L_935F:
		cmp	byte ptr DGROUP:M004_BCC_DATA_5EE0,2
		jne	short M004_L_9371
		mov	AX,157h
M004_L_9369:
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
M004_L_9371:
		mov	byte ptr DGROUP:M004_BCC_DATA_5EE0,1
		xor	SI,SI
M004_L_9378:
		push	SI
		nop
		push	CS
		db	0E8h
		dw	0052Eh
		push	SI
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	SI,AX
		mov	ES,word ptr DGROUP:M004_BCC_EXPR_SEGMENT
		mov	BX,word ptr DGROUP:M004_BCC_DATA_5EDE
		cmp	byte ptr ES:[BX],13h
		jne	short M004_L_939A
		push	SI
		db	0E8h
		dw	006CCh
		mov	SI,AX
M004_L_939A:
		push	SI
		push	word ptr [BP-22h]
		push	word ptr [BP-24h]
		push	word ptr DGROUP:M004_BCC_DATA_8263
		push	word ptr DGROUP:M004_BCC_DATA_8265
		db	09Ah
		dw	X057_12
		dw	seg X057_12
		mov	word ptr [BP-4],AX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-4]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		db	0E9h
		dw	0022Eh
		xor	AX,AX
		push	AX
		les	BX,[BP+4]
		push	word ptr ES:[BX]
		push	CS
		db	0E8h
		dw	0EF0Fh
		les	BX,[BP+4]
		mov	word ptr ES:[BX],AX
		db	0E9h
		dw	00218h
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0F07Ah
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_93F4
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_93F9
M004_L_93F4:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_93F9:
		cmp	AX,31h
		je	short M004_L_9413
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,33h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
		db	0E9h
		dw	001DFh
M004_L_9413:
		push	word ptr DGROUP:M004_BCC_DATA_8269
		push	word ptr DGROUP:M004_BCC_DATA_8618
		mov	AL,1
		push	AX
		db	09Ah
		dw	X04A_12
		dw	seg X04A_12
		mov	word ptr [BP-20h],AX
		cmp	word ptr [BP-20h],0
		jne	short M004_L_9458
		push	word ptr DGROUP:M004_BCC_DATA_8269
		push	word ptr DGROUP:M004_BCC_DATA_8618
		mov	AL,1
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		push	AX
		db	09Ah
		dw	X04A_0B
		dw	seg X04A_0B
		mov	word ptr [BP-20h],AX
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	BX,word ptr [BP-20h]
		mov	ES,word ptr DGROUP:M004_BCC_STMT_RECORD_SEG
		mov	word ptr ES:[BX+0Eh],AX
M004_L_9458:
		mov	BX,word ptr [BP-20h]
		mov	ES,word ptr DGROUP:M004_BCC_STMT_RECORD_SEG
		or	word ptr ES:[BX+6],80h
		push	word ptr ES:[BX+0Eh]
		push	word ptr [BP-22h]
		push	word ptr [BP-24h]
		push	word ptr DGROUP:M004_BCC_DATA_8263
		push	word ptr DGROUP:M004_BCC_DATA_8265
		db	0E8h
		dw	002FEh
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_948B
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_9490
M004_L_948B:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_9490:
		cmp	AX,7
		je	short M004_L_94A6
		push	DS
		mov	AX,3650h
		push	AX
		mov	AX,40h
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
M004_L_94A6:
		les	BX,[BP+4]
		mov	word ptr ES:[BX],0
		db	0E9h
		dw	00141h
M004_L_94B1:
		mov	AX,DGROUP:M004_BCC_DATA_8269
		mov	word ptr [BP-0Eh],AX
		cmp	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		je	short M004_L_94C8
		mov	byte ptr DGROUP:M004_BCC_TOKEN_SAVED,0
		mov	AX,DGROUP:M004_BCC_STMT_TYPE_CURRENT
		jmp	short M004_L_94CD
M004_L_94C8:
		db	09Ah
		dw	X031_09
		dw	seg X031_09
M004_L_94CD:
		cmp	AX,21h
		je	short M004_L_94D5
		db	0E9h
		dw	000ADh
M004_L_94D5:
		push	word ptr [BP-0Eh]
		push	word ptr DGROUP:M004_BCC_DATA_8618
		mov	AL,1
		push	AX
		db	09Ah
		dw	X04A_12
		dw	seg X04A_12
		mov	word ptr [BP-20h],AX
		les	BX,[BP+4]
		mov	word ptr ES:[BX],1
		mov	word ptr DGROUP:M004_BCC_DATA_77FA,1
		cmp	word ptr [BP-20h],0
		jne	short M004_L_952B
		push	word ptr [BP-0Eh]
		push	word ptr DGROUP:M004_BCC_DATA_8618
		mov	AL,1
		push	AX
		mov	AX,3
		push	AX
		xor	AX,AX
		push	AX
		push	AX
		mov	AX,40h
		push	AX
		db	09Ah
		dw	X04A_0B
		dw	seg X04A_0B
		mov	word ptr [BP-20h],AX
		db	09Ah
		dw	X057_06
		dw	seg X057_06
		mov	BX,word ptr [BP-20h]
		mov	ES,word ptr DGROUP:M004_BCC_STMT_RECORD_SEG
		mov	word ptr ES:[BX+0Eh],AX
		jmp	short M004_L_9567
M004_L_952B:
		mov	BX,word ptr [BP-20h]
		mov	ES,word ptr DGROUP:M004_BCC_STMT_RECORD_SEG
		test	word ptr ES:[BX+6],40h
		je	short M004_L_955A
		mov	word ptr DGROUP:M004_BCC_DATA_5F4E,0
		push	word ptr ES:[BX+2]
		db	09Ah
		dw	X019_04
		dw	seg X019_04
		push	DX
		push	AX
		mov	AX,0ADh
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		add	SP,6
		db	0E9h
		dw	0EF29h
M004_L_955A:
		mov	BX,word ptr [BP-20h]
		mov	ES,word ptr DGROUP:M004_BCC_STMT_RECORD_SEG
		db	026h,081h,04Fh,006h,040h,000h
M004_L_9567:
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		mov	BX,word ptr [BP-20h]
		mov	ES,word ptr DGROUP:M004_BCC_STMT_RECORD_SEG
		push	word ptr ES:[BX+0Eh]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		db	0E9h
		dw	0EF01h
M004_L_9582:
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0EED2h
		push	word ptr [BP-0Eh]
		xor	AX,AX
		push	AX
		db	09Ah
		dw	X047_01
		dw	seg X047_01
		mov	SI,AX
		or	SI,SI
		je	short M004_L_95F2
		push	SI
		nop
		push	CS
		db	0E8h
		dw	00201h
		push	SI
		db	09Ah
		dw	X049_03
		dw	seg X049_03
		mov	SI,AX
		push	SI
		push	word ptr [BP-22h]
		push	word ptr [BP-24h]
		push	word ptr DGROUP:M004_BCC_DATA_8263
		push	word ptr DGROUP:M004_BCC_DATA_8265
		db	09Ah
		dw	X057_0F
		dw	seg X057_0F
		mov	word ptr [BP-4],AX
		push	word ptr DGROUP:M004_BCC_DATA_5EDC
		push	word ptr [BP-4]
		push	word ptr DGROUP:M004_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		cmp	word ptr DGROUP:M004_BCC_STMT_TYPE_CURRENT,7
		je	short M004_L_95EA
		xor	AX,AX
		xor	DX,DX
		push	AX
		push	DX
		mov	AX,0EAh
		push	AX
		db	09Ah
		dw	X046_09
		dw	seg X046_09
		add	SP,6
M004_L_95EA:
		les	BX,[BP+4]
		mov	word ptr ES:[BX],1
M004_L_95F2:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_847A	endp
CO04B_TEXT	ends

CO04B_TEXT	segment byte public 'CODE'
		assume	cs:CO04B_TEXT

BCC_TABLE_95FB	label	word
		dw	00B0Dh
		dw	0092Bh
		dw	00CF0h
		dw	00FCDh
		dw	00ECAh
		dw	00F50h
		dw	00345h
		dw	00232h
		dw	003D6h
		dw	010FAh
		dw	003F5h
		dw	003E7h
		dw	003C8h
		dw	012A2h
		dw	012A2h
		dw	012A2h
		dw	012A2h
		dw	010E4h
		dw	003C3h
		dw	01312h

CO04B_TEXT	ends

		extrn	BCC_FAR_5B8B:far
		extrn	BCC_FAR_5BED:far


CO04B_TEXT	segment byte public 'CODE'
		assume	cs:CO04B_TEXT,ds:DGROUP

M006_BCC_DATA_8186	equ	8186h

BCC_NEAR_9623	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],13h
		jne	short M006_L_9641
		mov	AX,54h
		push	AX
		db	09Ah
		dw	BCC_FAR_5B8B
		dw	seg BCC_FAR_5B8B
		inc	SP
		inc	SP
M006_L_9641:
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8186
		mov	AX,word ptr ES:[SI]
		cmp	AX,2
		je	short M006_L_9659
		cmp	AX,12h
		je	short M006_L_9676
		cmp	AX,32h
		je	short M006_L_9671
		jmp	short M006_L_9683
M006_L_9659:
		mov	ES,word ptr DGROUP:M006_BCC_DATA_8186
		mov	AX,word ptr ES:[SI+0Ah]
		or	AX,word ptr ES:[SI+0Ch]
		jne	short M006_L_966C
		mov	AX,0FFFFh
		jmp	short M006_L_9685
M006_L_966C:
		mov	AX,1
		jmp	short M006_L_9685
M006_L_9671:
		mov	AX,1
		jmp	short M006_L_9685
M006_L_9676:
		mov	AX,16Eh
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
		jmp	short M006_L_9683
M006_L_9683:
		xor	AX,AX
M006_L_9685:
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_9623	endp
CO04B_TEXT	ends


		extrn	X047_0A:far
		extrn	X049_02:far
		extrn	X057_04:far
		extrn	X057_09:far


CO04B_TEXT	segment byte public 'CODE'
		assume	cs:CO04B_TEXT,ds:DGROUP

M007_BCC_DATA_5EDC	equ	5EDCh
M007_BCC_DATA_77EC	equ	77ECh

BCC_NEAR_968B	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+0Eh]
		push	SI
		db	09Ah
		dw	X047_0A
		dw	seg X047_0A
		mov	SI,AX
		push	SI
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	SI,AX
		push	SI
		db	0E8h
		dw	0FF79h
		mov	DI,AX
		push	SI
		nop
		push	CS
		db	0E8h
		dw	001FAh
		or	DI,DI
		jge	short M007_L_96CA
		push	word ptr [BP+0Ch]
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	000B0h
		jmp	short M007_L_96F9
M007_L_96CA:
		or	DI,DI
		jne	short M007_L_96F9
		xor	AX,AX
		push	AX
		push	SI
		push	word ptr [BP+0Ch]
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	09Ah
		dw	X057_09
		dw	seg X057_09
		mov	word ptr [BP-2],AX
		push	word ptr DGROUP:M007_BCC_DATA_5EDC
		push	word ptr [BP-2]
		push	word ptr DGROUP:M007_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
M007_L_96F9:
		mov	AX,DI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	0Ch
BCC_NEAR_968B	endp
CO04B_TEXT	ends


		extrn	X047_0A:far
		extrn	X049_02:far
		extrn	X057_04:far
		extrn	X057_09:far


CO04B_TEXT	segment byte public 'CODE'
		assume	cs:CO04B_TEXT,ds:DGROUP

M008_BCC_DATA_5EDC	equ	5EDCh
M008_BCC_DATA_77EC	equ	77ECh

BCC_NEAR_9704	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+0Eh]
		push	SI
		db	09Ah
		dw	X047_0A
		dw	seg X047_0A
		mov	SI,AX
		push	SI
		db	09Ah
		dw	X049_02
		dw	seg X049_02
		mov	SI,AX
		push	SI
		db	0E8h
		dw	0FF00h
		mov	DI,AX
		or	DI,DI
		jle	short M008_L_973D
		push	word ptr [BP+0Ch]
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	0E8h
		dw	0003Dh
		jmp	short M008_L_976D
M008_L_973D:
		or	DI,DI
		jne	short M008_L_976D
		mov	AX,1
		push	AX
		push	SI
		push	word ptr [BP+0Ch]
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	09Ah
		dw	X057_09
		dw	seg X057_09
		mov	word ptr [BP-2],AX
		push	word ptr DGROUP:M008_BCC_DATA_5EDC
		push	word ptr [BP-2]
		push	word ptr DGROUP:M008_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
M008_L_976D:
		mov	AX,DI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	0Ch
BCC_NEAR_9704	endp
CO04B_TEXT	ends


		extrn	X057_07:far
		extrn	X057_04:far


CO04B_TEXT	segment byte public 'CODE'
		assume	cs:CO04B_TEXT,ds:DGROUP

M009_BCC_DATA_5EDC	equ	5EDCh
M009_BCC_DATA_77EC	equ	77ECh

BCC_NEAR_9778	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	word ptr DGROUP:M009_BCC_DATA_5EDC
		push	word ptr [BP+0Ch]
		push	word ptr [BP+0Ah]
		push	word ptr [BP+8]
		push	word ptr [BP+6]
		push	word ptr [BP+4]
		db	09Ah
		dw	X057_07
		dw	seg X057_07
		push	AX
		push	word ptr DGROUP:M009_BCC_DATA_77EC
		db	09Ah
		dw	X057_04
		dw	seg X057_04
		pop	BP
		dec	BP
		ret	0Ah
BCC_NEAR_9778	endp
CO04B_TEXT	ends


		extrn	BCC_FAR_5BED:far


CO04B_TEXT	segment byte public 'CODE'
		assume	cs:CO04B_TEXT,ds:DGROUP

M00A_BCC_STMT_RECORD_SEG	equ	63C2h
M00A_BCC_DATA_8186	equ	8186h

		public	X04B_01
X04B_01	label	far
BCC_NEAR_97A3	label	near
BCC_FAR_97A3	proc	far
M00A_L_97A3:
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+6]
		or	SI,SI
		jne	short M00A_L_97B2
		db	0E9h
		dw	000F4h
M00A_L_97B2:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],0
		jne	short M00A_L_97C0
		db	0E9h
		dw	000E6h
M00A_L_97C0:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		cmp	word ptr ES:[SI],2Ah
		jne	short M00A_L_97E1
		push	word ptr ES:[SI+0Ah]
		push	CS
		db	0E8h
		dw	0FFD1h
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		push	word ptr ES:[SI+0Ch]
		push	CS
		db	0E8h
		dw	0FFC5h
		db	0E9h
		dw	000C5h
M00A_L_97E1:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		cmp	word ptr ES:[SI],25h
		jne	short M00A_L_9843
		cmp	word ptr ES:[SI+0Ch],0
		jne	short M00A_L_97F5
		db	0E9h
		dw	000B1h
M00A_L_97F5:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ch]
		mov	DI,word ptr ES:[BX+0Ah]
		cmp	word ptr ES:[DI],35h
		jne	short M00A_L_9812
		cmp	word ptr ES:[DI+2],0Ch
		je	short M00A_L_9812
		mov	DI,word ptr ES:[DI+0Ah]
M00A_L_9812:
		push	DI
		push	CS
		db	0E8h
		dw	0FF8Ch
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ch]
		mov	DI,word ptr ES:[BX+0Ch]
		cmp	word ptr ES:[DI],35h
		jne	short M00A_L_9834
		cmp	word ptr ES:[DI+2],0Ch
		je	short M00A_L_9834
		mov	DI,word ptr ES:[DI+0Ah]
M00A_L_9834:
		push	DI
		push	CS
		db	0E8h
		dw	0FF6Ah
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		push	word ptr ES:[SI+0Ah]
		jmp	short M00A_L_98A1
M00A_L_9843:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		cmp	word ptr ES:[SI],23h
		jne	short M00A_L_9854
		mov	word ptr ES:[SI],13h
		jmp	short M00A_L_98A0
M00A_L_9854:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		cmp	word ptr ES:[SI],24h
		jne	short M00A_L_9865
		mov	word ptr ES:[SI],14h
		jmp	short M00A_L_98A0
M00A_L_9865:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		cmp	word ptr ES:[SI],5
		jne	short M00A_L_987E
		mov	BX,word ptr ES:[SI+0Ah]
		mov	ES,word ptr DGROUP:M00A_BCC_STMT_RECORD_SEG
		cmp	word ptr ES:[BX+2],0
		je	short M00A_L_98A6
M00A_L_987E:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],0Ch
		je	short M00A_L_98A0
		mov	BX,word ptr ES:[SI]
		mov	AL,byte ptr [BX+35E6h]
		cbw
		or	AX,AX
		jne	short M00A_L_98A0
		mov	AX,172h
		push	AX
		db	09Ah
		dw	BCC_FAR_5BED
		dw	seg BCC_FAR_5BED
		inc	SP
		inc	SP
M00A_L_98A0:
		push	SI
M00A_L_98A1:
		nop
		push	CS
		db	0E8h
		dw	00006h
M00A_L_98A6:
		pop	DI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_97A3	endp
CO04B_TEXT	ends


		extrn	X04A_0E:far


CO04B_TEXT	segment byte public 'CODE'
		assume	cs:CO04B_TEXT,ds:DGROUP

M00B_BCC_EXPR_SEGMENT	equ	639Ah
M00B_BCC_STMT_RECORD_SEG	equ	63C2h
M00B_BCC_DATA_8186	equ	8186h

		public	X04B_02
X04B_02	label	far
BCC_NEAR_98AC	label	near
BCC_FAR_98AC	proc	far
M00B_L_98AC:
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+6]
M00B_L_98B4:
		or	DI,DI
		jne	short M00B_L_98BB
		db	0E9h
		dw	00199h
M00B_L_98BB:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		cmp	word ptr ES:[DI+2],0
		jne	short M00B_L_98C9
		db	0E9h
		dw	0018Bh
M00B_L_98C9:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		mov	BX,word ptr ES:[DI]
		cmp	BX,6
		je	short M00B_L_9914
		jg	short M00B_L_98E7
		dec	BX
		cmp	BX,4
		jbe	short M00B_L_98E0
		db	0E9h
		dw	00156h
M00B_L_98E0:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	177Ah
M00B_L_98E7:
		cmp	BX,2Ah
		jne	short M00B_L_98EF
		db	0E9h
		dw	000C5h
M00B_L_98EF:
		jg	short M00B_L_9901
		cmp	BX,7
		jne	short M00B_L_98F9
		db	0E9h
		dw	0015Bh
M00B_L_98F9:
		cmp	BX,12h
		je	short M00B_L_994A
		db	0E9h
		dw	00135h
M00B_L_9901:
		cmp	BX,32h
		jne	short M00B_L_9909
		db	0E9h
		dw	000CDh
M00B_L_9909:
		cmp	BX,33h
		jne	short M00B_L_9911
		db	0E9h
		dw	000BAh
M00B_L_9911:
		db	0E9h
		dw	00122h
M00B_L_9914:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+0Ah]
		mov	ES,word ptr DGROUP:M00B_BCC_STMT_RECORD_SEG
		test	word ptr ES:[BX+6],40h
		jne	short M00B_L_9935
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		push	word ptr ES:[DI+0Ah]
		db	09Ah
		dw	X04A_0E
		dw	seg X04A_0E
M00B_L_9935:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		mov	BX,word ptr ES:[DI+0Ah]
		mov	ES,word ptr DGROUP:M00B_BCC_STMT_RECORD_SEG
		or	word ptr ES:[BX+6],80h
		db	0E9h
		dw	0010Ah
M00B_L_994A:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		cmp	word ptr ES:[DI+0Ch],0
		je	short M00B_L_995D
		push	word ptr ES:[DI+0Ch]
		push	CS
		db	0E8h
		dw	0FF4Fh
M00B_L_995D:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		mov	SI,word ptr ES:[DI+0Ah]
		cmp	word ptr ES:[SI],33h
		jne	short M00B_L_996F
		mov	SI,word ptr ES:[SI+0Ah]
M00B_L_996F:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		cmp	word ptr ES:[SI],1
		jne	short M00B_L_998A
		mov	BX,word ptr ES:[SI+0Ah]
		mov	ES,word ptr DGROUP:M00B_BCC_STMT_RECORD_SEG
		or	word ptr ES:[BX+6],0C0h
		db	0E9h
		dw	000CAh
M00B_L_998A:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		cmp	word ptr ES:[SI],6
		je	short M00B_L_999A
		cmp	word ptr ES:[SI],5
		jne	short M00B_L_99AF
M00B_L_999A:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		mov	ES,word ptr DGROUP:M00B_BCC_STMT_RECORD_SEG
		db	026h,081h,04Fh,006h,040h,000h
		db	0E9h
		dw	000A5h
M00B_L_99AF:
		mov	DI,SI
		db	0E9h
		dw	0FF00h
M00B_L_99B4:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		push	word ptr ES:[DI+0Ah]
		push	CS
		db	0E8h
		dw	0FDE3h
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		mov	DI,word ptr ES:[DI+0Ch]
		db	0E9h
		dw	0FEE9h
M00B_L_99CB:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		mov	DI,word ptr ES:[DI+0Ah]
		db	0E9h
		dw	0FEDEh
M00B_L_99D6:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		mov	SI,word ptr ES:[DI+0Ah]
		cmp	word ptr ES:[SI],1
		je	short M00B_L_99F0
		cmp	word ptr ES:[SI],6
		je	short M00B_L_99F0
		cmp	word ptr ES:[SI],5
		jne	short M00B_L_9A02
M00B_L_99F0:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		mov	BX,word ptr ES:[SI+0Ah]
		mov	ES,word ptr DGROUP:M00B_BCC_STMT_RECORD_SEG
		or	word ptr ES:[BX+6],1C0h
M00B_L_9A02:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		cmp	word ptr ES:[SI+2],11h
		jne	short M00B_L_9A36
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M00B_BCC_EXPR_SEGMENT
		mov	AX,word ptr ES:[BX+7]
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		mov	word ptr ES:[SI+8],AX
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M00B_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		mov	word ptr ES:[SI+2],AX
M00B_L_9A36:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		cmp	word ptr ES:[DI+0Ah],0
		je	short M00B_L_9A49
		push	word ptr ES:[DI+0Ah]
		push	CS
		db	0E8h
		dw	0FE63h
M00B_L_9A49:
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8186
		mov	DI,word ptr ES:[DI+0Ch]
		db	0E9h
		dw	0FE60h
M00B_L_9A54:
		pop	DI
		pop	SI
		pop	BP
		retf	2
BCC_FAR_98AC	endp
CO04B_TEXT	ends

CO04B_TEXT	segment byte public 'CODE'
		assume	cs:CO04B_TEXT
; Original-image layout stub: not recovered source


		db	055h,016h,074h,017h,074h,017h,074h,017h,034h,016h	; ovr_1d10_982e:9A5A

CO04B_TEXT	ends

CO04B_TEXT	segment byte public 'CODE'
		assume	cs:CO04B_TEXT,ds:DGROUP

M00D_BCC_DATA_5EDE	equ	5EDEh
M00D_BCC_DATA_5EE3	equ	5EE3h
M00D_BCC_EXPR_SEGMENT	equ	639Ah
M00D_BCC_STMT_RECORD_SEG	equ	63C2h
M00D_BCC_DATA_80B8	equ	80B8h
M00D_BCC_DATA_80BC	equ	80BCh
M00D_BCC_DATA_8186	equ	8186h


BCC_NEAR_9A64	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		or	SI,SI
		je	short M00D_L_9A7D
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_8186
		cmp	word ptr ES:[SI],0
		jne	short M00D_L_9A80
M00D_L_9A7D:
		db	0E9h
		dw	000A4h
M00D_L_9A80:
		mov	BX,word ptr DGROUP:M00D_BCC_DATA_5EDE
		mov	ES,word ptr DGROUP:M00D_BCC_EXPR_SEGMENT
		mov	AX,word ptr ES:[BX+3]
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],1
		je	short M00D_L_9AA1
		cmp	word ptr [BP-2],2
		je	short M00D_L_9AA1
		cmp	word ptr [BP-2],4
		jne	short M00D_L_9AA4
M00D_L_9AA1:
		db	0E9h
		dw	00080h
M00D_L_9AA4:
		mov	AX,5
		push	AX
		mov	BX,word ptr DGROUP:M00D_BCC_DATA_5EE3
		mov	ES,word ptr DGROUP:M00D_BCC_STMT_RECORD_SEG
		push	word ptr ES:[BX+8]
		push	word ptr DGROUP:M00D_BCC_DATA_5EE3
		xor	AX,AX
		push	AX
		push	AX
		db	0FFh,01Eh
		dw	80BCh
		mov	DI,AX
		mov	AX,31h
		push	AX
		push	word ptr DGROUP:M00D_BCC_DATA_5EDE
		push	DI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		mov	DI,AX
		mov	AX,12h
		push	AX
		push	word ptr DGROUP:M00D_BCC_DATA_5EDE
		push	DI
		push	SI
		db	0FFh,01Eh
		dw	80B8h
		mov	SI,AX
		mov	AX,5
		push	AX
		mov	BX,word ptr DGROUP:M00D_BCC_DATA_5EE3
		mov	ES,word ptr DGROUP:M00D_BCC_STMT_RECORD_SEG
		push	word ptr ES:[BX+8]
		push	word ptr DGROUP:M00D_BCC_DATA_5EE3
		xor	AX,AX
		push	AX
		push	AX
		db	0FFh,01Eh
		dw	80BCh
		mov	DI,AX
		mov	AX,31h
		push	AX
		push	word ptr DGROUP:M00D_BCC_DATA_5EDE
		push	DI
		xor	AX,AX
		push	AX
		db	0FFh,01Eh
		dw	80B8h
		mov	DI,AX
		mov	AX,2Ah
		push	AX
		push	word ptr DGROUP:M00D_BCC_DATA_5EDE
		push	SI
		push	DI
		db	0FFh,01Eh
		dw	80B8h
		mov	SI,AX
M00D_L_9B24:
		mov	AX,SI
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_9A64	endp
CO04B_TEXT	ends

; END C122UNIT
		end
