		public	X038_00
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1cb7_853f
; BEGIN CODEMASK (listing ovr_1cb7_853f:53F0)

	extrn	BCC_MASK_A:word
	extrn	BCC_MASK_B:word
	extrn	BCC_MASK_C:word


CO038_TEXT	segment byte public 'CODE'
	assume	cs:CO038_TEXT,ds:DGROUP

		public	X038_00
X038_00	label	far
BCC_CODE_MASK	proc	far
	push	bp
	mov	bp,sp
	mov	al,byte ptr [bp+6]
	mov	ah,0
	dec	ax
	mov	bx,ax
	cmp	bx,5
	jbe	short M000_@@DISPATCH
	jmp	M000_@@DONE
M000_@@DISPATCH:
	shl	bx,1
	db	02Eh,0FFh,0A7h,0F0h,000h
M000_@@CASE_A:
	mov	ax,word ptr DGROUP:BCC_MASK_A+2
	mov	dx,word ptr DGROUP:BCC_MASK_A
	and	word ptr [bp+8],dx
	and	word ptr [bp+10],ax
M000_@@SHIFT_A:
	add	dx,1
	adc	ax,0
	sar	ax,1
	rcr	dx,1
	mov	bx,word ptr [bp+10]
	mov	cx,word ptr [bp+8]
	and	cx,dx
	and	bx,ax
	or	cx,bx
	jne	short M000_@@INVERT_A
	jmp	M000_@@DONE
M000_@@INVERT_A:
	mov	ax,word ptr DGROUP:BCC_MASK_A+2
	mov	dx,word ptr DGROUP:BCC_MASK_A
	not	dx
	not	ax
	or	word ptr [bp+8],dx
	or	word ptr [bp+10],ax
	jmp	M000_@@DONE
M000_@@LOAD_A:
	mov	ax,word ptr DGROUP:BCC_MASK_A+2
	mov	dx,word ptr DGROUP:BCC_MASK_A
	jmp	M000_@@APPLY_C
M000_@@CASE_B:
	mov	ax,word ptr DGROUP:BCC_MASK_B+2
	mov	dx,word ptr DGROUP:BCC_MASK_B
	and	word ptr [bp+8],dx
	and	word ptr [bp+10],ax
M000_@@SHIFT_B:
	add	dx,1
	adc	ax,0
	sar	ax,1
	rcr	dx,1
	mov	bx,word ptr [bp+10]
	mov	cx,word ptr [bp+8]
	and	cx,dx
	and	bx,ax
	or	cx,bx
	je	short M000_@@DONE
	mov	ax,word ptr DGROUP:BCC_MASK_B+2
	mov	dx,word ptr DGROUP:BCC_MASK_B
	not	dx
	not	ax
	or	word ptr [bp+8],dx
	or	word ptr [bp+10],ax
	jmp	short M000_@@DONE
M000_@@LOAD_B:
	mov	ax,word ptr DGROUP:BCC_MASK_B+2
	mov	dx,word ptr DGROUP:BCC_MASK_B
	jmp	short M000_@@APPLY_C
M000_@@CASE_C:
	mov	ax,word ptr DGROUP:BCC_MASK_C+2
	mov	dx,word ptr DGROUP:BCC_MASK_C
	and	word ptr [bp+8],dx
	and	word ptr [bp+10],ax
M000_@@SHIFT_C:
	add	dx,1
	adc	ax,0
	sar	ax,1
	rcr	dx,1
	mov	bx,word ptr [bp+10]
	mov	cx,word ptr [bp+8]
	and	cx,dx
	and	bx,ax
	or	cx,bx
	je	short M000_@@DONE
	mov	ax,word ptr DGROUP:BCC_MASK_C+2
	mov	dx,word ptr DGROUP:BCC_MASK_C
	not	dx
	not	ax
	or	word ptr [bp+8],dx
	or	word ptr [bp+10],ax
	jmp	short M000_@@DONE
M000_@@LOAD_C:
	mov	ax,word ptr DGROUP:BCC_MASK_C+2
	mov	dx,word ptr DGROUP:BCC_MASK_C
M000_@@APPLY_C:
	and	word ptr [bp+8],dx
	and	word ptr [bp+10],ax
M000_@@DONE:
	mov	dx,word ptr [bp+10]
	mov	ax,word ptr [bp+8]
	pop	bp
	retf	6
BCC_CODE_MASK	endp
CO038_TEXT	ends

CO038_TEXT	segment byte public 'CODE'
		assume	cs:CO038_TEXT
; Original-image layout stub: not recovered source


		db	01Ah,000h,056h,000h,060h,000h,098h,000h,0A1h,000h,0D9h,000h	; ovr_1cb7_853f:54E0

CO038_TEXT	ends
; END CODEMASK
		end
