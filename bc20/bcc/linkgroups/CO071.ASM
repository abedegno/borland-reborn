		public	X071_00
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1dc8_b159
; BEGIN C101UNIT (listing ovr_1dc8_b159:1590)

CO071_TEXT	segment byte public 'CODE'
		assume	cs:CO071_TEXT,ds:DGROUP

M000_BCC_DATA_87C2	equ	87C2h


BCC_NEAR_1590	label	near
STAOV159	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		mov	SI,8762h
		jmp	short M000_L_15A1
M000_L_159A:
		mov	word ptr [SI],0
		add	SI,4
M000_L_15A1:
		cmp	SI,879Eh
		jbe	short M000_L_159A
		mov	word ptr DGROUP:M000_BCC_DATA_87C2,0
		pop	SI
		pop	BP
		dec	BP
		ret
STAOV159	endp
CO071_TEXT	ends


CO071_TEXT	segment byte public 'CODE'
		assume	cs:CO071_TEXT,ds:DGROUP



BCC_NEAR_15B1	label	near
STAOV15A	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+4]
		mov	SI,8762h
		jmp	short M001_L_15CE
M001_L_15BF:
		test	DI,1
		je	short M001_L_15C9
		mov	word ptr [SI],0
M001_L_15C9:
		add	SI,4
		shr	DI,1
M001_L_15CE:
		or	DI,DI
		jne	short M001_L_15BF
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	2
STAOV15A	endp
CO071_TEXT	ends


CO071_TEXT	segment byte public 'CODE'
		assume	cs:CO071_TEXT,ds:DGROUP

M002_BCC_DATA_866E	equ	866Eh
M002_BCC_DATA_8680	equ	8680h
M002_BCC_DATA_8698	equ	8698h
M002_BCC_DATA_87C2	equ	87C2h


BCC_NEAR_15D9	label	near
STAOV15B	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		cmp	word ptr [BP+8],0
		jne	short M002_L_15E8
		db	0E9h
		dw	0011Ah
M002_L_15E8:
		mov	AX,word ptr [BP+8]
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		mov	AX,word ptr [BP+6]
		shl	AX,1
		shl	AX,1
		mov	DI,AX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		cmp	AL,byte ptr ES:[DI]
		je	short M002_L_1609
		db	0E9h
		dw	000F9h
M002_L_1609:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,400h
		or	AX,0
		je	short M002_L_1628
		db	0E9h
		dw	000DAh
M002_L_1628:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,1
		or	AX,0
		jne	short M002_L_1647
		db	0E9h
		dw	00080h
M002_L_1647:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		cmp	AX,word ptr ES:[DI]
		jne	short M002_L_165D
		mov	AX,word ptr ES:[SI+2]
		cmp	AX,word ptr ES:[DI+2]
		je	short M002_L_1660
M002_L_165D:
		db	0E9h
		dw	000A2h
M002_L_1660:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,8
		or	AX,0
		je	short M002_L_1682
		mov	AX,1
		db	0E9h
		dw	00082h
M002_L_1682:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		mov	CX,AX
		mov	BX,CX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_866E
		mov	AX,word ptr ES:[BX+19h]
		cmp	AX,word ptr [BP+4]
		jbe	short M002_L_169C
		jmp	short M002_L_1702
M002_L_169C:
		mov	BX,CX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_866E
		test	byte ptr ES:[BX+0Eh],4
		je	short M002_L_16B3
		mov	AX,DGROUP:M002_BCC_DATA_87C2
		cmp	AX,word ptr [BP+4]
		jbe	short M002_L_16B3
		jmp	short M002_L_1702
M002_L_16B3:
		mov	BX,CX
		mov	ES,word ptr DGROUP:M002_BCC_DATA_866E
		test	byte ptr ES:[BX+0Eh],80h
		je	short M002_L_16C2
		jmp	short M002_L_1702
M002_L_16C2:
		mov	AX,1
		jmp	short M002_L_1704
M002_L_16C7:
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,8
		or	AX,0
		je	short M002_L_1702
		mov	ES,word ptr DGROUP:M002_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		mov	DX,word ptr ES:[SI]
		cmp	AX,word ptr ES:[DI+2]
		jne	short M002_L_16FE
		cmp	DX,word ptr ES:[DI]
		jne	short M002_L_16FE
		mov	AX,1
		jmp	short M002_L_1700
