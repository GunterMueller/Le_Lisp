	.set	cval,0
	.set	plist,4
	.set	fval,8
	.set	pkgc,12
	.set	alink,16
	.set	ftype,20
	.set	ptype,21
	.set	plen,22
	.set	pname,24
	.set	val,0
	.set	car,0
	.set	cdr,4
	.set	subr0,1
	.set	subr1,2
	.set	subr2,3
	.set	subr3,4
	.set	subrn,5
	.set	subrf,6
	.set	expr,7
	.set	fexpr,8
	.set	macro,9
	.set	subrv1,10
	.set	subrv2,11
	.set	subrv3,12
	.set	subrvn,13
	.set	mk_eval,0xFFFFFFF0
	.set	mk_read,0xFFFFFFF1
	.set	mk_subrn,0xFFFFFFF2
	.set	mk_map,0xFFFFFFF3
	.text
	.globl	buildat
	.globl	csymb
	.globl	.undef
	.globl	.t
	.globl	.void
	.globl	gc
	.globl	bcode
	.globl	ecode
	.globl	reenter
	.globl	theend
	.globl	errnla
	.globl	ini_bll
ini_bll:
	movl	csymb,r0
	movl	r0,.loc
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	loc,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._loc
	.byte	0
	.word	3
	.ascii	"loc"
	movl	csymb,r0
	movl	r0,.vag
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	vag,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._vag
	.byte	0
	.word	3
	.ascii	"vag"
	movl	csymb,r0
	movl	r0,.memory
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	memory,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._memory
	.byte	0
	.word	6
	.ascii	"memory"
	movl	csymb,r0
	movl	r0,.addadr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	addadr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._addadr
	.byte	0
	.word	6
	.ascii	"addadr"
	movl	csymb,r0
	movl	r0,.subadr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	subadr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._subadr
	.byte	0
	.word	6
	.ascii	"subadr"
	movl	csymb,r0
	movl	r0,.gtadr
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	gtadr,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._gtadr
	.byte	0
	.word	5
	.ascii	"gtadr"
	movl	csymb,r0
	movl	r0,.abcode
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	abcode,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._abcode
	.byte	0
	.word	6
	.ascii	":BCODE"
	movl	csymb,r0
	movl	r0,.aecode
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	aecode,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._aecode
	.byte	0
	.word	6
	.ascii	":ECODE"
	rsb
	.data
.loc:
	.long	0
	.set	._loc,subr1
	.text
	.globl	loc
loc:
loc9:
	rsb
	.data
.vag:
	.long	0
	.set	._vag,subr1
	.text
	.globl	vag
vag:
	cmpl	r9,r1
	jgtr	vagerr
	movl	car(r1),r2
	movl	cdr(r1),r3
	rsb
vagerr:
	movl	.vag,r2
	jmp	errnla
	.data
.addadr:
	.long	0
	.set	._addadr,subr2
	.text
	.globl	addadr
addadr:
	cmpl	r6,r1
	jgtr	addadr1
	cmpl	r9,r1
	jgtr	addaer1
addadr1:
	cmpl	r6,r2
	jgtr	addadr2
	cmpl	r9,r2
	jgtr	addaer2
	movl	car(r2),r4
	movl	cdr(r2),r3
addadr2:
	addl2	r2,r1
	jmp	loc
addaer2:
	movl	r2,r1
addaer1:
	movl	.addadr,r2
	jmp	errnla
	.data
.subadr:
	.long	0
	.set	._subadr,subr2
	.text
	.globl	subadr
subadr:
	cmpl	r6,r1
	jgtr	subadr1
	cmpl	r9,r1
	jgtr	subaer1
	movl	car(r1),r4
	movl	cdr(r1),r3
subadr1:
	cmpl	r6,r2
	jgtr	subadr2
	cmpl	r9,r2
	jgtr	subaer2
	movl	car(r2),r4
	movl	cdr(r2),r3
subadr2:
	subl2	r2,r1
	jmp	loc
subaer2:
	movl	r2,r1
subaer1:
	movl	.subadr,r2
	jmp	errnla
	.data
.gtadr:
	.long	0
	.set	._gtadr,subr2
	.text
	.globl	gtadr
gtadr:
	cmpl	r6,r1
	jgtr	cmpadr1
	cmpl	r9,r1
	jgtr	cmpaer1
	movl	car(r1),r4
	movl	cdr(r1),r3
cmpadr1:
	cmpl	r6,r2
	jgtr	cmpadr2
	cmpl	r9,r2
	jgtr	cmpaer2
	movl	car(r2),r4
	movl	cdr(r2),r3
cmpadr2:
	cmpl	r1,r2
	jgtr	cmpadr8
	movl	r7,r1
	rsb
cmpadr8:
	movl	.t,r1
	rsb
cmpaer2:
	movl	r2,r1
cmpaer1:
	movl	.gtadr,r2
	jmp	errnla
	.data
.memory:
	.long	0
	.set	._memory,subrv2
	.text
	.globl	memory
memory:
	cmpl	r9,r1
	jgtr	memorer
	movl	car(r1),r3
	movl	cdr(r1),r4
	rsb
memorer:
	movl	.memory,r2
	jmp	errnla
	.data
.abcode:
	.long	0
	.set	._abcode,subr0
	.text
	.globl	abcode
abcode:
	movl	bcode,r1
	jmp	loc
	.data
.aecode:
	.long	0
	.set	._aecode,subr0
	.text
	.globl	aecode
aecode:
	movl	ecode,r1
	jmp	loc
	.data
zonarg:
	.space	10*4
	.globl	.eimpur
	.space	256
.eimpur:
