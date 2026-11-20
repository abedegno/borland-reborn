		public	X050_00
		public	X050_01
		public	X050_02
		public	X050_03
		public	X050_04
		public	X050_05
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1d2b_9c35
; BEGIN C100UNIT (listing ovr_1d2b_9c35:C350)

		extrn	BCC_FAR_03A9:far
		extrn	X055_03:far
		extrn	X055_01:far
		extrn	X055_06:far
		extrn	X055_04:far
		extrn	X055_09:far
		extrn	X055_0E:far
		extrn	X056_0E:far


CO050_TEXT	segment byte public 'CODE'
		assume	cs:CO050_TEXT,ds:DGROUP

M000_BCC_DATA_1700	equ	1700h
M000_BCC_DATA_1709	equ	1709h
M000_BCC_DATA_1776	equ	1776h
M000_BCC_EXPR_SEGMENT	equ	639Ah
M000_BCC_STMT_RECORD_SEG	equ	63C2h
M000_BCC_DATA_782A	equ	782Ah
M000_BCC_DATA_8164	equ	8164h
M000_BCC_DATA_85F4	equ	85F4h
M000_BCC_DATA_8652	equ	8652h
M000_BCC_STMT_CURRENT	equ	86C8h
M000_BCC_DATA_86D2	equ	86D2h
M000_BCC_DATA_8894	equ	8894h

		public	X050_00
X050_00	label	far
BCC_FAR_C350	proc	far
		push	BP
		mov	BP,SP
		sub	SP,12h
		push	SI
		push	DI
		mov	BX,word ptr DGROUP:M000_BCC_DATA_85F4
		mov	ES,word ptr DGROUP:M000_BCC_DATA_782A
		mov	AX,word ptr ES:[BX+6]
		mov	word ptr [BP-8],AX
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	word ptr [BP-0Eh],0
		mov	word ptr [BP-0Ah],1
		mov	SI,word ptr [BP-8]
		db	0E9h
		dw	001A7h
M000_L_C37C:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],2
		je	short M000_L_C38A
		db	0E9h
		dw	00192h
M000_L_C38A:
		test	word ptr ES:[SI+6],80h
		jne	short M000_L_C395
		db	0E9h
		dw	00187h
M000_L_C395:
		mov	AX,word ptr [BP-0Ah]
		mov	word ptr ES:[SI+0Eh],AX
		inc	word ptr [BP-0Ah]
		test	word ptr ES:[SI+6],800h
		je	short M000_L_C3AE
		mov	word ptr [BP-10h],0B0h
		jmp	short M000_L_C3B3
M000_L_C3AE:
		mov	word ptr [BP-10h],8Ch
M000_L_C3B3:
		cmp	word ptr [BP-0Eh],0
		je	short M000_L_C3CF
		mov	AX,word ptr [BP-0Eh]
		cmp	AX,word ptr [BP-10h]
		je	short M000_L_C3CF
		mov	AL,byte ptr [BP-0Eh]
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	09Ah
		dw	X055_01
		dw	seg X055_01
M000_L_C3CF:
		mov	AX,word ptr [BP-10h]
		mov	word ptr [BP-0Eh],AX
		push	SI
		nop
		push	CS
		db	0E8h
		dw	00B4Ch
		mov	AL,0
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		test	word ptr ES:[SI+6],800h
		jne	short M000_L_C3F2
		db	0E9h
		dw	000D3h
M000_L_C3F2:
		mov	DI,word ptr ES:[SI+8]
		mov	AX,word ptr ES:[SI+0Ch]
		cmp	AX,word ptr DGROUP:M000_BCC_DATA_8652
		jne	short M000_L_C403
		db	0E9h
		dw	00091h
M000_L_C403:
		mov	AL,61h
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	word ptr [BP-4],0
		mov	word ptr [BP-6],1
		jmp	short M000_L_C43C
M000_L_C417:
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		mov	CX,word ptr ES:[DI+5]
		mov	BX,word ptr ES:[DI+3]
		mov	DX,word ptr [BP-4]
		mov	AX,word ptr [BP-6]
		db	09Ah
		dw	BCC_FAR_03A9
		dw	seg BCC_FAR_03A9
		mov	word ptr [BP-4],DX
		mov	word ptr [BP-6],AX
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		mov	DI,word ptr ES:[DI+7]
M000_L_C43C:
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[DI],11h
		je	short M000_L_C417
		cmp	word ptr [BP-4],0
		ja	short M000_L_C459
		jne	short M000_L_C454
		cmp	word ptr [BP-6],7Fh
		ja	short M000_L_C459
M000_L_C454:
		mov	AL,byte ptr [BP-6]
		jmp	short M000_L_C496
M000_L_C459:
		cmp	word ptr [BP-4],0
		ja	short M000_L_C47A
		jne	short M000_L_C468
		cmp	word ptr [BP-6],7FFFh
		ja	short M000_L_C47A
M000_L_C468:
		mov	AL,81h
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		push	word ptr [BP-6]
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		jmp	short M000_L_C49C
M000_L_C47A:
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		push	word ptr [BP-6]
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		push	word ptr [BP-4]
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		jmp	short M000_L_C49C
M000_L_C494:
		mov	AL,62h
M000_L_C496:
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
M000_L_C49C:
		push	DI
		db	0FFh,01Eh
		dw	8164h
		mov	word ptr [BP-0Ch],AX
		cmp	word ptr [BP-0Ch],7Fh
		ja	short M000_L_C4B5
		mov	AL,byte ptr [BP-0Ch]
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		jmp	short M000_L_C4C5
M000_L_C4B5:
		mov	AL,81h
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
M000_L_C4C5:
		cmp	byte ptr DGROUP:M000_BCC_DATA_1700,0
		je	short M000_L_C507
		mov	AL,byte ptr [BP-10h]
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+8]
		db	0E8h
		dw	00472h
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E000h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	AL,88h
		jmp	short M000_L_C511
M000_L_C507:
		test	word ptr [BP-0Ah],7Fh
		jne	short M000_L_C51C
		mov	AL,byte ptr [BP-10h]
M000_L_C511:
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	09Ah
		dw	X055_01
		dw	seg X055_01
M000_L_C51C:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M000_L_C523:
		or	SI,SI
		je	short M000_L_C52A
		db	0E9h
		dw	0FE52h