M002_L_16FE:
		xor	AX,AX
M002_L_1700:
		jmp	short M002_L_1704
M002_L_1702:
		xor	AX,AX
M002_L_1704:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	6
STAOV15B	endp
CO071_TEXT	ends


CO071_TEXT	segment byte public 'CODE'
		assume	cs:CO071_TEXT,ds:DGROUP

M003_BCC_DATA_8666	equ	8666h
M003_BCC_DATA_866A	equ	866Ah
M003_BCC_DATA_8680	equ	8680h


BCC_NEAR_170B	label	near
STAOV15C	proc	near
		inc	BP
		push	BP
		mov	BP,SP
		push	SI
		push	DI
		mov	DI,word ptr [BP+4]
		mov	SI,word ptr DGROUP:M003_BCC_DATA_866A
		jmp	short M003_L_175B
M003_L_171A:
		sub	SI,9
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8666
		cmp	word ptr ES:[SI+3],DI
		ja	short M003_L_175B
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8666
		cmp	word ptr ES:[SI+5],DI
		jne	short M003_L_1747
		cmp	byte ptr ES:[SI],6
		jne	short M003_L_173D
		mov	DI,word ptr ES:[SI+7]
		jmp	short M003_L_175B
M003_L_173D:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8666
		mov	AL,byte ptr ES:[SI+2]
		jmp	short M003_L_176D
M003_L_1747:
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8666
		cmp	byte ptr ES:[SI],6
		jne	short M003_L_175B
		cmp	word ptr ES:[SI+7],DI
		jne	short M003_L_175B
		mov	DI,word ptr ES:[SI+5]
M003_L_175B:
		or	SI,SI
		jne	short M003_L_171A
		mov	BX,DI
		shl	BX,1
		shl	BX,1
		mov	ES,word ptr DGROUP:M003_BCC_DATA_8680
		mov	AL,byte ptr ES:[BX+2]
M003_L_176D:
		pop	DI
		pop	SI
		pop	BP
		dec	BP
		ret	2
STAOV15C	endp
CO071_TEXT	ends




CO071_TEXT	segment byte public 'CODE'
		assume	cs:CO071_TEXT,ds:DGROUP

M004_BCC_DATA_8680	equ	8680h

BCC_NEAR_1774	label	near
STAOV15D	proc	far
		push	BP
		mov	BP,SP
		sub	SP,4
		push	SI
		push	DI
		mov	BX,word ptr [BP+6]
		shl	BX,1
		mov	AX,word ptr [BX+4F7Ah]
		mov	word ptr [BP-2],AX
		mov	SI,8762h
		mov	byte ptr [BP-3],0
		jmp	short M004_L_17D8
M004_L_1791:
		test	word ptr [BP-2],1
		je	short M004_L_17CF
		cmp	word ptr [SI],0
		je	short M004_L_17CF
		push	word ptr [SI]
		push	word ptr [BP+8]
		push	word ptr [SI+2]
		db	0E8h
		dw	0FE31h
		or	AX,AX
		je	short M004_L_17CF
		mov	AX,word ptr [BP+8]
		shl	AX,1
		shl	AX,1
		mov	DI,AX
		push	word ptr [BP+8]
		db	0E8h
		dw	0FF50h
		mov	ES,word ptr DGROUP:M004_BCC_DATA_8680
		mov	byte ptr ES:[DI+2],AL
		and	byte ptr ES:[DI+1],1
		or	byte ptr ES:[DI+1],40h
		jmp	short M004_L_17DE
M004_L_17CF:
		add	SI,4
		inc	byte ptr [BP-3]
		shr	word ptr [BP-2],1
M004_L_17D8:
		cmp	word ptr [BP-2],0
		jne	short M004_L_1791
M004_L_17DE:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf	4
STAOV15D	endp
CO071_TEXT	ends


		extrn	X061_01:far


CO071_TEXT	segment byte public 'CODE'
		assume	cs:CO071_TEXT,ds:DGROUP

