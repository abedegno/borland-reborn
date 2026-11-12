; Recovered FBOV far-pointer references
CO055_TEXT	segment byte public 'CODE'
CO055_TEXT	ends
		public	X041_00
		public	X041_01
		public	X041_02
		public	X041_03
		public	X041_04
		public	X041_05
		public	X041_06
		public	X041_07
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1ce0_8b20
; BEGIN C127UNIT (listing ovr_1ce0_8b20:B200)

		extrn	X055_05:far
		extrn	X055_06:far
		extrn	X055_03:far
		extrn	X055_0E:far


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

BCC_RN_8000_B200	label	near
BCC_NEAR_B200	label	near
BCC_TYPE_MEMCHECK	proc	far
	push	bp
	mov	bp,sp
	db	9Ah
	dw	X055_05
	dw	seg X055_05
	cmp	ax,0FA0h
	jle	short M000_@@RETURN
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	push	word ptr [bp+6]
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
M000_@@RETURN:
	pop	bp
	retf	2
BCC_TYPE_MEMCHECK	endp
CO041_TEXT	ends

; Target-qualified reference aliases (zero bytes)

		extrn	BCC_RD_A03E_B:byte
		extrn	BCC_HASH_SEG1:word
		extrn	BCC_HASH_SEG2:word
		extrn	BCC_TYPE_SEGMENT:word
		extrn	X02C_08:far
		extrn	BCC_RD_5EC6_W:word
		extrn	BCC_EXPR_SEGMENT:word
		extrn	X055_03:far
		extrn	X055_0E:far
		extrn	BCC_EXPR_LINKSEG:word
		extrn	BCC_MEMBER_SEGMENT:word
		extrn	BCC_OPTION_BYTE:byte
		extrn	X055_06:far
		extrn	BCC_RD_63A4_W:word
		extrn	BCC_DEBUG_NAME:byte
		extrn	BCC_DEBUG_BUILD:far
		extrn	X055_01:far
		extrn	X055_09:far
		extrn	X055_04:far


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

M001_BCC_HASH_HEADS	equ	78ACh

		public	X041_07
X041_07	label	far
BCC_SYMBOL_SWEEP	proc	far
	push	bp
	mov	bp,sp
	sub	sp,0Ch
	push	si
	push	di
	mov	word ptr [bp-2],0
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	jne	short M001_@@P1_INIT
	db	0E9h
	dw	000BBh
M001_@@P1_INIT:
	mov	word ptr [bp-4],0
	db	0E9h
	dw	000A9h
M001_@@P1_BUCKET:
	mov	bx,word ptr [bp-4]
	shl	bx,1
	mov	ax,word ptr [bx+M001_BCC_HASH_HEADS]
	db	0E9h
	dw	0008Eh
M001_@@P1_CHAIN:
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr [bp-6]
	mov	di,word ptr es:[bx]
	jmp	short M001_@@P1_DI_TEST
M001_@@P1_ITEM:
	mov	si,di
M001_@@P1_NESTED:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,0Bh
	jne	short M001_@@P1_AFTER_EMIT
	push	word ptr es:[si+4]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	or	ax,ax
	je	short M001_@@P1_AFTER_EMIT
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[si+4]
	push	word ptr DGROUP:BCC_RD_5EC6_W
	nop
	push	cs
	db	0E8h
	dw	005F3h
M001_@@P1_AFTER_EMIT:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M001_@@P1_NEXT
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,8
	je	short M001_@@P1_NEXT
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	word ptr es:[bx],12h
	jne	short M001_@@P1_NEXT
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+13h]
	mov	si,ax
	or	ax,ax
	jne	short M001_@@P1_NESTED
M001_@@P1_NEXT:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	di,word ptr es:[di]
M001_@@P1_DI_TEST:
	or	di,di
	jne	short M001_@@P1_ITEM
	mov	es,word ptr DGROUP:BCC_HASH_SEG2
	mov	bx,word ptr [bp-6]
	mov	ax,word ptr es:[bx]
M001_@@P1_HAVE_BUCKET:
	mov	word ptr [bp-6],ax
	cmp	word ptr [bp-6],0
	je	short M001_@@P1_NEXT_BUCKET
	db	0E9h
	dw	0FF66h
M001_@@P1_NEXT_BUCKET:
	inc	word ptr [bp-4]
M001_@@P1_BUCKET_TEST:
	cmp	word ptr [bp-4],400h
	jge	short M001_@@P2_INIT
	db	0E9h
	dw	0FF4Dh
M001_@@P2_INIT:
	mov	word ptr [bp-4],0
	db	0E9h
	dw	000ACh
M001_@@P2_BUCKET:
	mov	bx,word ptr [bp-4]
	shl	bx,1
	mov	ax,word ptr [bx+M001_BCC_HASH_HEADS]
	db	0E9h
	dw	00091h
M001_@@P2_CHAIN:
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr [bp-6]
	mov	di,word ptr es:[bx]
	jmp	short M001_@@P2_DI_TEST
M001_@@P2_ITEM:
	mov	si,di
M001_@@P2_NESTED:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	mov	word ptr [bp-8],ax
	cmp	word ptr [bp-8],3
	je	short M001_@@P2_EMIT
	cmp	word ptr [bp-8],0Eh
	je	short M001_@@P2_EMIT
	cmp	word ptr [bp-8],9
	jne	short M001_@@P2_AFTER_EMIT
M001_@@P2_EMIT:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[si+4]
	push	word ptr DGROUP:BCC_RD_5EC6_W
	nop
	push	cs
	db	0E8h
	dw	00535h
M001_@@P2_AFTER_EMIT:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M001_@@P2_NEXT
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,8
	je	short M001_@@P2_NEXT
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	word ptr es:[bx],12h
	jne	short M001_@@P2_NEXT
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+13h]
	mov	si,ax
	or	ax,ax
	jne	short M001_@@P2_NESTED
M001_@@P2_NEXT:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	di,word ptr es:[di]
M001_@@P2_DI_TEST:
	or	di,di
	jne	short M001_@@P2_ITEM
	mov	es,word ptr DGROUP:BCC_HASH_SEG2
	mov	bx,word ptr [bp-6]
	mov	ax,word ptr es:[bx]
M001_@@P2_HAVE_BUCKET:
	mov	word ptr [bp-6],ax
	cmp	word ptr [bp-6],0
	je	short M001_@@P2_NEXT_BUCKET
	db	0E9h
	dw	0FF63h
M001_@@P2_NEXT_BUCKET:
	inc	word ptr [bp-4]
M001_@@P2_BUCKET_TEST:
	cmp	word ptr [bp-4],400h
	jge	short M001_@@P3_RESET
	db	0E9h
	dw	0FF4Ah
M001_@@P3_RESET:
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0E600h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	word ptr [bp-4],0
	db	0E9h
	dw	0027Eh
M001_@@P3_BUCKET:
	mov	bx,word ptr [bp-4]
	shl	bx,1
	mov	ax,word ptr [bx+M001_BCC_HASH_HEADS]
	db	0E9h
	dw	00263h
M001_@@P3_CHAIN:
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr [bp-6]
	mov	di,word ptr es:[bx]
	db	0E9h
	dw	00245h
M001_@@P3_ITEM:
	mov	si,di
M001_@@P3_NESTED:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+4]
	mov	word ptr [bp-8],ax
	cmp	word ptr es:[si+2],0
	jne	short M001_@@P3_CHECK_KIND
	db	0E9h
	dw	001ECh
M001_@@P3_CHECK_KIND:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	jne	short M001_@@P3_CPP
	db	0E9h
	dw	00114h
M001_@@P3_CPP:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,0Bh
	je	short M001_@@P3_CPP_CLASS
	db	0E9h
	dw	000FCh
M001_@@P3_CPP_CLASS:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr [bp-8]
	mov	bx,word ptr es:[bx]
	test	byte ptr [bx+09CAh],40h
	jne	short M001_@@P3_CLASS_FLAGS
	db	0E9h
	dw	000E8h
M001_@@P3_CLASS_FLAGS:
	mov	bx,word ptr [bp-8]
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	test	word ptr es:[bx+18h],1
	jne	short M001_@@P3_MEMBERS
	db	0E9h
	dw	000D2h
M001_@@P3_MEMBERS:
	mov	bx,word ptr [bp-8]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	ax,word ptr es:[bx+2]
	db	0E9h
	dw	000ADh
M001_@@P3_MEMBER:
	mov	bx,word ptr [bp-0Ah]
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	al,byte ptr es:[bx+4]
	mov	ah,0
	and	ax,3
	cmp	ax,3
	je	short M001_@@P3_MEMBER_TYPES
	db	0E9h
	dw	0008Bh
M001_@@P3_MEMBER_TYPES:
	mov	bx,word ptr [bp-0Ah]
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	ax,word ptr es:[bx+6]
	jmp	short M001_@@P3_STORE_NESTED
M001_@@P3_NESTED_MEMBER:
	mov	bx,word ptr [bp-0Ch]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[bx+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,3
	jne	short M001_@@P3_NEXT_NESTED
	mov	al,byte ptr es:[bx+6]
	mov	ah,0
	test	ax,20h
	jne	short M001_@@P3_NEXT_NESTED
	test	word ptr es:[bx+0Ah],2
	je	short M001_@@P3_NEXT_NESTED
	cmp	byte ptr DGROUP:BCC_OPTION_BYTE,3
	je	short M001_@@P3_NEXT_NESTED
	cmp	word ptr [bp-2],0
	je	short M001_@@P3_EMIT_MEMBER
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
	mov	word ptr [bp-2],0
M001_@@P3_EMIT_MEMBER:
	push	word ptr [bp-0Ch]
	push	word ptr DGROUP:BCC_RD_5EC6_W
	nop
	push	cs
	db	0E8h
	dw	0096Fh
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0E600h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	push	word ptr [bp-0Ch]
	db	0E8h
	dw	0117Fh
	mov	word ptr [bp-2],1
M001_@@P3_NEXT_NESTED:
	mov	bx,word ptr [bp-0Ch]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[bx+13h]
M001_@@P3_STORE_NESTED:
	mov	word ptr [bp-0Ch],ax
	cmp	word ptr [bp-0Ch],0
	jne	short M001_@@P3_NESTED_MEMBER
M001_@@P3_NEXT_MEMBER:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	bx,word ptr [bp-0Ah]
	mov	ax,word ptr es:[bx]
M001_@@P3_STORE_MEMBER:
	mov	word ptr [bp-0Ah],ax
	cmp	word ptr [bp-0Ah],0
	je	short M001_@@P3_MEMBERS_DONE
	db	0E9h
	dw	0FF47h
M001_@@P3_MEMBERS_DONE:
	db	0E9h
	dw	000CEh
M001_@@P3_NONCPP:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,0Eh
	jne	short M001_@@P3_CHECK_RECORD
	mov	bx,word ptr es:[si+8]
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	al,byte ptr es:[bx+4]
	mov	ah,0
	test	ax,40h
	je	short M001_@@P3_EMIT_ENUM
	db	0E9h
	dw	000A3h
M001_@@P3_EMIT_ENUM:
	push	si
	db	0E8h
	dw	0111Eh
	mov	word ptr [bp-2],1
	db	0E9h
	dw	00097h
M001_@@P3_CHECK_RECORD:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,3
	je	short M001_@@P3_RECORD
	db	0E9h
	dw	0007Fh
M001_@@P3_RECORD:
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	word ptr es:[bx],12h
	jne	short M001_@@P3_RECORD_FALLBACK
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+0Ch]
	mov	ah,0
	and	ax,3
	cmp	ax,1
	jne	short M001_@@P3_RECORD_FALLBACK
	test	word ptr es:[si+0Ah],2
	je	short M001_@@P3_AFTER_EMIT
	cmp	byte ptr DGROUP:BCC_OPTION_BYTE,3
	je	short M001_@@P3_AFTER_EMIT
	cmp	word ptr [bp-2],0
	je	short M001_@@P3_EMIT_RECORD
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
	mov	word ptr [bp-2],0
M001_@@P3_EMIT_RECORD:
	push	si
	push	word ptr DGROUP:BCC_RD_5EC6_W
	nop
	push	cs
	db	0E8h
	dw	0088Eh
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0E600h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	push	si
	db	0E8h
	dw	010A0h
	mov	word ptr [bp-2],1
	jmp	short M001_@@P3_AFTER_EMIT
