	entry   _atan,_arctan
	extern  ffpatan
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
_arctan equ     *
_atan   enter   0,d7
	move.l  8(a6),d7
	jsr     ffpatan
	move.l  d7,d0
	return  d7
	end
