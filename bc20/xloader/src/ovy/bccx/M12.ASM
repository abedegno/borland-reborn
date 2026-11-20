	.286p
	locals
	extrn	L0DCEB:far

Y0D920	segment para public 'CODE'
	assume	cs:Y0D920
	db	10h dup (0)	;@0D920
LOWER_SWITCHES:	int	3Fh	;@0D930
	and	ax, 1	;@0D932
BACKEND_NOOP_HOOK:	int	3Fh	;@0D935
	and	byte ptr [bx+di], al	;@0D937
	db	0, 0CDh	; add ch, cl	;@0D939
	aas	;@0D93B
	add	byte ptr [bx+si], al	;@0D93C
	add	byte ptr [bx+si], al	;@0D93E
	int	3Fh	;@0D940
	add	byte ptr [bx+si], al	;@0D942
	loopne	@@1	;@0D944
	add	ax, 0EE00h	;@0D946
@@1:	or	bp, word ptr [si+200h]	;@0D949
	add	byte ptr [bx+si], al	;@0D94D
	add	byte ptr [bx+si], al	;@0D94F
	add	byte ptr [bx+si], al	;@0D951
	add	byte ptr [bx+si], al	;@0D953
	add	byte ptr [bx+si], al	;@0D955
	add	byte ptr [bx+si], al	;@0D957
	add	byte ptr [bx+si], al	;@0D959
	add	byte ptr [bx+si], al	;@0D95B
	add	byte ptr [bx+si], al	;@0D95D
	db	0	; add ch, cl	;@0D95F
Y0D920	ends

Y0D960	segment para public 'CODE'
	assume	cs:Y0D960
EMIT_SWITCH_TABLES:	int	3Fh	;@0D960
	ror	word ptr [bp+di], 0	;@0D962
LOWER_SWITCH:	int	3Fh	;@0D965
	sbb	ax, 0	;@0D967
	add	byte ptr [bx+si], al	;@0D96A
	add	byte ptr [bx+si], al	;@0D96C
	add	byte ptr [bx+si], al	;@0D96E
	int	3Fh	;@0D970
	add	byte ptr [bx+si], al	;@0D972
	adc	byte ptr [bx+si], 5	;@0D974
	db	0, 0EBh	; add bl, ch	;@0D977
	or	al, 8Ah	;@0D979
	add	byte ptr [bx], cl	;@0D97B
	add	byte ptr [bx+si], al	;@0D97D
	add	byte ptr [bx+si], al	;@0D97F
	add	byte ptr [bx+si], al	;@0D981
	add	byte ptr [bx+si], al	;@0D983
	add	byte ptr [bx+si], al	;@0D985
	add	byte ptr [bx+si], al	;@0D987
	add	byte ptr [bx+si], al	;@0D989
	add	byte ptr [bx+si], al	;@0D98B
	add	byte ptr [bx+si], al	;@0D98D
	db	0, 0CDh	; add ch, cl	;@0D98F
	aas	;@0D991
	xlat	;@0D992
	add	byte ptr [bx+si], al	;@0D993
BEGIN_CODE_STREAM:	int	3Fh	;@0D995
	add	byte ptr [bx+si], al	;@0D997
	db	0, 0CDh	; add ch, cl	;@0D999
	aas	;@0D99B
	iret	;@0D99C
	db	1, 0	;@0D99D
ADD_FIXUP:	int	3Fh	;@0D99F
	and	ax, 1	;@0D9A1
INSERT_NODE_MARK_FRAGMENT:	int	3Fh	;@0D9A4
	mov	word ptr [bx+di], es	;@0D9A6
	db	0, 0CDh	; add ch, cl	;@0D9A8
	aas	;@0D9AA
	imul	ax, word ptr [bx+di], 0	;@0D9AB
EMIT_ASM_STATEMENT:	int	3Fh	;@0D9AE
	xor	ax, 9	;@0D9B0
PUT_CODE_CHAR:	int	3Fh	;@0D9B3
	ror	byte ptr [bx+si], cl	;@0D9B5
	db	0, 0CDh	; add ch, cl	;@0D9B7
	aas	;@0D9B9
	rol	byte ptr [bx+di], 0	;@0D9BA
DEFINE_LABEL:	int	3Fh	;@0D9BD
	insb	;@0D9BF
Y0D960	ends

Y0D9C0	segment para public 'CODE'
	assume	cs:Y0D9C0
	db	2, 0	;@0D9C0
PUT_CODE_STRING:	int	3Fh	;@0D9C2
	dec	sp	;@0D9C4
	or	al, 0	;@0D9C5
SHRINK_JUMPS_AND_EMIT:	int	3Fh	;@0D9C7
	xchg	word ptr [bx], ax	;@0D9C9
	db	0, 0CDh	; add ch, cl	;@0D9CB
	aas	;@0D9CD
	xchg	ax, bp	;@0D9CE
	add	byte ptr [bx+si], al	;@0D9CF
NEW_CODE_FRAGMENT:	int	3Fh	;@0D9D1
	add	byte ptr ss:[bx+si], al	;@0D9D3
PUT_FAR_STRING:	int	3Fh	;@0D9D6
	xchg	ax, sp	;@0D9D8
	or	al, 0	;@0D9D9
	add	byte ptr [bx+si], al	;@0D9DB
	add	byte ptr [bx+si], al	;@0D9DD
	db	0, 0CDh	; add ch, cl	;@0D9DF
	aas	;@0D9E1
	add	byte ptr [bx+si], al	;@0D9E2
	adc	byte ptr ds:[5], bl	;@0D9E4
	mov	cl, 2	;@0D9E8
	add	byte ptr [bx+si], al	;@0D9EA
	add	word ptr [bx+si], ax	;@0D9EC
	add	byte ptr [bx+si], al	;@0D9EE
Y0D9C0	ends

Y0D9F0	segment para public 'CODE'
	assume	cs:Y0D9F0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0D9F0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D9F0	ends

Y0DA10	segment para public 'CODE'
	assume	cs:Y0DA10
	db	0CDh, 3Fh, 0, 0, 0D0h, 20h, 5, 0, 6Dh, 10h, 0, 0, 0Dh, 0, 0, 0	;@0DA10
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
BYTE_REGISTERS_MASK:	int	3Fh	;@0DA30
	scasw	;@0DA32
	add	al, byte ptr [bx+si]	;@0DA33
IS_MARKED_MEM_OPERAND:	int	3Fh	;@0DA35
	stc	;@0DA37
	add	al, byte ptr [bx+si]	;@0DA38
SIMPLIFY_ZERO_CONST_INSNS:	int	3Fh	;@0DA3A
	add	byte ptr [bx+si], al	;@0DA3C
	db	0, 0CDh	; add ch, cl	;@0DA3E
Y0DA10	ends

Y0DA40	segment para public 'CODE'
	assume	cs:Y0DA40
	db	3Fh, 3Eh, 2, 0	;@0DA40
RESTORE_RESERVED_REGISTERS:	int	3Fh	;@0DA44
	push	bx	;@0DA46
	add	al, byte ptr [bx+si]	;@0DA47
BLOCK_FREE_REGISTERS:	int	3Fh	;@0DA49
	mov	al, byte ptr [bp+si]	;@0DA4B
	db	0, 0CDh	; add ch, cl	;@0DA4D
	aas	;@0DA4F
	mov	si, 3	;@0DA50
REGISTER_HINT_CODE:	int	3Fh	;@0DA53
	mov	bh, 2	;@0DA55
	db	0, 0CDh	; add ch, cl	;@0DA57
	aas	;@0DA59
	sbb	byte ptr [si], al	;@0DA5A
	db	0, 0CDh	; add ch, cl	;@0DA5C
	aas	;@0DA5E
	db	67h, 2, 0	; add al, byte ptr [eax]	;@0DA5F