M000_L_C52A:
		test	word ptr DGROUP:M000_BCC_DATA_86D2,2
		je	short M000_L_C55D
		cmp	word ptr [BP-0Eh],0B0h
		jne	short M000_L_C547
		mov	AL,byte ptr [BP-10h]
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	09Ah
		dw	X055_01
		dw	seg X055_01
M000_L_C547:
		push	DS
		mov	AX,387Ch
		push	AX
		db	09Ah
		dw	X055_03
		dw	seg X055_03
		mov	AL,0
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AL,8Ch
		jmp	short M000_L_C566
M000_L_C55D:
		cmp	word ptr [BP-0Eh],0
		je	short M000_L_C56C
		mov	AL,byte ptr [BP-0Eh]
M000_L_C566:
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
M000_L_C56C:
		mov	SI,word ptr [BP-8]
		db	0E9h
		dw	0023Ch
M000_L_C572:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],1
		je	short M000_L_C580
		db	0E9h
		dw	00154h
M000_L_C580:
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	AX,word ptr ES:[SI+0Ch]
		mov	word ptr [BP-0Ch],AX
		cmp	word ptr [BP-0Ch],0
		jne	short M000_L_C5A7
		mov	AX,DGROUP:M000_BCC_STMT_CURRENT
		mov	word ptr [BP-0Ch],AX
		mov	word ptr ES:[SI+0Ch],AX
		mov	AX,word ptr [BP+6]
		add	word ptr ES:[SI+0Eh],AX
M000_L_C5A7:
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X056_0E
		dw	seg X056_0E
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		cmp	word ptr ES:[BX+2],0
		je	short M000_L_C5CD
		mov	BX,word ptr ES:[BX+2]
		mov	AX,word ptr ES:[BX+2]
		mov	word ptr [BP-0Ah],AX
		jmp	short M000_L_C5D2
M000_L_C5CD:
		mov	word ptr [BP-0Ah],0
M000_L_C5D2:
		mov	AL,byte ptr [BP-0Ah]
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AL,byte ptr [BP-0Ch]
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		push	SI
		nop
		push	CS
		db	0E8h
		dw	0093Dh
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+0Eh]
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	AL,0
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AL,90h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		cmp	byte ptr DGROUP:M000_BCC_DATA_1700,0
		je	short M000_L_C679
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	AX,word ptr ES:[SI+8]
		mov	word ptr [BP-12h],AX
		push	word ptr [BP-12h]
		db	0E8h
		dw	00333h
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E100h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	BX,word ptr [BP-12h]
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		mov	BX,word ptr [BP-12h]
		cmp	byte ptr ES:[BX],12h
		jne	short M000_L_C669
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		test	word ptr ES:[SI+6],20h
		je	short M000_L_C669
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[BX+7],4
		jne	short M000_L_C665
		mov	AL,98h
		jmp	short M000_L_C667
M000_L_C665:
		mov	AL,18h
M000_L_C667:
		jmp	short M000_L_C66B
M000_L_C669:
		mov	AL,0
M000_L_C66B:
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
M000_L_C679:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[BX],12h
		je	short M000_L_C68E
		db	0E9h
		dw	00119h
M000_L_C68E:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		test	byte ptr ES:[BX+8],80h
		jne	short M000_L_C6A4
		db	0E9h
		dw	00103h
M000_L_C6A4:
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0A000h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	AX,2
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		push	SI
		nop
		push	CS
		db	0E8h
		dw	00866h
		mov	AL,0
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	0E9h
		dw	000D3h
M000_L_C6D4:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],3
		je	short M000_L_C6E2
		db	0E9h
		dw	000C5h
M000_L_C6E2:
		cmp	word ptr ES:[SI+0Ch],0
		jne	short M000_L_C6F7
		mov	AX,DGROUP:M000_BCC_STMT_CURRENT
		mov	word ptr ES:[SI+0Ch],AX
		mov	AX,word ptr [BP+6]
		add	word ptr ES:[SI+0Eh],AX
M000_L_C6F7:
		mov	AL,DGROUP:M000_BCC_DATA_1709
		or	AL,byte ptr DGROUP:M000_BCC_DATA_1776
		jne	short M000_L_C703
		db	0E9h
		dw	000A4h
M000_L_C703:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[BX],12h
		je	short M000_L_C718
		db	0E9h
		dw	0008Fh
M000_L_C718:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		test	byte ptr ES:[BX+8],1
		je	short M000_L_C7A7
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		test	word ptr ES:[SI+6],100h
		je	short M000_L_C7A7
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	AX,word ptr ES:[SI+0Ch]
		mov	word ptr [BP-0Ch],AX
		push	word ptr [BP-0Ch]
		db	09Ah
		dw	X056_0E
		dw	seg X056_0E
		mov	word ptr [BP-2],AX
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M000_BCC_DATA_8894
		cmp	word ptr ES:[BX+2],0
		je	short M000_L_C76D
		mov	BX,word ptr ES:[BX+2]
		mov	AX,word ptr ES:[BX+2]
		mov	word ptr [BP-0Ah],AX
		jmp	short M000_L_C772
M000_L_C76D:
		mov	word ptr [BP-0Ah],0
M000_L_C772:
		mov	AL,byte ptr [BP-0Ah]
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AL,byte ptr [BP-0Ch]
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		push	SI
		nop
		push	CS
		db	0E8h
		dw	0079Dh
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+0Eh]
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	AL,0
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AL,0B6h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
M000_L_C7A7:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M000_L_C7AE:
		or	SI,SI
		je	short M000_L_C7B5
		db	0E9h
		dw	0FDBDh
M000_L_C7B5:
		cmp	byte ptr DGROUP:M000_BCC_DATA_1700,0
		jne	short M000_L_C7BF
		db	0E9h
		dw	0018Bh
M000_L_C7BF:
		mov	SI,word ptr [BP-8]
		jmp	short M000_L_C7DD
M000_L_C7C4:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],3
		jne	short M000_L_C7D6
		push	word ptr ES:[SI+8]
		db	0E8h
		dw	0017Ch
M000_L_C7D6:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M000_L_C7DD:
		or	SI,SI
		jne	short M000_L_C7C4
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E600h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	word ptr [BP-0Ah],1
		mov	SI,word ptr [BP-8]
		jmp	short M000_L_C834
M000_L_C7F9:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],3
		jne	short M000_L_C82D
		test	word ptr [BP-0Ah],3Fh
		jne	short M000_L_C826
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E600h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	word ptr [BP-0Ah],1
M000_L_C826:
		push	SI
		db	0E8h
		dw	00636h
		inc	word ptr [BP-0Ah]
