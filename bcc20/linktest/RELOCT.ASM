CODE	segment byte public 'CODE'
	assume cs:CODE
	public	foo
foo	label far
	dw	foo
	dw	seg foo
	dw	CODE
CODE	ends
	end