M001_@@P3_RECORD_FALLBACK:
	cmp	si,word ptr DGROUP:BCC_RD_63A4_W
	je	short M001_@@P3_AFTER_EMIT
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	test	byte ptr es:[si+6],2
	je	short M001_@@P3_AFTER_EMIT
	push	si
	db	0E8h
	dw	01084h
	mov	word ptr [bp-2],1
M001_@@P3_AFTER_EMIT:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M001_@@P3_NEXT
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,8
	je	short M001_@@P3_NEXT
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	word ptr es:[bx],12h
	jne	short M001_@@P3_NEXT
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+13h]
	mov	si,ax
	or	ax,ax
	je	short M001_@@P3_NEXT
	db	0E9h
	dw	0FDC4h
M001_@@P3_NEXT:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	di,word ptr es:[di]
M001_@@P3_DI_TEST:
	or	di,di
	je	short M001_@@P3_CHAIN_DONE
	db	0E9h
	dw	0FDB4h
M001_@@P3_CHAIN_DONE:
	mov	es,word ptr DGROUP:BCC_HASH_SEG2
	mov	bx,word ptr [bp-6]
	mov	ax,word ptr es:[bx]
M001_@@P3_HAVE_BUCKET:
	mov	word ptr [bp-6],ax
	cmp	word ptr [bp-6],0
	je	short M001_@@P3_NEXT_BUCKET
	db	0E9h
	dw	0FD91h
M001_@@P3_NEXT_BUCKET:
	inc	word ptr [bp-4]
M001_@@P3_BUCKET_TEST:
	cmp	word ptr [bp-4],400h
	jge	short M001_@@P4_INIT
	db	0E9h
	dw	0FD78h
M001_@@P4_INIT:
	mov	word ptr [bp-4],0
	db	0E9h
	dw	0012Bh
M001_@@P4_BUCKET:
	mov	bx,word ptr [bp-4]
	shl	bx,1
	mov	ax,word ptr [bx+M001_BCC_HASH_HEADS]
	db	0E9h
	dw	00110h
M001_@@P4_CHAIN:
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr [bp-6]
	mov	si,word ptr es:[bx]
	db	0E9h
	dw	000F2h
M001_@@P4_ITEM:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	mov	word ptr [bp-8],ax
	push	word ptr es:[si+4]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	mov	word ptr [bp-0Ah],ax
	cmp	word ptr [bp-8],8
	je	short M001_@@P4_CHECKS
	cmp	word ptr [bp-8],9
	je	short M001_@@P4_CHECKS
	db	0E9h
	dw	000BDh
M001_@@P4_CHECKS:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	cmp	word ptr es:[si+2],0
	jne	short M001_@@P4_QUERY
	db	0E9h
	dw	000AFh
M001_@@P4_QUERY:
	cmp	word ptr [bp-0Ah],0
	jne	short M001_@@P4_KIND9
	db	0E9h
	dw	000A6h
M001_@@P4_KIND9:
	cmp	word ptr [bp-8],9
	jne	short M001_@@P4_EMIT
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx]
	mov	al,byte ptr [bx+09CAh]
	mov	ah,0
	test	ax,1
	jne	short M001_@@P4_EMIT
	db	0E9h
	dw	00083h
M001_@@P4_EMIT:
	mov	ax,0E600h
	push	ax
	push	cs
	db	0E8h
	dw	0FB1Bh
	mov	word ptr [bp-2],1
	push	ds
	mov	ax,offset DGROUP:BCC_DEBUG_NAME
	push	ax
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr es:[bx+4]
	push	word ptr [bx]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	push	word ptr es:[bx+2]
	db	9Ah
	dw	BCC_DEBUG_BUILD
	dw	seg BCC_DEBUG_BUILD
	push	dx
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
	push	word ptr [bp-0Ah]
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	cmp	word ptr [bp-8],8
	jne	short M001_@@P4_KIND9_EMIT
	mov	al,6
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	jmp	short M001_@@P4_NEXT
M001_@@P4_KIND9_EMIT:
	mov	al,5
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+8]
	and	ax,0FFFFh
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+0Ah]
	cwd
	and	ax,0FFFFh
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
M001_@@P4_NEXT:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	si,word ptr es:[si]
M001_@@P4_TEST:
	or	si,si
	je	short M001_@@P4_CHAIN_DONE
	db	0E9h
	dw	0FF07h
M001_@@P4_CHAIN_DONE:
	mov	es,word ptr DGROUP:BCC_HASH_SEG2
	mov	bx,word ptr [bp-6]
	mov	ax,word ptr es:[bx]
M001_@@P4_HAVE_BUCKET:
	mov	word ptr [bp-6],ax
	cmp	word ptr [bp-6],0
	je	short M001_@@P4_NEXT_BUCKET
	db	0E9h
	dw	0FEE4h
M001_@@P4_NEXT_BUCKET:
	inc	word ptr [bp-4]
M001_@@P4_BUCKET_TEST:
	cmp	word ptr [bp-4],400h
	jge	short M001_@@P5_INIT
	db	0E9h
	dw	0FECBh
M001_@@P5_INIT:
	mov	word ptr [bp-4],0
	db	0E9h
	dw	000CEh
M001_@@P5_BUCKET:
	mov	bx,word ptr [bp-4]
	shl	bx,1
	mov	ax,word ptr [bx+M001_BCC_HASH_HEADS]
	db	0E9h
	dw	000B3h
M001_@@P5_CHAIN:
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr [bp-6]
	mov	si,word ptr es:[bx]
	db	0E9h
	dw	00095h
M001_@@P5_ITEM:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+4]
	mov	word ptr [bp-8],ax
	push	word ptr [bp-8]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	mov	word ptr [bp-0Ah],ax
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,0Bh
	jne	short M001_@@P5_NEXT
	cmp	word ptr es:[si+2],0
	je	short M001_@@P5_NEXT
	cmp	word ptr [bp-8],0
	je	short M001_@@P5_NEXT
	cmp	word ptr [bp-0Ah],0
	je	short M001_@@P5_NEXT
	mov	ax,0E600h
	push	ax
	push	cs
	db	0E8h
	dw	0FA08h
	mov	word ptr [bp-2],1
	push	ds
	mov	ax,offset DGROUP:BCC_DEBUG_NAME
	push	ax
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr es:[bx+4]
	push	word ptr [bx]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	push	word ptr es:[bx+2]
	db	9Ah
	dw	BCC_DEBUG_BUILD
	dw	seg BCC_DEBUG_BUILD
	push	dx
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
	push	word ptr [bp-0Ah]
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	al,7
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
M001_@@P5_NEXT:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	si,word ptr es:[si]
M001_@@P5_TEST:
	or	si,si
	je	short M001_@@P5_CHAIN_DONE
	db	0E9h
	dw	0FF64h
M001_@@P5_CHAIN_DONE:
	mov	es,word ptr DGROUP:BCC_HASH_SEG2
	mov	bx,word ptr [bp-6]
	mov	ax,word ptr es:[bx]
M001_@@P5_HAVE_BUCKET:
	mov	word ptr [bp-6],ax
	cmp	word ptr [bp-6],0
	je	short M001_@@P5_NEXT_BUCKET
	db	0E9h
	dw	0FF41h
M001_@@P5_NEXT_BUCKET:
	inc	word ptr [bp-4]
M001_@@P5_BUCKET_TEST:
	cmp	word ptr [bp-4],400h
	jge	short M001_@@FINISH
	db	0E9h
	dw	0FF28h
M001_@@FINISH:
	cmp	word ptr [bp-2],0
	je	short M001_@@RETURN
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
M001_@@RETURN:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf
BCC_SYMBOL_SWEEP	endp
CO041_TEXT	ends


		extrn	BCC_RD_A03E_B:byte
		extrn	X02C_08:far
		extrn	X02C_1B:far
		extrn	BCC_EXPR_SEGMENT:word
		extrn	BCC_EXPR_LINKSEG:word
		extrn	BCC_TYPE_SEGMENT:word
		extrn	BCC_PARAM_SEGMENT:word
		extrn	BCC_TYPE_SEQUENCE:word
		extrn	BCC_RD_C63E_W:word
		extrn	BCC_RD_629E_W:word
		extrn	X055_03:far
		extrn	X055_0E:far
		extrn	X055_09:far
		extrn	BCC_HASH_SEG1:word
		extrn	BCC_DEBUG_NAME:byte
		extrn	BCC_DEBUG_BUILD:far
		extrn	BCC_DEBUG_EMPTY:byte
		extrn	X055_01:far
		extrn	X00A_03:far
		extrn	X055_04:far
		extrn	BCC_HASH_SPECIAL:word
		extrn	X055_06:far
		extrn	BCC_RD_6482_W:word
		extrn	BCC_RD_820E_W:word


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

		public	X041_04
X041_04	label	far
BCC_NEAR_B885	label	near
BCC_TYPE_EMIT1	proc	far
	push	bp
	mov	bp,sp
	sub	sp,0Ah
	push	si
	push	di
	mov	si,word ptr [bp+8]
	mov	di,word ptr [bp+6]
	or	si,si
	jne	short M002_L_B89A
	db	0E9h
	dw	00496h
M002_L_B89A:
	push	si
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	or	ax,ax
	je	short M002_L_B8D5
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	jne	short M002_L_B8AE
	db	0E9h
	dw	00482h
M002_L_B8AE:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si]
	test	byte ptr [bx+9CAh],40h
	jne	short M002_L_B8BF
	db	0E9h
	dw	00471h
M002_L_B8BF:
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	test	word ptr es:[bx+8],8000h
	jne	short M002_L_B8D2
	db	0E9h
	dw	0045Eh
M002_L_B8D2:
	db	0E9h
	dw	000C7h
M002_L_B8D5:
	mov	word ptr [bp-8],0
	push	si
	mov	ax,word ptr DGROUP:BCC_RD_6482_W
	inc	word ptr DGROUP:BCC_RD_6482_W
	push	ax
	db	9Ah
	dw	X02C_1B
	dw	seg X02C_1B
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si]
	sub	bx,0Dh
	cmp	bx,8
	jbe	short M002_L_B8FA
	db	0E9h
	dw	001C7h
M002_L_B8FA:
	shl	bx,1
	jmp	word ptr cs:[bx+0B4Ah]
M002_L_B901:
	inc	word ptr DGROUP:BCC_RD_6482_W
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	cmp	word ptr es:[bx+6],0
	je	short M002_L_B933
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	bx,word ptr es:[bx+6]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[bx+2]
	mov	word ptr [bp-8],ax
M002_L_B933:
	push	si
	db	0E8h
	dw	0066Eh
	db	0E9h
	dw	0018Ah
M002_L_B93A:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	cmp	word ptr es:[bx+4],0
	jne	short M002_L_B964
	push	si
	push	word ptr DGROUP:BCC_RD_629E_W
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X02C_1B
	dw	seg X02C_1B
M002_L_B95D:
	dec	word ptr DGROUP:BCC_RD_820E_W
	db	0E9h
	dw	003CCh
M002_L_B964:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	jne	short M002_L_B96E
	db	0E9h
	dw	000C8h
M002_L_B96E:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	test	word ptr es:[bx+18h],21h
	jne	short M002_L_B985
	db	0E9h
	dw	000B1h
M002_L_B985:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	ax,word ptr DGROUP:BCC_TYPE_SEQUENCE
	mov	word ptr es:[bx+8],ax
	inc	word ptr DGROUP:BCC_TYPE_SEQUENCE
M002_L_B99C:
	cmp	di,word ptr DGROUP:BCC_RD_C63E_W
	je	short M002_L_B9E2
	mov	dx,di
	jmp	short M002_L_B9B1
M002_L_B9A6:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,dx
	mov	ax,word ptr es:[bx]
	mov	dx,ax
M002_L_B9B1:
	or	dx,dx
	je	short M002_L_B9C9
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	ax,word ptr es:[bx+6]
	cmp	ax,dx
	jne	short M002_L_B9A6
M002_L_B9C9:
	or	dx,dx
	jne	short M002_L_B9E2
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	or	word ptr es:[bx+8],8000h
	db	0E9h
	dw	0034Eh