M000_L_C82D:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M000_L_C834:
		or	SI,SI
		jne	short M000_L_C7F9
		mov	SI,word ptr [BP-8]
		jmp	short M000_L_C8AB
M000_L_C83D:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],8
		jne	short M000_L_C8A4
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[BX+1],0
		je	short M000_L_C8A4
		test	word ptr [BP-0Ah],3Fh
		jne	short M000_L_C879
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E600h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	word ptr [BP-0Ah],1
M000_L_C879:
		inc	word ptr [BP-0Ah]
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+2]
		db	0E8h
		dw	00DFAh
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	AL,6
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
M000_L_C8A4:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M000_L_C8AB:
		or	SI,SI
		jne	short M000_L_C83D
		mov	SI,word ptr [BP-8]
		db	0E9h
		dw	00080h
M000_L_C8B5:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],0Bh
		jne	short M000_L_C92E
		cmp	word ptr ES:[SI+8],0
		je	short M000_L_C92E
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[BX+1],0
		je	short M000_L_C92E
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		cmp	word ptr ES:[SI+2],0
		je	short M000_L_C92E
		test	word ptr [BP-0Ah],3Fh
		jne	short M000_L_C903
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E600h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	word ptr [BP-0Ah],1
M000_L_C903:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+2]
		db	0E8h
		dw	00D73h
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M000_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	AL,7
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		inc	word ptr [BP-0Ah]
M000_L_C92E:
		mov	ES,word ptr DGROUP:M000_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M000_L_C935:
		or	SI,SI
		je	short M000_L_C93C
		db	0E9h
		dw	0FF79h
M000_L_C93C:
		cmp	word ptr [BP-0Ah],1
		jbe	short M000_L_C94A
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
M000_L_C94A:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_C350	endp
CO050_TEXT	ends


		extrn	BCC_FAR_B072:far
		extrn	X055_03:far
		extrn	X055_01:far
		extrn	X055_06:far
		extrn	X055_04:far
		extrn	X055_09:far
		extrn	X055_0E:far


CO050_TEXT	segment byte public 'CODE'
		assume	cs:CO050_TEXT,ds:DGROUP

M001_BCC_EXPR_SEGMENT	equ	639Ah
M001_BCC_STMT_RECORD_SEG	equ	63C2h
M001_BCC_DATA_7832	equ	7832h
M001_BCC_DATA_789C	equ	789Ch
M001_BCC_DATA_8164	equ	8164h
M001_BCC_DATA_86CC	equ	86CCh

BCC_NEAR_C952	proc	near
M001_L_C952:
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,8
		push	SI
		mov	SI,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[SI+1],0
		je	short M001_L_C96B
		db	0E9h
		dw	002D0h
M001_L_C96B:
		mov	word ptr [BP-6],DS
		mov	word ptr [BP-8],3888h
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	AX,DGROUP:M001_BCC_DATA_86CC
		mov	word ptr ES:[SI+1],AX
		inc	word ptr DGROUP:M001_BCC_DATA_86CC
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		sub	AX,0Dh
		mov	BX,AX
		cmp	BX,8
		jbe	short M001_L_C994
		db	0E9h
		dw	000EFh
M001_L_C994:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	905h
		push	SI
		db	0E8h
		dw	002C8h
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[SI+7],0
		jne	short M001_L_C9AD
		db	0E9h
		dw	000DDh
M001_L_C9AD:
		mov	BX,word ptr ES:[SI+7]
		mov	ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[BX+2]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_7832
		mov	BX,word ptr ES:[BX+4]
		mov	AX,word ptr [BX]
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[SI+7]
		mov	ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[BX+2]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_7832
		mov	DX,word ptr ES:[BX+2]
		mov	word ptr [BP-6],AX
		mov	word ptr [BP-8],DX
		db	0E9h
		dw	000A6h
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[SI+5],0
		jne	short M001_L_C9FC
		mov	word ptr ES:[SI+1],1
		dec	word ptr DGROUP:M001_BCC_DATA_86CC
		db	0E9h
		dw	0023Fh
M001_L_C9FC:
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[SI+9],1
		jne	short M001_L_CA0C
		mov	AX,1Eh
		jmp	short M001_L_CA0F
M001_L_CA0C:
		mov	AX,1Fh
M001_L_CA0F:
		mov	word ptr [BP-2],AX
		push	SI
		push	word ptr [BP-2]
		db	0E8h
		dw	002D5h
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[SI+7],0
		je	short M001_L_CA8A
		mov	BX,word ptr ES:[SI+7]
		mov	ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[BX+2]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_7832
		mov	BX,word ptr ES:[BX+4]
		mov	AX,word ptr [BX]
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[SI+7]
		mov	ES,word ptr DGROUP:M001_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[BX+2]
		mov	ES,word ptr DGROUP:M001_BCC_DATA_7832
		mov	DX,word ptr ES:[BX+2]
		mov	word ptr [BP-6],AX
		mov	word ptr [BP-8],DX
		jmp	short M001_L_CA8A
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		push	word ptr ES:[SI+7]
		db	0E8h
		dw	0FEEDh
		jmp	short M001_L_CA8A
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[SI+5],0
		je	short M001_L_CA76
		inc	word ptr DGROUP:M001_BCC_DATA_86CC
M001_L_CA76:
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		push	word ptr ES:[SI+3]
		db	0E8h
		dw	0FED1h
		jmp	short M001_L_CA8A
M001_L_CA83:
		dec	word ptr DGROUP:M001_BCC_DATA_86CC
		db	0E9h
		dw	001B1h