OP3_REGISTER_HINT:	int	3Fh	;@0DA62
	rol	word ptr [bp+si], cl	;@0DA64
	db	0, 0CDh	; add ch, cl	;@0DA66
	aas	;@0DA68
	xor	byte ptr [bp+di], al	;@0DA69
	db	0, 0CDh	; add ch, cl	;@0DA6B
	aas	;@0DA6D
	cmpsw	;@0DA6E
	db	2	; add al, byte ptr [bx+si]	;@0DA6F
Y0DA40	ends

Y0DA70	segment para public 'CODE'
	assume	cs:Y0DA70
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0DA70
	db	50h, 31h, 5, 0, 34h, 5, 0Ah, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0
ASSIGN_REGISTER_VARIABLES:	int	3Fh	;@0DAA0
	add	byte ptr [bx+si], al	;@0DAA2
	db	0, 0CDh	; add ch, cl	;@0DAA4
	aas	;@0DAA6
	cli	;@0DAA7
	add	al, 0	;@0DAA8
FIND_OR_ADD_VARIABLE:	int	3Fh	;@0DAAA
	aad	3	;@0DAAC
	add	byte ptr [bx+si], al	;@0DAAE
	int	3Fh	;@0DAB0
	add	byte ptr [bx+si], al	;@0DAB2
	nop	;@0DAB4
	db	36h, 5, 0, 29h	; add ax, 2900h	;@0DAB5
	db	16h	; push ss	;@0DAB9
	xor	al, 0	;@0DABA
	add	al, 0	;@0DABC
	add	byte ptr [bx+si], al	;@0DABE
	add	byte ptr [bx+si], al	;@0DAC0
	add	byte ptr [bx+si], al	;@0DAC2
	add	byte ptr [bx+si], al	;@0DAC4
	add	byte ptr [bx+si], al	;@0DAC6
	add	byte ptr [bx+si], al	;@0DAC8
	add	byte ptr [bx+si], al	;@0DACA
	add	byte ptr [bx+si], al	;@0DACC
	add	byte ptr [bx+si], al	;@0DACE
	int	3Fh	;@0DAD0
	nop	;@0DAD2
	or	ax, 0CD00h	;@0DAD3
	aas	;@0DAD6
	sub	byte ptr [bx+di], cl	;@0DAD7
	db	0, 0CDh	; add ch, cl	;@0DAD9
	aas	;@0DADB
	xchg	ax, si	;@0DADC
	adc	ax, 0CD00h	;@0DADD
Y0DA70	ends

Y0DAE0	segment para public 'CODE'
	assume	cs:Y0DAE0
	db	3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0	;@0DAE0
	db	0, 0F0h, 4Ch, 5, 0, 0Ah, 0Ah, 6Ch, 0, 14h, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0DAE0	ends

Y0DB10	segment para public 'CODE'
	assume	cs:Y0DB10
EMIT_SAVED_REG_PUSHES:	int	3Fh	;@0DB10
	nop	;@0DB12
	or	word ptr [bx+si], ax	;@0DB13
RELEASE_POOLED_NODE:	int	3Fh	;@0DB15
	jo	RESOLVE_STACK_BALANCE	;@0DB17
	db	0, 0CDh	; add ch, cl	;@0DB19
	aas	;@0DB1B
	inc	sp	;@0DB1C
	or	byte ptr [bx+si], al	;@0DB1D
RESOLVE_STACK_BALANCE:	int	3Fh	;@0DB1F
	out	4, ax	;@0DB21
	db	0, 0CDh	; add ch, cl	;@0DB23
	aas	;@0DB25
	hlt	;@0DB26
	push	es	;@0DB27
	db	0, 0CDh	; add ch, cl	;@0DB28
	aas	;@0DB2A
	mov	dl, 9	;@0DB2B
	db	0, 0CDh	; add ch, cl	;@0DB2D
	aas	;@0DB2F
	jge	@@1	;@0DB30
	db	0, 0CDh	; add ch, cl	;@0DB32
	aas	;@0DB34
	aad	8	;@0DB35
	db	0, 0CDh	; add ch, cl	;@0DB37
	aas	;@0DB39
	pop	sp	;@0DB3A
