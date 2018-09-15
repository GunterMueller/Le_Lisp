	entry   _sin,_cos,_tan
	extern  ffpsin,ffpcos,ffptan
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
_sin    enter   0,d7
	move.l  8(a6),d7
	jsr     ffpsin
	move.l  d7,d0
	return  d7
_cos    enter   0,d7
	move.l  8(a6),d7
	jsr     ffpcos
	move.l  d7,d0
	return  d7
_tan    enter   0,d7
	move.l  8(a6),d7
	jsr     ffptan
	move.l  d7,d0
	return  d7
	end