M002_L_B9E2:
	mov	word ptr [bp-8],0
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	and	word ptr es:[bx+8],7FFFh
	mov	word ptr [bp-4],0
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	ax,word ptr es:[bx+0Ch]
	jmp	short M002_L_BA2D
M002_L_BA10:
	inc	word ptr [bp-4]
	mov	bx,word ptr [bp-0Ah]
	mov	es,word ptr DGROUP:BCC_PARAM_SEGMENT
	push	word ptr es:[bx+2]
	push	di
	push	cs
	db	0E8h
	dw	0FE62h
	mov	es,word ptr DGROUP:BCC_PARAM_SEGMENT
	mov	bx,word ptr [bp-0Ah]
	mov	ax,word ptr es:[bx]
M002_L_BA2D:
	mov	word ptr [bp-0Ah],ax
	cmp	word ptr [bp-0Ah],0
	jne	short M002_L_BA10
M002_L_BA36:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	cmp	word ptr es:[bx+6],0
	je	short M002_L_BA64
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	bx,word ptr es:[bx+6]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[bx+2]
	mov	word ptr [bp-8],ax
M002_L_BA64:
	push	si
	push	di
	db	0E8h
	dw	00793h
	mov	word ptr [bp-6],ax
	jmp	short M002_L_BAC4
M002_L_BA6E:
	jmp	short M002_L_BAB2
M002_L_BA70:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M002_L_BA92
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	byte ptr es:[si+0Dh],0Bh
	jne	short M002_L_BA92
	inc	word ptr DGROUP:BCC_RD_6482_W
	push	word ptr es:[si+7]
	push	di
	nop
	push	cs
	db	0E8h
	dw	002CCh
	jmp	short M002_L_BABF
M002_L_BA92:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	word ptr es:[si+9],0
	je	short M002_L_BAA1
	inc	word ptr DGROUP:BCC_RD_6482_W
M002_L_BAA1:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr es:[si+7]
	push	di
	push	cs
	db	0E8h
	dw	0FDD7h
	jmp	short M002_L_BAC4
M002_L_BAB0:
	jmp	short M002_L_BAB2
M002_L_BAB2:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr es:[si+7]
	push	di
	push	cs
	db	0E8h
	dw	0FDC6h
M002_L_BABF:
	jmp	short M002_L_BAC4
M002_L_BAC1:
	db	0E9h
	dw	0FE99h
M002_L_BAC4:
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0E300h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	push	si
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	cmp	word ptr [bp-8],0
	je	short M002_L_BB04
M002_L_BAE4:
	push	ds
	mov	ax,offset DGROUP:BCC_DEBUG_NAME
	push	ax
	mov	bx,word ptr [bp-8]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr es:[bx+4]
	push	word ptr [bx]
	mov	bx,word ptr [bp-8]
	push	word ptr es:[bx+2]
	db	9Ah
	dw	BCC_DEBUG_BUILD
	dw	seg BCC_DEBUG_BUILD
	jmp	short M002_L_BB09
M002_L_BB04:
	mov	dx,ds
	mov	ax,offset DGROUP:BCC_DEBUG_EMPTY
M002_L_BB09:
	push	dx
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
	push	si
	db	9Ah
	dw	X00A_03
	dw	seg X00A_03
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si]
	sub	bx,0Dh
	cmp	bx,8
	jbe	short M002_L_BB2E
	db	0E9h
	dw	001FAh
M002_L_BB2E:
	shl	bx,1
	jmp	word ptr cs:[bx+0B38h]
M002_L_BB35:
	mov	al,22h
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,0
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	ax,8000h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	ax,7FFFh
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	db	0E9h
	dw	001CEh
M002_L_BB5A:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M002_L_BB82
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	test	word ptr es:[bx+18h],21h
	je	short M002_L_BB82
	push	si
	push	word ptr [bp-6]
	push	word ptr [bp-4]
	db	0E8h
	dw	0055Eh
	db	0E9h
	dw	001A6h
M002_L_BB82:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	word ptr es:[si],13h
	jne	short M002_L_BB90
	mov	al,1Eh
	jmp	short M002_L_BB92
M002_L_BB90:
	mov	al,1Fh
M002_L_BB92:
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	db	0E9h
	dw	0018Dh
M002_L_BB9B:
	mov	al,1Ah
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr es:[si+7]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	db	0E9h
	dw	000A3h
M002_L_BBB3:
	mov	word ptr [bp-2],15h
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	word ptr es:[si+9],0
	je	short M002_L_BBCA
	mov	word ptr [bp-2],30h
	jmp	short M002_L_BBF3
M002_L_BBCA:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M002_L_BBF3
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	test	byte ptr es:[si+2],20h
	je	short M002_L_BBE3
	mov	word ptr [bp-2],34h
	jmp	short M002_L_BBF3
M002_L_BBE3:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	byte ptr es:[si+0Dh],0Bh
	jne	short M002_L_BBF3
	mov	word ptr [bp-2],33h
M002_L_BBF3:
	mov	al,byte ptr [bp-2]
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr es:[si+7]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	cmp	word ptr [bp-2],30h
	jne	short M002_L_BC35
M002_L_BC15:
	push	ds
	mov	ax,offset DGROUP:BCC_DEBUG_NAME
	push	ax
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr DGROUP:BCC_HASH_SPECIAL
	push	word ptr es:[si+9]
	db	9Ah
	dw	BCC_DEBUG_BUILD
	dw	seg BCC_DEBUG_BUILD
	push	dx
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
	db	0E9h
	dw	000F3h
M002_L_BC35:
	cmp	word ptr [bp-2],33h
	jne	short M002_L_BC5F
M002_L_BC3B:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+7]
	mov	bx,word ptr es:[bx+3]
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	ax,word ptr es:[bx+8]
	and	ax,7FFFh
M002_L_BC56:
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	db	0E9h
	dw	000C9h
M002_L_BC5F:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	al,byte ptr es:[si+0Dh]
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	db	0E9h
	dw	000B8h
M002_L_BC70:
	mov	al,17h
M002_L_BC72:
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr es:[si+7]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	al,0
	db	0E9h
	dw	00092h
M002_L_BC90:
	mov	word ptr [bp-2],16h
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M002_L_BCAC
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	test	byte ptr es:[si+2],20h
	je	short M002_L_BCAC
	mov	word ptr [bp-2],35h
M002_L_BCAC:
	mov	al,byte ptr [bp-2]
	jmp	short M002_L_BC72
M002_L_BCB1:
	mov	al,16h
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr es:[si+7]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	al,1
	jmp	short M002_L_BD22
M002_L_BCD0:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	al,byte ptr es:[si+0Bh]
	mov	ah,0
	dec	ax
	and	ax,3
	mov	word ptr [bp-2],ax
	test	byte ptr es:[si+0Ch],1
	je	short M002_L_BCED
	db	081h,04Eh,0FEh,004h,000h	; or word ptr [bp-2],4
M002_L_BCED:
	mov	al,23h
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr es:[si+7]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	al,byte ptr [bp-2]
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	test	byte ptr es:[si+0Ch],4
	je	short M002_L_BD20
	mov	al,1
	jmp	short M002_L_BD22
M002_L_BD20:
	mov	al,0
M002_L_BD22:
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
M002_L_BD28:
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
M002_L_BD30:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf	4
BCC_TYPE_EMIT1	endp

; Case targets for the two indirect dispatches above.
	dw	09B3h,0A70h,0A90h
	dw	0AB1h,099Bh,0AD0h
	dw	095Ah,095Ah,0935h
	dw	0870h,08B0h,08B0h
	dw	08B0h,086Eh,08B2h
	dw	073Ah,073Ah,0701h
CO041_TEXT	ends


		extrn	BCC_EXPR_SEGMENT:word
		extrn	X02C_08:far
		extrn	BCC_RD_6482_W:word
		extrn	X02C_1B:far
		extrn	X055_03:far
		extrn	X055_0E:far
		extrn	X055_09:far
		extrn	BCC_DEBUG_EMPTY:byte
		extrn	X055_01:far
		extrn	X00A_03:far
		extrn	X055_04:far
		extrn	X055_06:far


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

		public	X041_03
X041_03	label	far
BCC_TYPE_EMIT2	proc	far
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	push	si
	push	di
	mov	si,word ptr [bp+8]
	mov	di,word ptr [bp+6]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr es:[si+3]
	push	di
	push	cs
	db	0E8h
	dw	0FB0Fh
	push	si
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	or	ax,ax
	je	short M003_L_BD83
	db	0E9h
	dw	000B8h
M003_L_BD83:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr es:[si+7]
	push	di
	push	cs
	db	0E8h
	dw	0FAF5h
	push	si
	push	word ptr DGROUP:BCC_RD_6482_W
	db	9Ah
	dw	X02C_1B
	dw	seg X02C_1B
	add	word ptr DGROUP:BCC_RD_6482_W,2
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0E300h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	push	si
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	push	ds
	mov	ax,offset DGROUP:BCC_DEBUG_EMPTY
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
	push	si
	db	9Ah
	dw	X00A_03
	dw	seg X00A_03
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	al,2Dh
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr es:[si+7]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	al,byte ptr es:[si+0Bh]
	mov	ah,0
	dec	ax
	and	ax,3
	mov	word ptr [bp-2],ax
	test	byte ptr es:[si+0Ch],1
	je	short M003_L_BE07
	db	081h,04Eh,0FEh,004h,000h	; or word ptr [bp-2],4
M003_L_BE07:
	mov	al,byte ptr [bp-2]
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,9
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr es:[si+3]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	xor	ax,ax
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
M003_L_BE3B:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf	4
BCC_TYPE_EMIT2	endp
CO041_TEXT	ends


		extrn	BCC_TYPE_SEGMENT:word
		extrn	X02C_08:far
		extrn	BCC_EXPR_SEGMENT:word
		extrn	BCC_RD_6482_W:word
		extrn	X02C_1B:far
		extrn	X055_03:far
		extrn	X055_0E:far
		extrn	X055_09:far
		extrn	BCC_DEBUG_EMPTY:byte
		extrn	X055_01:far
		extrn	X00A_03:far
		extrn	X055_04:far
		extrn	BCC_CPU_LEVEL:byte
		extrn	X040_02:far
		extrn	X055_06:far


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

		public	X041_05
X041_05	label	far
BCC_NEAR_BE43	label	near
BCC_TYPE_EMIT3	proc	far
	push	bp
	mov	bp,sp
	sub	sp,4
	push	si
	push	di
	mov	si,word ptr [bp+8]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	di,word ptr es:[si+4]
	push	di
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	or	ax,ax
	je	short M004_L_BE63
	db	0E9h
	dw	0013Ah
M004_L_BE63:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr es:[di+7]
	push	word ptr [bp+6]
	push	cs
	db	0E8h
	dw	0FA13h
	push	di
	push	word ptr DGROUP:BCC_RD_6482_W
	db	9Ah
	dw	X02C_1B
	dw	seg X02C_1B
	add	word ptr DGROUP:BCC_RD_6482_W,2
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0E300h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	push	di
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	push	ds
	mov	ax,offset DGROUP:BCC_DEBUG_EMPTY
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
	push	di
	db	9Ah
	dw	X00A_03
	dw	seg X00A_03
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	al,2Dh
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr es:[di+7]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	al,byte ptr es:[di+0Bh]
	mov	ah,0
	dec	ax
	and	ax,3
	mov	word ptr [bp-2],ax
	test	byte ptr es:[di+0Ch],1
	je	short M004_L_BEE9
	db	081h,04Eh,0FEh,004h,000h	; or word ptr [bp-2],4
M004_L_BEE9:
	mov	al,byte ptr [bp-2]
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	word ptr [bp-2],0
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	test	byte ptr es:[si+6],10h
	je	short M004_L_BF07
	db	081h,04Eh,0FEh,001h,000h	; or word ptr [bp-2],1
M004_L_BF07:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+0Ch]
	mov	ah,0
	and	ax,3
	cmp	ax,1
	jne	short M004_L_BF2D
	cmp	byte ptr DGROUP:BCC_CPU_LEVEL,3
	jne	short M004_L_BF28
	test	word ptr es:[si+0Ah],2
	jne	short M004_L_BF2D
M004_L_BF28:
	db	081h,04Eh,0FEh,008h,000h	; or word ptr [bp-2],8
