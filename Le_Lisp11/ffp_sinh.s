	entry   _sinh,_cosh,_tanh
	extern  ffpsinh,ffpcosh,ffptanh
*
EDOM    equ     33
ERANGE  equ     34
*
enter   macro
	link a6,#^1
	movem.l ^2,-(a7)
	endm
*
return  macro
	movem.l (a7)+,^1
	unlk a6
	rts
	endm
*
_sinh   enter   0,d7
	move.l  8(a6),d7
	jsr     ffpsinh
	move.l  d7,d0
	return  d7
_cosh   enter   0,d7
	move.l  8(a6),d7
	jsr     ffpcosh
	move.l  d7,d0
	return  d7
_tanh   enter   0,d7
	move.l  8(a6),d7
	jsr     ffptanh
	move.l  d7,d0
	return  d7
	end