M005_BCC_DATA_1704	equ	1704h
M005_BCC_DATA_8654	equ	8654h
M005_BCC_DATA_8666	equ	8666h
M005_BCC_DATA_866A	equ	866Ah
M005_BCC_DATA_866E	equ	866Eh
M005_BCC_DATA_8672	equ	8672h
M005_BCC_DATA_8680	equ	8680h
M005_BCC_DATA_8698	equ	8698h
M005_BCC_DATA_86E0	equ	86E0h
M005_BCC_DATA_8760	equ	8760h
M005_BCC_DATA_87C2	equ	87C2h

		public	X071_00
X071_00	label	far
STAOV15E	proc	far
		push	BP
		mov	BP,SP
		sub	SP,16h
		push	SI
		push	DI
		db	0E8h
		dw	0FD9Fh
		mov	word ptr DGROUP:M005_BCC_DATA_8760,0
		mov	word ptr [BP-8],2
		jmp	short M005_L_180F
M005_L_17FE:
		mov	BX,word ptr [BP-8]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_866E
		mov	word ptr ES:[BX+19h],0
		add	word ptr [BP-8],1Dh
M005_L_180F:
		mov	AX,word ptr [BP-8]
		cmp	AX,word ptr DGROUP:M005_BCC_DATA_8672
		jc	short M005_L_17FE
		mov	AX,DGROUP:M005_BCC_DATA_86E0
		db	0E9h
		dw	003CBh
M005_L_181E:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8654
		test	word ptr ES:[BX+1Ch],10h
		je	short M005_L_1830
		db	0E8h
		dw	0FD60h
M005_L_1830:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8654
		mov	BX,word ptr [BP-2]
		cmp	word ptr ES:[BX],5
		jne	short M005_L_1840
		db	0E8h
		dw	0FD50h
M005_L_1840:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8654
		mov	BX,word ptr [BP-2]
		cmp	word ptr ES:[BX],0
		je	short M005_L_1856
		cmp	word ptr ES:[BX],4
		je	short M005_L_1856
		db	0E9h
		dw	00388h
M005_L_1856:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+4]
		mov	word ptr [BP-0Ah],AX
		mov	AX,word ptr ES:[BX+6]
		mov	word ptr [BP-10h],AX
		mov	AX,word ptr [BP-0Ah]
		shl	AX,1
		shl	AX,1
		mov	SI,AX
		mov	DI,word ptr ES:[BX+0Ah]
		db	0E9h
		dw	0035Ah
M005_L_187B:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8666
		mov	AL,byte ptr ES:[DI]
		mov	AH,0
		cmp	AX,2
		je	short M005_L_18BC
		cmp	AX,3
		je	short M005_L_18BC
		cmp	AX,6
		je	short M005_L_1895
		jmp	short M005_L_18D1
M005_L_1895:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8666
		mov	AX,word ptr ES:[DI+5]
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-4],AX
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		mov	AL,byte ptr ES:[BX+2]
		cbw
		shl	AX,1
		shl	AX,1
		mov	BX,AX
		mov	word ptr [BX+8762h],0
M005_L_18BC:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8666
		mov	AL,byte ptr ES:[DI+2]
		cbw
		shl	AX,1
		shl	AX,1
		mov	BX,AX
		mov	word ptr [BX+8762h],0
M005_L_18D1:
		add	DI,9
M005_L_18D4:
		cmp	DI,word ptr DGROUP:M005_BCC_DATA_866A
		jnc	short M005_L_18E7
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8666
		mov	AX,word ptr ES:[DI+3]
		cmp	AX,word ptr [BP-0Ah]
		je	short M005_L_187B
M005_L_18E7:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		test	byte ptr ES:[SI+1],41h
		je	short M005_L_18F5
		db	0E9h
		dw	002D7h
M005_L_18F5:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		mov	AL,byte ptr ES:[SI]
		mov	AH,0
		mov	DX,13h
		imul	DX
		add	AX,3F98h
		mov	word ptr [BP-14h],AX
		cmp	byte ptr ES:[SI+2],0FFh
		je	short M005_L_196E
		mov	AX,word ptr [BP-0Ah]
		mov	word ptr [BP-16h],AX
		push	word ptr [BP-0Ah]
		db	0E8h
		dw	0FDEFh
		cbw
		shl	AX,1
		shl	AX,1
		add	AX,8762h
		mov	word ptr [BP-12h],AX
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		cmp	byte ptr ES:[SI],97h
		jc	short M005_L_1941
		cmp	byte ptr ES:[SI],99h
		ja	short M005_L_1941
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		mov	word ptr [BP-16h],AX
M005_L_1941:
		mov	BX,word ptr [BP-12h]
		push	word ptr [BX]
		push	word ptr [BP-16h]
		push	word ptr [BX+2]
		db	0E8h
		dw	0FC8Ah
		or	AX,AX
		je	short M005_L_195E
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		or	byte ptr ES:[SI+1],40h
		jmp	short M005_L_19C7