M004_L_BF2D:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	cmp	word ptr es:[si+0Fh],1
	jne	short M004_L_BF3D
	db	081h,04Eh,0FEh,004h,000h	; or word ptr [bp-2],4
M004_L_BF3D:
	mov	al,byte ptr [bp-2]
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	test	byte ptr es:[si+6],10h
	je	short M004_L_BF95
	mov	bx,word ptr es:[si]
	push	word ptr es:[bx+4]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	word ptr [bp-4],0
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	cmp	word ptr es:[si+15h],0
	je	short M004_L_BF7D
	mov	ax,word ptr es:[si+15h]
	dec	ax
	shr	ax,1
	mov	word ptr [bp-4],ax
M004_L_BF7D:
	push	word ptr [bp-4]
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	test	word ptr [bp-2],8
	jne	short M004_L_BF95
	push	si
	xor	ax,ax
	push	ax
	db	9Ah
	dw	X040_02
	dw	seg X040_02
M004_L_BF95:
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
M004_L_BF9D:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf	4
BCC_TYPE_EMIT3	endp
CO041_TEXT	ends


		extrn	X055_03:far
		extrn	X055_0E:far
		extrn	BCC_EXPR_SEGMENT:word
		extrn	BCC_EXPR_LINKSEG:word
		extrn	BCC_MEMBER_SEGMENT:word
		extrn	X055_04:far
		extrn	X00E_00:far
		extrn	X055_01:far
		extrn	BCC_TYPE_SEGMENT:word
		extrn	BCC_DEBUG_NAME:byte
		extrn	BCC_HASH_SEG1:word
		extrn	BCC_DEBUG_BUILD:far
		extrn	X055_06:far


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

