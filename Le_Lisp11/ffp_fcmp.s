	entry   fcmp
	extern  ffpcmp
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
fcmp    enter   0,d6-d7
	move.l  8(a6),d7
	move.l  12(a6),d6
	jsr     ffpcmp
	return  d6-d7
	end