@@1:	add	al, byte ptr [bx+si]	;@0DB3B
PUSH_FLOAT_ARGUMENT:	int	3Fh	;@0DB3D
	rol	byte ptr [bx+di], cl	;@0DB3F
	db	0, 0CDh	; add ch, cl	;@0DB41
	aas	;@0DB43
	cwd	;@0DB44
	add	word ptr [bx+si], ax	;@0DB45
EMIT_FPU_OP_ON_OPERAND:	int	3Fh	;@0DB47
	sti	;@0DB49
	or	byte ptr [bx+si], al	;@0DB4A
SWAP_OPERAND_OPCODE:	int	3Fh	;@0DB4C
	cmp	byte ptr [bx+si], al	;@0DB4E
	db	0, 0CDh	; add ch, cl	;@0DB50
	aas	;@0DB52
	sbb	al, 6	;@0DB53
	db	0, 0CDh	; add ch, cl	;@0DB55
	aas	;@0DB57
	dec	dx	;@0DB58
	add	ax, word ptr [bx+si]	;@0DB59
GEN_FPU_BINARY_OP:	int	3Fh	;@0DB5B
	jl	@@1	;@0DB5D
@@1:	db	0, 0CDh	; add ch, cl	;@0DB5F
	aas	;@0DB61
	arpl	word ptr [bx], ax	;@0DB62
	db	0, 0CDh	; add ch, cl	;@0DB64
	aas	;@0DB66
	xor	ax, word ptr ds:[0CD00h]	;@0DB67
	aas	;@0DB6B
	aam	0	;@0DB6C
	db	0, 0CDh	; add ch, cl	;@0DB6E
	aas	;@0DB70
	pop	word ptr ds:[0]	;@0DB71
	add	byte ptr [bx+si], al	;@0DB75
	add	byte ptr [bx+si], al	;@0DB77
	add	byte ptr [bx+si], al	;@0DB79
	add	byte ptr [bx+si], al	;@0DB7B
	add	byte ptr [bx+si], al	;@0DB7D
	db	0	; add ch, cl	;@0DB7F
Y0DB10	ends

Y0DB80	segment para public 'CODE'
	assume	cs:Y0DB80
	db	0CDh, 3Fh, 0, 0, 70h, 57h, 5, 0, 0B5h, 11h, 10h, 1, 6, 0, 0, 0	;@0DB80
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
EMIT_PROLOGUE:	int	3Fh	;@0DBA0
	out	5, ax	;@0DBA2
	db	0, 0CDh	; add ch, cl	;@0DBA4
	aas	;@0DBA6
	push	ss	;@0DBA7
	or	al, byte ptr [bx+si]	;@0DBA8
ASSIGN_PARAM_OFFSETS:	int	3Fh	;@0DBAA
	db	0Fh, 0Fh, 0	;@0DBAC
ASSIGN_LOCAL_OFFSETS:	db	0CDh	; int 3Fh	;@0DBAF
Y0DB80	ends

Y0DBB0	segment para public 'CODE'
	assume	cs:Y0DBB0
	db	3Fh, 63h, 0Dh, 0	;@0DBB0
CLEAR_VARIABLE_TABLE:	int	3Fh	;@0DBB4
	dec	bp	;@0DBB6
	or	ax, 0CD00h	;@0DBB7
	aas	;@0DBBA
	mov	byte ptr ds:[0Eh], al	;@0DBBB
	add	byte ptr [bx+si], al	;@0DBBE
	int	3Fh	;@0DBC0
	add	byte ptr [bx+si], al	;@0DBC2
	inc	ax	;@0DBC4
	push	5	;@0DBC5
	add	byte ptr [bx+di+1], bh	;@0DBC7
	push	es	;@0DBCA
	add	byte ptr [si], al	;@0DBCB
	add	byte ptr [bx+si], al	;@0DBCD
	add	byte ptr [bx+si], al	;@0DBCF
	add	byte ptr [bx+si], al	;@0DBD1
	add	byte ptr [bx+si], al	;@0DBD3
	add	byte ptr [bx+si], al	;@0DBD5
	add	byte ptr [bx+si], al	;@0DBD7
	add	byte ptr [bx+si], al	;@0DBD9
	add	byte ptr [bx+si], al	;@0DBDB
	add	byte ptr [bx+si], al	;@0DBDD
	db	0, 0CDh	; add ch, cl	;@0DBDF
	aas	;@0DBE1
	dec	bx	;@0DBE2
	add	word ptr [bx+si], ax	;@0DBE3