BCC_TYPE_PREP	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	push	di
	mov	di,word ptr [bp+4]
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0E400h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	test	byte ptr es:[di+2],40h
	je	short M005_L_C02C
	mov	bx,word ptr es:[di+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	si,word ptr es:[bx+2]
	jmp	short M005_L_C026
M005_L_BFD5:
	mov	ax,0E400h
	push	ax
	push	cs
	db	0E8h
	dw	0F223h
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	test	byte ptr es:[si+4],20h
	je	short M005_L_BFEC
	mov	al,80h
	jmp	short M005_L_BFEE
M005_L_BFEC:
	mov	al,0
M005_L_BFEE:
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	push	si
	db	9Ah
	dw	X00E_00
	dw	seg X00E_00
	push	dx
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	push	word ptr es:[si+6]
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	test	byte ptr es:[si+4],20h
	je	short M005_L_C01D
	xor	ax,ax
	jmp	short M005_L_C024
M005_L_C01D:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	ax,word ptr es:[si]
M005_L_C024:
	mov	si,ax
M005_L_C026:
	or	si,si
	jne	short M005_L_BFD5
	jmp	short M005_L_C0A9
M005_L_C02C:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[di+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	si,word ptr es:[bx+2]
	jmp	short M005_L_C0A5
M005_L_C03E:
	mov	ax,0E400h
	push	ax
	push	cs
	db	0E8h
	dw	0F1BAh
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	cmp	word ptr es:[si+0Ah],0
	jne	short M005_L_C055
	mov	al,80h
	jmp	short M005_L_C057
M005_L_C055:
	mov	al,0
M005_L_C057:
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	push	ds
	mov	ax,offset DGROUP:BCC_DEBUG_NAME
	push	ax
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr es:[bx+4]
	push	word ptr [bx]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	push	word ptr es:[bx+2]
	db	9Ah
	dw	BCC_DEBUG_BUILD
	dw	seg BCC_DEBUG_BUILD
	push	dx
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[si+8]
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	si,word ptr es:[si+0Ah]
M005_L_C0A5:
	or	si,si
	jne	short M005_L_C03E
M005_L_C0A9:
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
	pop	di
	pop	si
	pop	bp
	dec	bp
	ret	2
BCC_TYPE_PREP	endp
CO041_TEXT	ends


		extrn	X00F_00:far
		extrn	BCC_MEMBER_SEGMENT:word


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

BCC_TYPE_PARAM0	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	push	si
	push	word ptr [bp+4]
	db	9Ah
	dw	X00F_00
	dw	seg X00F_00
	mov	si,ax
	or	si,si
	jne	short M006_L_C0CF
	xor	ax,ax
	jmp	short M006_L_C0D7
M006_L_C0CF:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	ax,word ptr es:[si+6]
M006_L_C0D7:
	pop	si
	pop	bp
	dec	bp
	ret	2
BCC_TYPE_PARAM0	endp
CO041_TEXT	ends


		extrn	X055_04:far
		extrn	BCC_EXPR_SEGMENT:word
		extrn	BCC_EXPR_LINKSEG:word
		extrn	X055_09:far
		extrn	X055_06:far
		extrn	X055_03:far
		extrn	X055_0E:far
		extrn	BCC_OPTION_16EF:byte
		extrn	BCC_OPTION_1778:byte
		extrn	BCC_PARAM_SEGMENT:word


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

BCC_TYPE_PARAMS	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	push	si
	push	di
	mov	si,word ptr [bp+8]
	mov	al,2Eh
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	ax,word ptr es:[bx+8]
	and	ax,7FFFh
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0ED00h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	al,0
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	ax,word ptr es:[bx+8]
	and	ax,7FFFh
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	push	si
	db	0E8h
	dw	0FF74h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	test	word ptr es:[bx+18h],20h
	je	short M007_L_C162
	xor	ax,ax
	jmp	short M007_L_C165
M007_L_C162:
	mov	ax,1
M007_L_C165:
	mov	word ptr [bp-2],ax
	cmp	byte ptr DGROUP:BCC_OPTION_16EF,5
	je	short M007_L_C18A
	cmp	byte ptr DGROUP:BCC_OPTION_1778,0
	jne	short M007_L_C18A
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	test	word ptr es:[bx+18h],100h
	je	short M007_L_C18F
M007_L_C18A:
	db	081h,04Eh,0FEh,002h,000h	; or word ptr [bp-2],2
M007_L_C18F:
	mov	al,byte ptr [bp-2]
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	push	word ptr [bp+4]
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[si+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	di,word ptr es:[bx+0Ch]
	jmp	short M007_L_C1EF
M007_L_C1B2:
	mov	es,word ptr DGROUP:BCC_PARAM_SEGMENT
	mov	bx,word ptr es:[di+2]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	ax,word ptr es:[bx+8]
	and	ax,7FFFh
	mov	word ptr [bp-2],ax
	mov	es,word ptr DGROUP:BCC_PARAM_SEGMENT
	cmp	byte ptr es:[di+7],0
	je	short M007_L_C1E0
	db	081h,04Eh,0FEh,000h,080h	; or word ptr [bp-2],8000h
M007_L_C1E0:
	push	word ptr [bp-2]
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	es,word ptr DGROUP:BCC_PARAM_SEGMENT
	mov	di,word ptr es:[di]
M007_L_C1EF:
	or	di,di
	jne	short M007_L_C1B2
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret	6
BCC_TYPE_PARAMS	endp
CO041_TEXT	ends


		extrn	BCC_EXPR_SEGMENT:word
		extrn	BCC_EXPR_LINKSEG:word
		extrn	BCC_MEMBER_SEGMENT:word
		extrn	BCC_TYPE_SEGMENT:word
		extrn	BCC_TYPE_COUNTER:word
		extrn	X055_03:far
		extrn	X055_0E:far
		extrn	X055_04:far
		extrn	X00A_03:far
		extrn	BCC_DEBUG_NAME:byte
		extrn	BCC_HASH_SEG1:word
		extrn	BCC_DEBUG_BUILD:far
		extrn	X055_01:far
		extrn	X02C_08:far
		extrn	X040_02:far
		extrn	X00E_02:far
		extrn	X055_09:far
		extrn	X055_06:far


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

BCC_TYPE_EMIT_BIND	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,14h
	push	si
	push	di
	mov	bx,word ptr [bp+6]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	si,word ptr es:[bx+2]
	db	0E9h
	dw	0008Ch
M008_L_C21B:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	test	byte ptr es:[si+4],80h
	jne	short M008_L_C2A0
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	al,byte ptr es:[si+4]
	mov	ah,0
	and	ax,3
	mov	bx,ax
	cmp	bx,3
	ja	short M008_L_C2A0
	shl	bx,1
	jmp	word ptr cs:[bx+145Fh]
M008_L_C241:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	ax,word ptr es:[si+6]
	jmp	short M008_L_C272
M008_L_C24B:
	mov	bx,word ptr [bp-10h]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[bx+6]
	mov	ah,0
	test	ax,20h
	jne	short M008_L_C267
	push	word ptr [bp-10h]
	push	word ptr [bp+4]
	push	cs
	db	0E8h
	dw	0FBDCh
M008_L_C267:
	mov	bx,word ptr [bp-10h]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[bx+13h]
M008_L_C272:
	mov	word ptr [bp-10h],ax
	cmp	word ptr [bp-10h],0
	jne	short M008_L_C24B
	jmp	short M008_L_C2A0
M008_L_C27D:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	bx,word ptr es:[si+6]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[bx+4]
	jmp	short M008_L_C299
M008_L_C28F:
	jmp	short M008_L_C291
M008_L_C291:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	push	word ptr es:[si+8]
M008_L_C299:
	push	word ptr [bp+4]
	push	cs
	db	0E8h
	dw	0F5E5h
M008_L_C2A0:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	si,word ptr es:[si]
M008_L_C2A7:
	or	si,si
	je	short M008_L_C2AE
	db	0E9h
	dw	0FF6Dh
M008_L_C2AE:
	mov	ax,word ptr DGROUP:BCC_TYPE_COUNTER
	mov	word ptr [bp-0Eh],ax
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0E200h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	and	byte ptr es:[4],7Fh
	mov	word ptr [bp-8],0
	xor	ax,ax
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-2],ax
	mov	bx,word ptr [bp+6]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	si,word ptr es:[bx+2]
	db	0E9h
	dw	0031Ah
M008_L_C2EF:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	test	byte ptr es:[si+4],80h
	je	short M008_L_C2FD
	db	0E9h
	dw	00305h
M008_L_C2FD:
	inc	word ptr DGROUP:BCC_TYPE_COUNTER
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	al,byte ptr es:[si+4]
	mov	ah,0
	and	ax,3
	or	ax,ax
	je	short M008_L_C325
	cmp	ax,2
	jne	short M008_L_C31A
	db	0E9h
	dw	002B1h
M008_L_C31A:
	cmp	ax,3
	jne	short M008_L_C322
	db	0E9h
	dw	001CEh
M008_L_C322:
	db	0E9h
	dw	002DDh
M008_L_C325:
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr [bp+6]
	cmp	word ptr es:[bx],13h
	je	short M008_L_C335
	db	0E9h
	dw	000F8h
M008_L_C335:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	ax,word ptr es:[si+6]
	sub	ax,word ptr [bp-2]
	mov	word ptr [bp-4],ax
	mov	word ptr [bp-0Ah],0
	test	byte ptr es:[si+4],40h
	je	short M008_L_C38F
	mov	al,byte ptr es:[si+5]
	mov	ah,0
	and	ax,7
	cmp	ax,word ptr [bp-8]
	jle	short M008_L_C38F
	mov	al,byte ptr es:[si+5]
	mov	ah,0
	and	ax,7
	sub	ax,word ptr [bp-8]
	mov	word ptr [bp-0Ah],ax
	mov	ax,word ptr [bp-8]
	add	ax,word ptr [bp-0Ah]
	cmp	ax,8
	jl	short M008_L_C38F
	mov	ax,word ptr [bp-0Ah]
	add	word ptr [bp-8],ax
	mov	word ptr [bp-0Ah],0
M008_L_C382:
	inc	word ptr [bp-4]
	sub	word ptr [bp-8],8
	cmp	word ptr [bp-8],8
	jge	short M008_L_C382
M008_L_C38F:
	cmp	word ptr [bp-4],0
	jne	short M008_L_C398
	db	0E9h
	dw	00095h
M008_L_C398:
	cmp	word ptr [bp-4],1
	ja	short M008_L_C3A4
	cmp	word ptr [bp-8],0
	jne	short M008_L_C3F5
M008_L_C3A4:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	ax,word ptr es:[si+6]
	push	ax
	cmp	word ptr [bp-8],0
	jle	short M008_L_C3B8
	mov	ax,1
	jmp	short M008_L_C3BA
M008_L_C3B8:
	xor	ax,ax
M008_L_C3BA:
	pop	dx
	sub	dx,ax
	mov	word ptr [bp-10h],dx
	mov	al,40h
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,byte ptr [bp-10h]
	and	al,0FFh
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	ax,word ptr [bp-10h]
	mov	cl,8
	shr	ax,cl
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,0
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,0
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	word ptr [bp-4],1
M008_L_C3F5:
	cmp	word ptr [bp-8],0
	jle	short M008_L_C422
	mov	al,byte ptr [bp-4]
	shl	al,1
	shl	al,1
	shl	al,1
	sub	al,byte ptr [bp-8]
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,0
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,0
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	word ptr [bp-8],0
M008_L_C422:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	ax,word ptr es:[si+6]
	mov	word ptr [bp-2],ax
M008_L_C42D:
	mov	ax,0E200h
	push	ax
	push	cs
	db	0E8h
	dw	0EDCBh
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	test	byte ptr es:[si+4],40h
	je	short M008_L_C495
	cmp	word ptr [bp-0Ah],0
	jle	short M008_L_C465
	mov	al,byte ptr [bp-0Ah]
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,0
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,0
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	ax,word ptr [bp-0Ah]
	add	word ptr [bp-8],ax
M008_L_C465:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	al,byte ptr es:[si+5]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	mov	word ptr [bp-6],ax
	add	word ptr [bp-8],ax
	mov	al,byte ptr [bp-6]
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	jmp	short M008_L_C48D
M008_L_C486:
	inc	word ptr [bp-2]
	sub	word ptr [bp-8],8
M008_L_C48D:
	cmp	word ptr [bp-8],8
	jge	short M008_L_C486
	jmp	short M008_L_C4B2
M008_L_C495:
	mov	al,0
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	push	word ptr es:[si+8]
	db	9Ah
	dw	X00A_03
	dw	seg X00A_03
	add	word ptr [bp-2],ax
	mov	word ptr [bp-8],0
M008_L_C4B2:
	push	ds
	mov	ax,offset DGROUP:BCC_DEBUG_NAME
	push	ax
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr es:[bx+4]
	push	word ptr [bx]
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	push	word ptr es:[bx+2]
	db	9Ah
	dw	BCC_DEBUG_BUILD
	dw	seg BCC_DEBUG_BUILD
	push	dx
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	push	word ptr es:[si+8]
	db	0E9h
	dw	00107h
M008_L_C4F0:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	di,word ptr es:[si+6]
	db	0E9h
	dw	000C7h
M008_L_C4FB:
	mov	word ptr [bp-10h],0
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[di+0Ah]
	and	ax,6
	neg	ax
	sbb	ax,ax
	inc	ax
	mov	byte ptr [bp-11h],al
	push	word ptr es:[di+4]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	mov	word ptr [bp-14h],ax
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	test	byte ptr es:[di+6],20h
	je	short M008_L_C52D
	db	0E9h
	dw	0008Dh
M008_L_C52D:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	test	word ptr es:[di+0Ah],40h
	je	short M008_L_C540
	db	081h,04Eh,0F0h,050h,000h	; or word ptr [bp-10h],50h
	jmp	short M008_L_C583
M008_L_C540:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[di+0Fh]
	cmp	ax,2
	je	short M008_L_C559
	cmp	ax,3
	je	short M008_L_C560
	cmp	ax,4
	je	short M008_L_C567
	jmp	short M008_L_C56E
M008_L_C559:
	db	081h,04Eh,0F0h,04Bh,000h	; or word ptr [bp-10h],4Bh
	jmp	short M008_L_C573
M008_L_C560:
	db	081h,04Eh,0F0h,04Ah,000h	; or word ptr [bp-10h],4Ah
	jmp	short M008_L_C573
M008_L_C567:
	db	081h,04Eh,0F0h,049h,000h	; or word ptr [bp-10h],49h
	jmp	short M008_L_C573
M008_L_C56E:
	db	081h,04Eh,0F0h,048h,000h	; or word ptr [bp-10h],48h
M008_L_C573:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	cmp	word ptr es:[di+15h],0
	je	short M008_L_C583
	db	081h,04Eh,0F0h,004h,000h	; or word ptr [bp-10h],4
M008_L_C583:
	mov	al,byte ptr [bp-10h]
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	cmp	byte ptr [bp-11h],0
	je	short M008_L_C59D
	push	di
	xor	ax,ax
	push	ax
	db	9Ah
	dw	X040_02
	dw	seg X040_02
	jmp	short M008_L_C5AA
M008_L_C59D:
	push	di
	db	9Ah
	dw	X00E_02
	dw	seg X00E_02
	push	dx
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
M008_L_C5AA:
	push	word ptr [bp-14h]
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	ax,0E200h
	push	ax
	push	cs
	db	0E8h
	dw	0EC46h
M008_L_C5BA:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	di,word ptr es:[di+13h]
M008_L_C5C2:
	or	di,di
	je	short M008_L_C5C9
	db	0E9h
	dw	0FF32h
M008_L_C5C9:
	jmp	short M008_L_C602
M008_L_C5CB:
	mov	al,60h
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	push	word ptr es:[si+6]
	db	9Ah
	dw	X00E_02
	dw	seg X00E_02
	push	dx
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	bx,word ptr es:[si+6]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[bx+4]
M008_L_C5F7:
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
M008_L_C602:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	si,word ptr es:[si]
M008_L_C609:
	or	si,si
	je	short M008_L_C610
	db	0E9h
	dw	0FCDFh
M008_L_C610:
	push	word ptr [bp+6]
	db	9Ah
	dw	X00A_03
	dw	seg X00A_03
	mov	word ptr [bp-0Ch],ax
	mov	al,0C0h
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,byte ptr [bp-0Ch]
	and	al,0FFh
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	ax,word ptr [bp-0Ch]
	mov	cl,8
	shr	ax,cl
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,0
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,0
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
	mov	ax,word ptr [bp-0Eh]
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret	4
BCC_TYPE_EMIT_BIND	endp

; Case targets for the indirect member-kind dispatch.
	dw	108Fh,1091h
	dw	107Dh,1041h
CO041_TEXT	ends


		extrn	X02C_0E:far
		extrn	BCC_TYPE_SEGMENT:word
		extrn	BCC_EXPR_SEGMENT:word
		extrn	BCC_RD_143E_B:byte
		extrn	BCC_RECORD_SEGMENT:word
		extrn	X040_02:far
		extrn	X02C_08:far
		extrn	X055_09:far
		extrn	X055_04:far
		extrn	BCC_DEBUG_STREAM_HOOK:word
		extrn	X056_0D:far
		extrn	BCC_DEBUG_SEGMENT:word
		extrn	BCC_DEBUG_TYPE_HOOK:word
		extrn	X055_0E:far


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

BCC_NEAR_C667	label	near
BCC_TYPE_EMIT_SPECIAL	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	sub	sp,4
	push	si
	push	di
	mov	si,word ptr [bp+4]
	push	si
	db	9Ah
	dw	X02C_0E
	dw	seg X02C_0E
	mov	word ptr [bp-4],ax
	mov	ax,0E600h
	push	ax
	push	cs
	db	0E8h
	dw	0EB7Ch
	mov	byte ptr [bp-1],0
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	word ptr es:[bx],12h
	jne	short M009_L_C6CF
	cmp	byte ptr DGROUP:BCC_RD_143E_B,0
	je	short M009_L_C6A4
	db	0E9h
	dw	00097h
M009_L_C6A4:
	mov	bx,word ptr [bp-4]
	mov	es,word ptr DGROUP:BCC_RECORD_SEGMENT
	test	word ptr es:[bx+8],20h
	je	short M009_L_C6CF
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	byte ptr es:[bx+0Bh],4
	jne	short M009_L_C6CA
	mov	al,98h
	jmp	short M009_L_C6CC
M009_L_C6CA:
	mov	al,18h
M009_L_C6CC:
	or	byte ptr [bp-1],al
M009_L_C6CF:
	push	si
	mov	ax,1
	push	ax
	db	9Ah
	dw	X040_02
	dw	seg X040_02
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[si+4]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	al,byte ptr [bp-1]
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	push	word ptr [bp-4]
	db	0FFh,01Eh
	dw	DGROUP:BCC_DEBUG_STREAM_HOOK
	push	ax
	db	9Ah
	dw	X056_0D
	dw	seg X056_0D
	mov	di,ax
	mov	es,word ptr DGROUP:BCC_DEBUG_SEGMENT
	cmp	word ptr es:[di+2],0
	je	short M009_L_C719
	mov	bx,word ptr es:[di+2]
	mov	ax,word ptr es:[bx+2]
	jmp	short M009_L_C71B
M009_L_C719:
	xor	ax,ax
M009_L_C71B:
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	es,word ptr DGROUP:BCC_DEBUG_SEGMENT
	push	word ptr es:[di+4]
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	push	word ptr [bp-4]
	db	0FFh,01Eh
	dw	DGROUP:BCC_DEBUG_TYPE_HOOK
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
M009_L_C73B:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret	2
BCC_TYPE_EMIT_SPECIAL	endp
CO041_TEXT	ends


		extrn	X055_03:far
		extrn	X055_0E:far
		extrn	BCC_RD_8664_W:word
		extrn	X055_09:far
		extrn	X055_06:far


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

		public	X041_01
X041_01	label	far
BCC_DEBUG_FLUSH	proc	far
	push	bp
	mov	bp,sp
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0E500h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	push	word ptr DGROUP:BCC_RD_8664_W
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	push	word ptr [bp+6]
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
	pop	bp
	retf	2
BCC_DEBUG_FLUSH	endp
CO041_TEXT	ends


		extrn	BCC_RD_1714_B:byte
		extrn	BCC_DEBUG_RECORD_SEG:word
		extrn	BCC_TYPE_SEGMENT:word
		extrn	BCC_SCOPE_ID:word
		extrn	BCC_EXPR_SEGMENT:word
		extrn	X00A_01:far
		extrn	X055_03:far
		extrn	X055_0E:far
		extrn	BCC_MEMBER_SEGMENT:word
		extrn	X055_05:far
		extrn	BCC_DEBUG_NAME:byte
		extrn	BCC_DEBUG_EMPTY:byte
		extrn	BCC_HASH_SEG1:word
		extrn	BCC_DEBUG_BUILD:far
		extrn	X055_01:far
		extrn	X055_09:far
		extrn	X02C_0E:far
		extrn	BCC_DEBUG_STREAM_HOOK:word
		extrn	X056_0D:far
		extrn	BCC_DEBUG_SEGMENT:word
		extrn	BCC_DEBUG_TYPE_HOOK:word
		extrn	X055_04:far
		extrn	X02C_15:far
		extrn	X02C_08:far
		extrn	X035_04:far
		extrn	X055_06:far
		extrn	BCC_RD_A03E_B:byte
		extrn	BCC_RD_62A0_B:byte


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

		public	X041_00
X041_00	label	far
BCC_TYPE_QUERY_FRAME	proc	far
	push	bp
	mov	bp,sp
	sub	sp,0Ah
BCC_TYPE_QUERY	label	far
	push	si
	push	di
	mov	di,word ptr [bp+6]
	cmp	di,-2
	jne	short M00B_L_C793
	mov	al,byte ptr DGROUP:BCC_RD_1714_B
	cbw
	or	ax,ax
	je	short M00B_L_C78D
	db	0E9h
	dw	00383h
M00B_L_C78D:
	db	0E8h
	dw	0052Ch
	db	0E9h
	dw	0037Dh
M00B_L_C793:
	mov	es,word ptr DGROUP:BCC_DEBUG_RECORD_SEG
	mov	si,word ptr es:[di+6]
	jmp	short M00B_L_C7B8
M00B_L_C79D:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_DEBUG_RECORD_SEG
	push	word ptr es:[di+6]
	push	cs
	db	0E8h
	dw	0F0D4h
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	si,word ptr es:[si]
M00B_L_C7B8:
	or	si,si
	jne	short M00B_L_C79D
	mov	es,word ptr DGROUP:BCC_DEBUG_RECORD_SEG
	mov	si,word ptr es:[di+4]
	db	0E9h
	dw	0009Eh
M00B_L_C7C7:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+4]
	mov	word ptr [bp-0Ah],ax
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	mov	word ptr [bp-8],ax
	cmp	word ptr [bp-8],2
	je	short M00B_L_C85E
	cmp	word ptr [bp-8],3
	je	short M00B_L_C85E
	cmp	word ptr [bp-8],0Fh
	je	short M00B_L_C85E
	cmp	word ptr [bp-8],5
	jne	short M00B_L_C808
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+6]
	mov	ah,0
	test	ax,7
	je	short M00B_L_C85E