M005_L_195E:
		mov	BX,word ptr [BP-12h]
		mov	AX,word ptr [BP-16h]
		mov	word ptr [BX],AX
		mov	AX,DGROUP:M005_BCC_DATA_8760
		mov	word ptr [BX+2],AX
		jmp	short M005_L_19C7
M005_L_196E:
		mov	BX,word ptr [BP-14h]
		mov	AX,word ptr [BX+3]
		and	AX,100h
		or	AX,0
		je	short M005_L_19C7
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		push	word ptr ES:[SI]
		db	09Ah
		dw	X061_01
		dw	seg X061_01
		mov	byte ptr [BP-15h],AL
		cmp	byte ptr [BP-15h],0FFh
		je	short M005_L_19C7
		cbw
		shl	AX,1
		shl	AX,1
		add	AX,8762h
		mov	word ptr [BP-12h],AX
		mov	BX,word ptr [BP-12h]
		push	word ptr [BX]
		push	word ptr [BP-0Ah]
		push	word ptr [BX+2]
		db	0E8h
		dw	0FC2Fh
		or	AX,AX
		je	short M005_L_19B9
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		or	byte ptr ES:[SI+1],40h
		jmp	short M005_L_19C7
M005_L_19B9:
		mov	BX,word ptr [BP-12h]
		mov	AX,word ptr [BP-0Ah]
		mov	word ptr [BX],AX
		mov	AX,DGROUP:M005_BCC_DATA_8760
		mov	word ptr [BX+2],AX
M005_L_19C7:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		test	byte ptr ES:[SI+1],2
		jne	short M005_L_19D5
		db	0E9h
		dw	00142h
M005_L_19D5:
		inc	word ptr DGROUP:M005_BCC_DATA_8760
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-4],AX
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		mov	BX,word ptr [BP-4]
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,1
		or	AX,0
		jne	short M005_L_1A09
		db	0E9h
		dw	0008Ch
M005_L_1A09:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		mov	BX,word ptr [BP-4]
		mov	AX,word ptr ES:[BX]
		mov	word ptr [BP-8],AX
		mov	BX,word ptr [BP-8]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_866E
		mov	AX,DGROUP:M005_BCC_DATA_8760
		mov	word ptr ES:[BX+19h],AX
		test	byte ptr ES:[BX+0Eh],2
		je	short M005_L_1A3C
		mov	AL,byte ptr ES:[BX+7]
		cbw
		shl	AX,1
		shl	AX,1
		mov	BX,AX
		mov	word ptr [BX+8762h],0
M005_L_1A3C:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		mov	word ptr [BP-0Eh],AX
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-6],AX
		mov	BX,word ptr [BP-14h]
		mov	AX,word ptr [BX+3]
		and	AX,4
		or	AX,0
		je	short M005_L_1AD8
		cmp	word ptr [BP-0Eh],0
		je	short M005_L_1AD8
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		cmp	byte ptr ES:[BX+2],0FFh
		je	short M005_L_1AD8
		push	word ptr [BP-0Eh]
		db	0E8h
		dw	0FC95h
		cbw
		shl	AX,1
		shl	AX,1
		add	AX,8762h
		mov	word ptr [BP-12h],AX
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		mov	BX,word ptr [BP-12h]
		mov	word ptr [BX],AX
		mov	AX,DGROUP:M005_BCC_DATA_8760
		mov	word ptr [BX+2],AX
		jmp	short M005_L_1AD8
M005_L_1A95:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		mov	BX,word ptr [BP-4]
		mov	AL,byte ptr ES:[BX]
		mov	AH,0
		mov	DX,13h
		imul	DX
		mov	BX,AX
		mov	AX,word ptr [BX+3F9Bh]
		and	AX,20h
		or	AX,0
		je	short M005_L_1ACA
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		mov	BX,word ptr [BP-4]
		mov	BX,word ptr ES:[BX]
		shl	BX,1
		shl	BX,1
		mov	word ptr [BX+8762h],0
		jmp	short M005_L_1AD8