CLONE_NODE_KEEP_SERIAL:	int	3Fh	;@0DBE5
	push	di	;@0DBE7
	add	byte ptr [bx+si], al	;@0DBE8
CLONE_NODE_NEW_SERIAL:	int	3Fh	;@0DBEA
	lds	ax, dword ptr [bx+si]	;@0DBEC
	db	0, 0CDh	; add ch, cl	;@0DBEE
Y0DBB0	ends

Y0DBF0	segment para public 'CODE'
	assume	cs:Y0DBF0
	db	3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0	;@0DBF0
	db	0, 0D0h, 6Bh, 5, 0, 0F3h, 9, 10h, 0, 0Dh, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
EMIT_INSN_STACK_REG:	int	3Fh	;@0DC20
	sbb	word ptr [bx+si], ax	;@0DC22
	db	0, 0CDh	; add ch, cl	;@0DC24
	aas	;@0DC26
	add	byte ptr [bx+si], al	;@0DC27
	db	0, 0CDh	; add ch, cl	;@0DC29
	aas	;@0DC2B
	db	0C2h, 0, 0	; ret 0	;@0DC2C
EMIT_INSN_REG:	db	0CDh, 3Fh	; int 3Fh	;@0DC2F
	mov	word ptr ds:[0], ax	;@0DC31
EMIT_INSN_LOCAL:	int	3Fh	;@0DC34
	cli	;@0DC36
	add	word ptr [bx+si], ax	;@0DC37
EMIT_INSN_REG_STACK:	int	3Fh	;@0DC39
	pop	si	;@0DC3B
	add	byte ptr [bx+si], al	;@0DC3C
EMIT_INSN_NODE_IMM:	int	3Fh	;@0DC3E
	xlat	;@0DC40
	add	word ptr [bx+si], ax	;@0DC41
EMIT_INSN_NODE_NODE:	int	3Fh	;@0DC43
	mov	dh, 1	;@0DC45
	db	0, 0CDh	; add ch, cl	;@0DC47
	aas	;@0DC49
	xchg	ax, bx	;@0DC4A
	add	word ptr [bx+si], ax	;@0DC4B
EMIT_INSN_REG_IMM:	int	3Fh	;@0DC4D
	outsb	;@0DC4F
	add	word ptr [bx+si], ax	;@0DC50
EMIT_INSN_REG_NODE:	int	3Fh	;@0DC52
	xor	al, byte ptr [bx+di]	;@0DC54
	db	0, 0CDh	; add ch, cl	;@0DC56
	aas	;@0DC58
	fild	word ptr [bx+si]	;@0DC59
	db	0, 0CDh	; add ch, cl	;@0DC5B
	aas	;@0DC5D
	jcxz	@@1+1	;@0DC5E
	add	byte ptr [bx+si], al	;@0DC60
	add	byte ptr [bx+si], al	;@0DC62
	add	byte ptr [bx+si], al	;@0DC64
	add	byte ptr [bx+si], al	;@0DC66
@@1:	add	byte ptr [bx+si], al	;@0DC68
	add	byte ptr [bx+si], al	;@0DC6A
	add	byte ptr [bx+si], al	;@0DC6C
	add	byte ptr [bx+si], al	;@0DC6E
	int	3Fh	;@0DC70
	add	byte ptr [bx+si], al	;@0DC72
	db	0E0h, 75h	; loopne L0DCEB	;@0DC74
	add	ax, 900h	;@0DC76
	adc	ch, byte ptr [bp+si+100h]	;@0DC79
	add	byte ptr [bx+si], al	;@0DC7D
	db	0	; add byte ptr [bx+si], al	;@0DC7F
Y0DBF0	ends
	end