M00B_L_C808:
	cmp	word ptr [bp-0Ah],0
	je	short M00B_L_C85E
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M00B_L_C84F
	mov	es,word ptr DGROUP:BCC_DEBUG_RECORD_SEG
	cmp	byte ptr es:[di+14h],0
	je	short M00B_L_C84F
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+2]
	cmp	ax,word ptr DGROUP:BCC_SCOPE_ID
	jne	short M00B_L_C84F
	mov	bx,word ptr [bp-0Ah]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	push	word ptr es:[bx+7]
	push	word ptr es:[bx]
	mov	al,0
	push	ax
	db	9Ah
	dw	X00A_01
	dw	seg X00A_01
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	word ptr es:[si+4],ax
	mov	word ptr [bp-0Ah],ax
M00B_L_C84F:
	push	word ptr [bp-0Ah]
	mov	es,word ptr DGROUP:BCC_DEBUG_RECORD_SEG
	push	word ptr es:[di+6]
	push	cs
	db	0E8h
	dw	0F027h
M00B_L_C85E:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	si,word ptr es:[si]
M00B_L_C865:
	or	si,si
	je	short M00B_L_C86C
	db	0E9h
	dw	0FF5Bh
M00B_L_C86C:
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0E600h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	word ptr [bp-4],1
	mov	es,word ptr DGROUP:BCC_DEBUG_RECORD_SEG
	mov	si,word ptr es:[di+4]
	db	0E9h
	dw	00266h
M00B_L_C88A:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	cmp	word ptr es:[si+4],0
	jne	short M00B_L_C898
	db	0E9h
	dw	00251h
M00B_L_C898:
	test	byte ptr es:[si+6],20h
	je	short M00B_L_C8A2
	db	0E9h
	dw	00247h
M00B_L_C8A2:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	mov	word ptr [bp-8],ax
	cmp	word ptr [bp-8],2
	jne	short M00B_L_C8BE
	db	0E9h
	dw	0022Bh
M00B_L_C8BE:
	cmp	word ptr [bp-8],3
	jne	short M00B_L_C8C7
	db	0E9h
	dw	00222h
M00B_L_C8C7:
	cmp	word ptr [bp-8],0Fh
	jne	short M00B_L_C8D0
	db	0E9h
	dw	00219h
M00B_L_C8D0:
	cmp	word ptr [bp-8],5
	jne	short M00B_L_C8E8
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+6]
	mov	ah,0
	test	ax,7
	jne	short M00B_L_C8E8
	db	0E9h
	dw	00201h
M00B_L_C8E8:
	cmp	word ptr [bp-8],0Eh
	jne	short M00B_L_C904
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+8]
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	test	byte ptr es:[bx+4],40h
	je	short M00B_L_C904
	db	0E9h
	dw	001E5h
M00B_L_C904:
	cmp	word ptr [bp-8],9
	jne	short M00B_L_C927
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx]
	mov	al,byte ptr [bx+9CAh]
	mov	ah,0
	test	ax,1
	jne	short M00B_L_C927
	db	0E9h
	dw	001C2h
M00B_L_C927:
	db	9Ah
	dw	X055_05
	dw	seg X055_05
	cmp	ax,0FA0h
	jle	short M00B_L_C936
	mov	word ptr [bp-4],1
M00B_L_C936:
	mov	ax,0E600h
	push	ax
	push	cs
	db	0E8h
	dw	0E8C2h
	inc	word ptr [bp-4]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	cmp	word ptr es:[si+2],0
	je	short M00B_L_C976
	push	ds
	mov	ax,offset DGROUP:BCC_DEBUG_NAME
	push	ax
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr es:[bx+4]
	push	word ptr [bx]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	push	word ptr es:[bx+2]
	db	9Ah
	dw	BCC_DEBUG_BUILD
	dw	seg BCC_DEBUG_BUILD
	jmp	short M00B_L_C97B
M00B_L_C976:
	mov	dx,ds
	mov	ax,offset DGROUP:BCC_DEBUG_EMPTY
M00B_L_C97B:
	push	dx
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[si+4]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	sub	ax,4
	mov	bx,ax
	cmp	bx,0Ah
	jbe	short M00B_L_C9B2
	db	0E9h
	dw	00137h
M00B_L_C9B2:
	shl	bx,1
	jmp	word ptr cs:[bx+1918h]
M00B_L_C9B9:
	mov	al,0
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	push	si
	db	9Ah
	dw	X02C_0E
	dw	seg X02C_0E
	mov	word ptr [bp-0Ah],ax
	push	word ptr [bp-0Ah]
	db	0FFh,01Eh
	dw	DGROUP:BCC_DEBUG_STREAM_HOOK
	push	ax
	db	9Ah
	dw	X056_0D
	dw	seg X056_0D
	mov	word ptr [bp-2],ax
	mov	bx,word ptr [bp-2]
	mov	es,word ptr DGROUP:BCC_DEBUG_SEGMENT
	cmp	word ptr es:[bx+2],0
	je	short M00B_L_C9F2
	mov	bx,word ptr es:[bx+2]
	mov	ax,word ptr es:[bx+2]
	jmp	short M00B_L_C9F4
M00B_L_C9F2:
	xor	ax,ax
M00B_L_C9F4:
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	bx,word ptr [bp-2]
	mov	es,word ptr DGROUP:BCC_DEBUG_SEGMENT
	push	word ptr es:[bx+4]
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	push	word ptr [bp-0Ah]
	db	0FFh,01Eh
	dw	DGROUP:BCC_DEBUG_TYPE_HOOK
M00B_L_CA11:
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	db	0E9h
	dw	000CFh
M00B_L_CA1A:
	mov	al,5
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+8]
	and	ax,0FFFFh
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+0Ah]
	cwd
	and	ax,0FFFFh
	jmp	short M00B_L_CA11
M00B_L_CA41:
	push	si
	db	9Ah
	dw	X02C_0E
	dw	seg X02C_0E
	mov	word ptr [bp-0Ah],ax
	push	word ptr [bp-0Ah]
	db	9Ah
	dw	X02C_15
	dw	seg X02C_15
	test	ax,8
	je	short M00B_L_CA6E
	mov	al,4
M00B_L_CA59:
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	push	word ptr [bp-0Ah]
	db	0FFh,01Eh
	dw	DGROUP:BCC_DEBUG_STREAM_HOOK
	push	ax
	db	9Ah
	dw	X035_04
	dw	seg X035_04
	jmp	short M00B_L_CAE3
M00B_L_CA6E:
	mov	al,2
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	push	word ptr [bp-0Ah]
	db	0FFh,01Eh
	dw	DGROUP:BCC_DEBUG_TYPE_HOOK
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	jmp	short M00B_L_CAE9
M00B_L_CA85:
	push	si
	db	9Ah
	dw	X02C_0E
	dw	seg X02C_0E
	mov	word ptr [bp-0Ah],ax
	mov	word ptr [bp-6],0
	mov	al,byte ptr DGROUP:BCC_RD_62A0_B
	mov	ah,0
	or	ax,ax
	je	short M00B_L_CAAA
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+2]
	cmp	ax,word ptr DGROUP:BCC_SCOPE_ID
	je	short M00B_L_CAAF
M00B_L_CAAA:
	mov	word ptr [bp-6],8
M00B_L_CAAF:
	push	word ptr [bp-0Ah]
	db	9Ah
	dw	X02C_15
	dw	seg X02C_15
	test	ax,8
	je	short M00B_L_CAC3
	mov	al,byte ptr [bp-6]
	or	al,4
	jmp	short M00B_L_CA59
M00B_L_CAC3:
	mov	al,byte ptr [bp-6]
	or	al,2
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	push	word ptr [bp-0Ah]
	db	0FFh,01Eh
	dw	DGROUP:BCC_DEBUG_TYPE_HOOK
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	jmp	short M00B_L_CAE9
M00B_L_CADD:
	mov	al,6
	jmp	short M00B_L_CAE3
M00B_L_CAE1:
	mov	al,7
M00B_L_CAE3:
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
M00B_L_CAE9:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	si,word ptr es:[si]
M00B_L_CAF0:
	or	si,si
	je	short M00B_L_CAF7
	db	0E9h
	dw	0FD93h
M00B_L_CAF7:
	cmp	word ptr [bp-4],1
	jle	short M00B_L_CB05
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
M00B_L_CB05:
	mov	al,byte ptr DGROUP:BCC_RD_1714_B
	cbw
	or	ax,ax
	jne	short M00B_L_CB10
	db	0E8h
	dw	001ACh
M00B_L_CB10:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf	2
BCC_TYPE_QUERY_FRAME	endp

; Case targets for the indirect type-kind dispatch.
	dw	17B9h,1841h,1885h
	dw	18E9h,18DDh,181Ah
	dw	18E9h,18E1h,18E9h
	dw	18E9h,1841h
CO041_TEXT	ends


		extrn	BCC_SYMBOL_SEGMENT2:word
		extrn	BCC_DEBUG_NAME:byte
		extrn	BCC_DEBUG_EMPTY:byte
		extrn	BCC_HASH_SEG1:word
		extrn	BCC_DEBUG_BUILD:far
		extrn	X055_01:far
		extrn	BCC_EXPR_SEGMENT:word
		extrn	X055_04:far
		extrn	X02C_08:far
		extrn	X055_09:far
		extrn	BCC_RD_A03E_B:byte
		extrn	BCC_SCOPE_ID:word
		extrn	BCC_TREE_LINK:word
		extrn	BCC_DEBUG_RECORD_SEG:word
		extrn	X02C_13:far
		extrn	X02C_0E:far
		extrn	BCC_DEBUG_TYPE_HOOK:word
		extrn	X055_0E:far


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

BCC_TYPE_COUNT	proc	near
	inc	bp
	push	bp
	mov	bp,sp
	dec	sp
	dec	sp
	push	si
	push	di
	mov	si,word ptr [bp+6]
	mov	di,word ptr [bp+4]
	or	si,si
	jne	short M00C_L_CB45
	mov	ax,di
	db	0E9h
	dw	000E3h
M00C_L_CB45:
	mov	es,word ptr DGROUP:BCC_SYMBOL_SEGMENT2
	push	word ptr es:[si]
	push	di
	db	0E8h
	dw	0FFDEh
	mov	di,ax
	mov	es,word ptr DGROUP:BCC_SYMBOL_SEGMENT2
	cmp	word ptr es:[si+4],0
	je	short M00C_L_CB87
	push	ds
	mov	ax,offset DGROUP:BCC_DEBUG_NAME
	push	ax
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr es:[bx+4]
	push	word ptr [bx]
	mov	es,word ptr DGROUP:BCC_SYMBOL_SEGMENT2
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	push	word ptr es:[bx+2]
	db	9Ah
	dw	BCC_DEBUG_BUILD
	dw	seg BCC_DEBUG_BUILD
	jmp	short M00C_L_CB8C
M00C_L_CB87:
	mov	dx,ds
	mov	ax,offset DGROUP:BCC_DEBUG_EMPTY
M00C_L_CB8C:
	push	dx
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
	mov	es,word ptr DGROUP:BCC_SYMBOL_SEGMENT2
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	word ptr es:[bx],9
	jne	short M00C_L_CBC2
	mov	es,word ptr DGROUP:BCC_SYMBOL_SEGMENT2
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	test	byte ptr es:[bx+0Ch],8
	je	short M00C_L_CBC2
	mov	al,0Fh
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	jmp	short M00C_L_CBD5
M00C_L_CBC2:
	mov	es,word ptr DGROUP:BCC_SYMBOL_SEGMENT2
	push	word ptr es:[si+2]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