M005_L_1ACA:
		mov	AL,DGROUP:M005_BCC_DATA_1704
		cbw
		or	AX,AX
		jne	short M005_L_1AD8
		mov	AX,DGROUP:M005_BCC_DATA_8760
		mov	DGROUP:M005_BCC_DATA_87C2,AX
M005_L_1AD8:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		mov	word ptr [BP-0Eh],AX
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-6],AX
		cmp	word ptr [BP-0Eh],0
		jne	short M005_L_1AF3
		db	0E9h
		dw	000ADh
M005_L_1AF3:
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		test	byte ptr ES:[BX+1],1
		jne	short M005_L_1B04
		db	0E9h
		dw	0009Ch
M005_L_1B04:
		push	word ptr [BP-0Eh]
		mov	BX,word ptr [BP-14h]
		mov	AL,byte ptr [BX+0Ah]
		mov	AH,0
		push	AX
		push	CS
		db	0E8h
		dw	0FC60h
		db	0E9h
		dw	00089h
M005_L_1B17:
		mov	BX,word ptr [BP-14h]
		mov	AX,word ptr [BX+3]
		and	AX,429h
		or	AX,0
		jne	short M005_L_1BA0
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		cmp	byte ptr ES:[SI],97h
		jc	short M005_L_1B35
		cmp	byte ptr ES:[SI],99h
		jbe	short M005_L_1BA0
M005_L_1B35:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		mov	AX,word ptr ES:[SI]
		mov	word ptr [BP-0Ch],AX
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-4],AX
		cmp	word ptr [BP-0Ch],0
		je	short M005_L_1B6A
		mov	BX,word ptr [BP-4]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		test	byte ptr ES:[BX+1],1
		je	short M005_L_1B6A
		push	word ptr [BP-0Ch]
		mov	BX,word ptr [BP-14h]
		mov	AL,byte ptr [BX+9]
		mov	AH,0
		push	AX
		push	CS
		db	0E8h
		dw	0FC0Ah
M005_L_1B6A:
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8698
		mov	AX,word ptr ES:[SI+2]
		mov	word ptr [BP-0Eh],AX
		shl	AX,1
		shl	AX,1
		mov	word ptr [BP-6],AX
		cmp	word ptr [BP-0Eh],0
		je	short M005_L_1BA0
		mov	BX,word ptr [BP-6]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8680
		test	byte ptr ES:[BX+1],1
		je	short M005_L_1BA0
		push	word ptr [BP-0Eh]
		mov	BX,word ptr [BP-14h]
		mov	AL,byte ptr [BX+0Ah]
		mov	AH,0
		push	AX
		push	CS
		db	0E8h
		dw	0FBD4h
M005_L_1BA0:
		mov	BX,word ptr [BP-14h]
		mov	AX,word ptr [BX+3]
		and	AX,400h
		or	AX,0
		je	short M005_L_1BB3
		db	0E8h
		dw	0F9DFh
		jmp	short M005_L_1BCC
M005_L_1BB3:
		mov	BX,word ptr [BP-14h]
		cmp	byte ptr [BX+0Ch],0
		je	short M005_L_1BCC
		mov	AL,byte ptr [BX+0Ch]
		mov	AH,0
		shl	AX,1
		mov	BX,AX
		push	word ptr [BX+4FDDh]
		db	0E8h
		dw	0F9E5h
M005_L_1BCC:
		inc	word ptr [BP-0Ah]
		dec	word ptr [BP-10h]
		add	SI,4
M005_L_1BD5:
		cmp	word ptr [BP-10h],0
		je	short M005_L_1BDE
		db	0E9h
		dw	0FCF6h
M005_L_1BDE:
		mov	BX,word ptr [BP-2]
		mov	ES,word ptr DGROUP:M005_BCC_DATA_8654
		mov	AX,word ptr ES:[BX+0Ch]
M005_L_1BE9:
		mov	word ptr [BP-2],AX
		cmp	word ptr [BP-2],0
		je	short M005_L_1BF5
		db	0E9h
		dw	0FC29h
M005_L_1BF5:
		pop	DI
		pop	SI
		mov	SP,BP
		pop	BP
		retf
STAOV15E	endp
CO071_TEXT	ends

; END C101UNIT
		end