M001_L_CA8A:
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E300h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		push	word ptr ES:[SI+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		push	word ptr [BP-6]
		push	word ptr [BP-8]
		db	09Ah
		dw	X055_03
		dw	seg X055_03
		push	SI
		db	0FFh,01Eh
		dw	8164h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		sub	AX,0Dh
		mov	BX,AX
		cmp	BX,8
		jbe	short M001_L_CAD1
		db	0E9h
		dw	00162h
M001_L_CAD1:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	8F3h
		mov	AL,22h
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AL,0
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AX,8000h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	AX,7FFFh
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		inc	word ptr DGROUP:M001_BCC_DATA_86CC
		db	0E9h
		dw	00132h
		mov	AL,byte ptr [BP-2]
		db	0E9h
		dw	00126h
		mov	AL,1Ah
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[SI+7]
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		db	0E9h
		dw	00110h
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[SI+5],0
		je	short M001_L_CB32
		mov	AL,30h
		jmp	short M001_L_CB34
M001_L_CB32:
		mov	AL,15h
M001_L_CB34:
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[SI+3]
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[SI+5],0
		je	short M001_L_CB75
		push	DS
		mov	AX,5F50h
		push	AX
		push	word ptr DGROUP:M001_BCC_DATA_789C
		push	word ptr ES:[SI+5]
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		push	DS
		mov	AX,5F50h
		push	AX
		db	09Ah
		dw	X055_03
		dw	seg X055_03
		db	0E9h
		dw	000BEh
M001_L_CB75:
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI+8]
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		db	0E9h
		dw	000ADh
		mov	AL,17h
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[SI+3]
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	AL,0
		db	0E9h
		dw	00089h
		mov	AL,16h
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[SI+3]
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	AL,0
		jmp	short M001_L_CC2D
		mov	AL,16h
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[SI+3]
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	AL,1
		jmp	short M001_L_CC2D
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	AL,byte ptr ES:[SI+7]
		cbw
		dec	AX
		and	AX,3
		mov	word ptr [BP-4],AX
		test	byte ptr ES:[SI+8],1
		je	short M001_L_CBFA
		db	081h,04Eh,0FCh,004h,000h
M001_L_CBFA:
		mov	AL,23h
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		mov	BX,word ptr ES:[SI+3]
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	AL,byte ptr [BP-4]
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M001_BCC_EXPR_SEGMENT
		test	byte ptr ES:[SI+8],4
		je	short M001_L_CC2B
		mov	AL,1
		jmp	short M001_L_CC2D
M001_L_CC2B:
		mov	AL,0
M001_L_CC2D:
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
M001_L_CC33:
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
M001_L_CC3B:
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_C952	endp
CO050_TEXT	ends

CO050_TEXT	segment byte public 'CODE'
		assume	cs:CO050_TEXT

BCC_TABLE_CC43	label	word
		dw	007D3h
		dw	00836h
		dw	00854h
		dw	00871h
		dw	007B7h
		dw	0088Eh
		dw	007B1h
		dw	007B1h
		dw	00788h
		dw	00717h
		dw	00726h
		dw	00726h
		dw	00726h
		dw	0070Ah
		dw	00726h
		dw	00694h
		dw	00694h
		dw	0064Bh

CO050_TEXT	ends

		extrn	X055_01:far
		extrn	X055_06:far
		extrn	X055_07:far
		extrn	X055_04:far
		extrn	X055_0E:far


CO050_TEXT	segment byte public 'CODE'
		assume	cs:CO050_TEXT,ds:DGROUP

M003_BCC_EXPR_SEGMENT	equ	639Ah
M003_BCC_DATA_78A4	equ	78A4h

BCC_NEAR_CC67	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E400h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	BX,word ptr [BP+4]
		mov	ES,word ptr DGROUP:M003_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[BX+5]
		jmp	short M003_L_CCDC
M003_L_CC87:
		db	09Ah
		dw	X055_07
		dw	seg X055_07
		cmp	AX,0D2h
		jle	short M003_L_CCA7
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E400h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
M003_L_CCA7:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_78A4
		cmp	word ptr ES:[SI],0
		je	short M003_L_CCB5
		mov	AL,0
		jmp	short M003_L_CCB7
M003_L_CCB5:
		mov	AL,80h
M003_L_CCB7:
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M003_BCC_DATA_78A4
		push	word ptr ES:[SI+2]
		db	0E8h
		dw	009B9h
		mov	ES,word ptr DGROUP:M003_BCC_DATA_78A4
		push	word ptr ES:[SI+4]
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	ES,word ptr DGROUP:M003_BCC_DATA_78A4
		mov	SI,word ptr ES:[SI]
M003_L_CCDC:
		or	SI,SI
		jne	short M003_L_CC87
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_CC67	endp
CO050_TEXT	ends


		extrn	X055_01:far
		extrn	X055_06:far
		extrn	X055_07:far
		extrn	X055_04:far
		extrn	X055_09:far
		extrn	X055_0E:far


CO050_TEXT	segment byte public 'CODE'
		assume	cs:CO050_TEXT,ds:DGROUP

M004_BCC_OPTION_16F2	equ	16F2h
M004_BCC_EXPR_SEGMENT	equ	639Ah
M004_BCC_DATA_78A4	equ	78A4h
M004_BCC_DATA_8164	equ	8164h

BCC_NEAR_CCEE	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		xor	DI,DI
		mov	word ptr [BP-4],0
		mov	BX,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M004_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[BX+5]
		jmp	short M004_L_CD1D
M004_L_CD0B:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_78A4
		push	word ptr ES:[SI+9]
		db	0E8h
		dw	0FC3Ch
		mov	ES,word ptr DGROUP:M004_BCC_DATA_78A4
		mov	SI,word ptr ES:[SI]
M004_L_CD1D:
		or	SI,SI
		jne	short M004_L_CD0B
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E200h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	BX,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M004_BCC_EXPR_SEGMENT
		mov	SI,word ptr ES:[BX+5]
		db	0E9h
		dw	0010Bh
M004_L_CD3D:
		cmp	word ptr [BP+4],1Eh
		jne	short M004_L_CD85
		mov	ES,word ptr DGROUP:M004_BCC_DATA_78A4
		cmp	word ptr ES:[SI+4],DI
		je	short M004_L_CD85
		mov	AX,word ptr ES:[SI+4]
		sub	AX,DI
		mov	word ptr [BP-2],AX
		mov	AL,byte ptr [BP-2]
		shl	AL,1
		shl	AL,1
		shl	AL,1
		sub	AL,byte ptr [BP-4]
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AL,0
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AL,0
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M004_BCC_DATA_78A4
		mov	DI,word ptr ES:[SI+4]
		mov	word ptr [BP-4],0
M004_L_CD85:
		db	09Ah
		dw	X055_07
		dw	seg X055_07
		cmp	AX,0D6h
		jle	short M004_L_CDA5
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E200h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
M004_L_CDA5:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_78A4
		cmp	byte ptr ES:[SI+7],0
		jne	short M004_L_CDD7
		cmp	word ptr ES:[SI],0
		je	short M004_L_CDBA
		mov	AL,0
		jmp	short M004_L_CDBC