M00C_L_CBD5:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M00C_L_CBEE
	mov	es,word ptr DGROUP:BCC_SYMBOL_SEGMENT2
	mov	ax,word ptr es:[si+4]
	cmp	ax,word ptr DGROUP:BCC_SCOPE_ID
	jne	short M00C_L_CBEE
	mov	al,2
	jmp	short M00C_L_CBF0
M00C_L_CBEE:
	mov	al,0Ah
M00C_L_CBF0:
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	es,word ptr DGROUP:BCC_SYMBOL_SEGMENT2
	push	word ptr es:[si+4]
	mov	bx,word ptr DGROUP:BCC_TREE_LINK
	mov	es,word ptr DGROUP:BCC_DEBUG_RECORD_SEG
	push	word ptr es:[bx+4]
	db	9Ah
	dw	X02C_13
	dw	seg X02C_13
	mov	word ptr [bp-2],ax
	push	word ptr [bp-2]
	db	9Ah
	dw	X02C_0E
	dw	seg X02C_0E
	push	ax
	db	0FFh,01Eh
	dw	DGROUP:BCC_DEBUG_TYPE_HOOK
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	ax,di
	inc	ax
M00C_L_CC28:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	dec	bp
	ret	4
BCC_TYPE_COUNT	endp
CO041_TEXT	ends

; Target-qualified reference aliases (zero bytes)
BCC_RN_8000_CCBC	equ	BCC_TYPE_COUNT+18Eh

		extrn	BCC_DEBUG_ACTIVE:word
		extrn	X055_03:far
		extrn	X055_0E:far
		extrn	BCC_TREE_SPECIAL:word
		extrn	X040_02:far
		extrn	X055_06:far
		extrn	BCC_TREE_ROOT2:word
		extrn	BCC_EXPR_SEGMENT:word
		extrn	BCC_SYMBOL_SEGMENT2:word


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

		public	X041_06
X041_06	label	far
BCC_TYPE_EMIT_FINISH	proc	far
	push	bp
	mov	bp,sp
	push	si
	cmp	word ptr DGROUP:BCC_DEBUG_ACTIVE,0
	je	short M00D_L_CC5E
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0F800h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	push	word ptr DGROUP:BCC_TREE_SPECIAL
	xor	ax,ax
	push	ax
	db	9Ah
	dw	X040_02
	dw	seg X040_02
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
M00D_L_CC5E:
	mov	bx,word ptr DGROUP:BCC_TREE_ROOT2
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	si,word ptr es:[bx+9]
	jmp	short M00D_L_CC82
M00D_L_CC6C:
	mov	es,word ptr DGROUP:BCC_SYMBOL_SEGMENT2
	push	word ptr es:[si+2]
	xor	ax,ax
	push	ax
	push	cs
	db	0E8h
	dw	0EC0Ah
	mov	es,word ptr DGROUP:BCC_SYMBOL_SEGMENT2
	mov	si,word ptr es:[si]
M00D_L_CC82:
	or	si,si
	jne	short M00D_L_CC6C
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0E600h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	bx,word ptr DGROUP:BCC_TREE_ROOT2
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	si,word ptr es:[bx+9]
	or	si,si
	je	short M00D_L_CCB9
	push	si
	mov	ax,1
	push	ax
	db	0E8h
	dw	0FE82h
	cmp	ax,1
	jle	short M00D_L_CCB9
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
M00D_L_CCB9:
	pop	si
	pop	bp
	retf
BCC_TYPE_EMIT_FINISH	endp
CO041_TEXT	ends

CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT
; Original-image layout stub: not recovered source


		db	045h,055h,08Bh,0ECh,04Ch,04Ch,08Bh,01Eh,0A2h,088h,08Eh,006h,094h,088h	; ovr_1ce0_8b20:CCBC
		db	026h,08Bh,047h,00Ch,089h,046h,0FEh,09Ah
		dw	02Fh
		dw	seg CO055_TEXT
		db	0B8h,000h; ovr_1ce0_8b20:CCCA
		db	0E7h,050h,09Ah
		dw	066h
		dw	seg CO055_TEXT
		db	0FFh,076h,0FEh,09Ah
		dw	066h
		dw	seg CO055_TEXT
		db	0B0h,088h,050h,09Ah
		dw	03Eh
		dw	seg CO055_TEXT
		db	08Bh,0E5h,05Dh,04Dh,0C3h; ovr_1ce0_8b20:CCD8

CO041_TEXT	ends

		extrn	BCC_RD_A03E_B:byte
		extrn	BCC_HASH_SEG1:word
		extrn	BCC_HASH_SEG2:word
		extrn	BCC_TYPE_SEGMENT:word
		extrn	X02C_08:far
		extrn	BCC_RD_5EC6_W:word
		extrn	BCC_EXPR_SEGMENT:word
		extrn	X055_03:far
		extrn	X055_0E:far
		extrn	X03A_01:far
		extrn	X055_09:far
		extrn	X055_06:far
		extrn	X03F_0E:far
		extrn	X02C_15:far
		extrn	X055_04:far
		extrn	BCC_RD_63A4_W:word
		extrn	BCC_EXPR_LINKSEG:word
		extrn	BCC_MEMBER_SEGMENT:word
		extrn	BCC_DEBUG_NAME:byte
		extrn	BCC_DEBUG_BUILD:far
		extrn	X055_01:far


CO041_TEXT	segment byte public 'CODE'
		assume	cs:CO041_TEXT,ds:DGROUP

M00F_BCC_HASH_HEADS	equ	78ACh

		public	X041_02
X041_02	label	far
BCC_SYMBOL_SWEEP2	proc	far
	push	bp
	mov	bp,sp
	sub	sp,0Ch
	push	si
	push	di
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	jne	short M00F_L_CD06
	db	0E9h
	dw	000BAh
M00F_L_CD06:
	mov	word ptr [bp-4],0
	db	0E9h
	dw	000A8h
M00F_L_CD0E:
	mov	bx,word ptr [bp-4]
	shl	bx,1
	mov	ax,word ptr [bx+M00F_BCC_HASH_HEADS]
	db	0E9h
	dw	0008Dh
M00F_L_CD1A:
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr [bp-6]
	mov	di,word ptr es:[bx]
	jmp	short M00F_L_CD99
M00F_L_CD26:
	mov	si,di
M00F_L_CD28:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,0Bh
	jne	short M00F_L_CD5A
	push	word ptr es:[si+4]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	or	ax,ax
	je	short M00F_L_CD5A
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[si+4]
	push	word ptr DGROUP:BCC_RD_5EC6_W
	push	cs
	db	0E8h
	dw	0EB2Bh
M00F_L_CD5A:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M00F_L_CD92
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,8
	je	short M00F_L_CD92
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	word ptr es:[bx],12h
	jne	short M00F_L_CD92
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+13h]
	mov	si,ax
	or	ax,ax
	jne	short M00F_L_CD28
M00F_L_CD92:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	di,word ptr es:[di]
M00F_L_CD99:
	or	di,di
	jne	short M00F_L_CD26
	mov	es,word ptr DGROUP:BCC_HASH_SEG2
	mov	bx,word ptr [bp-6]
	mov	ax,word ptr es:[bx]
M00F_L_CDA7:
	mov	word ptr [bp-6],ax
	cmp	word ptr [bp-6],0
	je	short M00F_L_CDB3
	db	0E9h
	dw	0FF67h
M00F_L_CDB3:
	inc	word ptr [bp-4]
M00F_L_CDB6:
	cmp	word ptr [bp-4],400h
	jge	short M00F_L_CDC0
	db	0E9h
	dw	0FF4Eh
M00F_L_CDC0:
	mov	word ptr [bp-4],0
	db	0E9h
	dw	001A8h
M00F_L_CDC8:
	mov	bx,word ptr [bp-4]
	shl	bx,1
	mov	ax,word ptr [bx+M00F_BCC_HASH_HEADS]
	db	0E9h
	dw	0018Dh
M00F_L_CDD4:
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr [bp-6]
	mov	di,word ptr es:[bx]
	db	0E9h
	dw	0016Fh
M00F_L_CDE1:
	mov	si,di
M00F_L_CDE3:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,1
	jne	short M00F_L_CDFB
	db	0E9h
	dw	0008Bh
M00F_L_CDFB:
	cmp	ax,2
	je	short M00F_L_CE08
	cmp	ax,3
	je	short M00F_L_CE57
	db	0E9h
	dw	00106h
M00F_L_CE08:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	test	byte ptr es:[si+6],4
	jne	short M00F_L_CE16
	db	0E9h
	dw	000F8h
M00F_L_CE16:
	push	word ptr es:[si+4]
	push	word ptr DGROUP:BCC_RD_5EC6_W
	push	cs
	db	0E8h
	dw	0EA63h
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0EB00h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	push	si
	xor	ax,ax
	push	ax
	db	9Ah
	dw	X03A_01
	dw	seg X03A_01
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[si+4]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
	db	0E9h
	dw	000B7h
M00F_L_CE57:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	cmp	word ptr es:[si+8],0
	je	short M00F_L_CE73
	push	si
	db	9Ah
	dw	00066h
	dw	seg CO02C_TEXT
	push	ax
	db	9Ah
	dw	X02C_15
	dw	seg X02C_15
	test	ax,100h
	jne	short M00F_L_CE86
M00F_L_CE73:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[si+4]
	push	word ptr DGROUP:BCC_RD_5EC6_W
	push	cs
	db	0E8h
	dw	0EA02h
	db	0E9h
	dw	00088h
M00F_L_CE86:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[si+4]
	push	word ptr DGROUP:BCC_RD_5EC6_W
	push	cs
	db	0E8h
	dw	0E9EFh
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0EC00h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	push	si
	xor	ax,ax
	push	ax
	db	9Ah
	dw	X03A_01
	dw	seg X03A_01
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[si+4]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	word ptr es:[bx],12h
	jne	short M00F_L_CEFE
	push	si
	db	9Ah
	dw	00066h
	dw	seg CO02C_TEXT
	push	ax
	db	9Ah
	dw	X02C_15
	dw	seg X02C_15
	test	ax,20h
	je	short M00F_L_CEFE
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	byte ptr es:[bx+0Bh],4
	jne	short M00F_L_CEFA
	mov	al,98h
	jmp	short M00F_L_CEFC
M00F_L_CEFA:
	mov	al,18h
M00F_L_CEFC:
	jmp	short M00F_L_CF00
M00F_L_CEFE:
	mov	al,0
M00F_L_CF00:
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
M00F_L_CF0E:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M00F_L_CF49
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,8
	je	short M00F_L_CF49
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	word ptr es:[bx],12h
	jne	short M00F_L_CF49
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+13h]
	mov	si,ax
	or	ax,ax
	je	short M00F_L_CF49
	db	0E9h
	dw	0FE9Ah
M00F_L_CF49:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	di,word ptr es:[di]
M00F_L_CF50:
	or	di,di
	je	short M00F_L_CF57
	db	0E9h
	dw	0FE8Ah
M00F_L_CF57:
	mov	es,word ptr DGROUP:BCC_HASH_SEG2
	mov	bx,word ptr [bp-6]
	mov	ax,word ptr es:[bx]
M00F_L_CF61:
	mov	word ptr [bp-6],ax
	cmp	word ptr [bp-6],0
	je	short M00F_L_CF6D
	db	0E9h
	dw	0FE67h
M00F_L_CF6D:
	inc	word ptr [bp-4]
M00F_L_CF70:
	cmp	word ptr [bp-4],400h
	jge	short M00F_L_CF7A
	db	0E9h
	dw	0FE4Eh
M00F_L_CF7A:
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0E600h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	mov	word ptr [bp-2],0
	mov	word ptr [bp-4],0
	db	0E9h
	dw	002B7h
M00F_L_CF95:
	mov	bx,word ptr [bp-4]
	shl	bx,1
	mov	ax,word ptr [bx+M00F_BCC_HASH_HEADS]
	db	0E9h
	dw	0029Ch
M00F_L_CFA1:
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr [bp-6]
	mov	di,word ptr es:[bx]
	db	0E9h
	dw	0027Eh
M00F_L_CFAE:
	mov	si,di
