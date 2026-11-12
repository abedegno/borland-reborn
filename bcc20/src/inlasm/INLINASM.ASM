; /* target: CODE_8_R8UNIT */
; /* opts: /ml */
;
; CODE_8: BCC's built-in inline assembler (resident).  Hand-written
; assembly: one module with a single far entry,
;
;     int far pascal ASM_ASSEMBLE_STATEMENT(char far * far *text, unsigned length,
;                                 int mode);
;
; called from BLKLAYOT for each asm statement.  It returns 0 or a positive
; value on success and a negative code that the caller maps to an error
; message.  Its 0x1C0-byte frame holds the parser state, shared by the
; near routines through BP.
;
; Layout: the statement driver and operand parser, an expression evaluator
; (one routine per precedence level; most have a table of operator token,
; handler offset pairs walked by ASM_MATCH_OPERATOR_TABLE, where a handler is the
; table's address plus its word), number scanning with B/O/D/H radix suffixes and
; one digit accumulator per radix (acc_*), instruction encoding, and at
; the end the opcode table (ASM_MNEMONIC_HASH_TABLE) and the register-name table
; (ASM_KEYWORD_HASH_TABLE).
;
; The module is 8,119 bytes: its last 11 bytes (the end of the DS entry
; and the 8087 "ST" entry) lie at or after 1970:0000, where CODE_9's
; paragraph begins, so CODE_9's code starts at 1970:000B.
;
; The segment starts 4 bytes into paragraph 1775h (CODE_7 ends there), so
; code offsets the module loads as numbers are written as `offset label`;
; the linker adds the 4.  The section comments name the listing modules
; the earlier reconstruction split this module into.

DGROUP		group	_DATA,_BSS
_DATA		segment word public 'DATA'
_DATA		ends
_BSS		segment word public 'BSS'
_BSS		ends

		extrn	DECODE_ASM_SYMBOL:far
		extrn	EMIT_ASM_BYTE:far
		extrn	EMIT_ASM_FIXUP_OPERAND:far
		extrn	EMIT_SEGMENT_PREFIX:far
		extrn	ASM_FLUSH_KIND2_STUB:far
		extrn	ASM_COLON_LABEL_STUB:far

; Operator keyword tokens (the payload byte of each entry in the register
; table ASM_KEYWORD_HASH_TABLE); the dispatch tables are keyed by them.
TOK_NOT		equ	43h
TOK_OFFSET		equ	44h
TOK_SEG		equ	45h
TOK_TYPE		equ	46h
TOK_OR		equ	48h
TOK_XOR		equ	49h
TOK_AND		equ	4Ah
TOK_MOD		equ	4Bh
TOK_SHR		equ	4Ch
TOK_SHL		equ	4Dh
TOK_HIGH		equ	4Eh
TOK_LOW		equ	4Fh
TOK_PTR		equ	50h

CODE8		segment byte public 'CODE'
		assume	cs:CODE8,ds:DGROUP

; ---- R8MAIN (CODE_8:0004) ----

		public	ASM_ASSEMBLE_STATEMENT

ASM_ASSEMBLE_STATEMENT	proc	far
		push	bp
		mov	bp,sp
		sub	sp,1C0h
		call	ASM_INIT_STATE
		mov	byte ptr [bp-1Bh],1
		call	ASM_NEXT_TOKEN
		mov	ax,word ptr [bp-12h]
		mov	word ptr [bp-14h],ax
		call	ASM_PARSE_LABEL_PREFIX
		call	ASM_PARSE_PREFIXES
		dec	byte ptr [bp-1Bh]
		call	ASM_PARSE_DATA_DIRECTIVE
		je	short ASM_STMT_FLUSH
		mov	al,3Bh
		call	ASM_ACCEPT_TOKEN
		je	short ASM_STMT_PARSE_INSTRUCTION
		call	ASM_EMIT_PREFIX_LIST
		jmp	short ASM_STMT_FLUSH
ASM_STMT_PARSE_INSTRUCTION:
		mov	al,41h
		call	ASM_EXPECT_TOKEN
		call	ASM_PARSE_OPERANDS
		call	ASM_ENCODE_INSTRUCTION
ASM_STMT_FLUSH:
		call	ASM_FLUSH_EMIT_RECORDS
		xor	ax,ax
ASM_STATEMENT_EXIT:
		mov	cx,word ptr [bp-12h]
		lds	bx,[bp+0Ah]
		mov	word ptr [bx],cx
		mov	si,word ptr [bp-4]
		mov	di,word ptr [bp-6]
		mov	sp,bp
		pop	bp
		retf	8
ASM_ASSEMBLE_STATEMENT	endp
		public	ASM_STATEMENT_EXIT

; ---- R8INIT (CODE_8:0059) ----

		public	ASM_INIT_STATE

ASM_INIT_STATE	proc	near
		mov	word ptr [bp-4],si
		mov	word ptr [bp-6],di
		lea	ax,[bp+0FA58h]
		mov	word ptr [bp-8],ax
		les	bx,[bp+0Ah]
		les	bx,es:[bx]
		mov	word ptr [bp-12h],bx
		mov	word ptr [bp-10h],es
		xor	ax,ax
		mov	word ptr [bp-14h],ax
		mov	word ptr [bp-3Ah],ax
		mov	word ptr [bp-38h],ax
		mov	word ptr [bp-0Eh],ax
		mov	word ptr [bp+0FEF0h],ax
		mov	byte ptr [bp-25h],al
		ret
ASM_INIT_STATE	endp

; ---- R8FLUSH (CODE_8:0088) ----

		public	ASM_FLUSH_EMIT_RECORDS

ASM_FLUSH_EMIT_RECORDS	proc	near
		lea	si,[bp+0FE82h]
ASM_FLUSH_RECORD_LOOP:
		sub	word ptr [bp+0FEF0h],0Ah
		jc	short ASM_FLUSH_DONE
		cld
		push	si
		xor	ax,ax
		lodsb
		mov	bx,ax
		lodsb
		mov	cx,ax
		lodsw
		xchg	ax,dx
		lodsw
		xchg	ax,dx
		dec	bx
		js	short ASM_FLUSH_KIND0_BYTE
		je	short ASM_FLUSH_KIND1_FIXUP
		dec	bx
		je	short ASM_FLUSH_KIND2_RECORD
		push	ax
		mov	ax,cx
		and	cl,0FEh
		push	cx
		and	al,1
		push	ax
		call	far ptr EMIT_SEGMENT_PREFIX
		jmp	short ASM_FLUSH_CHECK_RESULT
ASM_FLUSH_KIND0_BYTE:
		push	ax
		call	far ptr EMIT_ASM_BYTE
		jmp	short ASM_FLUSH_CHECK_RESULT
ASM_FLUSH_KIND1_FIXUP:
		push	cx
		push	word ptr [si+2]
		push	word ptr [si]
		push	dx
		push	ax
		call	far ptr EMIT_ASM_FIXUP_OPERAND
		jmp	short ASM_FLUSH_CHECK_RESULT
ASM_FLUSH_KIND2_RECORD:
		push	ax
		push	word ptr [si+2]
		push	word ptr [si]
		call	far ptr ASM_FLUSH_KIND2_STUB
ASM_FLUSH_CHECK_RESULT:
		or	ax,ax
		je	short ASM_FLUSH_NEXT_RECORD
		jmp	ASM_REWIND_AND_EXIT
ASM_FLUSH_NEXT_RECORD:
		pop	si
		add	si,0Ah
		jmp	short ASM_FLUSH_RECORD_LOOP
ASM_FLUSH_DONE:
		mov	word ptr [bp+0FEF0h],0
		ret
ASM_FLUSH_EMIT_RECORDS	endp

; ---- R8SKIP (CODE_8:00F0) ----

		public	ASM_PARSE_PREFIXES

ASM_PARSE_PREFIXES	proc	near
		cmp	dh,41h
		jne	short ASM_PFX_DONE
		mov	bx,word ptr [bp-1Eh]
		cmp	byte ptr cs:[bx],0AEh
		jne	short ASM_PFX_DONE
		mov	al,byte ptr cs:[bx+2]
		mov	cx,5
		lea	bx,[bp-0Fh]
ASM_PFX_FIND_FREE_SLOT:
		inc	bx
		cmp	byte ptr [bx],0
		loopnz	short ASM_PFX_FIND_FREE_SLOT
		mov	ah,0
		mov	word ptr [bx],ax
		call	ASM_NEXT_TOKEN
		jmp	short ASM_PARSE_PREFIXES
ASM_PFX_DONE:
		ret
ASM_PARSE_PREFIXES	endp

; ---- R8ARGS (CODE_8:0118) ----

		public	ASM_PARSE_DATA_DIRECTIVE

ASM_PARSE_DATA_DIRECTIVE	proc	near
		cmp	dh,41h
		jne	short ASM_DATADIR_DONE
		mov	bx,word ptr [bp-1Eh]
		mov	ax,word ptr cs:[bx]
		cmp	al,0EAh
		jne	short ASM_DATADIR_DONE
		mov	byte ptr [bp-1Ah],ah
		cmp	word ptr [bp-0Eh],0
		je	short ASM_DATADIR_START
		jmp	ASM_FAIL_SYNTAX
ASM_DATADIR_START:
		call	ASM_NEXT_TOKEN
ASM_DATADIR_VALUE_LOOP:
		lea	si,[bp+0FE6Ah]
		call	ASM_PARSE_OPERAND_EXPR
		push	dx
		call	ASM_EMIT_DATA_VALUE
		call	ASM_FLUSH_EMIT_RECORDS
		pop	dx
		mov	al,2Ch
		call	ASM_ACCEPT_TOKEN
		jne	short ASM_DATADIR_VALUE_LOOP
		mov	al,3Bh
		call	ASM_EXPECT_TOKEN
		xor	ax,ax
ASM_DATADIR_DONE:
		ret
ASM_PARSE_DATA_DIRECTIVE	endp

; ---- R8EMIT (CODE_8:0154) ----

		public	ASM_EMIT_DATA_VALUE

ASM_EMIT_DATA_VALUE	proc	near
		mov	di,si
		mov	ax,word ptr [si]
		mov	dx,word ptr [si+2]
		mov	cx,word ptr [si+8]
		or	cx,word ptr [si+0Ah]
		cmp	byte ptr [bp-1Ah],2
		je	short ASM_DATAVAL_DW
		ja	short ASM_DATAVAL_DD
		or	cx,cx
		je	short ASM_DATAVAL_DB
		jmp	ASM_FAIL_SIZE_COMBINATION
ASM_DATAVAL_DB:
		lea	si,[bp+0FEF2h]
		cmp	byte ptr [si],0
		jne	short ASM_DATAVAL_DB_STRING
		call	ASM_IMM_FITS_BYTE
		jne	short ASM_DATAVAL_OVERFLOW
		jmp	short ASM_DATAVAL_QUEUE_BYTE
ASM_DATAVAL_DB_STRING:
		xor	ax,ax
		cld
		lodsb
		xchg	ax,cx
		jcxz	short ASM_DATAVAL_STRING_DONE
ASM_DATAVAL_STRING_LOOP:
		cld
		lodsb
		push	si
		push	cx
		call	ASM_DATAVAL_QUEUE_BYTE
		call	ASM_FLUSH_EMIT_RECORDS
		pop	cx
		pop	si
		loop	short ASM_DATAVAL_STRING_LOOP
ASM_DATAVAL_STRING_DONE:
		ret
ASM_DATAVAL_DW:
		cmp	byte ptr [bp+0FEF2h],2
		ja	short ASM_DATAVAL_TOO_LONG
		call	ASM_CHECK_IMM_FITS_WORD
		jcxz	short ASM_DATAVAL_QUEUE_WORD
		mov	bx,101h
		cmp	byte ptr [si+13h],bh
		jc	short ASM_DATAVAL_DW_FIXUP
		mov	bh,byte ptr [si+13h]
ASM_DATAVAL_DW_FIXUP:
		xchg	ax,cx
		mov	ax,word ptr [bp+0FE72h]
		mov	word ptr [bp+0FE7Eh],ax
		mov	ax,word ptr [bp+0FE74h]
		mov	word ptr [bp+0FE80h],ax
		jmp	ASM_QUEUE_EMIT_RECORD
ASM_DATAVAL_DD:
		cmp	byte ptr [bp+0FEF2h],4
		ja	short ASM_DATAVAL_TOO_LONG
		jcxz	short ASM_DATAVAL_DD_CONSTANT
		xchg	ax,cx
		mov	bx,301h
		cmp	byte ptr [si+13h],0
		je	short ASM_DATAVAL_QUEUE_RECORD
		mov	bh,byte ptr [si+13h]
		mov	ax,word ptr [bp+0FE72h]
		mov	word ptr [bp+0FE7Eh],ax
		mov	ax,word ptr [bp+0FE74h]
		mov	word ptr [bp+0FE80h],ax
		call	ASM_QUEUE_EMIT_RECORD
		jmp	short ASM_DATAVAL_HIGH_WORD
ASM_DATAVAL_DD_CONSTANT:
		call	ASM_DATAVAL_QUEUE_WORD
ASM_DATAVAL_HIGH_WORD:
		xchg	ax,dx
ASM_DATAVAL_QUEUE_WORD:
		call	ASM_DATAVAL_QUEUE_BYTE
		xchg	al,ah
ASM_DATAVAL_QUEUE_BYTE:
		mov	bl,0
		mov	cx,ax
ASM_DATAVAL_QUEUE_RECORD:
		call	ASM_QUEUE_EMIT_RECORD
		ret
ASM_DATAVAL_OVERFLOW:
		jmp	ASM_FAIL_NUMBER_OVERFLOW
ASM_DATAVAL_TOO_LONG:
		jmp	ASM_FAIL_STRING_TOO_LONG
ASM_EMIT_DATA_VALUE	endp

; ---- R8COLON (CODE_8:0203) ----

		public	ASM_PARSE_LABEL_PREFIX

ASM_PARSE_LABEL_PREFIX	proc	near
		call	ASM_PEEK_NONBLANK_CHAR
		cmp	al,3Ah
		jne	short ASM_LABELPFX_DONE
		lea	bx,[bp-6Ch]
		push	ss
		push	bx
		call	far ptr ASM_COLON_LABEL_STUB
		jne	ASM_REWIND_AND_EXIT
		call	ASM_NEXT_TOKEN
		mov	al,3Ah
		call	ASM_EXPECT_TOKEN
ASM_LABELPFX_DONE:
		ret
ASM_PARSE_LABEL_PREFIX	endp

; ---- R8LIST (CODE_8:021F) ----

		public	ASM_PARSE_OPERANDS

ASM_PARSE_OPERANDS	proc	near
		mov	byte ptr [bp-1Ch],0
		mov	ax,word ptr [bp-14h]
		mov	word ptr [bp-16h],ax
		mov	al,3Bh
		call	ASM_ACCEPT_TOKEN
		jne	short ASM_OPERANDS_DONE
		lea	si,[bp+0FE6Ah]
		call	ASM_PARSE_OPERAND_EXPR
		inc	byte ptr [bp-1Ch]
		mov	al,3Bh
		call	ASM_ACCEPT_TOKEN
		jne	short ASM_OPERANDS_DONE
		mov	al,2Ch
		call	ASM_EXPECT_TOKEN
		mov	ax,word ptr [bp-14h]
		mov	word ptr [bp-18h],ax
		lea	si,[bp+0FE56h]
		call	ASM_PARSE_OPERAND_EXPR
		inc	byte ptr [bp-1Ch]
		lea	si,[bp+0FE6Ah]
		lea	di,[bp+0FE56h]
		mov	ax,word ptr [si+0Ch]
		mov	cx,word ptr [di+0Ch]
		mov	word ptr [bp-22h],cx
		jcxz	short ASM_OPERANDS_SIZE_TO_SECOND
		or	ax,ax
		jne	short ASM_OPERANDS_THIRD
		xchg	word ptr [si+0Ch],cx
		jmp	short ASM_OPERANDS_THIRD
ASM_OPERANDS_SIZE_TO_SECOND:
		xchg	word ptr [di+0Ch],ax
ASM_OPERANDS_THIRD:
		mov	al,3Bh
		call	ASM_ACCEPT_TOKEN
		jne	short ASM_OPERANDS_DONE
		mov	al,2Ch
		call	ASM_EXPECT_TOKEN
		lea	si,[bp+0FE42h]
		call	ASM_PARSE_OPERAND_EXPR
		inc	byte ptr [bp-1Ch]
		mov	al,3Bh
		call	ASM_EXPECT_TOKEN
ASM_OPERANDS_DONE:
		ret
ASM_PARSE_OPERANDS	endp

; ---- R8ERR (CODE_8:0291) ----

		public	ASM_RETURN_ERROR

ASM_RETURN_ERROR	proc	near
		cbw
ASM_REWIND_AND_EXIT:
		push	word ptr [bp-14h]
		pop	word ptr [bp-12h]
		jmp	ASM_STATEMENT_EXIT
ASM_FAIL_FIELD_IDENT:
		mov	al,0F1h
		jmp	short ASM_RETURN_ERROR
ASM_FAIL_DIVIDE_BY_ZERO:
		mov	al,0F2h
		jmp	short ASM_RETURN_ERROR
ASM_FAIL_NEEDS_286_287:
		mov	al,0F3h
		jmp	short ASM_RETURN_ERROR
ASM_FAIL_BAD_COMBINATION:
		mov	al,0F4h
		jmp	short ASM_RETURN_ERROR
ASM_FAIL_BAD_DIGIT:
		mov	al,0F5h
		jmp	short ASM_RETURN_ERROR
ASM_FAIL_STRING_TOO_LONG:
		mov	al,0F6h
		jmp	short ASM_RETURN_ERROR
ASM_FAIL_NUMBER_OVERFLOW:
		mov	al,0F7h
		jmp	short ASM_RETURN_ERROR
ASM_FAIL_INVALID_REGISTER:
		mov	al,0F8h
		jmp	short ASM_RETURN_ERROR
ASM_FAIL_ADD_RELOCATABLES:
		mov	al,0F9h
		jmp	short ASM_RETURN_ERROR
		mov	al,0FAh			; error -6: unreferenced in this module
		jmp	short ASM_RETURN_ERROR
ASM_FAIL_NOT_CONSTANT:
		mov	al,0FBh
		jmp	short ASM_RETURN_ERROR
ASM_FAIL_MEMORY_REFERENCE:
		mov	al,0FCh
		jmp	short ASM_RETURN_ERROR
ASM_FAIL_SIZE_COMBINATION:
		mov	al,0FDh
		jmp	short ASM_RETURN_ERROR
ASM_FAIL_STACK_OVERFLOW:
		mov	al,0FEh
		jmp	short ASM_RETURN_ERROR
ASM_FAIL_SYNTAX:
		mov	al,0FFh
		jmp	short ASM_RETURN_ERROR
ASM_CHECK_STACK_DEPTH:
		cmp	sp,word ptr [bp-8]
		jbe	short ASM_FAIL_STACK_OVERFLOW
		ret
ASM_RETURN_ERROR	endp
		public	ASM_REWIND_AND_EXIT
		public	ASM_FAIL_FIELD_IDENT
		public	ASM_FAIL_DIVIDE_BY_ZERO
		public	ASM_FAIL_NEEDS_286_287
		public	ASM_FAIL_BAD_COMBINATION
		public	ASM_FAIL_BAD_DIGIT
		public	ASM_FAIL_STRING_TOO_LONG
		public	ASM_FAIL_NUMBER_OVERFLOW
		public	ASM_FAIL_INVALID_REGISTER
		public	ASM_FAIL_ADD_RELOCATABLES
		public	ASM_FAIL_NOT_CONSTANT
		public	ASM_FAIL_SIZE_COMBINATION
		public	ASM_FAIL_SYNTAX
		public	ASM_CHECK_STACK_DEPTH

; ---- R8EXPR (CODE_8:02DD) ----

		public	ASM_PARSE_OPERAND_EXPR

ASM_PARSE_OPERAND_EXPR	proc	near
		call	ASM_CHECK_STACK_DEPTH
		call	ASM_CLEAR_OPERAND
		call	ASM_EXPR_OR_XOR
		cmp	byte ptr [si+12h],67h
		jne	short ASM_OPEXPR_DONE
		test	byte ptr [si+0Eh],40h
		je	ASM_FAIL_MEMORY_REFERENCE
ASM_OPEXPR_DONE:
		ret
ASM_PARSE_OPERAND_EXPR	endp

; ---- R8MUL (CODE_8:02F3) ----

		public	ASM_EXPR_OR_XOR

ASM_EXPR_OR_XOR	proc	near
		call	ASM_EXPR_AND
ASM_ORXOR_LOOP:
		mov	bx,offset ASM_OR_XOR_OPS_TABLE
		call	ASM_MATCH_OPERATOR_TABLE
		je	short ASM_ORXOR_DONE
		call	ASM_REQUIRE_IMMEDIATE
		call	ASM_PUSH_TEMP_OPERAND
		call	ASM_EXPR_AND
		call	ASM_REQUIRE_IMMEDIATE
		call	ASM_POP_TEMP_OPERAND
		mov	ax,word ptr [di]
		mov	cx,word ptr [di+2]
		call	bx
		add	sp,14h
		jmp	short ASM_ORXOR_LOOP
ASM_ORXOR_DONE:
		ret
ASM_EXPR_OR_XOR	endp

; ---- R8OR (CODE_8:031A) ----

		public	ASM_OP_OR

ASM_OP_OR	proc	near
		or	word ptr [si],ax
		or	word ptr [si+2],cx
		ret
ASM_OP_OR	endp

; ---- R8XOR (CODE_8:0320) ----

		public	ASM_OP_XOR

ASM_OP_XOR	proc	near
		xor	word ptr [si],ax
		xor	word ptr [si+2],cx
		ret
ASM_OP_XOR	endp

; ---- R8TD1 (CODE_8:0326) ----
		public	ASM_OR_XOR_OPS_TABLE
ASM_OR_XOR_OPS_TABLE	label	byte
		db	TOK_OR
		dw	ASM_OP_OR-ASM_OR_XOR_OPS_TABLE
		db	TOK_XOR
		dw	ASM_OP_XOR-ASM_OR_XOR_OPS_TABLE
		db	0			; end of table
; ---- R8AND (CODE_8:032D) ----

		public	ASM_EXPR_AND

ASM_EXPR_AND	proc	near
		call	ASM_EXPR_NOT
ASM_EXPRAND_LOOP:
		mov	al,TOK_AND
		call	ASM_ACCEPT_TOKEN
		je	short ASM_EXPRAND_DONE
		call	ASM_REQUIRE_IMMEDIATE
		call	ASM_PUSH_TEMP_OPERAND
		call	ASM_EXPR_NOT
		call	ASM_REQUIRE_IMMEDIATE
		call	ASM_POP_TEMP_OPERAND
		mov	ax,word ptr [di]
		and	word ptr [si],ax
		mov	ax,word ptr [di+2]
		and	word ptr [si+2],ax
		add	sp,14h
		jmp	short ASM_EXPRAND_LOOP
ASM_EXPRAND_DONE:
		ret
ASM_EXPR_AND	endp

; ---- R8NOT (CODE_8:0356) ----

		public	ASM_EXPR_NOT

ASM_EXPR_NOT	proc	near
		call	ASM_CHECK_STACK_DEPTH
		mov	bx,offset ASM_NOT_OPS_TABLE
		call	ASM_MATCH_OPERATOR_TABLE
		je	ASM_EXPR_ADD_SUB
		call	ASM_EXPR_NOT
		call	ASM_REQUIRE_IMMEDIATE
		not	word ptr [si]
		not	word ptr [si+2]
		mov	byte ptr [bp+0FEF2h],0
		ret
ASM_EXPR_NOT	endp

; ---- R8TD2 (CODE_8:0372) ----
		public	ASM_NOT_OPS_TABLE
ASM_NOT_OPS_TABLE	label	byte
		db	TOK_NOT
		dw	0			; no handler: NOT only tests for the token
		db	0			; end of table
; ---- R8ADD (CODE_8:0376) ----

		public	ASM_EXPR_ADD_SUB

ASM_EXPR_ADD_SUB	proc	near
		call	ASM_EXPR_MUL_DIV_SHIFT
ASM_ADDSUB_LOOP:
		mov	bx,offset ASM_ADD_SUB_OPS_TABLE
		call	ASM_MATCH_OPERATOR_TABLE
		je	short ASM_ADDSUB_DONE
		call	ASM_PUSH_TEMP_OPERAND
		call	ASM_EXPR_MUL_DIV_SHIFT
		call	ASM_POP_TEMP_OPERAND
		call	bx
		add	sp,14h
		jmp	short ASM_ADDSUB_LOOP
ASM_ADDSUB_OP_SUB:
		xchg	si,di
		call	ASM_REQUIRE_CONSTANT
		xchg	si,di
		neg	word ptr [di]
		adc	word ptr [di+2],0
		neg	word ptr [di+2]
ASM_ADDSUB_OP_ADD:
		call	ASM_ADD_OPERANDS
		mov	byte ptr [bp+0FEF2h],0
ASM_ADDSUB_DONE:
		ret
ASM_EXPR_ADD_SUB	endp

; ---- R8TD3 (CODE_8:03AA) ----
		public	ASM_ADD_SUB_OPS_TABLE
ASM_ADD_SUB_OPS_TABLE	label	byte
		db	'+'
		dw	ASM_ADDSUB_OP_ADD-ASM_ADD_SUB_OPS_TABLE
		db	'-'
		dw	ASM_ADDSUB_OP_SUB-ASM_ADD_SUB_OPS_TABLE
		db	0			; end of table
; ---- R8SHIFT (CODE_8:03B1) ----

		public	ASM_EXPR_MUL_DIV_SHIFT

ASM_EXPR_MUL_DIV_SHIFT	proc	near
		call	ASM_EXPR_PTR_SEG_OVERRIDE
ASM_MULDIV_LOOP:
		mov	bx,offset ASM_MUL_DIV_SHIFT_OPS_TABLE
		call	ASM_MATCH_OPERATOR_TABLE
		je	short ASM_MULDIV_DONE
		call	ASM_REQUIRE_IMMEDIATE
		call	ASM_PUSH_TEMP_OPERAND
		call	ASM_EXPR_PTR_SEG_OVERRIDE
		call	ASM_REQUIRE_IMMEDIATE
		call	ASM_POP_TEMP_OPERAND
		push	dx
		mov	ax,word ptr [si]
		mov	dx,word ptr [si+2]
		mov	cx,word ptr [di]
		call	bx
		mov	word ptr [si],ax
		mov	word ptr [si+2],dx
		pop	dx
		add	sp,14h
		jmp	short ASM_MULDIV_LOOP
ASM_MULDIV_SHL_AS_SHR:
		neg	cx
ASM_MULDIV_OP_SHR:
		and	cx,803Fh
		js	short ASM_MULDIV_SHR_AS_SHL
		je	short ASM_MULDIV_DONE
ASM_MULDIV_SHR_BIT_LOOP:
		shr	dx,1
		rcr	ax,1
		loop	short ASM_MULDIV_SHR_BIT_LOOP
		ret
ASM_MULDIV_SHR_AS_SHL:
		neg	cx
		jo	short ASM_MULDIV_DONE
ASM_MULDIV_OP_SHL:
		and	cx,803Fh
		js	short ASM_MULDIV_SHL_AS_SHR
		je	short ASM_MULDIV_DONE
ASM_MULDIV_SHL_BIT_LOOP:
		shl	ax,1
		rcl	dx,1
		loop	short ASM_MULDIV_SHL_BIT_LOOP
ASM_MULDIV_DONE:
		ret
ASM_MULDIV_OP_MUL:
		mov	bx,word ptr [di+2]
		jmp	ASM_MUL32
ASM_MULDIV_OP_DIV:
		mov	bx,word ptr [di+2]
		jmp	ASM_DIV32
ASM_MULDIV_OP_MOD:
		call	ASM_MULDIV_OP_DIV
		xchg	ax,cx
		xchg	dx,bx
		ret
ASM_EXPR_MUL_DIV_SHIFT	endp

; ---- R8TD4 (CODE_8:0417) ----
		public	ASM_MUL_DIV_SHIFT_OPS_TABLE
ASM_MUL_DIV_SHIFT_OPS_TABLE	label	byte
		db	'*'
		dw	ASM_MULDIV_OP_MUL-ASM_MUL_DIV_SHIFT_OPS_TABLE
		db	'/'
		dw	ASM_MULDIV_OP_DIV-ASM_MUL_DIV_SHIFT_OPS_TABLE
		db	TOK_MOD
		dw	ASM_MULDIV_OP_MOD-ASM_MUL_DIV_SHIFT_OPS_TABLE
		db	TOK_SHR
		dw	ASM_MULDIV_OP_SHR-ASM_MUL_DIV_SHIFT_OPS_TABLE
		db	TOK_SHL
		dw	ASM_MULDIV_OP_SHL-ASM_MUL_DIV_SHIFT_OPS_TABLE
		db	0			; end of table
; ---- R8UNARY (CODE_8:0427) ----

		public	ASM_EXPR_PTR_SEG_OVERRIDE

ASM_EXPR_PTR_SEG_OVERRIDE	proc	near
		call	ASM_CHECK_STACK_DEPTH
		mov	bx,offset ASM_OFFSET_SEG_TYPE_TABLE
		call	ASM_MATCH_OPERATOR_TABLE
		je	short ASM_PTRSEG_NO_OPERATOR
		push	bx
		call	ASM_CLEAR_OPERAND
		jmp	short ASM_EXPR_PTR_SEG_OVERRIDE
ASM_PTRSEG_NO_OPERATOR:
		call	ASM_EXPR_UNARY_SIGN
		mov	al,50h
		call	ASM_ACCEPT_TOKEN
		jne	short ASM_PTRSEG_TYPE_PTR
		cmp	byte ptr [si+10h],2
		jne	short ASM_PTRSEG_DONE
		cmp	byte ptr [si+12h],65h
		jne	short ASM_PTRSEG_DONE
		mov	al,3Ah
		call	ASM_ACCEPT_TOKEN
		je	short ASM_PTRSEG_DONE
		push	word ptr [si+11h]
		call	ASM_CLEAR_OPERAND
		call	ASM_EXPR_PTR_SEG_OVERRIDE
		pop	ax
		mov	cl,3
		shl	al,cl
		or	al,26h
		mov	byte ptr [si+0Fh],al
		or	byte ptr [si+0Eh],40h
		call	ASM_MAKE_MEMORY_OPERAND
		jmp	short ASM_PTRSEG_DONE
ASM_PTRSEG_TYPE_PTR:
		call	ASM_PUSH_TEMP_OPERAND
		call	ASM_EXPR_PTR_SEG_OVERRIDE
		call	ASM_POP_TEMP_OPERAND
		push	word ptr [si+0Ch]
		push	word ptr [si+4]
		push	word ptr [si+6]
		call	ASM_COPY_OPERAND_FROM_DI
		pop	word ptr [si+6]
		pop	word ptr [si+4]
		pop	word ptr [si+0Ch]
		mov	byte ptr [si+12h],67h
		or	byte ptr [si+0Eh],40h
		add	sp,14h
ASM_PTRSEG_DONE:
		ret
ASM_EXPR_PTR_SEG_OVERRIDE	endp

; ---- R8CONST (CODE_8:049B) ----

		public	ASM_APPLY_OFFSET_SEG_TYPE

ASM_APPLY_OFFSET_SEG_TYPE	proc	near
		mov	byte ptr [si+13h],1
		jmp	short ASM_OFSSEG_MAKE_CONSTANT
ASM_OFSSEG_OP_SEG:
		mov	byte ptr [si+13h],2
		mov	ax,word ptr [si+2]
		mov	word ptr [si],ax
		jmp	short ASM_OFSSEG_MAKE_CONSTANT
ASM_OFSSEG_OP_TYPE:
		mov	ax,word ptr [si+0Ch]
		mov	word ptr [si],ax
		xor	ax,ax
		mov	word ptr [si+8],ax
		mov	word ptr [si+0Ah],ax
ASM_OFSSEG_MAKE_CONSTANT:
		mov	byte ptr [si+12h],64h
		xor	bx,bx
		mov	byte ptr [si+0Eh],bl
		mov	byte ptr [si+0Fh],bl
		mov	word ptr [si+2],bx
		mov	word ptr [si+0Ch],bx
		mov	ax,word ptr [si+8]
		or	ax,word ptr [si+0Ah]
		jne	ASM_PTRSEG_DONE
		mov	byte ptr [si+13h],bl
		ret
ASM_APPLY_OFFSET_SEG_TYPE	endp

; ---- R8TD5 (CODE_8:04D7) ----
		public	ASM_OFFSET_SEG_TYPE_TABLE
ASM_OFFSET_SEG_TYPE_TABLE	label	byte
		db	TOK_OFFSET
		dw	ASM_APPLY_OFFSET_SEG_TYPE-ASM_OFFSET_SEG_TYPE_TABLE
		db	TOK_SEG
		dw	ASM_OFSSEG_OP_SEG-ASM_OFFSET_SEG_TYPE_TABLE
		db	TOK_TYPE
		dw	ASM_OFSSEG_OP_TYPE-ASM_OFFSET_SEG_TYPE_TABLE
		db	0			; end of table
; ---- R8NEG (CODE_8:04E1) ----

		public	ASM_EXPR_UNARY_SIGN

ASM_EXPR_UNARY_SIGN	proc	near
		mov	bx,offset ASM_UNARY_SIGN_OPS_TABLE
		call	ASM_MATCH_OPERATOR_TABLE
		je	ASM_EXPR_HIGH_LOW
		call	ASM_CHECK_STACK_DEPTH
		push	bx
		jmp	short ASM_EXPR_UNARY_SIGN
ASM_USIGN_OP_NEG:
		call	ASM_REQUIRE_CONSTANT
		neg	word ptr [si]
		adc	word ptr [si+2],0
		neg	word ptr [si+2]
ASM_USIGN_OP_PLUS:
		mov	byte ptr [bp+0FEF2h],0
		ret
ASM_EXPR_UNARY_SIGN	endp

; ---- R8TD6 (CODE_8:0501) ----
		public	ASM_UNARY_SIGN_OPS_TABLE
ASM_UNARY_SIGN_OPS_TABLE	label	byte
		db	'+'
		dw	ASM_USIGN_OP_PLUS-ASM_UNARY_SIGN_OPS_TABLE
		db	'-'
		dw	ASM_USIGN_OP_NEG-ASM_UNARY_SIGN_OPS_TABLE
		db	0			; end of table
; ---- R8ROTR (CODE_8:0508) ----

		public	ASM_EXPR_HIGH_LOW

ASM_EXPR_HIGH_LOW	proc	near
		mov	bx,offset ASM_HIGH_LOW_OPS_TABLE
		call	ASM_MATCH_OPERATOR_TABLE
		je	ASM_EXPR_POSTFIX
		call	ASM_CHECK_STACK_DEPTH
		push	bx
		jmp	short ASM_EXPR_HIGH_LOW
ASM_HILO_OP_HIGH:
		mov	cl,8
		ror	word ptr [si],cl
ASM_HILO_OP_LOW:
		mov	byte ptr [si+1],0
		mov	word ptr [si+2],0
		ret
ASM_EXPR_HIGH_LOW	endp

; ---- R8TD7 (CODE_8:0524) ----
		public	ASM_HIGH_LOW_OPS_TABLE
ASM_HIGH_LOW_OPS_TABLE	label	byte
		db	TOK_HIGH
		dw	ASM_HILO_OP_HIGH-ASM_HIGH_LOW_OPS_TABLE
		db	TOK_LOW
		dw	ASM_HILO_OP_LOW-ASM_HIGH_LOW_OPS_TABLE
		db	0			; end of table
; ---- R8POST (CODE_8:052B) ----

		public	ASM_EXPR_POSTFIX

ASM_EXPR_POSTFIX	proc	near
		call	ASM_CHECK_STACK_DEPTH
		call	ASM_EXPR_BRACKETED
ASM_POSTFIX_LOOP:
		cmp	dh,2Eh
		je	ASM_INDEX_MEMBER_DOT
		cmp	dh,5Bh
		je	ASM_EXPR_INDEX_OR_MEMBER
		cmp	dh,28h
		je	ASM_EXPR_INDEX_OR_MEMBER
		ret
ASM_EXPR_POSTFIX	endp

; ---- R8INDEX (CODE_8:0541) ----

		public	ASM_EXPR_INDEX_OR_MEMBER

ASM_EXPR_INDEX_OR_MEMBER	proc	near
		call	ASM_PUSH_TEMP_OPERAND
		call	ASM_EXPR_BRACKETED
		call	ASM_POP_TEMP_OPERAND
		mov	cx,word ptr [si+0Ch]
		jcxz	short ASM_INDEX_ADD
		mov	word ptr [di+0Ch],0
ASM_INDEX_ADD:
		call	ASM_ADD_OPERANDS
		add	sp,14h
		jmp short	ASM_POSTFIX_LOOP
ASM_INDEX_MEMBER_DOT:
		mov	ax,word ptr [si+4]
		mov	word ptr [bp-3Ah],ax
		mov	ax,word ptr [si+6]
		mov	word ptr [bp-38h],ax
		xor	ax,ax
		mov	word ptr [si+4],ax
		mov	word ptr [si+6],ax
		call	ASM_NEXT_TOKEN
		call	ASM_PUSH_TEMP_OPERAND
		call	ASM_EXPR_PTR_SEG_OVERRIDE
		call	ASM_POP_TEMP_OPERAND
		cmp	byte ptr [di+12h],65h
		jne	short ASM_INDEX_MEMBER_FIELD_OK
		jmp	ASM_FAIL_FIELD_IDENT
ASM_INDEX_MEMBER_FIELD_OK:
		mov	cx,word ptr [di+0Ch]
		jcxz	short ASM_INDEX_MEMBER_ADD
		mov	word ptr [si+0Ch],0
ASM_INDEX_MEMBER_ADD:
		call	ASM_ADD_OPERANDS
		add	sp,14h
		jmp short	ASM_POSTFIX_LOOP
ASM_EXPR_BRACKETED:
		mov	bx,offset ASM_BRACKET_OPS_TABLE
		call	ASM_MATCH_OPERATOR_TABLE
		je	ASM_EXPR_PRIMARY
		push	bx
		call	ASM_EXPR_OR_XOR
		ret
ASM_EXPR_INDEX_OR_MEMBER	endp
		public	ASM_EXPR_BRACKETED

; ---- R8CLOSE (CODE_8:05A4) ----

		public	ASM_EXPECT_CLOSE_BRACKET

ASM_EXPECT_CLOSE_BRACKET	proc	near
		mov	al,29h
		jmp	short ASM_CLOSE_EXPECT
ASM_CLOSE_SQUARE:
		call	ASM_MAKE_MEMORY_OPERAND
		or	byte ptr [si+0Eh],40h
		mov	al,5Dh
ASM_CLOSE_EXPECT:
		jmp	ASM_EXPECT_TOKEN
ASM_EXPECT_CLOSE_BRACKET	endp

; ---- R8TD8 (CODE_8:05B4) ----
		public	ASM_BRACKET_OPS_TABLE
ASM_BRACKET_OPS_TABLE	label	byte
		db	'('
		dw	ASM_EXPECT_CLOSE_BRACKET-ASM_BRACKET_OPS_TABLE
		db	'['
		dw	ASM_CLOSE_SQUARE-ASM_BRACKET_OPS_TABLE
		db	0			; end of table
; ---- R8TYPE (CODE_8:05BB) ----

		public	ASM_EXPR_PRIMARY

ASM_EXPR_PRIMARY	proc	near
		call	ASM_PRIMARY_TERM
		jmp	ASM_NEXT_TOKEN
ASM_PRIMARY_TERM:
		mov	byte ptr [si+12h],dh
		cmp	dh,65h
		je	short ASM_PRIMARY_REGISTER
		cmp	dh,64h
		je	ASM_TERM_NUMBER
		cmp	dh,6Bh
		je	ASM_TERM_SYMBOL
		cmp	dh,66h
		je	ASM_TERM_SIZE_KEYWORD
		jmp	ASM_FAIL_SYNTAX
ASM_PRIMARY_REGISTER:
		mov	ax,word ptr [bp-20h]
		mov	word ptr [si+10h],ax
		dec	al
		js	short ASM_PRIMARY_SIZE_PLUS_ONE
		jne	short ASM_PRIMARY_DONE
		inc	word ptr [si+0Ch]
ASM_PRIMARY_SIZE_PLUS_ONE:
		inc	word ptr [si+0Ch]
ASM_PRIMARY_DONE:
		ret
ASM_EXPR_PRIMARY	endp

; ---- R8INC (CODE_8:05EE) ----

		public	ASM_TERM_SIZE_KEYWORD

ASM_TERM_SIZE_KEYWORD	proc	near
		mov	byte ptr [si+12h],64h
		mov	ax,word ptr [bp-36h]
		mov	word ptr [si+0Ch],ax
		ret
ASM_TERM_SIZE_KEYWORD	endp

; ---- R8DEC (CODE_8:05F9) ----

		public	ASM_TERM_NUMBER

ASM_TERM_NUMBER	proc	near
		mov	ax,word ptr [bp-36h]
		mov	word ptr [si],ax
		mov	ax,word ptr [bp-34h]
		mov	word ptr [si+2],ax
		ret
ASM_TERM_NUMBER	endp

; ---- R8ADDR (CODE_8:0605) ----

		public	ASM_TERM_SYMBOL

ASM_TERM_SYMBOL	proc	near
		mov	byte ptr [si+12h],67h
		mov	ax,word ptr [bp-3Eh]
		mov	word ptr [si+0Ch],ax
		mov	ax,word ptr [bp-42h]
		mov	word ptr [si],ax
		mov	ax,word ptr [bp-40h]
		mov	word ptr [si+2],ax
		mov	ax,word ptr [bp-3Ah]
		mov	word ptr [si+4],ax
		mov	ax,word ptr [bp-38h]
		mov	word ptr [si+6],ax
		xor	ax,ax
		mov	word ptr [bp-3Ah],ax
		mov	word ptr [bp-38h],ax
		mov	ax,word ptr [bp-46h]
		mov	cx,word ptr [bp-44h]
		inc	cx
		je	ASM_TERM_SYMBOL_NO_FIXUP
		dec	cx
		mov	word ptr [si+8],ax
		mov	word ptr [si+0Ah],cx
		test	byte ptr [bp-3Ch],1
		je	short ASM_SYMBOL_MARK_MEMORY
		mov	byte ptr [si+0Fh],2Eh
ASM_SYMBOL_MARK_MEMORY:
		or	byte ptr [si+0Eh],40h
		ret
ASM_TERM_SYMBOL	endp

; ---- R8DEREF (CODE_8:064D) ----

		public	ASM_TERM_SYMBOL_NO_FIXUP

ASM_TERM_SYMBOL_NO_FIXUP	proc	near
		cmp	ax,0FFFEh
		jc	ASM_TERM_BP_RELATIVE
		je	ASM_BPREL_MARK_MEMORY
		mov	byte ptr [si+12h],64h
		ret
ASM_TERM_SYMBOL_NO_FIXUP	endp

; ---- R8MEMBER (CODE_8:0659) ----

		public	ASM_TERM_BP_RELATIVE

ASM_TERM_BP_RELATIVE	proc	near
		mov	byte ptr [si+0Eh],4
ASM_BPREL_MARK_MEMORY:
		jmp short	ASM_SYMBOL_MARK_MEMORY
ASM_COPY_OPERAND_FROM_DI:
		push	ds
		pop	es
		xchg	si,di
		mov	cx,0Ah
		cld
		rep	movsw
		sub	si,14h
		sub	di,14h
		xchg	si,di
		ret
ASM_TERM_BP_RELATIVE	endp
		public	ASM_COPY_OPERAND_FROM_DI

; ---- R8CVT (CODE_8:0672) ----

		public	ASM_ADD_OPERANDS

ASM_ADD_OPERANDS	proc	near
		push	dx
		cmp	byte ptr [di+12h],64h
		jne	short ASM_ADDOPS_TO_MEMORY
		cmp	byte ptr [si+12h],64h
		je	short ASM_ADDOPS_SUM
		cmp	byte ptr [si+12h],65h
		jne	short ASM_ADDOPS_TO_MEMORY
		cmp	byte ptr [si+10h],4
		jne	short ASM_ADDOPS_TO_MEMORY
		mov	ax,word ptr [di]
		add	byte ptr [si+11h],al
		and	byte ptr [si+11h],7
		jmp	short ASM_ADDOPS_DONE
ASM_ADDOPS_TO_MEMORY:
		call	ASM_MAKE_MEMORY_OPERAND
		xchg	si,di
		call	ASM_MAKE_MEMORY_OPERAND
		xchg	si,di
ASM_ADDOPS_SUM:
		mov	ax,word ptr [di]
		mov	bx,word ptr [di+2]
		add	word ptr [si],ax
		adc	word ptr [si+2],bx
		mov	ax,word ptr [di+4]
		mov	dx,word ptr [di+6]
		or	ax,dx
		je	short ASM_ADDOPS_FIXUP
		mov	ax,word ptr [di+4]
		mov	word ptr [si+4],ax
		mov	ax,word ptr [di+6]
		mov	word ptr [si+6],ax
ASM_ADDOPS_FIXUP:
		mov	cl,byte ptr [di+13h]
		mov	bx,word ptr [di+8]
		mov	dx,word ptr [di+0Ah]
		mov	ax,dx
		or	ax,bx
		je	short ASM_ADDOPS_SIZE
		mov	byte ptr [si+13h],cl
		xchg	word ptr [si+8],bx
		xchg	word ptr [si+0Ah],dx
		or	bx,dx
		je	short ASM_ADDOPS_SIZE
		jmp	ASM_FAIL_ADD_RELOCATABLES
ASM_ADDOPS_SIZE:
		mov	cx,word ptr [di+0Ch]
		jcxz	short ASM_ADDOPS_BASE_INDEX
		xchg	word ptr [si+0Ch],cx
ASM_ADDOPS_BASE_INDEX:
		mov	al,byte ptr [di+0Eh]
		mov	ah,al
		and	ah,byte ptr [si+0Eh]
		or	byte ptr [si+0Eh],al
		and	ah,0Fh
		je	short ASM_ADDOPS_SEG_OVERRIDE
		jmp	ASM_FAIL_INVALID_REGISTER
ASM_ADDOPS_SEG_OVERRIDE:
		mov	al,byte ptr [di+0Fh]
		or	al,al
		je	short ASM_ADDOPS_DONE
		cmp	byte ptr [si+0Fh],0
		jns	short ASM_ADDOPS_SET_SEG_OVERRIDE
		jmp	ASM_FAIL_SYNTAX
ASM_ADDOPS_SET_SEG_OVERRIDE:
		mov	byte ptr [si+0Fh],al
ASM_ADDOPS_DONE:
		pop	dx
		ret
ASM_ADD_OPERANDS	endp

; ---- R8NORM (CODE_8:070F) ----

		public	ASM_MAKE_MEMORY_OPERAND

ASM_MAKE_MEMORY_OPERAND	proc	near
		cmp	byte ptr [si+12h],64h
		je	short ASM_MKMEM_SET_MEMORY
		cmp	byte ptr [si+12h],65h
		jne	short ASM_MKMEM_CHECK_MEMORY
		cmp	byte ptr [si+10h],1
		jne	ASM_ERROR_INVALID_REGISTER
		xor	bx,bx
		add	bl,byte ptr [si+11h]
		add	bh,byte ptr cs:ASM_REG_ADDRESS_BITS[bx]
		js	ASM_ERROR_INVALID_REGISTER
		mov	byte ptr [si+0Eh],bh
		mov	word ptr [si+0Ch],0
		jmp	short ASM_MKMEM_SET_MEMORY
ASM_MKMEM_CHECK_MEMORY:
		cmp	byte ptr [si+12h],67h
		je	short ASM_MKMEM_SET_MEMORY
		jmp	ASM_FAIL_MEMORY_REFERENCE
ASM_MKMEM_SET_MEMORY:
		mov	byte ptr [si+12h],67h
		ret
ASM_MAKE_MEMORY_OPERAND	endp

; ---- R8TD9 (CODE_8:0745) ----
; Addressing bits by 16-bit register number (AX CX DX BX SP BP SI DI):
; BX=8, BP=4, SI=2, DI=1; 0FFh means the register cannot address memory.
		public	ASM_REG_ADDRESS_BITS
ASM_REG_ADDRESS_BITS	label	byte
		db	0FFh,0FFh,0FFh,008h,0FFh,004h,002h,001h
; ---- R8ERR2 (CODE_8:074D) ----

		public	ASM_ERROR_INVALID_REGISTER

ASM_ERROR_INVALID_REGISTER	proc	near
		jmp	ASM_FAIL_INVALID_REGISTER
ASM_ERROR_INVALID_REGISTER	endp

; ---- R8DISP (CODE_8:0750) ----

		public	ASM_MATCH_OPERATOR_TABLE

ASM_MATCH_OPERATOR_TABLE	proc	near
		mov	cx,bx
ASM_MATCHOP_LOOP:
		mov	al,byte ptr cs:[bx]
		add	bx,3
		or	al,al
		je	short ASM_MATCHOP_DONE
		cmp	al,dh
		jne	short ASM_MATCHOP_LOOP
		mov	bx,word ptr cs:[bx-2]
		add	bx,cx
		call	ASM_NEXT_TOKEN
		or	bx,bx
ASM_MATCHOP_DONE:
		ret
ASM_MATCH_OPERATOR_TABLE	endp

; ---- R8PUSH (CODE_8:076C) ----

		public	ASM_PUSH_TEMP_OPERAND

ASM_PUSH_TEMP_OPERAND	proc	near
		pop	cx
		sub	sp,14h
		mov	ax,sp
		push	si
		push	bx
		xchg	ax,si
		push	cx
ASM_CLEAR_OPERAND:
		push	ds
		pop	es
		xor	ax,ax
		mov	cx,0Ah
		push	di
		lea	di,[si]
		cld
		rep	stosw
		pop	di
		ret
ASM_PUSH_TEMP_OPERAND	endp
		public	ASM_CLEAR_OPERAND

; ---- R8POP (CODE_8:0785) ----

		public	ASM_POP_TEMP_OPERAND

ASM_POP_TEMP_OPERAND	proc	near
		pop	ax
		pop	bx
		pop	si
		mov	di,sp
		push	ax
		ret
ASM_POP_TEMP_OPERAND	endp

; ---- R8CHK (CODE_8:078C) ----

		public	ASM_REQUIRE_CONSTANT

ASM_REQUIRE_CONSTANT	proc	near
		cmp	byte ptr [si+12h],67h
		je	short ASM_REQCONST_NO_FIXUP
ASM_REQUIRE_IMMEDIATE:
		cmp	byte ptr [si+12h],64h
		jne	ASM_ERROR_NOT_CONSTANT
ASM_REQCONST_NO_FIXUP:
		mov	ax,word ptr [si+8]
		or	ax,word ptr [si+0Ah]
		jne	ASM_ERROR_NOT_CONSTANT
		ret
ASM_REQUIRE_CONSTANT	endp
		public	ASM_REQUIRE_IMMEDIATE

; ---- R8ERR3 (CODE_8:07A1) ----

		public	ASM_ERROR_NOT_CONSTANT

ASM_ERROR_NOT_CONSTANT	proc	near
		jmp	ASM_FAIL_NOT_CONSTANT
ASM_ERROR_NOT_CONSTANT	endp

; ---- R8EXPECT (CODE_8:07A4) ----

		public	ASM_EXPECT_TOKEN

ASM_EXPECT_TOKEN	proc	near
		cmp	al,dh
		je	ASM_NEXT_TOKEN
		jmp	ASM_FAIL_SYNTAX
ASM_ACCEPT_TOKEN:
		cmp	al,dh
		je	ASM_NEXT_TOKEN
		xor	ax,ax
		ret
ASM_EXPECT_TOKEN	endp
		public	ASM_ACCEPT_TOKEN

; ---- R8NEXT (CODE_8:07B2) ----

		public	ASM_NEXT_TOKEN

ASM_NEXT_TOKEN	proc	near
		mov	dh,3Bh
		cmp	word ptr [bp+8],0
		jbe	short ASM_NEXTTOK_SET_FLAGS
		push	si
		push	di
		push	bx
		call	ASM_SCAN_WORD
		cmp	byte ptr [bp-1Bh],1
		jne	short ASM_NEXTTOK_TRY_PUNCT
		call	ASM_LOOKUP_MNEMONIC
		jne	short ASM_NEXTTOK_FOUND
ASM_NEXTTOK_TRY_PUNCT:
		call	ASM_GET_PUNCT_TOKEN
		jne	short ASM_NEXTTOK_FOUND
		call	ASM_LOOKUP_KEYWORD
		jne	short ASM_NEXTTOK_FOUND
		call	ASM_SCAN_NUMBER_TOKEN
		jne	short ASM_NEXTTOK_FOUND
		cmp	byte ptr [bp-1Bh],1
		je	short ASM_NEXTTOK_FOUND
		call	ASM_LOOKUP_C_SYMBOL
ASM_NEXTTOK_FOUND:
		pop	bx
		pop	di
		pop	si
ASM_NEXTTOK_SET_FLAGS:
		sub	dh,1
		adc	dh,1
		ret
ASM_NEXT_TOKEN	endp

; ---- R8SCAN (CODE_8:07ED) ----

		public	ASM_ADVANCE_CHAR

ASM_ADVANCE_CHAR	proc	near
		inc	word ptr [bp-12h]
		dec	word ptr [bp+8]
ASM_PEEK_CHAR:
		xor	ax,ax
		cmp	word ptr [bp+8],ax
		jbe	ASM_SET_TEXT_END
		les	bx,[bp-12h]
		add	al,byte ptr es:[bx]
		je	ASM_SET_TEXT_END
		ret
ASM_ADVANCE_CHAR	endp
		public	ASM_PEEK_CHAR

; ---- R8END (CODE_8:0803) ----

		public	ASM_SET_TEXT_END

ASM_SET_TEXT_END	proc	near
		mov	word ptr [bp+8],ax
		ret
ASM_SET_TEXT_END	endp

; ---- R8WS (CODE_8:0807) ----

		public	ASM_SKIP_WHITESPACE

ASM_SKIP_WHITESPACE	proc	near
		inc	word ptr [bp-12h]
		dec	word ptr [bp+8]
ASM_PEEK_NONBLANK_CHAR:
		call	ASM_PEEK_CHAR
		je	short ASM_SKIPWS_DONE
		cmp	al,20h
		jbe	short ASM_SKIP_WHITESPACE
		cmp	al,7Fh
		jnc	short ASM_SKIP_WHITESPACE
ASM_SKIPWS_DONE:
		ret
ASM_SKIP_WHITESPACE	endp
		public	ASM_PEEK_NONBLANK_CHAR

; ---- R8LEX (CODE_8:081B) ----

		public	ASM_SCAN_WORD

ASM_SCAN_WORD	proc	near
		xor	ax,ax
		mov	word ptr [bp-6Ch],ax
		mov	word ptr [bp+0FF72h],ax
		mov	byte ptr [bp-23h],al
		call	ASM_PEEK_NONBLANK_CHAR
		mov	word ptr [bp-14h],bx
		je	short ASM_SCANWORD_END_STATEMENT
		call	ASM_IS_WORD_CHAR
		jnc	short ASM_SCANWORD_NOT_WORD
ASM_SCANWORD_CHAR_LOOP:
		mov	si,word ptr [bp-6Ch]
		and	si,0FFh
		cmp	si,20h
		je	short ASM_SCANWORD_NEXT_CHAR
		inc	byte ptr [bp-6Ch]
		inc	byte ptr [bp+0FF72h]
		mov	word ptr [bp+si-6Bh],ax
		cmp	al,61h
		jc	short ASM_SCANWORD_STORE_UPPER
		and	al,5Fh
ASM_SCANWORD_STORE_UPPER:
		mov	word ptr [bp+si+0FF73h],ax
		dec	ax
		add	byte ptr [bp-23h],al
ASM_SCANWORD_NEXT_CHAR:
		call	ASM_ADVANCE_CHAR
		je	short ASM_SCANWORD_END_OF_WORD
		call	ASM_IS_WORD_CHAR
		jc	short ASM_SCANWORD_CHAR_LOOP
ASM_SCANWORD_END_OF_WORD:
		mov	byte ptr [bp-19h],1
		cmp	word ptr [bp+0FF72h],4503h
		jne	short ASM_SCANWORD_DONE
		cmp	word ptr [bp+0FF74h],444Eh
		je	short ASM_SCANWORD_END_STATEMENT
		jmp	short ASM_SCANWORD_DONE
ASM_SCANWORD_NOT_WORD:
		mov	byte ptr [bp-19h],2
		call	ASM_SCAN_QUOTED_STRING
		je	short ASM_SCANWORD_DONE
		mov	byte ptr [bp-19h],0
		inc	byte ptr [bp-6Ch]
		mov	word ptr [bp-6Bh],ax
		cmp	al,3Bh
		je	short ASM_SCANWORD_END_STATEMENT
		cmp	al,7Bh
		je	short ASM_SCANWORD_END_STATEMENT
		xchg	ax,dx
		call	ASM_ADVANCE_CHAR
		mov	ah,dl
		cmp	ax,282Ah
		jne	short ASM_SCANWORD_DONE
ASM_SCANWORD_END_STATEMENT:
		mov	byte ptr [bp-19h],0
		mov	word ptr [bp-6Ch],3B01h
		mov	word ptr [bp+8],0
		mov	ax,word ptr [bp-14h]
		mov	word ptr [bp-12h],ax
ASM_SCANWORD_DONE:
		ret
ASM_SCAN_WORD	endp

; ---- R8QUOTE (CODE_8:08B3) ----

		public	ASM_SCAN_QUOTED_STRING

ASM_SCAN_QUOTED_STRING	proc	near
		mov	cl,al
		cmp	al,27h
		je	ASM_SCAN_STRING_BODY
		cmp	al,22h
		je	ASM_SCAN_STRING_BODY
		ret
ASM_SCAN_QUOTED_STRING	endp

; ---- R8STRING (CODE_8:08BE) ----

		public	ASM_SCAN_STRING_BODY

ASM_SCAN_STRING_BODY	proc	near
		mov	byte ptr [bp+0FEF2h],0
		jmp	short ASM_STRBODY_NEXT_CHAR
ASM_STRBODY_STORE_CHAR:
		mov	si,word ptr [bp+0FEF2h]
		and	si,0FFh
		cmp	si,7Fh
		jne	short ASM_STRBODY_APPEND
		jmp	ASM_FAIL_STRING_TOO_LONG
ASM_STRBODY_APPEND:
		inc	byte ptr [bp+0FEF2h]
		mov	byte ptr [bp+si+0FEF3h],al
ASM_STRBODY_NEXT_CHAR:
		call	ASM_ADVANCE_CHAR
		jne	short ASM_STRBODY_CHECK_QUOTE
		jmp	ASM_FAIL_STRING_TOO_LONG
ASM_STRBODY_CHECK_QUOTE:
		cmp	al,cl
		jne	short ASM_STRBODY_STORE_CHAR
		call	ASM_ADVANCE_CHAR
		cmp	al,cl
		je	short ASM_STRBODY_STORE_CHAR
		xor	ax,ax
		ret
ASM_SCAN_STRING_BODY	endp

; ---- R8CLASS (CODE_8:08F3) ----

		public	ASM_IS_WORD_CHAR

ASM_IS_WORD_CHAR	proc	near
		call	ASM_IS_IDENT_CHAR
		jnc	ASM_IS_DIGIT
		ret
ASM_IS_WORD_CHAR	endp

; ---- R8DIGIT (CODE_8:08F9) ----

		public	ASM_IS_DIGIT

ASM_IS_DIGIT	proc	near
		push	ax
		sub	al,3Ah
		add	al,0Ah
		pop	ax
		ret
ASM_IS_DIGIT	endp

; ---- R8IDCHAR (CODE_8:0900) ----

		public	ASM_IS_IDENT_CHAR

ASM_IS_IDENT_CHAR	proc	near
		call	ASM_IS_LETTER
		jc	short ASM_IDCHAR_YES
		cmp	al,5Fh
		je	short ASM_IDCHAR_YES
		cmp	al,24h
		je	short ASM_IDCHAR_YES
		cmp	al,40h
		je	short ASM_IDCHAR_YES
		cmp	al,26h
		je	short ASM_IDCHAR_YES
		cmp	al,3Fh
		je	short ASM_IDCHAR_YES
		clc
		ret
ASM_IDCHAR_YES:
		stc
		ret
ASM_IS_IDENT_CHAR	endp

; ---- R8ALPHA (CODE_8:091D) ----

		public	ASM_IS_LETTER

ASM_IS_LETTER	proc	near
		push	ax
		sub	al,5Bh
		add	al,1Ah
		jc	short ASM_LETTER_DONE
		sub	al,3Ah
		add	al,1Ah
ASM_LETTER_DONE:
		pop	ax
		ret
ASM_IS_LETTER	endp

; ---- R8TOK (CODE_8:092A) ----

		public	ASM_LOOKUP_C_SYMBOL

ASM_LOOKUP_C_SYMBOL	proc	near
		lea	bx,[bp-6Ch]
		mov	ax,word ptr [bx]
		cmp	ah,26h
		jne	short ASM_CSYM_DECODE
		inc	bx
		dec	al
		jne	short ASM_CSYM_DROP_AMPERSAND
		jmp	ASM_FAIL_SYNTAX
ASM_CSYM_DROP_AMPERSAND:
		mov	byte ptr [bx],al
ASM_CSYM_DECODE:
		push	ss
		push	bx
		lea	bx,[bp-4Ah]
		push	ss
		push	bx
		mov	ax,word ptr [bp-3Ah]
		mov	word ptr [bp-4Ah],ax
		mov	ax,word ptr [bp-38h]
		mov	word ptr [bp-48h],ax
		call	far ptr DECODE_ASM_SYMBOL
		or	ax,ax
		je	short ASM_CSYM_FOUND
		jmp	ASM_REWIND_AND_EXIT
ASM_CSYM_FOUND:
		mov	ax,word ptr [bp-4Ah]
		mov	word ptr [bp-3Ah],ax
		mov	ax,word ptr [bp-48h]
		mov	word ptr [bp-38h],ax
		mov	dh,6Bh
		ret
ASM_LOOKUP_C_SYMBOL	endp

; ---- R8FLAG (CODE_8:096C) ----

		public	ASM_GET_PUNCT_TOKEN

ASM_GET_PUNCT_TOKEN	proc	near
		cmp	byte ptr [bp-19h],0
		jne	short ASM_PUNCT_NONE
		mov	dx,word ptr [bp-6Ch]
		cmp	dl,1
		je	short ASM_PUNCT_DONE
ASM_PUNCT_NONE:
		xor	dx,dx
ASM_PUNCT_DONE:
		or	dh,dh
		ret
ASM_GET_PUNCT_TOKEN	endp

; ---- R8NUM (CODE_8:097F) ----

		public	ASM_SCAN_NUMBER_TOKEN

ASM_SCAN_NUMBER_TOKEN	proc	near
		cmp	byte ptr [bp-19h],1
		je	ASM_LITERAL_WORD
		ja	ASM_CONVERT_LITERAL
ASM_NUMTOK_NONE:
		xor	ax,ax
		ret
ASM_SCAN_NUMBER_TOKEN	endp

; ---- R8LIT (CODE_8:098A) ----

		public	ASM_CONVERT_LITERAL

ASM_CONVERT_LITERAL	proc	near
		lea	si,[bp+0FEF2h]
		xor	ax,ax
		xor	di,di
		cwd
		cld
		lodsb
		xchg	ax,cx
		jcxz	short ASM_LITERAL_STORE
ASM_LITERAL_CHAR_LOOP:
		and	di,0FFh
		call	ASM_MUL32_BY_16
		call	ASM_MUL32_BY_16
		lodsb
		mov	dl,al
		loop	short ASM_LITERAL_CHAR_LOOP
		jmp	short ASM_LITERAL_STORE
ASM_LITERAL_WORD:
		mov	byte ptr [bp+0FEF2h],0
		xor	cx,cx
		mov	cl,byte ptr [bp+0FF72h]
		mov	ax,word ptr [bp+0FF73h]
		mov	si,1
		cmp	al,24h
		je	short ASM_LITERAL_HEX
		dec	si
		call	ASM_IS_DIGIT
		jnc	ASM_NUMTOK_NONE
		mov	di,cx
		mov	al,byte ptr [bp+di+0FF72h]
		call	ASM_IS_DIGIT
		mov	bx,offset acc_decimal	; no suffix letter
		jc	short ASM_LITERAL_ACCUMULATE
		dec	cx
		cmp	al,'D'
		je	short ASM_LITERAL_ACCUMULATE
		mov	bx,offset acc_binary
		cmp	al,'B'
		je	short ASM_LITERAL_ACCUMULATE
		mov	bx,offset acc_octal
		cmp	al,'O'
		je	short ASM_LITERAL_ACCUMULATE
		cmp	al,'H'
		jne	ASM_ERROR_BAD_DIGIT
ASM_LITERAL_HEX:
		sub	cx,si
		mov	bx,offset acc_hex
ASM_LITERAL_ACCUMULATE:
		xor	di,di
		xor	dx,dx
ASM_LITERAL_DIGIT_LOOP:
		jcxz	short ASM_LITERAL_STORE
		dec	cx
		inc	si
		xor	ax,ax
		mov	al,byte ptr [bp+si+0FF72h]
		call	bx
		jmp	short ASM_LITERAL_DIGIT_LOOP
ASM_LITERAL_STORE:
		mov	word ptr [bp-36h],dx
		mov	word ptr [bp-34h],di
		mov	dh,64h
		or	dh,dh
		ret
ASM_CONVERT_LITERAL	endp

; ---- R8ACC (CODE_8:0A0C) ----

		public	ASM_ACCUMULATE_DIGIT

; Digit accumulators, one per radix, reached through BX (set from the
; number's suffix above).  Each multiplies DI:DX by the radix, checks the
; digit in AL and adds it; an invalid digit goes to ASM_ERROR_BAD_DIGIT.
ASM_ACCUMULATE_DIGIT	proc	near
acc_binary:
		call	ASM_MUL32_BY_2
		sub	al,'2'
		add	al,2
		jmp	short ASM_ACCDIGIT_ADD
acc_octal:
		call	ASM_MUL32_BY_8
		sub	al,'8'
		add	al,8
		jmp	short ASM_ACCDIGIT_ADD
acc_decimal:
		call	ASM_MUL32_BY_10
		sub	al,':'
		add	al,10
		jmp	short ASM_ACCDIGIT_ADD
acc_hex:
		call	ASM_MUL32_BY_16
		cmp	al,':'
		jc	short ASM_ACCDIGIT_HEX_LETTER
		sub	al,7
ASM_ACCDIGIT_HEX_LETTER:
		sub	al,40h
		add	al,10h
ASM_ACCDIGIT_ADD:
		jnc	ASM_ERROR_BAD_DIGIT
		add	dx,ax
		adc	di,0
		jc	ASM_ERRDIGIT_NUMBER_OVERFLOW
		ret
ASM_ACCUMULATE_DIGIT	endp

; ---- R8DBL (CODE_8:0A3E) ----

		public	ASM_MUL32_BY_10

ASM_MUL32_BY_10	proc	near
		push	ax
		call	ASM_MUL32_BY_2
		push	di
		push	dx
		call	ASM_MUL32_BY_4
		pop	ax
		add	dx,ax
		pop	ax
		add	di,ax
		jc	ASM_ERRDIGIT_NUMBER_OVERFLOW
		pop	ax
		ret
ASM_MUL32_BY_10	endp

; ---- R8SHL (CODE_8:0A51) ----

		public	ASM_MUL32_BY_16

ASM_MUL32_BY_16	proc	near
		call	ASM_MUL32_BY_2
ASM_MUL32_BY_8:
		call	ASM_MUL32_BY_2
ASM_MUL32_BY_4:
		call	ASM_MUL32_BY_2
ASM_MUL32_BY_2:
		add	dx,dx
		adc	di,di
		jc	ASM_ERRDIGIT_NUMBER_OVERFLOW
		ret
ASM_MUL32_BY_16	endp
		public	ASM_MUL32_BY_8
		public	ASM_MUL32_BY_4
		public	ASM_MUL32_BY_2

; ---- R8LOOK1 (CODE_8:0A61) ----

		public	ASM_ERROR_BAD_DIGIT

ASM_ERROR_BAD_DIGIT	proc	near
		jmp	ASM_FAIL_BAD_DIGIT
ASM_ERRDIGIT_NUMBER_OVERFLOW:
		jmp	ASM_FAIL_NUMBER_OVERFLOW
ASM_LOOKUP_MNEMONIC:
		call	ASM_OPCODE_TABLE_ADDRESS
		call	ASM_HASH_TABLE_LOOKUP
		je	short ASM_MNEMONIC_DONE
		mov	word ptr [bp-1Eh],di
		mov	dh,41h
ASM_MNEMONIC_DONE:
		ret
ASM_ERROR_BAD_DIGIT	endp
		public	ASM_LOOKUP_MNEMONIC

; ---- R8LOOK2 (CODE_8:0A75) ----

		public	ASM_LOOKUP_KEYWORD

ASM_LOOKUP_KEYWORD	proc	near
		call	ASM_KEYWORD_TABLE_ADDRESS
		call	ASM_HASH_TABLE_LOOKUP
		je	short ASM_KEYWORD_DONE
		mov	dh,byte ptr cs:[di]
		inc	di
		mov	ax,word ptr cs:[di]
		mov	word ptr [bp-20h],ax
		mov	word ptr [bp-36h],ax
		add	ax,ax
		sbb	ax,ax
		mov	word ptr [bp-34h],ax
		dec	ax
ASM_KEYWORD_DONE:
		ret
ASM_LOOKUP_KEYWORD	endp

; ---- R8LOOKUP (CODE_8:0A93) ----

		public	ASM_HASH_TABLE_LOOKUP

ASM_HASH_TABLE_LOOKUP	proc	near
		cmp	byte ptr [bp-19h],1
		jne	short ASM_HASH_NOT_FOUND
		cld
		push	cs
		pop	es
		mov	bl,byte ptr [bp-23h]
		add	bl,bl
		and	bx,word ptr es:[di]
		mov	bx,word ptr es:[bx+di+2]
		or	bx,bx
		je	short ASM_HASH_NOT_FOUND
		lea	ax,[bp+0FF72h]
		mov	dl,byte ptr [bp+0FF72h]
		mov	dh,0
		inc	dx
ASM_HASH_CHAIN_LOOP:
		lea	di,[bx+2]
		mov	si,ax
		mov	cx,dx
		repe cmpsb
		je	short ASM_HASH_DONE
		mov	bx,word ptr es:[bx]
		or	bx,bx
		jne	short ASM_HASH_CHAIN_LOOP
ASM_HASH_NOT_FOUND:
		xor	di,di
ASM_HASH_DONE:
		or	di,di
		ret
ASM_HASH_TABLE_LOOKUP	endp

; ---- R8MUL32 (CODE_8:0ACE) ----

		public	ASM_MUL32

ASM_MUL32	proc	near
		push	si
		push	di
		mov	si,ax
		mov	di,dx
		mul	cx
		push	ax
		push	dx
		mov	ax,si
		mul	bx
		xchg	ax,bx
		xchg	ax,di
		mul	cx
		pop	dx
		add	dx,bx
		add	dx,ax
		pop	ax
		pop	di
		pop	si
		ret
ASM_MUL32	endp

; ---- R8DIV (CODE_8:0AE9) ----

		public	ASM_DIV32

ASM_DIV32	proc	near
		push	si
		push	di
		push	bp
		mov	si,cx
		or	si,bx
		jne	short ASM_DIV32_NONZERO
		jmp	ASM_FAIL_DIVIDE_BY_ZERO
ASM_DIV32_NONZERO:
		or	bx,bx
		pushf
		jns	short ASM_DIV32_DIVISOR_POSITIVE
		neg	cx
		adc	bx,0
		neg	bx
ASM_DIV32_DIVISOR_POSITIVE:
		or	dx,dx
		pushf
		jns	short ASM_DIV32_DIVIDEND_POSITIVE
		neg	ax
		adc	dx,0
		neg	dx
ASM_DIV32_DIVIDEND_POSITIVE:
		mov	si,cx
		mov	di,bx
		xor	cx,cx
		xor	bx,bx
		mov	bp,21h
ASM_DIV32_BIT_LOOP:
		rcl	cx,1
		rcl	bx,1
		sub	cx,si
		sbb	bx,di
		jnc	short ASM_DIV32_SHIFT_QUOTIENT
		add	cx,si
		adc	bx,di
ASM_DIV32_SHIFT_QUOTIENT:
		cmc
		rcl	ax,1
		rcl	dx,1
		dec	bp
		jne	short ASM_DIV32_BIT_LOOP
		popf
		jns	short ASM_DIV32_DIVIDEND_WAS_POS
		neg	cx
		adc	bx,0
		neg	bx
		popf
		jns	short ASM_DIV32_NEGATE_QUOTIENT
		jmp	short ASM_DIV32_DONE
ASM_DIV32_DIVIDEND_WAS_POS:
		popf
		jns	short ASM_DIV32_DONE
ASM_DIV32_NEGATE_QUOTIENT:
		neg	ax
		adc	dx,0
		neg	dx
ASM_DIV32_DONE:
		pop	bp
		pop	di
		pop	si
		ret
ASM_DIV32	endp

; ---- R8PAD1 (CODE_8:0B4B) ----
		db	0			; pad byte: ASM_ENCODE_INSTRUCTION starts on a word
; ---- R8EVAL (CODE_8:0B4C) ----

		public	ASM_ENCODE_INSTRUCTION

ASM_ENCODE_INSTRUCTION	proc	near
		xor	ax,ax
		mov	word ptr [bp+0FEF0h],ax
		mov	byte ptr [bp-25h],al
		mov	byte ptr [bp-2Dh],al
		mov	byte ptr [bp-2Eh],al
		mov	bx,word ptr [bp-1Eh]
		mov	bx,word ptr cs:[bx]
		mov	cl,6
		shr	bh,cl
		cmp	bh,byte ptr [bp-1Ch]
		jne	short ASM_ENCODE_NEXT_FORM
		lea	si,[bp+0FE6Ah]
		lea	di,[bp+0FE56h]
		mov	ah,byte ptr [si+12h]
		mov	al,byte ptr [di+12h]
		and	bx,7Eh
		call	word ptr cs:ASM_FORM_HANDLER_TABLE[bx]
		je	short ASM_ENCODE_FORM_MATCHED
ASM_ENCODE_NEXT_FORM:
		call	ASM_OPCODE_BYTE_COUNT
		test	byte ptr cs:[bx],80h
		je	short ASM_ENCODE_NO_FORM
		add	ax,2
		add	word ptr [bp-1Eh],ax
		jmp	short ASM_ENCODE_INSTRUCTION
ASM_ENCODE_FORM_MATCHED:
		mov	bx,word ptr [bp-1Eh]
		test	byte ptr cs:[bx+1],4
		je	short ASM_ENCODE_FINISH
		test	byte ptr [bp+6],3
		jne	short ASM_ENCODE_FINISH
		mov	ax,word ptr [bp-16h]
		mov	word ptr [bp-14h],ax
		jmp	ASM_FAIL_NEEDS_286_287
ASM_ENCODE_FINISH:
		call	ASM_FLUSH_PENDING_OPCODE
		ret
ASM_ENCODE_NO_FORM:
		mov	ax,word ptr [bp-16h]
		cmp	byte ptr [bp-1Ch],1
		jle	short ASM_ENCODE_SET_ERROR_POS
		mov	ax,word ptr [bp-18h]
ASM_ENCODE_SET_ERROR_POS:
		mov	word ptr [bp-14h],ax
		jle	short ASM_ENCODE_BAD_COMBINATION
		mov	ax,word ptr [bp+0FE76h]
		cmp	ax,word ptr [bp+0FE62h]
		je	short ASM_ENCODE_BAD_COMBINATION
		jmp	ASM_FAIL_SIZE_COMBINATION
ASM_ENCODE_BAD_COMBINATION:
		jmp	ASM_FAIL_BAD_COMBINATION
ASM_ENCODE_INSTRUCTION	endp

; ---- R8DROP (CODE_8:0BD1) ----

		public	ASM_ENCODE_NO_OPERANDS

ASM_ENCODE_NO_OPERANDS	proc	near
		call	ASM_BEGIN_OPCODE
		xor	ax,ax
		ret
ASM_ENCODE_NO_OPERANDS	endp

; ---- R8BAD (CODE_8:0BD7) ----

		public	ASM_REJECT_OPERAND_FORM

ASM_REJECT_OPERAND_FORM	proc	near
		jmp	ASM_FAIL_SYNTAX
ASM_REJECT_OPERAND_FORM	endp

; ---- R8NEXT1 (CODE_8:0BDA) ----

		public	ASM_ENCODE_NEAR_INDIRECT

ASM_ENCODE_NEAR_INDIRECT	proc	near
		call	ASM_IS_WORD_RM
		jne	short ASM_NEARIND_DONE
		call	ASM_BEGIN_OPCODE
		call	ASM_EMIT_MODRM
ASM_NEARIND_DONE:
		ret
ASM_ENCODE_NEAR_INDIRECT	endp

; ---- R8NEXT2 (CODE_8:0BE6) ----

		public	ASM_ENCODE_FAR_INDIRECT

ASM_ENCODE_FAR_INDIRECT	proc	near
		call	ASM_DECODE_RM_OPERAND
		jne	short ASM_FARIND_DONE
		cmp	al,0FFh
		jne	short ASM_FARIND_DONE
		call	ASM_BEGIN_OPCODE
		call	ASM_EMIT_MODRM
ASM_FARIND_DONE:
		ret
ASM_ENCODE_FAR_INDIRECT	endp

; ---- R8VALUE (CODE_8:0BF6) ----

		public	ASM_ENCODE_SHORT_JUMP

ASM_ENCODE_SHORT_JUMP	proc	near
		cmp	ah,67h
		jne	short ASM_SHORTJMP_DONE
		cmp	word ptr [si+0Ch],-3
		jne	short ASM_SHORTJMP_DONE
		mov	ax,word ptr [si]
		or	ax,word ptr [si+2]
		jne	short ASM_SHORTJMP_DONE
		call	ASM_EMIT_PREFIX_LIST
		call	ASM_OPCODE_BYTE_COUNT
		mov	cl,byte ptr cs:[bx+2]
		mov	bx,2
		mov	ax,word ptr [si+8]
		mov	word ptr [bp+0FE7Eh],ax
		mov	ax,word ptr [si+0Ah]
		mov	word ptr [bp+0FE80h],ax
		call	ASM_QUEUE_EMIT_RECORD
ASM_SHORTJMP_DONE:
		ret
ASM_ENCODE_SHORT_JUMP	endp

; ---- R8FLAGS (CODE_8:0C27) ----

		public	ASM_ENCODE_DIRECT_JUMP

ASM_ENCODE_DIRECT_JUMP	proc	near
		mov	bh,0
		mov	cx,0FFFDh
		cmp	word ptr [si+0Ch],cx
		je	short ASM_DIRJMP_CHECK_SIZE
		mov	cl,0FFh
		jmp	short ASM_DIRJMP_CHECK_SIZE
ASM_DIRJMP_FAR_FORM:
		mov	bh,3
		mov	cx,0FFFEh
ASM_DIRJMP_CHECK_SIZE:
		cmp	word ptr [si+0Ch],cx
		jne	short ASM_DIRJMP_DONE
		cmp	ah,67h
		jne	short ASM_DIRJMP_DONE
		cmp	byte ptr [si+0Eh],40h
		jne	short ASM_DIRJMP_DONE
		push	bx
		call	ASM_EMIT_PREFIX_LIST
		call	ASM_OPCODE_BYTE_COUNT
		mov	cl,byte ptr cs:[bx+2]
		mov	bl,0
		call	ASM_QUEUE_EMIT_RECORD
		pop	bx
		mov	bl,1
		mov	cx,word ptr [si]
		mov	dx,word ptr [si+2]
		mov	ax,word ptr [si+8]
		mov	word ptr [bp+0FE7Eh],ax
		mov	ax,word ptr [si+0Ah]
		mov	word ptr [bp+0FE80h],ax
		call	ASM_QUEUE_EMIT_RECORD
ASM_DIRJMP_DONE:
		ret
ASM_ENCODE_DIRECT_JUMP	endp

; ---- R8ATTR (CODE_8:0C74) ----

		public	ASM_ENCODE_SHIFT_ROTATE

ASM_ENCODE_SHIFT_ROTATE	proc	near
		call	ASM_IS_BYTE_OR_WORD_RM
		jne	ASM_SHIFT_DONE
		call	ASM_BEGIN_OPCODE
		call	ASM_IMM_FITS_BYTE
		jne	short ASM_SHIFT_BY_CL
		cmp	al,1
		je	short ASM_SHIFT_EMIT_MODRM
		test	byte ptr [bp+6],3
		jne	short ASM_SHIFT_BY_IMM8
		jmp	ASM_FAIL_NEEDS_286_287
ASM_SHIFT_BY_IMM8:
		sub	byte ptr [bp-24h],10h
		push	ax
		call	ASM_EMIT_MODRM_FORM_REG
		pop	ax
		call	ASM_QUEUE_BYTE
		ret
ASM_SHIFT_BY_CL:
		cmp	byte ptr [di+12h],65h
		jne	ASM_SHIFT_DONE
		cmp	word ptr [di+10h],100h
		jne	ASM_SHIFT_DONE
		add	byte ptr [bp-24h],2
ASM_SHIFT_EMIT_MODRM:
		call	ASM_EMIT_MODRM_FORM_REG
ASM_SHIFT_DONE:
		ret
ASM_ENCODE_SHIFT_ROTATE	endp

; ---- R8XCHG (CODE_8:0CB0) ----

		public	ASM_ENCODE_XCHG_REG16_AX

ASM_ENCODE_XCHG_REG16_AX	proc	near
		xchg	al,ah
		xchg	si,di
ASM_XCHGAX_NO_SWAP:
		cmp	ax,6565h
		jne	short ASM_XCHGAX_DONE
		cmp	word ptr [si+10h],1
		jne	short ASM_XCHGAX_DONE
		cmp	byte ptr [di+10h],1
		jne	short ASM_XCHGAX_DONE
		call	ASM_BEGIN_OPCODE
		mov	al,byte ptr [di+11h]
		or	byte ptr [bp-24h],al
		xor	ax,ax
ASM_XCHGAX_DONE:
		ret
ASM_ENCODE_XCHG_REG16_AX	endp

; ---- R8SWAP (CODE_8:0CD1) ----

		public	ASM_ENCODE_ENTER

ASM_ENCODE_ENTER	proc	near
		xchg	si,di
		call	ASM_BEGIN_OPCODE
		call	ASM_EMIT_IMM16
		jne	short ASM_ENTER_DONE
		xchg	si,di
		call	ASM_EMIT_IMM8
ASM_ENTER_DONE:
		ret
ASM_ENCODE_ENTER	endp

; ---- R8MARK (CODE_8:0CE1) ----

		public	ASM_ENCODE_RETURN

ASM_ENCODE_RETURN	proc	near
		call	ASM_BEGIN_OPCODE
		test	byte ptr [bp+7],1
		je	short ASM_RET_CHECK_OPERAND
		or	byte ptr [bp-24h],8
ASM_RET_CHECK_OPERAND:
		cmp	byte ptr [bp-1Ch],0
		jne	short ASM_RET_CHECK_POP_COUNT
		ret
ASM_RET_WITH_IMM_FORM:
		call	ASM_BEGIN_OPCODE
ASM_RET_CHECK_POP_COUNT:
		mov	di,si
		or	byte ptr [bp-24h],1
		call	ASM_IS_IMM_ZERO
		jne	short ASM_RET_EMIT_POP_COUNT
		ret
ASM_RET_EMIT_POP_COUNT:
		and	byte ptr [bp-24h],0FEh
		jmp	ASM_EMIT_IMM16
ASM_ENCODE_RETURN	endp

; ---- R8COMM (CODE_8:0D0B) ----

		public	ASM_ENCODE_IMM16_OPERAND

ASM_ENCODE_IMM16_OPERAND	proc	near
		call	ASM_BEGIN_OPCODE
		xchg	si,di
		jmp	ASM_EMIT_IMM16
ASM_ENCODE_IMM16_OPERAND	endp

; ---- R8CAST (CODE_8:0D13) ----

		public	ASM_ENCODE_IMM8_OPERAND

ASM_ENCODE_IMM8_OPERAND	proc	near
		xchg	si,di
		call	ASM_BEGIN_OPCODE
		call	ASM_IMM_FITS_SIGNED_BYTE
		jne	short ASM_IMM8OP_DONE
		call	ASM_QUEUE_BYTE
ASM_IMM8OP_DONE:
		ret
ASM_ENCODE_IMM8_OPERAND	endp

; ---- R8CONV (CODE_8:0D21) ----

		public	ASM_ENCODE_IMUL_IMMEDIATE

ASM_ENCODE_IMUL_IMMEDIATE	proc	near
		cmp	ah,65h
		jne	short ASM_IMUL_DONE
		cmp	byte ptr [si+10h],1
		jne	short ASM_IMUL_DONE
		xchg	si,di
		call	ASM_IS_WORD_RM
		jne	short ASM_IMUL_DONE
		call	ASM_BEGIN_OPCODE
		call	ASM_SET_MODRM_REG_FROM_DI
		lea	di,[bp+0FE42h]
		call	ASM_CHECK_IMM_FITS_WORD
		jne	short ASM_IMUL_DONE
		call	ASM_IMM_FITS_SIGNED_BYTE
		pushf
		jne	short ASM_IMUL_EMIT_MODRM
		or	byte ptr [bp-24h],2
ASM_IMUL_EMIT_MODRM:
		push	ax
		call	ASM_EMIT_MODRM_NO_SIZE
		pop	ax
		popf
		jne	short ASM_IMUL_IMM16
		jmp	ASM_QUEUE_BYTE
ASM_IMUL_IMM16:
		call	ASM_QUEUE_WORD
ASM_IMUL_DONE:
		ret
ASM_ENCODE_IMUL_IMMEDIATE	endp

; ---- R8ASSIGN (CODE_8:0D5B) ----

		public	ASM_ENCODE_LEA

ASM_ENCODE_LEA	proc	near
		cmp	ax,6567h
		jne	short ASM_LEA_DONE
		cmp	byte ptr [si+10h],1
		jne	short ASM_LEA_DONE
		xchg	si,di
		call	ASM_DECODE_RM_OPERAND
		xchg	si,di
		jne	short ASM_LEA_DONE
		mov	byte ptr [bp-2Eh],0
		call	ASM_BEGIN_OPCODE
		call	ASM_SET_MODRM_REG_FIELD
		call	ASM_EMIT_MODRM_NO_SIZE
ASM_LEA_DONE:
		ret
ASM_ENCODE_LEA	endp

; ---- R8REL (CODE_8:0D7D) ----

		public	ASM_ENCODE_OUT_IMM8_ACC

ASM_ENCODE_OUT_IMM8_ACC	proc	near
		xchg	si,di
		xchg	al,ah
ASM_OUTIMM_NO_SWAP:
		call	ASM_EMIT_OPCODE_IF_ACC
		jne	short ASM_OUTIMM_DONE
		call	ASM_EMIT_IMM8
ASM_OUTIMM_DONE:
		ret
ASM_ENCODE_OUT_IMM8_ACC	endp

; ---- R8REL2 (CODE_8:0D8A) ----

		public	ASM_ENCODE_OUT_DX_ACC

ASM_ENCODE_OUT_DX_ACC	proc	near
		xchg	si,di
		xchg	al,ah
ASM_OUTDX_NO_SWAP:
		cmp	al,65h
		jne	short ASM_OUTDX_DONE
		cmp	word ptr [di+10h],201h
		jne	short ASM_OUTDX_DONE
		call	ASM_EMIT_OPCODE_IF_ACC
ASM_OUTDX_DONE:
		ret
ASM_ENCODE_OUT_DX_ACC	endp

; ---- R8CHK65 (CODE_8:0D9D) ----

		public	ASM_EMIT_OPCODE_IF_ACC

ASM_EMIT_OPCODE_IF_ACC	proc	near
		cmp	ah,65h
		jne	short ASM_IFACC_DONE
		cmp	byte ptr [si+11h],0
		jne	short ASM_IFACC_DONE
		call	ASM_BEGIN_OPCODE
		mov	al,byte ptr [si+10h]
		cmp	al,1
		ja	short ASM_IFACC_DONE
		or	byte ptr [bp-24h],al
		xor	ax,ax
ASM_IFACC_DONE:
		ret
ASM_EMIT_OPCODE_IF_ACC	endp

; ---- R8INCR (CODE_8:0DB8) ----

		public	ASM_ENCODE_INT

ASM_ENCODE_INT	proc	near
		call	ASM_BEGIN_OPCODE
		mov	di,si
		call	ASM_IMM_FITS_BYTE
		jne	short ASM_INT_DONE
		cmp	al,3
		je	short ASM_INT_DONE
		inc	byte ptr [bp-24h]
		call	ASM_QUEUE_BYTE
ASM_INT_DONE:
		ret
ASM_ENCODE_INT	endp

; ---- R8SIGN (CODE_8:0DCD) ----

		public	ASM_ENCODE_MOV_SREG_RM

ASM_ENCODE_MOV_SREG_RM	proc	near
		xchg	al,ah
		xchg	si,di
		mov	bl,byte ptr [di+11h]
		sub	bl,1
		jne	short ASM_MOVSREG_NO_SWAP
		dec	bx
		ret
ASM_MOVSREG_NO_SWAP:
		cmp	al,65h
		jne	short ASM_MOVSREG_DONE
		cmp	byte ptr [di+10h],2
		jne	short ASM_MOVSREG_DONE
		call	ASM_DECODE_RM_OPERAND
		jne	short ASM_MOVSREG_DONE
		cmp	al,1
		je	short ASM_MOVSREG_EMIT
		cmp	word ptr [si+0Ch],0
		jne	short ASM_MOVSREG_DONE
ASM_MOVSREG_EMIT:
		call	ASM_BEGIN_OPCODE
		call	ASM_SET_MODRM_REG_FROM_DI
		call	ASM_EMIT_MODRM_NO_SIZE
ASM_MOVSREG_DONE:
		ret
ASM_ENCODE_MOV_SREG_RM	endp

; ---- R8MODE (CODE_8:0DFE) ----

		public	ASM_ENCODE_MOV_REG_IMM

ASM_ENCODE_MOV_REG_IMM	proc	near
		cmp	ax,6564h
		jne	short ASM_MOVIMM_DONE
		cmp	byte ptr [si+10h],1
		ja	short ASM_MOVIMM_DONE
		call	ASM_BEGIN_OPCODE
		mov	al,byte ptr [si+11h]
		or	byte ptr [bp-24h],al
		cmp	byte ptr [si+10h],0
		je	short ASM_MOVIMM_BYTE
		or	byte ptr [bp-24h],8
		jmp	ASM_EMIT_IMM16
ASM_MOVIMM_BYTE:
		call	ASM_EMIT_IMM8
ASM_MOVIMM_DONE:
		ret
ASM_ENCODE_MOV_REG_IMM	endp

; ---- R8TEST (CODE_8:0E23) ----

		public	ASM_ENCODE_UNARY_RM

ASM_ENCODE_UNARY_RM	proc	near
		call	ASM_IS_BYTE_OR_WORD_RM
		jne	short ASM_UNARYRM_DONE
		call	ASM_BEGIN_OPCODE
		call	ASM_EMIT_MODRM_FORM_REG
ASM_UNARYRM_DONE:
		ret
ASM_ENCODE_UNARY_RM	endp

; ---- R8ORDER (CODE_8:0E2F) ----

		public	ASM_ENCODE_MOV_ACC_MOFFS

ASM_ENCODE_MOV_ACC_MOFFS	proc	near
		xchg	al,ah
		xchg	si,di
ASM_MOVMOFFS_NO_SWAP:
		cmp	ax,6765h
		jne	short ASM_MOVMOFFS_DONE
		cmp	byte ptr [di+11h],0
		jne	short ASM_MOVMOFFS_DONE
		call	ASM_IS_DIRECT_ADDRESS
		jne	short ASM_MOVMOFFS_DONE
		call	ASM_BEGIN_OPCODE
		mov	al,byte ptr [di+10h]
		cmp	al,1
		ja	short ASM_MOVMOFFS_DONE
		cmp	al,byte ptr [bp-2Ch]
		jne	short ASM_MOVMOFFS_DONE
		or	byte ptr [bp-24h],al
		call	ASM_EMIT_DISPLACEMENT
ASM_MOVMOFFS_DONE:
		ret
ASM_ENCODE_MOV_ACC_MOFFS	endp

; ---- R8ORDER2 (CODE_8:0E59) ----

		public	ASM_ENCODE_TEST_XCHG_RM

ASM_ENCODE_TEST_XCHG_RM	proc	near
		push	ax
		call	ASM_TESTXCHG_TRY_ORDER
		pop	ax
		je	short ASM_TESTXCHG_DONE
		xchg	si,di
		xchg	al,ah
ASM_TESTXCHG_TRY_ORDER:
		cmp	al,65h
		jne	short ASM_TESTXCHG_DONE
		cmp	byte ptr [di+10h],1
		ja	short ASM_TESTXCHG_DONE
		call	ASM_IS_BYTE_OR_WORD_RM
		jne	short ASM_TESTXCHG_DONE
		call	ASM_BEGIN_OPCODE
		call	ASM_SET_MODRM_REG_FROM_DI
		mov	al,byte ptr [di+10h]
		cmp	al,byte ptr [bp-2Ch]
		jne	short ASM_TESTXCHG_DONE
		call	ASM_EMIT_MODRM_BYTES
ASM_TESTXCHG_DONE:
		ret
ASM_ENCODE_TEST_XCHG_RM	endp

; ---- R8UNSIGN (CODE_8:0E85) ----

		public	ASM_ENCODE_LDS_LES

ASM_ENCODE_LDS_LES	proc	near
		cmp	ax,6567h
		jne	short ASM_LDSLES_DONE
		cmp	byte ptr [si+10h],1
		jne	short ASM_LDSLES_DONE
		xchg	si,di
		call	ASM_DECODE_RM_OPERAND
		cmp	word ptr [bp-22h],0
		je	short ASM_LDSLES_EMIT
		cmp	al,0FFh
		jne	short ASM_LDSLES_DONE
ASM_LDSLES_EMIT:
		call	ASM_BEGIN_OPCODE
		call	ASM_SET_MODRM_REG_FROM_DI
		call	ASM_EMIT_MODRM_NO_SIZE
ASM_LDSLES_DONE:
		ret
ASM_ENCODE_LDS_LES	endp

; ---- R8CVT2 (CODE_8:0EA9) ----

		public	ASM_ENCODE_LAR_LSL

ASM_ENCODE_LAR_LSL	proc	near
		xchg	si,di
		xchg	al,ah
ASM_LARLSL_NO_SWAP:
		cmp	al,65h
		jne	short ASM_LARLSL_DONE
		cmp	byte ptr [di+10h],1
		jne	short ASM_LARLSL_DONE
		call	ASM_IS_WORD_RM
		jne	short ASM_LARLSL_DONE
		call	ASM_BEGIN_OPCODE
		call	ASM_SET_MODRM_REG_FROM_DI
		call	ASM_EMIT_MODRM_NO_SIZE
ASM_LARLSL_DONE:
		ret
ASM_ENCODE_LAR_LSL	endp

; ---- R8INT (CODE_8:0EC6) ----

		public	ASM_ENCODE_DESCRIPTOR_MEM

ASM_ENCODE_DESCRIPTOR_MEM	proc	near
		call	ASM_DECODE_RM_OPERAND
		jne	short ASM_DESCMEM_DONE
		cmp	word ptr [si+0Ch],6
		je	short ASM_DESCMEM_EMIT
		cmp	word ptr [si+0Ch],0
		jne	short ASM_DESCMEM_DONE
ASM_DESCMEM_EMIT:
		call	ASM_BEGIN_OPCODE
		call	ASM_EMIT_MODRM
ASM_DESCMEM_DONE:
		ret
ASM_ENCODE_DESCRIPTOR_MEM	endp

; ---- R8CMP (CODE_8:0EDE) ----

		public	ASM_ENCODE_RM_REG

ASM_ENCODE_RM_REG	proc	near
		cmp	al,65h
		je	short ASM_RMREG_REG_IN_DI
		cmp	ah,65h
		jne	short ASM_RMREG_DONE
		mov	byte ptr [bp-2Dh],2
		xchg	si,di
ASM_RMREG_REG_IN_DI:
		cmp	byte ptr [di+10h],1
		ja	short ASM_RMREG_DONE
		call	ASM_IS_BYTE_OR_WORD_RM
		jne	short ASM_RMREG_DONE
		call	ASM_BEGIN_OPCODE
		call	ASM_SET_MODRM_REG_FROM_DI
		mov	al,byte ptr [di+10h]
		cmp	al,byte ptr [bp-2Ch]
		jne	short ASM_RMREG_DONE
		call	ASM_EMIT_MODRM_BYTES
ASM_RMREG_DONE:
		ret
ASM_ENCODE_RM_REG	endp

; ---- R8REL3 (CODE_8:0F0A) ----

		public	ASM_ENCODE_RM16

ASM_ENCODE_RM16	proc	near
		call	ASM_IS_WORD_RM
		jne	short ASM_RM16_DONE
		call	ASM_BEGIN_OPCODE
		call	ASM_EMIT_MODRM
ASM_RM16_DONE:
		ret
ASM_ENCODE_RM16	endp

; ---- R8BOOL (CODE_8:0F16) ----

		public	ASM_ENCODE_ALU_RM_IMM

ASM_ENCODE_ALU_RM_IMM	proc	near
		call	ASM_CHECK_IMM_FITS_WORD
		jne	short ASM_ALUIMM_DONE
		call	ASM_IS_BYTE_OR_WORD_RM
		jne	short ASM_ALUIMM_DONE
		call	ASM_BEGIN_OPCODE
		cmp	byte ptr [bp-2Ch],0
		je	short ASM_ALUIMM_BYTE_IMM
		call	ASM_IMM_FITS_SIGNED_BYTE
		jne	short ASM_ALUIMM_WORD_IMM
		or	byte ptr [bp-24h],2
ASM_ALUIMM_BYTE_IMM:
		call	ASM_IMM_FITS_BYTE
		jne	short ASM_ALUIMM_DONE
		call	ASM_EMIT_MODRM_FORM_REG
		jne	short ASM_ALUIMM_DONE
		call	ASM_EMIT_IMM8
		jmp	short ASM_ALUIMM_DONE
ASM_ALUIMM_WORD_IMM:
		call	ASM_EMIT_MODRM_FORM_REG
		jne	short ASM_ALUIMM_DONE
		call	ASM_EMIT_IMM16
ASM_ALUIMM_DONE:
		ret
ASM_ENCODE_ALU_RM_IMM	endp

; ---- R8SIZE (CODE_8:0F4A) ----

		public	ASM_ENCODE_RM_IMM

ASM_ENCODE_RM_IMM	proc	near
		cmp	al,64h
		jne	short ASM_RMIMM_DONE
		call	ASM_IS_BYTE_OR_WORD_RM
		jne	short ASM_RMIMM_DONE
		call	ASM_BEGIN_OPCODE
		call	ASM_EMIT_MODRM_FORM_REG
		cmp	byte ptr [bp-2Ch],1
		je	short ASM_RMIMM_WORD
		jmp	ASM_EMIT_IMM8
ASM_RMIMM_WORD:
		jmp	ASM_EMIT_IMM16
ASM_RMIMM_DONE:
		ret
ASM_ENCODE_RM_IMM	endp

; ---- R8FLOAT (CODE_8:0F66) ----

		public	ASM_ENCODE_ACC_IMM

ASM_ENCODE_ACC_IMM	proc	near
		cmp	ax,6564h
		jne	short ASM_ACCIMM_DONE
		call	ASM_CHECK_IMM_FITS_WORD
		jne	short ASM_ACCIMM_DONE
		cmp	byte ptr [si+11h],0
		jne	short ASM_ACCIMM_DONE
		cmp	byte ptr [si+10h],1
		ja	short ASM_ACCIMM_DONE
		jne	short ASM_ACCIMM_BYTE
		call	ASM_BEGIN_OPCODE
		inc	byte ptr [bp-24h]
		call	ASM_EMIT_IMM16
		jmp	short ASM_ACCIMM_DONE
ASM_ACCIMM_BYTE:
		call	ASM_IMM_FITS_BYTE
		jne	short ASM_ACCIMM_DONE
		call	ASM_BEGIN_OPCODE
		call	ASM_EMIT_IMM8
ASM_ACCIMM_DONE:
		ret
ASM_ENCODE_ACC_IMM	endp

; ---- R8FLAG2 (CODE_8:0F95) ----

		public	ASM_ENCODE_REG16_IN_OPCODE

ASM_ENCODE_REG16_IN_OPCODE	proc	near
		cmp	ah,65h
		jne	short ASM_REG16OP_DONE
		cmp	byte ptr [si+10h],1
		jne	short ASM_REG16OP_DONE
		call	ASM_BEGIN_OPCODE
		mov	al,byte ptr [si+11h]
		or	byte ptr [bp-24h],al
		xor	ax,ax
ASM_REG16OP_DONE:
		ret
ASM_ENCODE_REG16_IN_OPCODE	endp

; ---- R8RANGE (CODE_8:0FAC) ----

		public	ASM_ENCODE_PUSH_POP_SREG

ASM_ENCODE_PUSH_POP_SREG	proc	near
		mov	cl,1
		jmp	short ASM_PPSREG_CHECK
ASM_PPSREG_ANY_SREG_FORM:
		mov	cl,0FFh
ASM_PPSREG_CHECK:
		cmp	ah,65h
		jne	short ASM_PPSREG_DONE
		cmp	byte ptr [si+10h],2
		jne	short ASM_PPSREG_DONE
		cmp	byte ptr [si+11h],cl
		je	short ASM_PPSREG_REJECT
		call	ASM_BEGIN_OPCODE
		mov	al,byte ptr [si+11h]
		mov	cl,3
		shl	al,cl
		or	byte ptr [bp-24h],al
		xor	ax,ax
ASM_PPSREG_DONE:
		ret
ASM_PPSREG_REJECT:
		inc	ax
		ret
ASM_ENCODE_PUSH_POP_SREG	endp

; ---- R8ENCODE (CODE_8:0FD4) ----

		public	ASM_ENCODE_FSTSW_AX

ASM_ENCODE_FSTSW_AX	proc	near
		cmp	ah,65h
		jne	short ASM_FSTSW_DONE
		cmp	word ptr [si+10h],1
		jne	short ASM_FSTSW_DONE
ASM_EMIT_FPU_OPCODE:
		mov	al,0
ASM_EMIT_FPU_OPCODE_BITS:
		xchg	ax,dx
		call	ASM_EMIT_PREFIX_LIST
		call	ASM_OPCODE_BYTE_COUNT
		mov	dh,0
		test	byte ptr [bp+6],3
		jne	short ASM_FPUOP_SCAN_BYTES
		mov	dh,1
ASM_FPUOP_SCAN_BYTES:
		mov	cx,word ptr cs:[bx+2]
		cmp	cl,1
		ja	short ASM_FPUOP_CHECK_WAIT
		mov	dh,cl
		inc	bx
		dec	ax
		jmp	short ASM_FPUOP_SCAN_BYTES
ASM_FPUOP_CHECK_WAIT:
		cmp	cl,9Bh
		jne	short ASM_FPUOP_QUEUE
		xor	dh,dh
ASM_FPUOP_QUEUE:
		or	cl,dl
		mov	ah,ch
		mov	bl,3
		mov	bh,byte ptr [bp-2Eh]
		mov	byte ptr [bp-2Eh],0
		or	bh,dh
		call	ASM_QUEUE_EMIT_RECORD
		dec	ax
		mov	byte ptr [bp-25h],al
		mov	byte ptr [bp-24h],ah
		xor	ax,ax
ASM_FSTSW_DONE:
		ret
ASM_ENCODE_FSTSW_AX	endp
		public	ASM_EMIT_FPU_OPCODE
		public	ASM_EMIT_FPU_OPCODE_BITS

; ---- R8KIND (CODE_8:1024) ----

		public	ASM_ENCODE_FPU_MEM_SIZED

ASM_ENCODE_FPU_MEM_SIZED	proc	near
		mov	cx,0FDFDh
		jmp	short ASM_FPUMEM_CHECK_OPERAND
ASM_FPUMEM_QWORD_ONLY:
		mov	cx,0FEFEh
		jmp	short ASM_FPUMEM_CHECK_OPERAND
ASM_FPUMEM_WORD_OR_DWORD:
		mov	cx,0FF01h
		jmp	short ASM_FPUMEM_CHECK_OPERAND
ASM_FPUMEM_WORD_ONLY:
		cmp	word ptr [si+0Ch],0
		jne	short ASM_FPUMEM_SET_WORD_SIZES
		mov	word ptr [si+0Ch],2
ASM_FPUMEM_SET_WORD_SIZES:
		mov	cx,101h
		jmp	short ASM_FPUMEM_CHECK_OPERAND
ASM_FPUMEM_DWORD_OR_QWORD:
		mov	cx,0FFFEh
ASM_FPUMEM_CHECK_OPERAND:
		cmp	ah,67h
		jne	short ASM_FPUMEM_DONE
		push	cx
		call	ASM_DECODE_RM_OPERAND
		pop	cx
		jne	short ASM_FPUMEM_DONE
		mov	al,0
		cmp	byte ptr [bp-2Ch],ch
		je	short ASM_FPUMEM_EMIT
		cmp	byte ptr [bp-2Ch],cl
		jne	short ASM_FPUMEM_DONE
		or	al,4
ASM_FPUMEM_EMIT:
		call	ASM_EMIT_FPU_OPCODE_BITS
		call	ASM_EMIT_MODRM
ASM_FPUMEM_DONE:
		ret
ASM_ENCODE_FPU_MEM_SIZED	endp

; ---- R8KIND2 (CODE_8:1067) ----

		public	ASM_ENCODE_FPU_ENV_MEM

ASM_ENCODE_FPU_ENV_MEM	proc	near
		mov	cx,0Eh
		jmp	short ASM_FPUENV_CHECK_SIZE
ASM_FPUENV_SAVE_FORM:
		mov	cx,5Eh
ASM_FPUENV_CHECK_SIZE:
		cmp	word ptr [si+0Ch],cx
		je	short ASM_FPUENV_CHECK_MEMORY
		cmp	word ptr [si+0Ch],0
		jne	short ASM_FPUENV_DONE
ASM_FPUENV_CHECK_MEMORY:
		cmp	ah,67h
		jne	short ASM_FPUENV_DONE
		call	ASM_DECODE_RM_OPERAND
		jne	short ASM_FPUENV_DONE
		call	ASM_EMIT_FPU_OPCODE
		call	ASM_EMIT_MODRM
ASM_FPUENV_DONE:
		ret
ASM_ENCODE_FPU_ENV_MEM	endp

; ---- R8FLOAT2 (CODE_8:108B) ----

		public	ASM_ENCODE_FPU_STI

ASM_ENCODE_FPU_STI	proc	near
		mov	al,65h
		jmp	short ASM_FPUSTI_CHECK_REG
ASM_FPUSTI_ST_FIRST:
		xchg	si,di
		xchg	al,ah
ASM_FPUSTI_ST_SECOND:
		cmp	word ptr [di+10h],4
		jne	short ASM_FPUSTI_DONE
ASM_FPUSTI_CHECK_REG:
		cmp	ax,6565h
		jne	short ASM_FPUSTI_DONE
		cmp	byte ptr [si+10h],4
		jne	short ASM_FPUSTI_DONE
		call	ASM_EMIT_FPU_OPCODE
		mov	al,byte ptr [si+11h]
		or	byte ptr [bp-24h],al
		xor	ax,ax
ASM_FPUSTI_DONE:
		ret
ASM_ENCODE_FPU_STI	endp

; ---- R8ISINT (CODE_8:10B0) ----

		public	ASM_IS_DIRECT_ADDRESS

ASM_IS_DIRECT_ADDRESS	proc	near
		call	ASM_DECODE_RM_OPERAND
		jne	short ASM_DIRADDR_DONE
		cmp	byte ptr [bp-2Bh],1
ASM_DIRADDR_DONE:
		ret
ASM_IS_DIRECT_ADDRESS	endp

; ---- R8ISSIGN (CODE_8:10BA) ----

		public	ASM_IS_BYTE_OR_WORD_RM

ASM_IS_BYTE_OR_WORD_RM	proc	near
		call	ASM_DECODE_RM_OPERAND
		jne	short ASM_BWRM_DONE
		test	al,0FEh
ASM_BWRM_DONE:
		ret
ASM_IS_BYTE_OR_WORD_RM	endp

; ---- R8ISONE (CODE_8:10C2) ----

		public	ASM_IS_WORD_RM

ASM_IS_WORD_RM	proc	near
		call	ASM_DECODE_RM_OPERAND
		jne	short ASM_WORDRM_DONE
		cmp	al,1
ASM_WORDRM_DONE:
		ret
ASM_IS_WORD_RM	endp

; ---- R8CLSFY (CODE_8:10CA) ----

		public	ASM_DECODE_RM_OPERAND

ASM_DECODE_RM_OPERAND	proc	near
		mov	ax,word ptr [si+8]
		mov	word ptr [bp-2Ah],ax
		mov	ax,word ptr [si+0Ah]
		mov	word ptr [bp-28h],ax
		mov	word ptr [bp-30h],0
		mov	byte ptr [bp-2Eh],0
		cmp	byte ptr [si+12h],65h
		je	short ASM_DECRM_REGISTER
		cmp	byte ptr [si+12h],67h
		jne	short ASM_DECRM_DONE
		mov	al,byte ptr [si+13h]
		or	al,al
		jne	short ASM_DECRM_SET_FIXUP_KIND
		inc	ax
ASM_DECRM_SET_FIXUP_KIND:
		mov	byte ptr [bp-31h],al
		mov	ax,601h
		mov	bl,byte ptr [si+0Eh]
		and	bx,0Fh
		je	short ASM_DECRM_STORE_MODE
		mov	ah,byte ptr cs:[bx+ASM_MODRM_RM_SIZE_TABLE-1]
		or	ah,ah
		jns	short ASM_DECRM_BASED
		jmp	ASM_FAIL_INVALID_REGISTER
ASM_DECRM_BASED:
		dec	ax
ASM_DECRM_STORE_MODE:
		mov	byte ptr [bp-2Bh],al
		mov	cx,word ptr [si]
		mov	word ptr [bp-30h],cx
		mov	cl,0FCh
		mov	bx,word ptr [si+0Ch]
		cmp	bx,0Ah
		ja	short ASM_DECRM_STORE_SIZE
		mov	cl,byte ptr cs:[bx+ASM_MODRM_RM_SIZE_TABLE+0Fh]
ASM_DECRM_STORE_SIZE:
		mov	byte ptr [bp-2Ch],cl
		mov	byte ptr [bp-26h],ah
		mov	ah,byte ptr [si+0Fh]
		or	ah,ah
		je	short ASM_DECRM_OK
		mov	al,3Eh
		cmp	byte ptr [bp-2Bh],1
		je	short ASM_DECRM_CHECK_DEFAULT_SEG
		test	byte ptr [si+0Eh],4
		je	short ASM_DECRM_CHECK_DEFAULT_SEG
		mov	al,36h
ASM_DECRM_CHECK_DEFAULT_SEG:
		cmp	al,ah
		je	short ASM_DECRM_OK
		mov	byte ptr [bp-2Eh],ah
		jmp	short ASM_DECRM_OK
ASM_DECRM_REGISTER:
		mov	byte ptr [bp-2Bh],0
		mov	ax,word ptr [si+10h]
		or	ah,0C0h
		mov	byte ptr [bp-26h],ah
		cmp	al,1
		ja	short ASM_DECRM_DONE
		mov	byte ptr [bp-2Ch],al
ASM_DECRM_OK:
		xor	ax,ax
ASM_DECRM_DONE:
		mov	al,byte ptr [bp-2Ch]
		ret
ASM_DECODE_RM_OPERAND	endp

; ---- R8TAB1 (CODE_8:1165) ----

		public	ASM_MODRM_RM_SIZE_TABLE
ASM_MODRM_RM_SIZE_TABLE	label	word
		dw	00405h
		dw	006FFh
		dw	00203h
		dw	007FFh
		dw	00001h
		dw	0FFFFh
		dw	0FFFFh
		dw	0FCFFh
		dw	00100h
		dw	0FFFCh
		dw	0FCFCh
		dw	0FEFCh
		dw	0FDFCh

; ---- R8PRED1 (CODE_8:117F) ----

		public	ASM_IMM_FITS_SIGNED_BYTE

ASM_IMM_FITS_SIGNED_BYTE	proc	near
		cmp	byte ptr [di+12h],64h
		jne	short ASM_SBYTE_DONE
		cmp	byte ptr [di+13h],0
		jne	short ASM_SBYTE_DONE
		mov	al,byte ptr [di]
		cbw
		cwd
		cmp	ah,byte ptr [di+1]
		jne	short ASM_SBYTE_DONE
		cmp	dx,word ptr [di+2]
ASM_SBYTE_DONE:
		ret
ASM_IMM_FITS_SIGNED_BYTE	endp

; ---- R8PRED2 (CODE_8:1198) ----

		public	ASM_IMM_FITS_BYTE

ASM_IMM_FITS_BYTE	proc	near
		call	ASM_CHECK_IMM_FITS_WORD
		jne	short ASM_FITBYTE_DONE
		cmp	byte ptr [di+13h],0
		jne	short ASM_FITBYTE_DONE
		or	dx,dx
		js	short ASM_FITBYTE_NEGATIVE
		or	ah,ah
		ret
ASM_FITBYTE_NEGATIVE:
		mov	dx,ax
		cbw
		cmp	ax,dx
ASM_FITBYTE_DONE:
		ret
ASM_IMM_FITS_BYTE	endp

; ---- R8PRED3 (CODE_8:11B0) ----

		public	ASM_CHECK_IMM_FITS_WORD

ASM_CHECK_IMM_FITS_WORD	proc	near
		cmp	byte ptr [di+12h],64h
		jne	short ASM_FITWORD_DONE
		mov	ax,word ptr [di]
		cwd
		cmp	word ptr [di+2],dx
		je	short ASM_FITWORD_DONE
		xor	dx,dx
		cmp	word ptr [di+2],dx
		je	short ASM_FITWORD_DONE
		jmp	ASM_FAIL_NUMBER_OVERFLOW
ASM_FITWORD_DONE:
		ret
ASM_CHECK_IMM_FITS_WORD	endp

; ---- R8PRED4 (CODE_8:11C9) ----

		public	ASM_SET_MODRM_REG_FIELD

ASM_SET_MODRM_REG_FIELD	proc	near
		mov	al,byte ptr [si+11h]
		jmp	short ASM_MODRMREG_SHIFT_IN
ASM_SET_MODRM_REG_FROM_DI:
		mov	al,byte ptr [di+11h]
ASM_MODRMREG_SHIFT_IN:
		shl	al,1
		shl	al,1
		shl	al,1
		or	byte ptr [bp-26h],al
		ret
ASM_SET_MODRM_REG_FIELD	endp
		public	ASM_SET_MODRM_REG_FROM_DI

; ---- R8EMIT1 (CODE_8:11DB) ----

		public	ASM_BEGIN_OPCODE

ASM_BEGIN_OPCODE	proc	near
		call	ASM_EMIT_PREFIX_LIST
		mov	al,byte ptr [bp-2Eh]
		or	al,al
		je	short ASM_BEGINOP_OPCODE_BYTES
		call	ASM_QUEUE_BYTE
ASM_BEGINOP_OPCODE_BYTES:
		call	ASM_EMIT_OPCODE_BYTES
		inc	byte ptr [bp-25h]
		mov	byte ptr [bp-24h],al
		ret
ASM_BEGIN_OPCODE	endp

; ---- R8EMIT2 (CODE_8:11F2) ----

		public	ASM_EMIT_OPCODE_BYTES

ASM_EMIT_OPCODE_BYTES	proc	near
		call	ASM_OPCODE_BYTE_COUNT
		xchg	ax,cx
		dec	cx
		je	short ASM_OPBYTES_FETCH_BYTE
		js	short ASM_OPBYTES_FETCH_BYTE
ASM_OPBYTES_LOOP:
		call	ASM_OPBYTES_FETCH_BYTE
		call	ASM_QUEUE_BYTE
		loop	short ASM_OPBYTES_LOOP
ASM_OPBYTES_FETCH_BYTE:
		mov	al,byte ptr cs:[bx+2]
		inc	bx
		ret
ASM_EMIT_OPCODE_BYTES	endp

; ---- R8EMIT3 (CODE_8:1209) ----

		public	ASM_EMIT_PREFIX_LIST

ASM_EMIT_PREFIX_LIST	proc	near
		lea	bx,[bp-0Eh]
ASM_PREFIXES_LOOP:
		xor	ax,ax
		add	al,byte ptr ss:[bx]
		je	short ASM_PREFIXES_DONE
		call	ASM_QUEUE_BYTE
		inc	bx
		jmp	short ASM_PREFIXES_LOOP
ASM_PREFIXES_DONE:
		ret
ASM_EMIT_PREFIX_LIST	endp

; ---- R8FLUSH2 (CODE_8:121A) ----

		public	ASM_FLUSH_PENDING_OPCODE

ASM_FLUSH_PENDING_OPCODE	proc	near
		push	ax
		xor	ax,ax
		xchg	byte ptr [bp-25h],al
		or	al,al
		je	short ASM_PENDING_DONE
		mov	al,byte ptr [bp-24h]
		call	ASM_QUEUE_BYTE
ASM_PENDING_DONE:
		pop	ax
		ret
ASM_FLUSH_PENDING_OPCODE	endp

; ---- R8CHK0 (CODE_8:122C) ----

		public	ASM_IS_IMM_ZERO

ASM_IS_IMM_ZERO	proc	near
		cmp	byte ptr [di+13h],0
		jne	short ASM_IMMZERO_DONE
		call	ASM_CHECK_IMM_FITS_WORD
		jne	short ASM_IMMZERO_DONE
		or	ax,ax
ASM_IMMZERO_DONE:
		ret
ASM_IS_IMM_ZERO	endp

; ---- R8LOAD (CODE_8:123A) ----

		public	ASM_EMIT_IMM16

ASM_EMIT_IMM16	proc	near
		mov	bh,byte ptr [di+13h]
		or	bh,bh
		jne	short ASM_IMM16_FIXUP
		call	ASM_CHECK_IMM_FITS_WORD
		je	ASM_QUEUE_WORD
		ret
ASM_IMM16_FIXUP:
		mov	bl,1
		mov	cx,word ptr [di]
		mov	dx,word ptr [di+2]
		mov	ax,word ptr [di+8]
		mov	word ptr [bp+0FE7Eh],ax
		mov	ax,word ptr [di+0Ah]
		mov	word ptr [bp+0FE80h],ax
		call	ASM_QUEUE_EMIT_RECORD
		ret
ASM_EMIT_IMM16	endp

; ---- R8STORE (CODE_8:1260) ----

		public	ASM_EMIT_IMM8

ASM_EMIT_IMM8	proc	near
		call	ASM_IMM_FITS_BYTE
		je	short ASM_QUEUE_BYTE
		ret
ASM_QUEUE_WORD:
		call	ASM_QUEUE_BYTE
		xchg	al,ah
ASM_QUEUE_BYTE:
		call	ASM_FLUSH_PENDING_OPCODE
		push	bx
		push	cx
		mov	bl,0
		mov	cx,ax
		call	ASM_QUEUE_EMIT_RECORD
		pop	cx
		pop	bx
		ret
ASM_EMIT_IMM8	endp
		public	ASM_QUEUE_WORD
		public	ASM_QUEUE_BYTE

; ---- R8PUSH2 (CODE_8:127A) ----

		public	ASM_QUEUE_EMIT_RECORD

ASM_QUEUE_EMIT_RECORD	proc	near
		call	ASM_FLUSH_PENDING_OPCODE
		push	si
		mov	si,word ptr [bp+0FEF0h]
		cmp	si,6Eh
		jne	short ASM_QUEUE_STORE_RECORD
		jmp	ASM_FAIL_SYNTAX
ASM_QUEUE_STORE_RECORD:
		mov	word ptr [bp+si+0FE82h],bx
		mov	word ptr [bp+si+0FE84h],cx
		mov	word ptr [bp+si+0FE86h],dx
		push	word ptr [bp+0FE7Eh]
		pop	word ptr [bp+si+0FE88h]
		push	word ptr [bp+0FE80h]
		pop	word ptr [bp+si+0FE8Ah]
		add	word ptr [bp+0FEF0h],0Ah
		pop	si
		cmp	ax,ax
		ret
ASM_QUEUE_EMIT_RECORD	endp

; ---- R8PUSH3 (CODE_8:12AF) ----

		public	ASM_EMIT_DISPLACEMENT

ASM_EMIT_DISPLACEMENT	proc	near
		mov	ax,word ptr [bp-30h]
		mov	cx,word ptr [bp-2Ah]
		or	cx,word ptr [bp-28h]
		je	ASM_QUEUE_WORD
		xchg	ax,cx
		xor	dx,dx
		mov	bl,1
		mov	bh,byte ptr [bp-31h]
		mov	ax,word ptr [bp-2Ah]
		mov	word ptr [bp+0FE7Eh],ax
		mov	ax,word ptr [bp-28h]
		mov	word ptr [bp+0FE80h],ax
		jmp short	ASM_QUEUE_EMIT_RECORD
ASM_EMIT_DISPLACEMENT	endp

; ---- R8FINISH (CODE_8:12D2) ----

		public	ASM_EMIT_MODRM

ASM_EMIT_MODRM	proc	near
		mov	byte ptr [bp-2Ch],0
ASM_EMIT_MODRM_FORM_REG:
		call	ASM_GET_FORM_FLAGS
		and	al,38h
		or	byte ptr [bp-26h],al
		cmp	byte ptr [bp-2Dh],0
		je	short ASM_EMIT_MODRM_BYTES
		ret
ASM_EMIT_MODRM_NO_SIZE:
		mov	byte ptr [bp-2Ch],0
ASM_EMIT_MODRM_BYTES:
		mov	al,byte ptr [bp-2Ch]
		or	al,byte ptr [bp-2Dh]
		or	byte ptr [bp-24h],al
		mov	al,byte ptr [bp-26h]
		mov	ah,al
		and	ax,0C7C0h
		cmp	al,0C0h
		je	short ASM_MODRM_QUEUE_MODRM
		cmp	byte ptr [bp-2Bh],1
		je	short ASM_MODRM_EMIT_DISP16
		mov	cx,word ptr [bp-2Ah]
		or	cx,word ptr [bp-28h]
		jne	short ASM_MODRM_DISP16
		mov	cx,word ptr [bp-30h]
		cmp	ah,6
		je	short ASM_MODRM_CHECK_DISP8
		jcxz	short ASM_MODRM_QUEUE_MODRM
ASM_MODRM_CHECK_DISP8:
		mov	ax,cx
		cbw
		cmp	ax,cx
		je	short ASM_MODRM_DISP8
ASM_MODRM_DISP16:
		or	byte ptr [bp-26h],80h
ASM_MODRM_EMIT_DISP16:
		call	ASM_MODRM_QUEUE_MODRM
		call	ASM_EMIT_DISPLACEMENT
		jmp	short ASM_MODRM_SET_RESULT
ASM_MODRM_DISP8:
		or	byte ptr [bp-26h],40h
		call	ASM_MODRM_QUEUE_MODRM
		mov	ax,word ptr [bp-30h]
		jmp	short ASM_MODRM_QUEUE_AL
ASM_MODRM_QUEUE_MODRM:
		mov	al,byte ptr [bp-26h]
ASM_MODRM_QUEUE_AL:
		call	ASM_QUEUE_BYTE
ASM_MODRM_SET_RESULT:
		cmp	byte ptr [bp-2Ch],0FDh
		ja	short ASM_MODRM_DONE
		xor	ax,ax
ASM_MODRM_DONE:
		ret
ASM_EMIT_MODRM	endp
		public	ASM_EMIT_MODRM_FORM_REG
		public	ASM_EMIT_MODRM_NO_SIZE
		public	ASM_EMIT_MODRM_BYTES

; ---- R8WIDTH (CODE_8:1344) ----

		public	ASM_OPCODE_BYTE_COUNT

ASM_OPCODE_BYTE_COUNT	proc	near
		call	ASM_GET_FORM_FLAGS
		and	ax,3
		inc	ax
		ret
ASM_OPCODE_BYTE_COUNT	endp

; ---- R8GETOP (CODE_8:134C) ----

		public	ASM_GET_FORM_FLAGS

ASM_GET_FORM_FLAGS	proc	near
		mov	bx,word ptr [bp-1Eh]
		mov	al,byte ptr cs:[bx+1]
		ret
ASM_GET_FORM_FLAGS	endp

; ---- R8TAB2 (CODE_8:1354) ----

		public	ASM_FORM_HANDLER_TABLE
ASM_FORM_HANDLER_TABLE	label	word
		dw	ASM_ENCODE_NO_OPERANDS
		dw	ASM_ENCODE_IMM16_OPERAND
		dw	ASM_ENCODE_IMM8_OPERAND
		dw	ASM_ENCODE_LEA
		dw	ASM_ENCODE_OUT_DX_ACC
		dw	ASM_ENCODE_OUT_IMM8_ACC
		dw	ASM_OUTDX_NO_SWAP
		dw	ASM_OUTIMM_NO_SWAP
		dw	ASM_ENCODE_XCHG_REG16_AX
		dw	ASM_XCHGAX_NO_SWAP
		dw	ASM_ENCODE_INT
		dw	ASM_ENCODE_ENTER
		dw	ASM_ENCODE_ACC_IMM
		dw	ASM_ENCODE_MOV_REG_IMM
		dw	ASM_ENCODE_NEAR_INDIRECT
		dw	ASM_DIRJMP_FAR_FORM
		dw	ASM_ENCODE_FAR_INDIRECT
		dw	ASM_ENCODE_SHORT_JUMP
		dw	ASM_ENCODE_DIRECT_JUMP
		dw	ASM_MOVMOFFS_NO_SWAP
		dw	ASM_ENCODE_MOV_ACC_MOFFS
		dw	ASM_ENCODE_RETURN
		dw	ASM_RET_WITH_IMM_FORM
		dw	ASM_REJECT_OPERAND_FORM
		dw	ASM_PPSREG_ANY_SREG_FORM
		dw	ASM_ENCODE_PUSH_POP_SREG
		dw	ASM_ENCODE_REG16_IN_OPCODE
		dw	ASM_ENCODE_DESCRIPTOR_MEM
		dw	ASM_ENCODE_LAR_LSL
		dw	ASM_LARLSL_NO_SWAP
		dw	ASM_ENCODE_IMUL_IMMEDIATE
		dw	ASM_ENCODE_MOV_SREG_RM
		dw	ASM_MOVSREG_NO_SWAP
		dw	ASM_ENCODE_RM_REG
		dw	ASM_ENCODE_TEST_XCHG_RM
		dw	ASM_ENCODE_RM16
		dw	ASM_ENCODE_ALU_RM_IMM
		dw	ASM_ENCODE_RM_IMM
		dw	ASM_ENCODE_UNARY_RM
		dw	ASM_ENCODE_LDS_LES
		dw	ASM_ENCODE_SHIFT_ROTATE
		dw	ASM_EMIT_FPU_OPCODE
		dw	ASM_ENCODE_FSTSW_AX
		dw	ASM_ENCODE_FPU_STI
		dw	ASM_FPUSTI_ST_SECOND
		dw	ASM_FPUSTI_ST_FIRST
		dw	ASM_FPUMEM_DWORD_OR_QWORD
		dw	ASM_ENCODE_FPU_MEM_SIZED
		dw	ASM_FPUMEM_WORD_ONLY
		dw	ASM_FPUMEM_WORD_OR_DWORD
		dw	ASM_FPUMEM_QWORD_ONLY
		dw	ASM_ENCODE_FPU_ENV_MEM
		dw	ASM_FPUENV_SAVE_FORM
		dw	ASM_REJECT_OPERAND_FORM

; ---- R8AUX (CODE_8:13C0) ----

		public	ASM_OPCODE_TABLE_ADDRESS

ASM_OPCODE_TABLE_ADDRESS	proc	near
		mov	di,offset ASM_MNEMONIC_HASH_TABLE
		ret
ASM_OPCODE_TABLE_ADDRESS	endp

; ---- R8DATA1 (CODE_8:13C4) ----

; Instruction mnemonics and directives: a hash mask, 16 bucket heads, then the entries.
; Each entry: the next entry in its bucket (0 ends the chain), the name
; as a length byte and its characters, then the payload.
		public	ASM_MNEMONIC_HASH_TABLE
ASM_MNEMONIC_HASH_TABLE	label	word
		dw	001Eh			; hash mask
		dw	op_FSTENV
		dw	op_FCOM
		dw	op_FSTSW
		dw	op_FLDL2E
		dw	op_FPTAN
		dw	op_FINIT
		dw	op_FWAIT
		dw	op_FNDISI
		dw	op_FXAM
		dw	op_FSETPM
		dw	op_FDISI
		dw	op_FNENI
		dw	op_FLDZ
		dw	op_FNSTENV
		dw	op_FENI
		dw	op_FNSTSW
op_DB:	dw	0
		db	2,'DB'
		db	0EAh,001h
op_DW:	dw	0
		db	2,'DW'
		db	0EAh,002h
op_DD:	dw	0
		db	2,'DD'
		db	0EAh,004h
op_LOCK:	dw	0
		db	4,'LOCK'
		db	0AEh,000h,0F0h
op_REP:	dw	op_DB
		db	3,'REP'
		db	0AEh,000h,0F3h
op_REPE:	dw	0
		db	4,'REPE'
		db	0AEh,000h,0F3h
op_REPZ:	dw	0
		db	4,'REPZ'
		db	0AEh,000h,0F3h
op_REPNE:	dw	op_LOCK
		db	5,'REPNE'
		db	0AEh,000h,0F2h
op_REPNZ:	dw	0
		db	5,'REPNZ'
		db	0AEh,000h,0F2h
op_SEGES:	dw	0
		db	5,'SEGES'
		db	0AEh,000h,026h
op_SEGCS:	dw	0
		db	5,'SEGCS'
		db	0AEh,000h,02Eh
op_SEGSS:	dw	op_SEGCS
		db	5,'SEGSS'
		db	0AEh,000h,036h
op_SEGDS:	dw	0
		db	5,'SEGDS'
		db	0AEh,000h,03Eh
op_ADC:	dw	op_REPNE
		db	3,'ADC'
		db	098h,080h,014h,0C2h,080h,010h,048h,090h,080h
op_ADD:	dw	op_DD
		db	3,'ADD'
		db	098h,080h,004h,0C2h,080h,000h,048h,080h,080h
op_AND:	dw	op_SEGSS
		db	3,'AND'
		db	098h,080h,024h,0C2h,080h,020h,04Ah,0A0h,080h
op_AAA:	dw	op_AND
		db	3,'AAA'
		db	000h,000h,037h
op_AAS:	dw	op_SEGES
		db	3,'AAS'
		db	000h,000h,03Fh
op_AAD:	dw	0
		db	3,'AAD'
		db	080h,001h,0D5h,00Ah,004h,040h,0D5h
op_AAM:	dw	0
		db	3,'AAM'
		db	080h,001h,0D4h,00Ah,004h,040h,0D4h
op_BOUND:	dw	op_AAD
		db	5,'BOUND'
		db	04Eh,084h,062h
op_CALL:	dw	op_REPE
		db	4,'CALL'
		db	0A4h,040h,0E8h,09Eh,040h,09Ah,09Ch,050h,0FFh,020h,058h,0FFh
op_CMP:	dw	op_REPZ
		db	3,'CMP'
		db	098h,080h,03Ch,0C2h,080h,038h,048h,0B8h,080h
op_CBW:	dw	op_DW
		db	3,'CBW'
		db	000h,000h,098h
op_CWD:	dw	0
		db	3,'CWD'
		db	000h,000h,099h
op_CLC:	dw	0
		db	3,'CLC'
		db	000h,000h,0F8h
op_CLD:	dw	op_AAA
		db	3,'CLD'
		db	000h,000h,0FCh
op_CLI:	dw	op_ADC
		db	3,'CLI'
		db	000h,000h,0FAh
op_CMC:	dw	op_CLD
		db	3,'CMC'
		db	000h,000h,0F5h
op_CMPSB:	dw	op_CMC
		db	5,'CMPSB'
		db	000h,000h,0A6h
op_CMPSW:	dw	op_CLI
		db	5,'CMPSW'
		db	000h,000h,0A7h
op_DAA:	dw	op_BOUND
		db	3,'DAA'
		db	000h,000h,027h
op_DAS:	dw	op_CMPSW
		db	3,'DAS'
		db	000h,000h,02Fh
op_DEC:	dw	op_CBW
		db	3,'DEC'
		db	0B4h,040h,048h,04Ch,048h,0FEh
op_DIV:	dw	op_CMPSB
		db	3,'DIV'
		db	04Ch,070h,0F6h
op_ENTER:	dw	op_DEC
		db	5,'ENTER'
		db	016h,084h,0C8h
op_HLT:	dw	op_DAS
		db	3,'HLT'
		db	000h,000h,0F4h
op_IDIV:	dw	op_CALL
		db	4,'IDIV'
		db	04Ch,078h,0F6h
op_IMUL:	dw	op_DAA
		db	4,'IMUL'
		db	0CCh,068h,0F6h,03Ch,0C4h,069h
op_IN:	dw	op_HLT
		db	2,'IN'
		db	08Ch,080h,0ECh,00Eh,080h,0E4h
op_INC:	dw	0
		db	3,'INC'
		db	0B4h,040h,040h,04Ch,040h,0FEh
op_INSB:	dw	op_IDIV
		db	4,'INSB'
		db	000h,004h,06Ch
op_INSW:	dw	op_CMP
		db	4,'INSW'
		db	000h,004h,06Dh
op_INT:	dw	op_INSB
		db	3,'INT'
		db	014h,040h,0CCh
op_INTO:	dw	op_ADD
		db	4,'INTO'
		db	000h,000h,0CEh
op_IRET:	dw	op_DIV
		db	4,'IRET'
		db	000h,000h,0CFh
op_JMP:	dw	op_REP
		db	3,'JMP'
		db	0A2h,040h,0EBh,0A4h,040h,0E9h,09Eh,040h,0EAh,09Ch,060h,0FFh,020h,068h,0FFh
op_JO:	dw	op_INC
		db	2,'JO'
		db	022h,040h,070h
op_JNO:	dw	op_JMP
		db	3,'JNO'
		db	022h,040h,071h
op_JC:	dw	op_CWD
		db	2,'JC'
		db	022h,040h,072h
op_JB:	dw	op_REPNZ
		db	2,'JB'
		db	022h,040h,072h
op_JNAE:	dw	op_JB
		db	4,'JNAE'
		db	022h,040h,072h
op_JNC:	dw	op_INT
		db	3,'JNC'
		db	022h,040h,073h
op_JAE:	dw	op_INSW
		db	3,'JAE'
		db	022h,040h,073h
op_JNB:	dw	op_JO
		db	3,'JNB'
		db	022h,040h,073h
op_JE:	dw	op_JAE
		db	2,'JE'
		db	022h,040h,074h
op_JZ:	dw	op_AAS
		db	2,'JZ'
		db	022h,040h,074h
op_JNE:	dw	op_JNAE
		db	3,'JNE'
		db	022h,040h,075h
op_JNZ:	dw	op_CLC
		db	3,'JNZ'
		db	022h,040h,075h
op_JBE:	dw	0
		db	3,'JBE'
		db	022h,040h,076h
op_JNA:	dw	op_INTO
		db	3,'JNA'
		db	022h,040h,076h
op_JA:	dw	op_ENTER
		db	2,'JA'
		db	022h,040h,077h
op_JNBE:	dw	op_JC
		db	4,'JNBE'
		db	022h,040h,077h
op_JS:	dw	op_JNBE
		db	2,'JS'
		db	022h,040h,078h
op_JNS:	dw	op_JNC
		db	3,'JNS'
		db	022h,040h,079h
op_JP:	dw	op_JNS
		db	2,'JP'
		db	022h,040h,07Ah
op_JPE:	dw	op_AAM
		db	3,'JPE'
		db	022h,040h,07Ah
op_JNP:	dw	op_IN
		db	3,'JNP'
		db	022h,040h,07Bh
op_JPO:	dw	op_JNA
		db	3,'JPO'
		db	022h,040h,07Bh
op_JL:	dw	op_JNO
		db	2,'JL'
		db	022h,040h,07Ch
op_JNGE:	dw	op_IRET
		db	4,'JNGE'
		db	022h,040h,07Ch
op_JGE:	dw	op_IMUL
		db	3,'JGE'
		db	022h,040h,07Dh
op_JNL:	dw	op_SEGDS
		db	3,'JNL'
		db	022h,040h,07Dh
op_JLE:	dw	op_JP
		db	3,'JLE'
		db	022h,040h,07Eh
op_JNG:	dw	op_JPE
		db	3,'JNG'
		db	022h,040h,07Eh
op_JG:	dw	op_JNZ
		db	2,'JG'
		db	022h,040h,07Fh
op_JNLE:	dw	op_JNP
		db	4,'JNLE'
		db	022h,040h,07Fh
op_JCXZ:	dw	op_JS
		db	4,'JCXZ'
		db	022h,040h,0E3h
op_LAHF:	dw	op_JNB
		db	4,'LAHF'
		db	000h,000h,09Fh
op_LDS:	dw	op_JNGE
		db	3,'LDS'
		db	04Eh,080h,0C5h
op_LEA:	dw	op_JG
		db	3,'LEA'
		db	006h,080h,08Dh
op_LEAVE:	dw	op_JLE
		db	5,'LEAVE'
		db	000h,004h,0C9h
op_LES:	dw	op_JNL
		db	3,'LES'
		db	04Eh,080h,0C4h
op_LODSB:	dw	op_LEA
		db	5,'LODSB'
		db	000h,000h,0ACh
op_LODSW:	dw	op_JL
		db	5,'LODSW'
		db	000h,000h,0ADh
op_LOOP:	dw	op_JPO
		db	4,'LOOP'
		db	022h,040h,0E2h
op_LOOPE:	dw	op_JNE
		db	5,'LOOPE'
		db	022h,040h,0E1h
op_LOOPZ:	dw	op_LODSB
		db	5,'LOOPZ'
		db	022h,040h,0E1h
op_LOOPNE:	dw	op_LAHF
		db	6,'LOOPNE'
		db	022h,040h,0E0h
op_LOOPNZ:	dw	op_JNG
		db	6,'LOOPNZ'
		db	022h,040h,0E0h
op_MOV:	dw	op_LOOPZ
		db	3,'MOV'
		db	0A8h,080h,0A0h,0A6h,080h,0A2h,09Ah,080h,0B0h,0CAh,080h,0C6h,0C2h,080h,088h,0C0h,080h,08Ch,03Eh,080h,08Eh
op_MOVSB:	dw	op_JZ
		db	5,'MOVSB'
		db	000h,000h,0A4h
op_MOVSW:	dw	op_LOOPNE
		db	5,'MOVSW'
		db	000h,000h,0A5h
op_MUL:	dw	op_JCXZ
		db	3,'MUL'
		db	04Ch,060h,0F6h
op_NEG:	dw	op_MOVSW
		db	3,'NEG'
		db	04Ch,058h,0F6h
op_NOP:	dw	op_LOOPE
		db	3,'NOP'
		db	000h,000h,090h
op_NOT:	dw	op_JBE
		db	3,'NOT'
		db	04Ch,050h,0F6h
op_OR:	dw	op_MOV
		db	2,'OR'
		db	098h,080h,00Ch,0C2h,080h,008h,04Ah,088h,080h
op_OUT:	dw	op_JNLE
		db	3,'OUT'
		db	088h,080h,0EEh,00Ah,080h,0E6h
op_OUTSB:	dw	op_LEAVE
		db	5,'OUTSB'
		db	000h,004h,06Eh
op_OUTSW:	dw	op_JE
		db	5,'OUTSW'
		db	000h,004h,06Fh
op_POP:	dw	op_LOOPNZ
		db	3,'POP'
		db	0B4h,040h,058h,0B2h,040h,007h,046h,040h,08Fh
op_POPA:	dw	op_POP
		db	4,'POPA'
		db	000h,004h,061h
op_POPF:	dw	op_LES
		db	4,'POPF'
		db	000h,000h,09Dh
op_PUSH:	dw	op_POPA
		db	4,'PUSH'
		db	0B4h,040h,050h,0B0h,040h,006h,0C6h,070h,0FFh,084h,044h,06Ah,002h,044h,068h
op_PUSHA:	dw	op_PUSH
		db	5,'PUSHA'
		db	000h,004h,060h
op_PUSHF:	dw	op_POPF
		db	5,'PUSHF'
		db	000h,000h,09Ch
op_RET:	dw	op_OUTSB
		db	3,'RET'
		db	0AAh,000h,0C3h,02Ah,040h,0C2h
op_RETN:	dw	op_OUT
		db	4,'RETN'
		db	080h,000h,0C3h,02Ch,040h,0C2h
op_RETF:	dw	op_OUTSW
		db	4,'RETF'
		db	080h,000h,0CBh,02Ch,040h,0CAh
op_SUB:	dw	op_NEG
		db	3,'SUB'
		db	098h,080h,02Ch,0C2h,080h,028h,048h,0A8h,080h
op_SBB:	dw	op_LODSW
		db	3,'SBB'
		db	098h,080h,01Ch,0C2h,080h,018h,048h,098h,080h
op_RCL:	dw	op_NOT
		db	3,'RCL'
		db	050h,090h,0D0h
op_RCR:	dw	op_SBB
		db	3,'RCR'
		db	050h,098h,0D0h
op_ROL:	dw	op_NOP
		db	3,'ROL'
		db	050h,080h,0D0h
op_ROR:	dw	op_LDS
		db	3,'ROR'
		db	050h,088h,0D0h
op_SAL:	dw	op_RETF
		db	3,'SAL'
		db	050h,0A0h,0D0h
op_SHL:	dw	op_RCR
		db	3,'SHL'
		db	050h,0A0h,0D0h
op_SAR:	dw	op_JGE
		db	3,'SAR'
		db	050h,0B8h,0D0h
op_SHR:	dw	op_ROL
		db	3,'SHR'
		db	050h,0A8h,0D0h
op_SAHF:	dw	op_RCL
		db	4,'SAHF'
		db	000h,000h,09Eh
op_SCASB:	dw	op_SUB
		db	5,'SCASB'
		db	000h,000h,0AEh
op_SCASW:	dw	op_PUSHA
		db	5,'SCASW'
		db	000h,000h,0AFh
op_STC:	dw	op_SCASB
		db	3,'STC'
		db	000h,000h,0F9h
op_STD:	dw	op_RET
		db	3,'STD'
		db	000h,000h,0FDh
op_STI:	dw	op_SAL
		db	3,'STI'
		db	000h,000h,0FBh
op_STOSB:	dw	op_LOOP
		db	5,'STOSB'
		db	000h,000h,0AAh
op_STOSW:	dw	op_MUL
		db	5,'STOSW'
		db	000h,000h,0ABh
op_TEST:	dw	op_SCASW
		db	4,'TEST'
		db	098h,080h,0A8h,0CAh,080h,0F6h,044h,080h,084h
op_WAIT:	dw	op_PUSHF
		db	4,'WAIT'
		db	000h,000h,09Bh
op_XCHG:	dw	op_STOSB
		db	4,'XCHG'
		db	090h,080h,090h,092h,080h,090h,044h,080h,086h
op_XLAT:	dw	op_RETN
		db	4,'XLAT'
		db	000h,000h,0D7h
op_XOR:	dw	op_XCHG
		db	3,'XOR'
		db	098h,080h,034h,0C2h,080h,030h,04Ah,0B0h,080h
op_ARPL:	dw	op_STOSW
		db	4,'ARPL'
		db	03Ah,084h,063h
op_LAR:	dw	op_TEST
		db	3,'LAR'
		db	038h,085h,00Fh,002h
op_CLTS:	dw	op_MOVSB
		db	4,'CLTS'
		db	000h,005h,00Fh,006h
op_LGDT:	dw	op_STC
		db	4,'LGDT'
		db	036h,055h,00Fh,001h
op_SGDT:	dw	op_SAHF
		db	4,'SGDT'
		db	036h,045h,00Fh,001h
op_LIDT:	dw	op_JA
		db	4,'LIDT'
		db	036h,05Dh,00Fh,001h
op_SIDT:	dw	op_ROR
		db	4,'SIDT'
		db	036h,04Dh,00Fh,001h
op_LLDT:	dw	op_LAR
		db	4,'LLDT'
		db	046h,055h,00Fh,000h
op_SLDT:	dw	op_SAR
		db	4,'SLDT'
		db	046h,045h,00Fh,000h
op_LMSW:	dw	op_OR
		db	4,'LMSW'
		db	046h,075h,00Fh,001h
op_SMSW:	dw	op_XOR
		db	4,'SMSW'
		db	046h,065h,00Fh,001h
op_LSL:	dw	op_STD
		db	3,'LSL'
		db	038h,085h,00Fh,003h
op_LTR:	dw	op_LMSW
		db	3,'LTR'
		db	046h,05Dh,00Fh,000h
op_STR:	dw	op_SMSW
		db	3,'STR'
		db	046h,04Dh,00Fh,000h
op_VERR:	dw	op_ARPL
		db	4,'VERR'
		db	046h,065h,00Fh,000h
op_VERW:	dw	op_SIDT
		db	4,'VERW'
		db	046h,06Dh,00Fh,000h
op_FLD:	dw	op_SLDT
		db	3,'FLD'
		db	0D2h,001h,0D9h,0C1h,0D6h,041h,0D9h,0C0h,0DCh,040h,0D9h,05Eh,068h,0DBh
op_FILD:	dw	op_VERR
		db	4,'FILD'
		db	0E2h,040h,0DBh,064h,068h,0DFh
op_FST:	dw	op_SHR
		db	3,'FST'
		db	0D2h,001h,0DDh,0D1h,0D6h,041h,0DDh,0D0h,05Ch,050h,0D9h
op_FSTP:	dw	op_LIDT
		db	4,'FSTP'
		db	0D2h,001h,0DDh,0D9h,0D6h,041h,0DDh,0D8h,0DCh,058h,0D9h,05Eh,078h,0DBh
op_FIST:	dw	op_CLTS
		db	4,'FIST'
		db	062h,050h,0DBh
op_FISTP:	dw	op_WAIT
		db	5,'FISTP'
		db	0E2h,058h,0DBh,064h,078h,0DFh
op_FADD:	dw	op_FILD
		db	4,'FADD'
		db	0D2h,001h,0DEh,0C1h,0DAh,081h,0D8h,0C0h,0D8h,081h,0DCh,0C0h,05Ch,040h,0D8h
op_FADDP:	dw	op_FST
		db	5,'FADDP'
		db	0D2h,001h,0DEh,0C1h,058h,081h,0DEh,0C0h
op_FIADD:	dw	op_FLD
		db	5,'FIADD'
		db	062h,040h,0DAh
op_FSUB:	dw	op_LLDT
		db	4,'FSUB'
		db	0D2h,001h,0DEh,0E9h,0DAh,081h,0D8h,0E0h,0D8h,081h,0DCh,0E8h,05Ch,060h,0D8h
op_FSUBP:	dw	op_FADD
		db	5,'FSUBP'
		db	0D2h,001h,0DEh,0E9h,058h,081h,0DEh,0E8h
op_FSUBR:	dw	op_STI
		db	5,'FSUBR'
		db	0D2h,001h,0DEh,0E1h,0DAh,081h,0D8h,0E8h,0D8h,081h,0DCh,0E0h,05Ch,068h,0D8h
op_FSUBRP:	dw	op_FSUB
		db	6,'FSUBRP'
		db	0D2h,001h,0DEh,0E1h,058h,081h,0DEh,0E0h
op_FISUB:	dw	op_SHL
		db	5,'FISUB'
		db	062h,060h,0DAh
op_FISUBR:	dw	op_XLAT
		db	6,'FISUBR'
		db	062h,068h,0DAh
op_FMUL:	dw	op_VERW
		db	4,'FMUL'
		db	0D2h,001h,0DEh,0C9h,0DAh,081h,0D8h,0C8h,0D8h,081h,0DCh,0C8h,05Ch,048h,0D8h
op_FMULP:	dw	op_LTR
		db	5,'FMULP'
		db	0D2h,001h,0DEh,0C9h,058h,081h,0DEh,0C8h
op_FIMUL:	dw	op_LSL
		db	5,'FIMUL'
		db	062h,048h,0DAh
op_FDIV:	dw	op_FISUBR
		db	4,'FDIV'
		db	0D2h,001h,0DEh,0F9h,0DAh,081h,0D8h,0F0h,0D8h,081h,0DCh,0F8h,05Ch,070h,0D8h
op_FDIVP:	dw	op_FISUB
		db	5,'FDIVP'
		db	0D2h,001h,0DEh,0F9h,058h,081h,0DEh,0F8h
op_FDIVR:	dw	op_STR
		db	5,'FDIVR'
		db	0D2h,001h,0DEh,0F1h,0DAh,081h,0D8h,0F8h,0D8h,081h,0DCh,0F0h,05Ch,078h,0D8h
op_FDIVRP:	dw	op_FDIV
		db	6,'FDIVRP'
		db	0D2h,001h,0DEh,0F1h,058h,081h,0DEh,0F0h
op_FIDIV:	dw	op_FSUBR
		db	5,'FIDIV'
		db	062h,070h,0DAh
op_FIDIVR:	dw	op_SGDT
		db	6,'FIDIVR'
		db	062h,078h,0DAh
op_FCOM:	dw	op_FISTP
		db	4,'FCOM'
		db	0D2h,001h,0D8h,0D1h,0D6h,041h,0D8h,0D0h,05Ch,050h,0D8h
op_FCOMP:	dw	op_FMUL
		db	5,'FCOMP'
		db	0D2h,001h,0D8h,0D9h,0D6h,041h,0D8h,0D8h,05Ch,058h,0D8h
op_FCOMPP:	dw	op_FMULP
		db	6,'FCOMPP'
		db	052h,001h,0DEh,0D9h
op_FICOM:	dw	op_FSTP
		db	5,'FICOM'
		db	062h,050h,0DAh
op_FICOMP:	dw	op_FIMUL
		db	6,'FICOMP'
		db	062h,058h,0DAh
op_F2XM1:	dw	op_FICOM
		db	5,'F2XM1'
		db	052h,001h,0D9h,0F0h
op_FABS:	dw	op_FICOMP
		db	4,'FABS'
		db	052h,001h,0D9h,0E1h
op_FBLD:	dw	op_FDIVP
		db	4,'FBLD'
		db	05Eh,060h,0DFh
op_FBSTP:	dw	op_FADDP
		db	5,'FBSTP'
		db	05Eh,070h,0DFh
op_FCHS:	dw	op_FCOMP
		db	4,'FCHS'
		db	052h,001h,0D9h,0E0h
op_FDECSTP:	dw	op_FIST
		db	7,'FDECSTP'
		db	052h,001h,0D9h,0F6h
op_FFREE:	dw	op_FIADD
		db	5,'FFREE'
		db	056h,041h,0DDh,0C0h
op_FINCSTP:	dw	op_FCHS
		db	7,'FINCSTP'
		db	052h,001h,0D9h,0F7h
op_FLD1:	dw	op_FFREE
		db	4,'FLD1'
		db	052h,001h,0D9h,0E8h
op_FLDCW:	dw	op_FSUBP
		db	5,'FLDCW'
		db	060h,068h,0D9h
op_FLDENV:	dw	op_F2XM1
		db	6,'FLDENV'
		db	066h,060h,0D9h
op_FLDL2E:	dw	op_FLD1
		db	6,'FLDL2E'
		db	052h,001h,0D9h,0EAh
op_FLDL2T:	dw	op_FDECSTP
		db	6,'FLDL2T'
		db	052h,001h,0D9h,0E9h
op_FLDLG2:	dw	op_FDIVRP
		db	6,'FLDLG2'
		db	052h,001h,0D9h,0ECh
op_FLDLN2:	dw	op_FSUBRP
		db	6,'FLDLN2'
		db	052h,005h,0D9h,0EDh
op_FLDPI:	dw	op_FBSTP
		db	5,'FLDPI'
		db	052h,001h,0D9h,0EBh
op_FLDZ:	dw	op_FLDLN2
		db	4,'FLDZ'
		db	052h,001h,0D9h,0EEh
op_FNOP:	dw	op_FCOMPP
		db	4,'FNOP'
		db	052h,001h,0D9h,0D0h
op_FPATAN:	dw	op_FBLD
		db	6,'FPATAN'
		db	052h,001h,0D9h,0F3h
op_FPREM:	dw	op_FLDLG2
		db	5,'FPREM'
		db	052h,001h,0D9h,0F8h
op_FPTAN:	dw	op_FPATAN
		db	5,'FPTAN'
		db	052h,001h,0D9h,0F2h
op_FRNDINT:	dw	op_FIDIVR
		db	7,'FRNDINT'
		db	052h,001h,0D9h,0FCh
op_FRSTOR:	dw	op_FLDPI
		db	6,'FRSTOR'
		db	068h,060h,0DDh
op_FSCALE:	dw	op_FABS
		db	6,'FSCALE'
		db	052h,001h,0D9h,0FDh
op_FSETPM:	dw	op_FLDENV
		db	6,'FSETPM'
		db	052h,005h,0DBh,0E4h
op_FSQRT:	dw	op_FLDCW
		db	5,'FSQRT'
		db	052h,001h,0D9h,0FAh
op_FTST:	dw	op_FIDIV
		db	4,'FTST'
		db	052h,001h,0D9h,0E4h
op_FWAIT:	dw	op_FDIVR
		db	5,'FWAIT'
		db	052h,000h,09Bh
op_FXAM:	dw	op_FSCALE
		db	4,'FXAM'
		db	052h,001h,0D9h,0E5h
op_FXCH:	dw	op_FPREM
		db	4,'FXCH'
		db	0D2h,001h,0D9h,0C9h,056h,041h,0D9h,0C8h
op_FXTRACT:	dw	op_FXCH
		db	7,'FXTRACT'
		db	052h,001h,0D9h,0F4h
op_FYL2X:	dw	op_FINCSTP
		db	5,'FYL2X'
		db	052h,001h,0D9h,0F1h
op_FYL2XP1:	dw	op_FNOP
		db	7,'FYL2XP1'
		db	052h,001h,0D9h,0F9h
op_FCLEX:	dw	op_FTST
		db	5,'FCLEX'
		db	052h,002h,001h,0DBh,0E2h
op_FNCLEX:	dw	op_FRSTOR
		db	6,'FNCLEX'
		db	052h,002h,000h,0DBh,0E2h
op_FDISI:	dw	op_FNCLEX
		db	5,'FDISI'
		db	052h,002h,001h,0DBh,0E1h
op_FNDISI:	dw	op_LGDT
		db	6,'FNDISI'
		db	052h,002h,000h,0DBh,0E1h
op_FENI:	dw	op_FRNDINT
		db	4,'FENI'
		db	052h,002h,001h,0DBh,0E0h
op_FNENI:	dw	op_FSQRT
		db	5,'FNENI'
		db	052h,002h,000h,0DBh,0E0h
op_FINIT:	dw	op_FXTRACT
		db	5,'FINIT'
		db	052h,002h,001h,0DBh,0E3h
op_FNINIT:	dw	op_FLDL2T
		db	6,'FNINIT'
		db	052h,002h,000h,0DBh,0E3h
op_FSAVE:	dw	op_FYL2X
		db	5,'FSAVE'
		db	068h,071h,001h,0DDh
op_FNSAVE:	dw	op_FCLEX
		db	6,'FNSAVE'
		db	068h,071h,000h,0DDh
op_FSTCW:	dw	op_FNINIT
		db	5,'FSTCW'
		db	060h,079h,001h,0D9h
op_FNSTCW:	dw	op_FYL2XP1
		db	6,'FNSTCW'
		db	060h,079h,000h,0D9h
op_FSTENV:	dw	op_FSAVE
		db	6,'FSTENV'
		db	066h,071h,001h,0D9h
op_FNSTENV:	dw	op_FNSAVE
		db	7,'FNSTENV'
		db	066h,071h,000h,0D9h
op_FSTSW:	dw	op_FSTCW
		db	5,'FSTSW'
		db	0E0h,079h,001h,0DDh,054h,046h,001h,0DFh,0E0h
op_FNSTSW:	dw	op_FNSTCW
		db	6,'FNSTSW'
		db	0E0h,079h,000h,0DDh,054h,046h,000h,0DFh,0E0h
; ---- R8AUX2 (CODE_8:1E56) ----

		public	ASM_KEYWORD_TABLE_ADDRESS

ASM_KEYWORD_TABLE_ADDRESS	proc	near
		mov	di,offset ASM_KEYWORD_HASH_TABLE
		ret
ASM_KEYWORD_TABLE_ADDRESS	endp

; ---- R8DATA2 (CODE_8:1E5A) ----

; Registers and operator keywords: a hash mask, 8 bucket heads, then the entries.
; Each entry: the next entry in its bucket (0 ends the chain), the name
; as a length byte and its characters, then the payload.
		public	ASM_KEYWORD_HASH_TABLE
ASM_KEYWORD_HASH_TABLE	label	word
		dw	000Eh			; hash mask
		dw	reg_BH
		dw	reg_CH
		dw	reg_DH
		dw	reg_AL
		dw	reg_SS
		dw	reg_ST
		dw	reg_ES
		dw	reg_AH
reg_OFFSET:	dw	0
		db	6,'OFFSET'
		db	044h
reg_SEG:	dw	0
		db	3,'SEG'
		db	045h
reg_TYPE:	dw	0
		db	4,'TYPE'
		db	046h
reg_PTR:	dw	0
		db	3,'PTR'
		db	050h
reg_NOT:	dw	reg_TYPE
		db	3,'NOT'
		db	043h
reg_OR:	dw	0
		db	2,'OR'
		db	048h
reg_XOR:	dw	reg_NOT
		db	3,'XOR'
		db	049h
reg_AND:	dw	0
		db	3,'AND'
		db	04Ah
reg_MOD:	dw	0
		db	3,'MOD'
		db	04Bh
reg_SHR:	dw	0
		db	3,'SHR'
		db	04Ch
reg_SHL:	dw	reg_SEG
		db	3,'SHL'
		db	04Dh
reg_HIGH:	dw	reg_SHL
		db	4,'HIGH'
		db	04Eh
reg_LOW:	dw	reg_OR
		db	3,'LOW'
		db	04Fh
reg_BYTE:	dw	reg_AND
		db	4,'BYTE'
		db	066h,001h,000h
reg_WORD:	dw	reg_BYTE
		db	4,'WORD'
		db	066h,002h,000h
reg_DWORD:	dw	reg_PTR
		db	5,'DWORD'
		db	066h,004h,000h
reg_QWORD:	dw	reg_WORD
		db	5,'QWORD'
		db	066h,008h,000h
reg_TBYTE:	dw	reg_DWORD
		db	5,'TBYTE'
		db	066h,00Ah,000h
reg_NEAR:	dw	reg_SHR
		db	4,'NEAR'
		db	066h,0FFh,0FFh
reg_FAR:	dw	reg_XOR
		db	3,'FAR'
		db	066h,0FEh,0FFh
reg_AX:	dw	reg_LOW
		db	2,'AX'
		db	065h,001h,000h
reg_CX:	dw	reg_OFFSET
		db	2,'CX'
		db	065h,001h,001h
reg_DX:	dw	reg_NEAR
		db	2,'DX'
		db	065h,001h,002h
reg_BX:	dw	reg_QWORD
		db	2,'BX'
		db	065h,001h,003h
reg_SP:	dw	reg_CX
		db	2,'SP'
		db	065h,001h,004h
reg_BP:	dw	reg_BX
		db	2,'BP'
		db	065h,001h,005h
reg_SI:	dw	reg_DX
		db	2,'SI'
		db	065h,001h,006h
reg_DI:	dw	reg_TBYTE
		db	2,'DI'
		db	065h,001h,007h
reg_AL:	dw	reg_DI
		db	2,'AL'
		db	065h,000h,000h
reg_CL:	dw	reg_MOD
		db	2,'CL'
		db	065h,000h,001h
reg_DL:	dw	reg_FAR
		db	2,'DL'
		db	065h,000h,002h
reg_BL:	dw	reg_HIGH
		db	2,'BL'
		db	065h,000h,003h
reg_AH:	dw	reg_AX
		db	2,'AH'
		db	065h,000h,004h
reg_CH:	dw	reg_SP
		db	2,'CH'
		db	065h,000h,005h
reg_DH:	dw	reg_SI
		db	2,'DH'
		db	065h,000h,006h
reg_BH:	dw	reg_BP
		db	2,'BH'
		db	065h,000h,007h
reg_ES:	dw	reg_DL
		db	2,'ES'
		db	065h,002h,000h
reg_CS:	dw	reg_BL
		db	2,'CS'
		db	065h,002h,001h
reg_SS:	dw	reg_CS
		db	2,'SS'
		db	065h,002h,002h
reg_DS:	dw	reg_CL
		db	2,'DS'
		db	065h,002h,003h
reg_ST:	dw	reg_DS
		db	2,'ST'
		db	065h,004h,000h

CODE8		ends
		end