M004_L_CDBA:
		mov	AL,80h
M004_L_CDBC:
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M004_BCC_DATA_78A4
		push	word ptr ES:[SI+9]
		db	0FFh,01Eh
		dw	8164h
		add	DI,AX
		mov	word ptr [BP-4],0
		jmp	short M004_L_CE21
M004_L_CDD7:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_78A4
		mov	AL,byte ptr ES:[SI+7]
		cbw
		mov	word ptr [BP-2],AX
		cmp	word ptr ES:[SI],0
		je	short M004_L_CDED
		mov	AL,0
		jmp	short M004_L_CDEF
M004_L_CDED:
		mov	AL,80h
M004_L_CDEF:
		mov	DL,byte ptr [BP-2]
		add	DL,AL
		push	DX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AX,word ptr [BP-2]
		add	word ptr [BP-4],AX
		cmp	byte ptr DGROUP:M004_BCC_OPTION_16F2,0
		je	short M004_L_CE1B
		cmp	word ptr [BP-4],10h
		jl	short M004_L_CE21
		inc	DI
		inc	DI
		mov	word ptr [BP-4],0
		jmp	short M004_L_CE21
M004_L_CE16:
		inc	DI
		sub	word ptr [BP-4],8
M004_L_CE1B:
		cmp	word ptr [BP-4],8
		jge	short M004_L_CE16
M004_L_CE21:
		mov	ES,word ptr DGROUP:M004_BCC_DATA_78A4
		push	word ptr ES:[SI+2]
		db	0E8h
		dw	00855h
		mov	ES,word ptr DGROUP:M004_BCC_DATA_78A4
		mov	BX,word ptr ES:[SI+9]
		mov	ES,word ptr DGROUP:M004_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	ES,word ptr DGROUP:M004_BCC_DATA_78A4
		mov	SI,word ptr ES:[SI]
M004_L_CE48:
		or	SI,SI
		je	short M004_L_CE4F
		db	0E9h
		dw	0FEEEh
M004_L_CE4F:
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	4
BCC_NEAR_CCEE	endp
CO050_TEXT	ends


		extrn	X055_06:far
		extrn	X055_09:far
		extrn	X055_0E:far
		extrn	X056_0E:far


CO050_TEXT	segment byte public 'CODE'
		assume	cs:CO050_TEXT,ds:DGROUP

M005_BCC_DATA_1714	equ	1714h
M005_BCC_EXPR_SEGMENT	equ	639Ah
M005_BCC_STMT_RECORD_SEG	equ	63C2h
M005_BCC_DATA_8894	equ	8894h

BCC_NEAR_CE60	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	SI,word ptr [BP+4]
		mov	byte ptr [BP-1],0
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M005_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[BX],12h
		jne	short M005_L_CEAF
		cmp	byte ptr DGROUP:M005_BCC_DATA_1714,0
		je	short M005_L_CE8B
		db	0E9h
		dw	00093h
M005_L_CE8B:
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		test	word ptr ES:[SI+6],20h
		je	short M005_L_CEAF
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M005_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[BX+7],4
		jne	short M005_L_CEAA
		mov	AL,98h
		jmp	short M005_L_CEAC
M005_L_CEAA:
		mov	AL,18h
M005_L_CEAC:
		or	byte ptr [BP-1],AL
M005_L_CEAF:
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+2]
		db	0E8h
		dw	007C7h
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M005_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	AL,byte ptr [BP-1]
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+0Ch]
		db	09Ah
		dw	X056_0E
		dw	seg X056_0E
		mov	DI,AX
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8894
		cmp	word ptr ES:[DI+2],0
		je	short M005_L_CEFC
		mov	BX,word ptr ES:[DI+2]
		mov	AX,word ptr ES:[BX+2]
		jmp	short M005_L_CEFE
M005_L_CEFC:
		xor	AX,AX
M005_L_CEFE:
		push	AX
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8894
		push	word ptr ES:[DI+4]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	ES,word ptr DGROUP:M005_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+0Eh]
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
M005_L_CF1E:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_CE60	endp
CO050_TEXT	ends


		extrn	BCC_FAR_AB12:far
		extrn	BCC_FAR_AB51:far
		extrn	BCC_FAR_B072:far
		extrn	X055_06:far


CO050_TEXT	segment byte public 'CODE'
		assume	cs:CO050_TEXT,ds:DGROUP

M006_BCC_DATA_1716	equ	1716h
M006_BCC_STMT_RECORD_SEG	equ	63C2h
M006_BCC_DATA_7832	equ	7832h

		public	X050_02
X050_02	label	far
BCC_NEAR_CF27	label	near
BCC_FAR_CF27	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		mov	SI,word ptr [BP+6]
		push	DS
		mov	AX,5F50h
		push	AX
		mov	ES,word ptr DGROUP:M006_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+2]
		mov	ES,word ptr DGROUP:M006_BCC_DATA_7832
		mov	BX,word ptr ES:[BX+4]
		push	word ptr [BX]
		mov	ES,word ptr DGROUP:M006_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+2]
		mov	ES,word ptr DGROUP:M006_BCC_DATA_7832
		push	word ptr ES:[BX+2]
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		mov	word ptr [BP-2],DX
		mov	word ptr [BP-4],AX
		mov	ES,word ptr DGROUP:M006_BCC_STMT_RECORD_SEG
		test	word ptr ES:[SI+6],400h
		je	short M006_L_CF9E
		push	word ptr [BP-2]
		push	word ptr [BP-4]
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		jmp	short M006_L_CF8C
M006_L_CF7C:
		les	BX,[BP-4]
		inc	word ptr [BP-4]
		mov	AL,byte ptr ES:[BX]
		cbw
		push	AX
		db	09Ah
		dw	BCC_FAR_AB51
		dw	seg BCC_FAR_AB51
M006_L_CF8C:
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		les	BX,[BP-4]
		cmp	byte ptr ES:[BX],0
		jne	short M006_L_CF7C
		db	0E9h
		dw	00080h
M006_L_CF9E:
		mov	ES,word ptr DGROUP:M006_BCC_STMT_RECORD_SEG
		test	word ptr ES:[SI+6],2000h
		je	short M006_L_CFDB
		push	word ptr [BP-2]
		push	word ptr [BP-4]
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		inc	AL
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AL,40h
		jmp	short M006_L_CFCA
