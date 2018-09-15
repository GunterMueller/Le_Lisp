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
	.globl	buildat
	.globl	csymb
	.globl	.undef
	.globl	.t
	.globl	.void
	.globl	.quote
	.globl	gc
	.globl	mstack
	.globl	errfs
	.globl	errnaa
	.globl	errnna
	.globl	errnla
	.globl	errnva
	.globl	errnca
	.globl	erroob
	.globl	getpnam
	.globl	ostream
	.globl	eval
	.globl	evalcar
	.globl	apply
	.globl	itsoft
	.globl	list
	.globl	ini_print
	.globl	probj
	.globl	probjt
	.globl	fullin
	.globl	pratom
	.globl	outch
	.globl	outsp
	.globl	nbleft
	.globl	obase
	.data
	.set	maxbufout,256
bufout:
	.space	maxbufout
bufpn:
	.space	maxbufout
obase:
	.long	0
prmdp:
	.long	0
prcdp:
	.long	0
prmlp:
	.long	0
prclp:
	.long	0
prmln:
	.long	0
prcln:
	.long	0
sprint:
	.long	0
pocour:
	.long	0
nbleft:
	.long	0
nbrig:
	.long	0
iexpld:
	.long	0
lexpld:
	.long	0
	.text
ini_print:
	movl	r7,iexpld
	movl	$10,obase
	movl	$0100,prmdp
	movl	$2000,prmlp
	movl	$2000,prmln
	movl	$0,pocour
	movl	$0,nbleft
	movl	$78,nbrig
	movl	$maxbufout,r1
	jmp	prii2
prii1:
	movl	r1,r0
	movb	$0x20,*$bufout[r0]
prii2:
	sobgeq	r1,prii1
	movl	csymb,r0
	movl	r0,.eol
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	eol,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._eol
	.byte	0
	.word	3
	.ascii	"eol"
	movl	csymb,r0
	movl	r0,.fflush
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	fflush,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._fflush
	.byte	0
	.word	5
	.ascii	"flush"
	movl	csymb,r0
	movl	r0,.prin
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	prin,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._prin
	.byte	0
	.word	4
	.ascii	"prin"
	movl	csymb,r0
	movl	r0,.print
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	print,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._print
	.byte	0
	.word	5
	.ascii	"print"
	movl	csymb,r0
	movl	r0,.prinflush
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	prinflush,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._prinflush
	.byte	0
	.word	9
	.ascii	"prinflush"
	movl	csymb,r0
	movl	r0,.terpri
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	terpri,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._terpri
	.byte	0
	.word	6
	.ascii	"terpri"
	movl	csymb,r0
	movl	r0,.prinlp
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	prinlp,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._prinlp
	.byte	0
	.word	6
	.ascii	"prinlp"
	movl	csymb,r0
	movl	r0,.princh
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	princh,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._princh
	.byte	0
	.word	6
	.ascii	"princh"
	movl	csymb,r0
	movl	r0,.princod
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	princod,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._princod
	.byte	0
	.word	6
	.ascii	"princn"
	movl	csymb,r0
	movl	r0,.spaces
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	spaces,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._spaces
	.byte	0
	.word	6
	.ascii	"spaces"
	movl	csymb,r0
	movl	r0,.plength
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	plength,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._plength
	.byte	0
	.word	7
	.ascii	"plength"
	movl	csymb,r0
	movl	r0,.fptype
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	fptype,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._fptype
	.byte	0
	.word	5
	.ascii	"ptype"
	movl	csymb,r0
	movl	r0,.prline
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	prline,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._prline
	.byte	0
	.word	9
	.ascii	"printline"
	movl	csymb,r0
	movl	r0,.prlevel
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	prlevel,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._prlevel
	.byte	0
	.word	10
	.ascii	"printlevel"
	movl	csymb,r0
	movl	r0,.prlength
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	prlength,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._prlength
	.byte	0
	.word	11
	.ascii	"printlength"
	movl	csymb,r0
	movl	r0,.fobase
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	fobase,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._fobase
	.byte	0
	.word	5
	.ascii	"obase"
	movl	csymb,r0
	movl	r0,.lmargin
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	lmargin,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._lmargin
	.byte	0
	.word	7
	.ascii	"lmargin"
	movl	csymb,r0
	movl	r0,.rmargin
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	rmargin,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._rmargin
	.byte	0
	.word	7
	.ascii	"rmargin"
	movl	csymb,r0
	movl	r0,.outpos
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	outpos,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._outpos
	.byte	0
	.word	6
	.ascii	"outpos"
	movl	csymb,r0
	movl	r0,.outbuf
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	outbuf,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._outbuf
	.byte	0
	.word	6
	.ascii	"outbuf"
	movl	csymb,r0
	movl	r0,.explode
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	explode,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._explode
	.byte	0
	.word	7
	.ascii	"explode"
	.data
