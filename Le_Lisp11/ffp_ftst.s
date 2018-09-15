	entry   ftst
	extern  ffptst
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
ftst    enter   0,d7
	move.l  8(a6),d7
	jsr     ffptst
	return  d7
	end