M006_L_CFC1:
		les	BX,[BP-4]
		inc	word ptr [BP-4]
		mov	AL,byte ptr ES:[BX]
M006_L_CFCA:
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		les	BX,[BP-4]
		cmp	byte ptr ES:[BX],0
		jne	short M006_L_CFC1
		jmp	short M006_L_D01E
M006_L_CFDB:
		cmp	byte ptr DGROUP:M006_BCC_DATA_1716,0
		je	short M006_L_CFF9
		push	word ptr [BP-2]
		push	word ptr [BP-4]
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		inc	AL
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AL,5Fh
		jmp	short M006_L_D00F
M006_L_CFF9:
		push	word ptr [BP-2]
		push	word ptr [BP-4]
		db	09Ah
		dw	BCC_FAR_AB12
		dw	seg BCC_FAR_AB12
		jmp	short M006_L_D00F
M006_L_D006:
		les	BX,[BP-4]
		inc	word ptr [BP-4]
		mov	AL,byte ptr ES:[BX]
M006_L_D00F:
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		les	BX,[BP-4]
		cmp	byte ptr ES:[BX],0
		jne	short M006_L_D006
M006_L_D01E:
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_CF27	endp
CO050_TEXT	ends


		extrn	X055_01:far
		extrn	X055_06:far
		extrn	X055_04:far
		extrn	X055_0E:far


CO050_TEXT	segment byte public 'CODE'
		assume	cs:CO050_TEXT,ds:DGROUP

M007_BCC_DATA_8664	equ	8664h

		public	X050_04
X050_04	label	far
BCC_FAR_D025	proc	far
		push	BP
		mov	BP,SP
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E500h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	AL,DGROUP:M007_BCC_DATA_8664
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		push	word ptr [BP+6]
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		pop	BP
		retf	2
BCC_FAR_D025	endp
CO050_TEXT	ends


		extrn	X035_06:far
		extrn	X055_01:far
		extrn	X055_06:far
		extrn	X055_04:far
		extrn	X055_09:far
		extrn	X055_0E:far
		extrn	X056_0E:far


CO050_TEXT	segment byte public 'CODE'
		assume	cs:CO050_TEXT,ds:DGROUP

M008_BCC_DATA_1714	equ	1714h
M008_BCC_EXPR_SEGMENT	equ	639Ah
M008_BCC_STMT_RECORD_SEG	equ	63C2h
M008_BCC_DATA_782A	equ	782Ah
M008_BCC_DATA_8894	equ	8894h

		public	X050_03
X050_03	label	far
BCC_FAR_D053	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		cmp	word ptr [BP+6],-2
		jne	short M008_L_D071
		mov	AL,DGROUP:M008_BCC_DATA_1714
		cbw
		or	AX,AX
		je	short M008_L_D06B
		db	0E9h
		dw	00241h
M008_L_D06B:
		db	0E8h
		dw	00378h
		db	0E9h
		dw	0023Bh
M008_L_D071:
		mov	BX,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M008_BCC_DATA_782A
		mov	SI,word ptr ES:[BX+6]
		jmp	short M008_L_D0D2
M008_L_D07E:
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],5
		jne	short M008_L_D099
		test	word ptr ES:[SI+6],1000h
		jne	short M008_L_D099
		test	word ptr ES:[SI+6],0C0h
		je	short M008_L_D0CB
M008_L_D099:
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],2
		je	short M008_L_D0CB
		cmp	byte ptr ES:[SI+5],3
		je	short M008_L_D0CB
		cmp	byte ptr ES:[SI+5],9
		je	short M008_L_D0CB
		cmp	word ptr ES:[SI+2],0
		je	short M008_L_D0CB
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		cmp	word ptr ES:[SI+8],0
		je	short M008_L_D0CB
		push	word ptr ES:[SI+8]
		db	0E8h
		dw	0F887h
M008_L_D0CB:
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M008_L_D0D2:
		or	SI,SI
		jne	short M008_L_D07E
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E600h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	BX,word ptr [BP+6]
		mov	ES,word ptr DGROUP:M008_BCC_DATA_782A
		mov	SI,word ptr ES:[BX+6]
		mov	word ptr [BP-2],1
		db	0E9h
		dw	00195h
M008_L_D0F7:
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],5
		jne	short M008_L_D115
		test	word ptr ES:[SI+6],1000h
		jne	short M008_L_D115
		test	word ptr ES:[SI+6],0C0h
		jne	short M008_L_D115
		db	0E9h
		dw	00170h
M008_L_D115:
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		cmp	word ptr ES:[SI+8],0
		jne	short M008_L_D123
		db	0E9h
		dw	00162h
M008_L_D123:
		cmp	word ptr ES:[SI+2],0
		jne	short M008_L_D12D
		db	0E9h
		dw	00158h
M008_L_D12D:
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],2
		jne	short M008_L_D13B
		db	0E9h
		dw	0014Ah
M008_L_D13B:
		cmp	byte ptr ES:[SI+5],3
		jne	short M008_L_D145
		db	0E9h
		dw	00140h
M008_L_D145:
		cmp	byte ptr ES:[SI+5],9
		jne	short M008_L_D14F
		db	0E9h
		dw	00136h
M008_L_D14F:
		test	word ptr [BP-2],3Fh
		jne	short M008_L_D171
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E600h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	word ptr [BP-2],1
M008_L_D171:
		inc	word ptr [BP-2]
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+2]
		db	0E8h
		dw	00502h
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M008_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		mov	AL,byte ptr ES:[SI+5]
		mov	AH,0
		sub	AX,4
		mov	BX,AX
		cmp	BX,7
		jbe	short M008_L_D1AB
		db	0E9h
		dw	000DAh
M008_L_D1AB:
		shl	BX,1
		db	02Eh,0FFh,0A7h
		dw	0F64h
		mov	AL,0
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+0Ch]
		db	09Ah
		dw	X056_0E
		dw	seg X056_0E
		mov	DI,AX
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8894
		cmp	word ptr ES:[DI+2],0
		je	short M008_L_D1DE
		mov	BX,word ptr ES:[DI+2]
		mov	AX,word ptr ES:[BX+2]
		jmp	short M008_L_D1E0
M008_L_D1DE:
		xor	AX,AX