.statpr:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.statpr
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	12
	.ascii	"status-print"
	.data
.statpc:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.statpc
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	17
	.ascii	"status-print-case"
	movl	.statpr,r1
	movl	r7,cval(r1)
	movl	.statpc,r1
	movl	r7,cval(r1)
false:
	movl	r7,r1
popj:
	rsb
true:
	movl	.t,r1
	rsb
	.globl	u_print
u_print:
	jsb	probj
	jsb	fullin
	rsb
fullin:
	pushl	r1
	pushl	r2
	pushl	r3
	pushl	r4
	movl	.eol,r1
	movl	r7,r2
	jsb	itsoft
	movl	(r14)+,r4
	movl	(r14)+,r3
	movl	(r14)+,r2
	movl	(r14)+,r1
	rsb
	.data
.eol:
	.long	0
	.set	._eol,subr0
	.text
	.globl	eol
eol:
	jsb	outlin
	movl	r7,r1
	rsb
	.data
.fflush:
	.long	0
	.set	._fflush,subr0
	.text
	.globl	fflush
fflush:
	cmpl	pocour,$0
	jeql	true
	clrl	r2
	movl	pocour,r2
	jmp	fflush2
fflush1:
	movl	r2,r0
	movb	$0x20,*$bufout[r0]
fflush2:
	sobgeq	r2,fflush1
	movl	nbleft,pocour
	jmp	true
outlin:
	cmpl	r7,iexpld
	jneq	expls
	movl	pocour,r1
	cmpl	r7,ostream
	jneq	outli1
	movl	r1,r0
	movb	$13,*$bufout[r0]
	incl	r1
	movl	r1,r0
	movb	$10,*$bufout[r0]
	incl	r1
	movl	r1,pocour
	movl	r1,r10
	moval	bufout,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r2
	jmp	outli2
outli1:
	clrl	r2
outli2:
	movl	pocour,r2
	jmp	outli4
outli3:
	movl	r2,r0
	movb	$0x20,*$bufout[r0]
outli4:
	sobgeq	r2,outli3
	movl	nbleft,pocour
	incl	prclp
	movl	prclp,r2
	cmpl	prmlp,r2
	jneq	outlret
	movl	sprint,r14
	jmp	probje
outlret:
	rsb
outch:
	cmpl	r7,iexpld
	jneq	explch
	pushl	r1
	movl	pocour,r1
	cmpl	r1,nbrig
	jlss	outch1
	jsb	fullin
outch1:
	movl	r1,r0
	movb	r4,*$bufout[r0]
	incl	pocour
	movl	(r14)+,r1
	rsb
outsp:
	cmpl	r7,iexpld
	jneq	expls
	pushl	r1
	movl	pocour,r1
	cmpl	r1,nbrig
	jgeq	outsp1
	movl	r1,r0
	movb	$0x20,*$bufout[r0]
	incl	pocour
	movl	(r14)+,r1
	rsb
outsp1:
	jsb	fullin
	movl	(r14)+,r1
	rsb
pratom:
	cmpl	r6,r1
	jgtr	prat0
	cmpl	r6,r1
	jgtr	.1
	cmpl	r7,r1
	jgtr	prstrg
.1:
	bitb	$0x80,ptype(r1)
	jneq	prspec
prat0:
	moval	bufpn,r0
	clrl	r10
	jsb	getpnam
	movl	r11,r3
	pushl	r3
	addl2	pocour,r3
	cmpl	r3,nbrig
	jleq	prat1
	jsb	fullin
prat1:
	movl	(r14)+,r3
	movl	$0,r2
	pushl	r1
	movl	.statpc,r1
	movl	cval(r1),r1
	jmp	prat4
prat2:
	movzbl	*$bufpn[r2],r4
	cmpl	r7,r1
	jeql	prat3
	cmpl	r4,$0x41
	jlss	.2
	cmpl	r4,$0x5a
	jgtr	.2
	addl2	$0x20,r4
.2:
prat3:
	jsb	outch
	incl	r2
prat4:
	sobgeq	r3,prat2
	movl	(r14)+,r1
	rsb
prstrg:
	pushl	r1
	movl	(r1),r1
	movl	.statpr,r2
	movl	cval(r2),r2
	cmpl	r7,r2
	jneq	prstr0
	jsb	prat0
	movl	(r14)+,r1
	rsb
