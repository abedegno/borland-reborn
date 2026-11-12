		public	X037_00
DGROUP	group	_DATA,_BSS
_DATA	segment para public 'DATA'
_DATA	ends
_BSS	segment word public 'DATA'
_BSS	ends
; Consolidated original-order group ovr_1cb4_853c
; BEGIN FILETIME (listing ovr_1cb4_853c:53C0)

	extrn	BCC_RF_1A86_0002:far


CO037_TEXT	segment byte public 'CODE'
	assume	cs:CO037_TEXT,ds:DGROUP

		public	X037_00
X037_00	label	far
BCC_FILE_TIME	proc	far
	push	bp
	mov	bp,sp
	sub	sp,44
	push	word ptr [bp+8]
	push	word ptr [bp+6]
	push	ss
	lea	ax,[bp-44]
	push	ax
	xor	ax,ax
	push	ax
	db	9Ah
	dw	BCC_RF_1A86_0002
	dw	seg BCC_RF_1A86_0002
	or	ax,ax
	jne	short M000_@@MISSING
	mov	dx,word ptr [bp-20]
	mov	ax,word ptr [bp-22]
	jmp	short M000_@@DONE
M000_@@MISSING:
	xor	dx,dx
	xor	ax,ax
M000_@@DONE:
	mov	sp,bp
	pop	bp
	retf	4
BCC_FILE_TIME	endp
CO037_TEXT	ends

; END FILETIME
		end