M00F_L_CFB0:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,3
	jne	short M00F_L_D040
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	word ptr es:[bx],12h
	jne	short M00F_L_D01D
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+0Ch]
	mov	ah,0
	and	ax,3
	cmp	ax,1
	jne	short M00F_L_D01D
	test	word ptr es:[si+0Ah],2
	jne	short M00F_L_CFF0
	db	0E9h
	dw	001FAh
M00F_L_CFF0:
	cmp	word ptr [bp-2],0
	je	short M00F_L_D003
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
	mov	word ptr [bp-2],0
M00F_L_D003:
	push	si
	push	word ptr DGROUP:BCC_RD_5EC6_W
	push	cs
	db	0E8h
	dw	0EE37h
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0E600h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	db	0E9h
	dw	001CDh
M00F_L_D01D:
	cmp	si,word ptr DGROUP:BCC_RD_63A4_W
	jne	short M00F_L_D026
	db	0E9h
	dw	001C4h
M00F_L_D026:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	test	byte ptr es:[si+6],2
	jne	short M00F_L_D034
	db	0E9h
	dw	001B6h
M00F_L_D034:
	push	si
	db	0E8h
	dw	0F62Fh
	mov	word ptr [bp-2],1
	db	0E9h
	dw	001AAh
M00F_L_D040:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	jne	short M00F_L_D04A
	db	0E9h
	dw	001A0h
M00F_L_D04A:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx]
	test	byte ptr [bx+09CAh],40h
	jne	short M00F_L_D063
	db	0E9h
	dw	00187h
M00F_L_D063:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	test	word ptr es:[bx+18h],1
	jne	short M00F_L_D082
	db	0E9h
	dw	00168h
M00F_L_D082:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	mov	bx,word ptr es:[bx+5]
	mov	es,word ptr DGROUP:BCC_EXPR_LINKSEG
	mov	ax,word ptr es:[bx+2]
	db	0E9h
	dw	00141h
M00F_L_D09D:
	mov	bx,word ptr [bp-8]
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	al,byte ptr es:[bx+4]
	mov	ah,0
	and	ax,3
	cmp	ax,3
	je	short M00F_L_D0B5
	db	0E9h
	dw	0011Fh
M00F_L_D0B5:
	mov	bx,word ptr [bp-8]
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	ax,word ptr es:[bx+6]
	db	0E9h
	dw	00105h
M00F_L_D0C3:
	mov	bx,word ptr [bp-0Ah]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[bx+6]
	mov	ah,0
	test	ax,20h
	je	short M00F_L_D0D8
	db	0E9h
	dw	000E5h
M00F_L_D0D8:
	mov	al,byte ptr es:[bx+0Ch]
	mov	ah,0
	and	ax,3
	cmp	ax,1
	jne	short M00F_L_D11D
	test	word ptr es:[bx+0Ah],2
	je	short M00F_L_D11D
	cmp	word ptr [bp-2],0
	je	short M00F_L_D101
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
	mov	word ptr [bp-2],0
M00F_L_D101:
	push	word ptr [bp-0Ah]
	push	word ptr DGROUP:BCC_RD_5EC6_W
	push	cs
	db	0E8h
	dw	0ED37h
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0E600h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	db	0E9h
	dw	000A0h
M00F_L_D11D:
	mov	bx,word ptr [bp-0Ah]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	test	byte ptr es:[bx+0Ch],3
	je	short M00F_L_D12E
	db	0E9h
	dw	0008Fh
M00F_L_D12E:
	test	byte ptr es:[bx+6],2
	jne	short M00F_L_D138
	db	0E9h
	dw	00085h
M00F_L_D138:
	mov	ax,word ptr es:[bx+4]
	mov	word ptr [bp-0Ch],ax
	cmp	word ptr [bp-2],0
	je	short M00F_L_D152
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
	mov	word ptr [bp-2],0
M00F_L_D152:
	push	word ptr [bp-0Ch]
	push	word ptr DGROUP:BCC_RD_5EC6_W
	push	cs
	db	0E8h
	dw	0E728h
	db	9Ah
	dw	X055_03
	dw	seg X055_03
	mov	ax,0EC00h
	push	ax
	db	9Ah
	dw	X055_0E
	dw	seg X055_0E
	push	word ptr [bp-0Ah]
	xor	ax,ax
	push	ax
	db	9Ah
	dw	X03A_01
	dw	seg X03A_01
	push	word ptr [bp-0Ch]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	push	ax
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	push	word ptr [bp-0Ah]
	db	9Ah
	dw	00066h
	dw	seg CO02C_TEXT
	push	ax
	db	9Ah
	dw	X02C_15
	dw	seg X02C_15
	test	ax,20h
	je	short M00F_L_D1AD
	mov	bx,word ptr [bp-0Ch]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	byte ptr es:[bx+0Bh],4
	jne	short M00F_L_D1A9
	mov	al,98h
	jmp	short M00F_L_D1AB
M00F_L_D1A9:
	mov	al,18h
M00F_L_D1AB:
	jmp	short M00F_L_D1AF
M00F_L_D1AD:
	mov	al,0
M00F_L_D1AF:
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
M00F_L_D1BD:
	mov	bx,word ptr [bp-0Ah]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[bx+13h]
M00F_L_D1C8:
	mov	word ptr [bp-0Ah],ax
	cmp	word ptr [bp-0Ah],0
	je	short M00F_L_D1D4
	db	0E9h
	dw	0FEEFh
M00F_L_D1D4:
	mov	es,word ptr DGROUP:BCC_MEMBER_SEGMENT
	mov	bx,word ptr [bp-8]
	mov	ax,word ptr es:[bx]
M00F_L_D1DE:
	mov	word ptr [bp-8],ax
	cmp	word ptr [bp-8],0
	je	short M00F_L_D1EA
	db	0E9h
	dw	0FEB3h
M00F_L_D1EA:
	cmp	byte ptr DGROUP:BCC_RD_A03E_B,0
	je	short M00F_L_D225
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,8
	je	short M00F_L_D225
	mov	bx,word ptr es:[si+4]
	mov	es,word ptr DGROUP:BCC_EXPR_SEGMENT
	cmp	word ptr es:[bx],12h
	jne	short M00F_L_D225
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	ax,word ptr es:[si+13h]
	mov	si,ax
	or	ax,ax
	je	short M00F_L_D225
	db	0E9h
	dw	0FD8Bh
M00F_L_D225:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	di,word ptr es:[di]
M00F_L_D22C:
	or	di,di
	je	short M00F_L_D233
	db	0E9h
	dw	0FD7Bh
M00F_L_D233:
	mov	es,word ptr DGROUP:BCC_HASH_SEG2
	mov	bx,word ptr [bp-6]
	mov	ax,word ptr es:[bx]
M00F_L_D23D:
	mov	word ptr [bp-6],ax
	cmp	word ptr [bp-6],0
	je	short M00F_L_D249
	db	0E9h
	dw	0FD58h
M00F_L_D249:
	inc	word ptr [bp-4]
M00F_L_D24C:
	cmp	word ptr [bp-4],400h
	jge	short M00F_L_D256
	db	0E9h
	dw	0FD3Fh
M00F_L_D256:
	mov	word ptr [bp-4],0
	db	0E9h
	dw	000C2h
M00F_L_D25E:
	mov	bx,word ptr [bp-4]
	shl	bx,1
	mov	ax,word ptr [bx+M00F_BCC_HASH_HEADS]
	db	0E9h
	dw	000A7h
M00F_L_D26A:
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr [bp-6]
	mov	si,word ptr es:[bx]
	db	0E9h
	dw	00089h
M00F_L_D277:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[si+4]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	mov	word ptr [bp-8],ax
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,8
	jne	short M00F_L_D2F9
	cmp	word ptr es:[si+2],0
	je	short M00F_L_D2F9
	cmp	word ptr [bp-8],0
	je	short M00F_L_D2F9
	mov	ax,0E600h
	push	ax
	push	cs
	db	0E8h
	dw	0DF4Fh
	mov	word ptr [bp-2],1
	push	ds
	mov	ax,offset DGROUP:BCC_DEBUG_NAME
	push	ax
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr es:[bx+4]
	push	word ptr [bx]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	push	word ptr es:[bx+2]
	db	9Ah
	dw	BCC_DEBUG_BUILD
	dw	seg BCC_DEBUG_BUILD
	push	dx
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
	push	word ptr [bp-8]
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	al,6
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
M00F_L_D2F9:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	si,word ptr es:[si]
M00F_L_D300:
	or	si,si
	je	short M00F_L_D307
	db	0E9h
	dw	0FF70h
M00F_L_D307:
	mov	es,word ptr DGROUP:BCC_HASH_SEG2
	mov	bx,word ptr [bp-6]
	mov	ax,word ptr es:[bx]
M00F_L_D311:
	mov	word ptr [bp-6],ax
	cmp	word ptr [bp-6],0
	je	short M00F_L_D31D
	db	0E9h
	dw	0FF4Dh
M00F_L_D31D:
	inc	word ptr [bp-4]
M00F_L_D320:
	cmp	word ptr [bp-4],400h
	jge	short M00F_L_D32A
	db	0E9h
	dw	0FF34h
M00F_L_D32A:
	mov	word ptr [bp-4],0
	db	0E9h
	dw	000C9h
M00F_L_D332:
	mov	bx,word ptr [bp-4]
	shl	bx,1
	mov	ax,word ptr [bx+M00F_BCC_HASH_HEADS]
	db	0E9h
	dw	000AEh
M00F_L_D33E:
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr [bp-6]
	mov	si,word ptr es:[bx]
	db	0E9h
	dw	00090h
M00F_L_D34B:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	push	word ptr es:[si+4]
	db	9Ah
	dw	X02C_08
	dw	seg X02C_08
	mov	word ptr [bp-8],ax
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	al,byte ptr es:[si+7]
	mov	ah,0
	sar	ax,1
	sar	ax,1
	sar	ax,1
	cmp	ax,0Bh
	jne	short M00F_L_D3D4
	cmp	word ptr es:[si+4],0
	je	short M00F_L_D3D4
	cmp	word ptr [bp-8],0
	je	short M00F_L_D3D4
	cmp	word ptr es:[si+2],0
	je	short M00F_L_D3D4
	mov	ax,0E600h
	push	ax
	push	cs
	db	0E8h
	dw	0DE74h
	mov	word ptr [bp-2],1
	push	ds
	mov	ax,offset DGROUP:BCC_DEBUG_NAME
	push	ax
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	mov	bx,word ptr es:[bx+4]
	push	word ptr [bx]
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	bx,word ptr es:[si+2]
	mov	es,word ptr DGROUP:BCC_HASH_SEG1
	push	word ptr es:[bx+2]
	db	9Ah
	dw	BCC_DEBUG_BUILD
	dw	seg BCC_DEBUG_BUILD
	push	dx
	push	ax
	db	9Ah
	dw	X055_01
	dw	seg X055_01
	push	word ptr [bp-8]
	db	9Ah
	dw	X055_09
	dw	seg X055_09
	mov	al,7
	push	ax
	db	9Ah
	dw	X055_04
	dw	seg X055_04
M00F_L_D3D4:
	mov	es,word ptr DGROUP:BCC_TYPE_SEGMENT
	mov	si,word ptr es:[si]
M00F_L_D3DB:
	or	si,si
	je	short M00F_L_D3E2
	db	0E9h
	dw	0FF69h
M00F_L_D3E2:
	mov	es,word ptr DGROUP:BCC_HASH_SEG2
	mov	bx,word ptr [bp-6]
	mov	ax,word ptr es:[bx]
M00F_L_D3EC:
	mov	word ptr [bp-6],ax
	cmp	word ptr [bp-6],0
	je	short M00F_L_D3F8
	db	0E9h
	dw	0FF46h
M00F_L_D3F8:
	inc	word ptr [bp-4]
M00F_L_D3FB:
	cmp	word ptr [bp-4],400h
	jge	short M00F_L_D405
	db	0E9h
	dw	0FF2Dh
M00F_L_D405:
	cmp	word ptr [bp-2],0
	je	short M00F_L_D413
	mov	al,88h
	push	ax
	db	9Ah
	dw	X055_06
	dw	seg X055_06
M00F_L_D413:
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	retf
BCC_SYMBOL_SWEEP2	endp
CO041_TEXT	ends

; END C127UNIT
		end