prstr0:
	moval	bufpn,r0
	clrl	r10
	jsb	getpnam
	movl	r11,r3
	pushl	r3
	addl2	pocour,r3
	addl2	$2,r3
	cmpl	r3,nbrig
	jleq	prstr1
	jsb	fullin
prstr1:
	movl	(r14)+,r3
	movl	$34,r4
	jsb	outch
	movl	$0,r2
	jmp	prstr4
prstr3:
	movzbl	*$bufpn[r2],r4
	jsb	outch
	incl	r2
prstr4:
	sobgeq	r3,prstr3
	movl	$34,r4
	jsb	outch
	movl	(r14)+,r1
	rsb
prspec:
	movl	.statpr,r2
	movl	cval(r2),r2
	cmpl	r7,r2
	jeql	prat0
	moval	bufpn,r0
	clrl	r10
	jsb	getpnam
	movl	r11,r3
	pushl	r3
	addl2	pocour,r3
	addl2	$2,r3
	cmpl	r3,nbrig
	jleq	prspc1
	jsb	fullin
prspc1:
	movl	(r14)+,r3
	movl	$124,r4
	jsb	outch
	movl	$0,r2
	jmp	prspc4
prspc3:
	movzbl	*$bufpn[r2],r4
	jsb	outch
	incl	r2
prspc4:
	sobgeq	r3,prspc3
	movl	$124,r4
	jmp	outch
probj:
	pushl	r1
	movl	r14,sprint
	movl	$0,prclp
	movl	$0,prcln
	movl	$0,prcdp
	jsb	probj0
probje:
	movl	(r14)+,r1
	rsb
probj0:
	cmpl	r9,r1
	jgtr	pratom
	incl	prcdp
	movl	prcdp,r2
	cmpl	r2,prmdp
	jleq	probj2
	movl	$0x26,r4
	jmp	outch
probj2:
	movl	car(r1),r2
	cmpl	.quote,r2
	jneq	probj5
	movl	cdr(r1),r2
	movl	cdr(r2),r3
	movl	$0x27,r4
	jsb	outch
	movl	car(r2),r1
	jmp	probj0
probj5:
	movl	$0x28,r4
	jsb	outch
	jmp	probj7
probj6:
	jsb	outsp
probj7:
	incl	prcln
	movl	prcln,r2
	cmpl	r2,prmln
	jleq	probj8
	pushal	probj9
	jsb	probjd
	nop
probjd:
	movl	$0x2e,r4
	jmp	outch
probj8:
	cmpl	r14,mstack
	jleq	errfs
	pushl	cdr(r1)
	movl	car(r1),r1
	jsb	probj0
	movl	(r14)+,r1
	cmpl	r9,r1
	jleq	probj6
	cmpl	r7,r1
	jeql	probj9
	jsb	outsp
	jsb	probjd
	jsb	outsp
	jsb	pratom
probj9:
	movl	$0x29,r4
	jsb	outch
	decl	prcdp
	rsb
probjt:
	pushal	fullin
	jmp	probj
	.data
.prin:
	.long	0
	.set	._prin,subrvn
	.text
	.globl	prin
prin:
	cmpl	$0,r4
	jeql	false
	cmpl	$1,r4
	jneq	prin10
	movl	(r14)+,r1
	jmp	probj
prin10:
	pushl	r4
	decl	r4
prin11:
	movl	r4,r0
	incl	r0
	movl	(r14)[r0],r1
	pushl	r4
	jsb	probj
	movl	(r14)+,r4
	sobgeq	r4,prin11
	ashl	$2,(r14)+,r0
	addl2	r0,r14
	rsb
	.data
.print:
	.long	0
	.set	._print,subrvn
	.text
	.globl	print
print:
	cmpl	$0,r4
	jneq	print10
	jsb	fullin
	jmp	false
print10:
	pushl	r4
	decl	r4
print11:
	movl	r4,r0
	incl	r0
	movl	(r14)[r0],r1
	pushl	r4
	jsb	probj
	movl	(r14)+,r4
	sobgeq	r4,print11
	pushl	r1
	jsb	fullin
	movl	(r14)+,r1
	ashl	$2,(r14)+,r0
	addl2	r0,r14
	rsb
	.data
.prinflush:
	.long	0
	.set	._prinflush,subrvn
	.text
	.globl	prinflush
prinflush:
	cmpl	$0,r4
	jneq	prinf10
	jsb	fflush
	jmp	false