M008_L_D1E0:
		push	AX
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	ES,word ptr DGROUP:M008_BCC_DATA_8894
		push	word ptr ES:[DI+4]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+0Eh]
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		db	0E9h
		dw	00082h
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		test	word ptr ES:[SI+6],1000h
		je	short M008_L_D227
		mov	AL,4
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		mov	AL,byte ptr ES:[SI+0Ch]
		push	AX
		db	09Ah
		dw	X035_06
		dw	seg X035_06
		jmp	short M008_L_D27F
M008_L_D227:
		mov	AL,2
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+0Eh]
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		jmp	short M008_L_D285
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		test	word ptr ES:[SI+6],1000h
		je	short M008_L_D262
		mov	AL,0Ch
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		mov	AL,byte ptr ES:[SI+0Ch]
		push	AX
		db	09Ah
		dw	X035_06
		dw	seg X035_06
		jmp	short M008_L_D27F
M008_L_D262:
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+0Eh]
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		jmp	short M008_L_D285
		mov	AL,6
		jmp	short M008_L_D27F
		mov	AL,7
M008_L_D27F:
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
M008_L_D285:
		mov	ES,word ptr DGROUP:M008_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M008_L_D28C:
		or	SI,SI
		je	short M008_L_D293
		db	0E9h
		dw	0FE64h
M008_L_D293:
		cmp	word ptr [BP-2],1
		jle	short M008_L_D2A1
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
M008_L_D2A1:
		mov	AL,DGROUP:M008_BCC_DATA_1714
		cbw
		or	AX,AX
		jne	short M008_L_D2AC
		db	0E8h
		dw	0013Ah
M008_L_D2AC:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	2
BCC_FAR_D053	endp
CO050_TEXT	ends

CO050_TEXT	segment byte public 'CODE'
		assume	cs:CO050_TEXT

BCC_TABLE_D2B4	label	word
		dw	00E62h
		dw	00EB3h
		dw	00EEEh
		dw	00F35h
		dw	00F29h
		dw	00F35h
		dw	00F35h
		dw	00F2Dh

CO050_TEXT	ends

		extrn	X055_01:far
		extrn	X055_06:far
		extrn	X055_04:far
		extrn	X055_09:far
		extrn	X055_0E:far


CO050_TEXT	segment byte public 'CODE'
		assume	cs:CO050_TEXT,ds:DGROUP

M00A_BCC_EXPR_SEGMENT	equ	639Ah
M00A_BCC_STMT_RECORD_SEG	equ	63C2h
M00A_BCC_DATA_866E	equ	866Eh
M00A_BCC_DATA_8672	equ	8672h
M00A_BCC_DATA_86EC	equ	86ECh
M00A_BCC_DATA_86F0	equ	86F0h

		public	X050_01
X050_01	label	far
BCC_FAR_D2C4	proc	far
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	SI,2
		jmp	short M00A_L_D2F9
M00A_L_D2CE:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		cmp	byte ptr ES:[SI+0Dh],6
		jne	short M00A_L_D2F6
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M00A_BCC_STMT_RECORD_SEG
		cmp	word ptr ES:[BX+2],0
		je	short M00A_L_D2F6
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		push	word ptr ES:[SI+0Bh]
		db	0E8h
		dw	0F65Ch
M00A_L_D2F6:
		add	SI,1Dh
M00A_L_D2F9:
		cmp	SI,word ptr DGROUP:M00A_BCC_DATA_8672
		jc	short M00A_L_D2CE
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E600h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	DI,1
		mov	SI,word ptr DGROUP:M00A_BCC_DATA_8672
		db	0E9h
		dw	000B6h
M00A_L_D317:
		sub	SI,1Dh
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		cmp	byte ptr ES:[SI+0Dh],6
		je	short M00A_L_D328
		db	0E9h
		dw	000A5h
M00A_L_D328:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M00A_BCC_STMT_RECORD_SEG
		cmp	word ptr ES:[BX+2],0
		jne	short M00A_L_D33D
		db	0E9h
		dw	00090h
M00A_L_D33D:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		mov	AX,word ptr ES:[SI+2]
		cmp	AX,word ptr DGROUP:M00A_BCC_DATA_86EC
		je	short M00A_L_D34E
		db	0E9h
		dw	0007Fh
M00A_L_D34E:
		test	DI,3Fh
		jne	short M00A_L_D36D
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E600h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	DI,1
M00A_L_D36D:
		inc	DI
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		mov	BX,word ptr ES:[SI]
		mov	ES,word ptr DGROUP:M00A_BCC_STMT_RECORD_SEG
		push	word ptr ES:[BX+2]
		db	0E8h
		dw	00301h
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		mov	BX,word ptr ES:[SI+0Bh]
		mov	ES,word ptr DGROUP:M00A_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[BX],9
		jne	short M00A_L_D3A3
		cmp	word ptr DGROUP:M00A_BCC_DATA_86F0,0
		jne	short M00A_L_D3A3
		mov	AL,0Fh
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		jmp	short M00A_L_D3B8
M00A_L_D3A3:
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		mov	BX,word ptr ES:[SI+0Bh]
		mov	ES,word ptr DGROUP:M00A_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
M00A_L_D3B8:
		mov	AL,0Ah
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	ES,word ptr DGROUP:M00A_BCC_DATA_866E
		push	word ptr ES:[SI+0Fh]
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
M00A_L_D3CD:
		cmp	SI,2
		jbe	short M00A_L_D3D5
		db	0E9h
		dw	0FF42h
M00A_L_D3D5:
		cmp	DI,1
		jle	short M00A_L_D3E2
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
M00A_L_D3E2:
		pop	DI
		pop	SI
		pop	BP
		retf
BCC_FAR_D2C4	endp
CO050_TEXT	ends


		extrn	X055_01:far
		extrn	X055_04:far
		extrn	X055_0E:far


CO050_TEXT	segment byte public 'CODE'
		assume	cs:CO050_TEXT,ds:DGROUP

M00B_BCC_DATA_8894	equ	8894h
M00B_BCC_DATA_88A2	equ	88A2h

BCC_NEAR_D3E6	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		mov	BX,word ptr DGROUP:M00B_BCC_DATA_88A2
		mov	ES,word ptr DGROUP:M00B_BCC_DATA_8894
		mov	AX,word ptr ES:[BX+0Ch]
		mov	word ptr [BP-2],AX
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E700h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		push	word ptr [BP-2]
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		mov	SP,BP
		pop	BP
		dec	BP
		ret
