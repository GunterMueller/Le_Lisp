	entry   _atof
	extern  ffpafp
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
_atof   enter   0,a0/d3-d7
	move.l  8(a6),a0
atf1    move.b  (a0)+,d0
	cmpi.b  #$20,d0        blank?
	beq     atf1
	cmpi.b  #$09,d0        tab?
	beq     atf1
	subq.l  #1,a0          backspace
	jsr     ffpafp
	move.l  d7,d0
	return  a0/d3-d7
	end