prinf10:
	pushl	r4
	decl	r4
prinf11:
	movl	r4,r0
	incl	r0
	movl	(r14)[r0],r1
	pushl	r4
	jsb	probj
	movl	(r14)+,r4
	sobgeq	r4,prinf11
	pushl	r1
	jsb	fflush
	movl	(r14)+,r1
	ashl	$2,(r14)+,r0
	addl2	r0,r14
	rsb
	.data
.prinlp:
	.long	0
	.set	._prinlp,subr1
	.text
	.globl	prinlp
prinlp:
	cmpl	r9,r1
	jgtr	popj
	pushl	cdr(r1)
	movl	car(r1),r1
	jsb	spaces
	jmp	prinlp3
prinlp1:
	pushl	cdr(r1)
	movl	car(r1),r2
	rotl	$-8,r2,r4
	bicl2	0xffffff00,r4
	beql	prinlp2
	pushl	r2
	jsb	outch
	movl	(r14)+,r2
prinlp2:
	movl	r2,r4
	bicl2	$0xffffff00,r4
	jeql	prinlp3
	jsb	outch
prinlp3:
	movl	(r14)+,r1
	cmpl	r9,r1
	jleq	prinlp1
	jmp	true
	.data
.terpri:
	.long	0
	.set	._terpri,subrv1
	.text
	.globl	terpri
terpri:
	cmpl	r6,r1
	jgtr	terpr2
	movl	$1,r1
	jmp	terpr2
terpr1:
	jsb	fullin
terpr2:
	sobgeq	r1,terpr1
	jmp	true
	.data
.princh:
	.long	0
	.set	._princh,subrv2
	.text
	.globl	princh
princh:
	cmpl	r9,r1
	jleq	prince
	pushl	r1
	moval	bufpn,r0
	clrl	r10
	jsb	getpnam
	movl	r11,r1
	movl	$0,r3
	movzbl	*$bufpn[r3],r4
	cmpl	r6,r2
	jgtr	princ2
	movl	$1,r2
	jmp	princ2
princ1:
	pushl	r2
	jsb	outch
	movl	(r14)+,r2
princ2:
	sobgeq	r2,princ1
	movl	(r14)+,r1
	rsb
prince:
	movl	.princh,r2
	jmp	errnca
	.data
.princod:
	.long	0
	.set	._princod,subr1
	.text
	.globl	princod
princod:
	cmpl	r6,r1
	jleq	princode
	movl	r1,r4
	pushl	r1
	jsb	outch
	movl	(r14)+,r1
	rsb
princode:
	movl	.princod,r2
	jmp	errnna
	.data
.spaces:
	.long	0
	.set	._spaces,subr1
	.text
	.globl	spaces
spaces:
	movl	$0x20,r4
	cmpl	r6,r1
	jgtr	space1
	cmpl	r7,r1
	jneq	spacerr
	movl	$1,r1
space1:
	pushl	r1
	jmp	space3
space2:
	pushl	r1
	jsb	outch
	movl	(r14)+,r1
space3:
	sobgeq	r1,space2
	movl	(r14)+,r1
	rsb
spacerr:
	movl	.spaces,r2
	jmp	errnna
	.data
.plength:
	.long	0
	.set	._plength,subr1
	.text
	.globl	plength
plength:
	cmpl	r9,r1
	jleq	plenger
	moval	bufpn,r0
	clrl	r10
	jsb	getpnam
	movl	r11,r1
	rsb
plenger:
	movl	.plength,r2
	jmp	errnaa
	.data
.fptype:
	.long	0
	.set	._fptype,subrv2
	.text
	.globl	fptype
fptype:
	cmpl	r7,r1
	jgtr	ptyper1
	cmpl	r9,r1
	jleq	ptyper1
	cmpl	r7,r2
	jeql	ptyp1
	cmpl	r6,r2
	jleq	ptyper2
	movb	r2,ptype(r1)
ptyp1:
	movzbl	ptype(r1),r1
	rsb
ptyper1:
	movl	.fptype,r2
	jmp	errnaa
ptyper2:
	movl	r2,r1
	movl	.fptype,r2
	jmp	errnna
	.data
.fobase:
	.long	0
	.set	._fobase,subrv1
	.text
	.globl	fobase
fobase:
	cmpl	r7,r1
	jeql	fobase1
	cmpl	r6,r1
	jgtr	fobase0
	movl	.fobase,r2
	jmp	errnna
fobase0:
	cmpl	r1,$0
	jleq	fobase3
	cmpl	r1,$32
	jgtr	fobase3
	movl	r1,obase