BCC_NEAR_D3E6	endp
CO050_TEXT	ends


		extrn	X055_01:far
		extrn	X055_06:far
		extrn	X055_04:far
		extrn	X055_09:far
		extrn	X055_0E:far


CO050_TEXT	segment byte public 'CODE'
		assume	cs:CO050_TEXT,ds:DGROUP

M00C_BCC_EXPR_SEGMENT	equ	639Ah
M00C_BCC_STMT_RECORD_SEG	equ	63C2h
M00C_BCC_DATA_782A	equ	782Ah
M00C_BCC_DATA_85F4	equ	85F4h

		public	X050_05
X050_05	label	far
BCC_FAR_D41E	proc	far
		push	BP
		mov	BP,SP
		dec	SP
		dec	SP
		push	SI
		push	DI
		mov	BX,word ptr DGROUP:M00C_BCC_DATA_85F4
		mov	ES,word ptr DGROUP:M00C_BCC_DATA_782A
		mov	AX,word ptr ES:[BX+6]
		mov	word ptr [BP-2],AX
		mov	SI,word ptr [BP-2]
		db	0E9h
		dw	000E7h
M00C_L_D43A:
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],2
		jne	short M00C_L_D487
		test	word ptr ES:[SI+6],80h
		je	short M00C_L_D487
		push	word ptr ES:[SI+8]
		db	0E8h
		dw	0F4FEh
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0EB00h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		push	SI
		push	CS
		db	0E8h
		dw	0FAC0h
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	0E9h
		dw	00093h
M00C_L_D487:
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],1
		jne	short M00C_L_D508
		push	word ptr ES:[SI+8]
		db	0E8h
		dw	0F4B9h
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0EC00h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		push	SI
		push	CS
		db	0E8h
		dw	0FA7Bh
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[BX],12h
		jne	short M00C_L_D4F6
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		test	word ptr ES:[SI+6],20h
		je	short M00C_L_D4F6
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
		cmp	byte ptr ES:[BX+7],4
		jne	short M00C_L_D4F2
		mov	AL,98h
		jmp	short M00C_L_D4F4
M00C_L_D4F2:
		mov	AL,18h
M00C_L_D4F4:
		jmp	short M00C_L_D4F8
M00C_L_D4F6:
		mov	AL,0
M00C_L_D4F8:
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		jmp	short M00C_L_D51A
M00C_L_D508:
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],3
		jne	short M00C_L_D51A
		push	word ptr ES:[SI+8]
		db	0E8h
		dw	0F438h
M00C_L_D51A:
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M00C_L_D521:
		or	SI,SI
		je	short M00C_L_D528
		db	0E9h
		dw	0FF12h
M00C_L_D528:
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E600h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	DI,1
		mov	SI,word ptr [BP-2]
		jmp	short M00C_L_D574
M00C_L_D53E:
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],3
		jne	short M00C_L_D56D
		test	DI,3Fh
		jne	short M00C_L_D568
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E600h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	DI,1
M00C_L_D568:
		push	SI
		db	0E8h
		dw	0F8F4h
		inc	DI
M00C_L_D56D:
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M00C_L_D574:
		or	SI,SI
		jne	short M00C_L_D53E
		mov	SI,word ptr [BP-2]
		jmp	short M00C_L_D5E6
M00C_L_D57D:
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],8
		jne	short M00C_L_D5DF
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[BX+1],0
		je	short M00C_L_D5DF
		test	DI,3Fh
		jne	short M00C_L_D5B6
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E600h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	DI,1
M00C_L_D5B6:
		inc	DI
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+2]
		db	0E8h
		dw	000BFh
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	AL,6
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
M00C_L_D5DF:
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M00C_L_D5E6:
		or	SI,SI
		jne	short M00C_L_D57D
		mov	SI,word ptr [BP-2]
		jmp	short M00C_L_D66A
M00C_L_D5EF:
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		cmp	byte ptr ES:[SI+5],0Bh
		jne	short M00C_L_D663
		cmp	word ptr ES:[SI+8],0
		je	short M00C_L_D663
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
		cmp	word ptr ES:[BX+1],0
		je	short M00C_L_D663
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		cmp	word ptr ES:[SI+2],0
		je	short M00C_L_D663
		test	DI,3Fh
		jne	short M00C_L_D63A
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
		db	09Ah
		dw	X055_01
		dw	seg X055_01
		mov	AX,0E600h
		push	AX
		db	09Ah
		dw	X055_0E
		dw	seg X055_0E
		mov	DI,1
M00C_L_D63A:
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		push	word ptr ES:[SI+2]
		db	0E8h
		dw	0003Ch
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		mov	BX,word ptr ES:[SI+8]
		mov	ES,word ptr DGROUP:M00C_BCC_EXPR_SEGMENT
		push	word ptr ES:[BX+1]
		db	09Ah
		dw	X055_09
		dw	seg X055_09
		mov	AL,7
		push	AX
		db	09Ah
		dw	X055_06
		dw	seg X055_06
		inc	DI
M00C_L_D663:
		mov	ES,word ptr DGROUP:M00C_BCC_STMT_RECORD_SEG
		mov	SI,word ptr ES:[SI]
M00C_L_D66A:
		or	SI,SI
		jne	short M00C_L_D5EF
		cmp	DI,1
		jle	short M00C_L_D67B
		mov	AL,88h
		push	AX
		db	09Ah
		dw	X055_04
		dw	seg X055_04
M00C_L_D67B:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf
BCC_FAR_D41E	endp
CO050_TEXT	ends


		extrn	BCC_FAR_B072:far
		extrn	X055_03:far


CO050_TEXT	segment byte public 'CODE'
		assume	cs:CO050_TEXT,ds:DGROUP

M00D_BCC_DATA_7832	equ	7832h

BCC_NEAR_D681	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,word ptr [BP+4]
		push	DS
		mov	AX,5F50h
		push	AX
		mov	ES,word ptr DGROUP:M00D_BCC_DATA_7832
		mov	BX,word ptr ES:[SI+4]
		push	word ptr [BX]
		push	word ptr ES:[SI+2]
		db	09Ah
		dw	BCC_FAR_B072
		dw	seg BCC_FAR_B072
		push	DS
		mov	AX,5F50h
		push	AX
		db	09Ah
		dw	X055_03
		dw	seg X055_03
		pop	SI
		pop	BP
		dec	BP
		ret	2
BCC_NEAR_D681	endp
CO050_TEXT	ends

; END C100UNIT
		end