fobase1:
	movl	obase,r1
	rsb
fobase3:
	movl	.fobase,r2
	jmp	erroob
	.data
.prline:
	.long	0
	.set	._prline,subrv1
	.text
	.globl	prline
prline:
	cmpl	r7,r1
	jeql	printn1
	cmpl	r6,r1
	jgtr	printn0
	movl	.prline,r2
	jmp	errnna
printn0:
	movl	r1,prmlp
printn1:
	movl	prmlp,r1
	rsb
	.data
.prlevel:
	.long	0
	.set	._prlevel,subrv1
	.text
	.globl	prlevel
prlevel:
	cmpl	r7,r1
	jeql	printl1
	cmpl	r6,r1
	jgtr	printl0
	movl	.prlevel,r2
	jmp	errnna
printl0:
	movl	r1,prmdp
printl1:
	movl	prmdp,r1
	rsb
	.data
.prlength:
	.long	0
	.set	._prlength,subrv1
	.text
	.globl	prlength
prlength:
	cmpl	r7,r1
	jeql	printg1
	cmpl	r6,r1
	jgtr	printg0
	movl	.prlength,r2
	jmp	errnna
printg0:
	movl	r1,prmln
printg1:
	movl	prmln,r1
	rsb
tespos:
	cmpl	r6,r1
	jleq	poser2
	cmpl	r1,$0
	jlss	poser
	cmpl	r1,nbrig
	jleq	popj
poser:
	movl	r4,r2
	jmp	erroob
poser2:
	movl	r4,r2
	jmp	errnna
	.data
.lmargin:
	.long	0
	.set	._lmargin,subrv1
	.text
	.globl	lmargin
lmargin:
	cmpl	r7,r1
	jeql	lmarg1
	movl	.lmargin,r4
	jsb	tespos
	movl	r1,nbleft
lmarg1:
	movl	nbleft,r1
	rsb
	.data
.rmargin:
	.long	0
	.set	._rmargin,subrv1
	.text
	.globl	rmargin
rmargin:
	cmpl	r7,r1
	jeql	rmarg1
	movl	.rmargin,r4
	cmpl	r6,r1
	jleq	poser
	cmpl	r1,$0
	jlss	poser
	cmpl	r1,$132
	jgtr	poser
	movl	r1,nbrig
rmarg1:
	movl	nbrig,r1
	rsb
	.data
.outpos:
	.long	0
	.set	._outpos,subrv1
	.text
	.globl	outpos
outpos:
	cmpl	r7,r1
	jeql	outpo1
	movl	.outpos,r4
	jsb	tespos
	movl	r1,pocour
outpo1:
	movl	pocour,r1
	rsb
	.data
.outbuf:
	.long	0
	.set	._outbuf,subrv2
	.text
	.globl	outbuf
outbuf:
	movl	.outbuf,r4
	jsb	tespos
	cmpl	r7,r2
	jeql	outbu1
	cmpl	r6,r2
	jleq	outbuer
	movl	r1,r0
	movb	r2,*$bufout[r0]
outbu1:
	movzbl	*$bufout[r1],r1
	rsb
outbuer:
	movl	r2,r1
	movl	r4,r2
	jmp	errnna
	.data
.explode:
	.long	0
	.set	._explode,subr1
	.text
	.globl	explode
explode:
	movl	r7,r2
	cmpl	r5,r7
	jneq	.3
	jsb	gc
.3:
	movl	r2,car(r5)
	movl	r5,r2
	movl	cdr(r5),r5
	movl	r7,cdr(r2)
	pushl	r2
	movl	r2,lexpld
	movl	.t,iexpld
	jsb	probj
	movl	r7,iexpld
	movl	(r14)+,r1
	movl	cdr(r1),r1
	rsb
expls:
	pushl	r1
	pushl	r2
	movl	$0x20,r1
expls1:
	cmpl	r5,r7
	jneq	.4
	jsb	gc
.4:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r7,cdr(r1)
	movl	lexpld,r2
	movl	r1,cdr(r2)
	movl	r1,lexpld
	movl	(r14)+,r2
	movl	(r14)+,r1
	rsb
explch:
	pushl	r4
	pushl	r2
	cmpl	r5,r7
	jneq	.5
	jsb	gc
.5:
	movl	r4,car(r5)
	movl	r5,r4
	movl	cdr(r5),r5
	movl	r7,cdr(r4)
	movl	lexpld,r2
	movl	r4,cdr(r2)
	movl	r4,lexpld
	movl	(r14)+,r2
	movl	(r14)+,r4
	rsb
