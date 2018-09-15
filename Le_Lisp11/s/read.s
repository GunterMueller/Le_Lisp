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
	.globl	.quote
	.globl	.fcons
	.globl	.mcons
	.globl	.list
	.globl	gc
	.globl	tryatom
	.globl	crastrg
	.globl	getpnam
	.globl	errnla
	.globl	errnna
	.globl	errnca
	.globl	errsxt
	.globl	nreverse
	.globl	evala1
	.globl	apply
	.globl	de
	.globl	inphy
	.globl	istream
	.globl	ini_read
	.globl	.dmc
	.globl	.ctrlz
	.globl	u_read
	.globl	iread
	.globl	.void
	.globl	cpkgc
	.data
tabch:
	.space	128
ringur:
	.long	0
rdprd:
	.long	0
impli:
	.long	0
impld:
	.long	0
	.set	maxat,64
bufat:
	.space	maxat*4
cpkgc:
	.long	0
	.text
ini_read:
	movl	r7,ringur
	movl	r7,impli
	.data
.void:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.void
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	0
	movl	csymb,r0
	movl	r0,.cquote
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cquote,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cquote
	.byte	0
	.word	1
	.byte	0x27
	movl	csymb,r0
	movl	r0,.carrob
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	carrob,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._carrob
	.byte	0
	.word	1
	.ascii	"@"
	.data
.ctrlz:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.ctrlz
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	1
	.byte	0x1a
	.data
.statrc:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.statrc
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	16
	.ascii	"status-read-case"
	movl	csymb,r0
	movl	r0,.dmc
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	dmc,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._dmc
	.byte	0
	.word	3
	.ascii	"dmc"
	movl	csymb,r0
	movl	r0,.lread
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	lread,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._lread
	.byte	0
	.word	4
	.ascii	"read"
	movl	csymb,r0
	movl	r0,.implode
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	implode,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._implode
	.byte	0
	.word	7
	.ascii	"implode"
	movl	csymb,r0
	movl	r0,.readch
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	readch,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._readch
	.byte	0
	.word	6
	.ascii	"readch"
	movl	csymb,r0
	movl	r0,.readcod
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	readcod,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._readcod
	.byte	0
	.word	6
	.ascii	"readcn"
	movl	csymb,r0
	movl	r0,.reread
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	reread,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._reread
	.byte	0
	.word	6
	.ascii	"reread"
	movl	csymb,r0
	movl	r0,.readline
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	readline,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._readline
	.byte	0
	.word	8
	.ascii	"readline"
	movl	csymb,r0
	movl	r0,.peekch
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	peekch,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._peekch
	.byte	0
	.word	6
	.ascii	"peekch"
	movl	csymb,r0
	movl	r0,.peekcn
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	peekcn,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._peekcn
	.byte	0
	.word	6
	.ascii	"peekcn"
	movl	csymb,r0
	movl	r0,.fascii
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	fascii,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._fascii
	.byte	0
	.word	5
	.ascii	"ascii"
	movl	csymb,r0
	movl	r0,.cascii
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cascii,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cascii
	.byte	0
	.word	6
	.ascii	"cascii"
	movl	csymb,r0
	movl	r0,.uppercase
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	uppercase,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._uppercase
	.byte	0
	.word	9
	.ascii	"uppercase"
	movl	csymb,r0
	movl	r0,.lowercase
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	lowercase,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._lowercase
	.byte	0
	.word	9
	.ascii	"lowercase"
	movl	csymb,r0
	movl	r0,.digitp
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	digitp,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._digitp
	.byte	0
	.word	6
	.ascii	"digitp"
	movl	csymb,r0
	movl	r0,.typech
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	typech,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._typech
	.byte	0
	.word	6
	.ascii	"typech"
	movl	csymb,r0
	movl	r0,.typecod
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	typecod,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._typecod
	.byte	0
	.word	6
	.ascii	"typecn"
	.data
.shrpm:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.shrpm
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	11
	.ascii	"sharp-macro"
	movl	$127,r1
reini:
	movzbl	*$tabchini[r1],r2
	movl	r1,r0
	movb	r2,*$tabch[r0]
	sobgeq	r1,reini
	movl	.statrc,r1
	movl	r7,cval(r1)
	movl	.void,cpkgc
false:
	movl	r7,r1
popj:
	rsb
u_read:
	jsb	iread
	cmpl	.ctrlz,r1
	jneq	u_read9
	movl	r7,istream
u_read9:
	rsb
iread:
	jsb	rd1
	cmpl	$1,r3
	jeql	u_read
	jmp	read0
getch:
	cmpl	r7,ringur
	jeql	getch1
	movl	ringur,r4
	cmpl	r6,r4
	jgtr	getch0
	movl	cdr(r4),ringur
	movl	car(r4),r4
	jmp	getch2
getch0:
	movl	r7,ringur
	jmp	getch2
getch1:
	cmpl	r7,impli
	jneq	getch3
	jsb	inphy
getch2:
	movzbl	*$tabch[r4],r3
	rsb
getch3:
	movl	impld,r4
	cmpl	r7,r4
	jeql	getch4
	cmpl	r9,r4
	jgtr	erlec1
	movl	cdr(r4),impld
	movl	car(r4),r4
	cmpl	r6,r4
	jleq	erlec9
	jmp	getch2
getch4:
	movl	$0,impld
	movl	$32,r4
	jmp	getch2
getcv1:
	jsb	getch
	cmpl	$2,r3
	jneq	getcv1
getcv:
	jsb	getch
	cmpl	$0,r3
	jeql	getcv
	cmpl	$3,r3
	jneq	getcv2
	jsb	getch
	movl	$8,r3
	rsb
getcv2:
	cmpl	$1,r3
	jeql	getcv1
	cmpl	$2,r3
	jeql	getcv
	subl2	$4,r3
	pushl	r1
	movl	.statrc,r1
	movl	cval(r1),r1
	cmpl	r7,r1
	jneq	getcv3
	cmpl	r4,$0x41
	jlss	.1
	cmpl	r4,$0x5a
	jgtr	.1
	addl2	$0x20,r4
.1:
getcv3:
	movl	(r14)+,r1
	rsb
	.globl	rd1
rd1:
	jsb	getcv
	movl	rdtb1[r3],r0
	jmp	(r0)
rdtb1:
	.long	rdparo
	.long	rdparf
	.long	popj
	.long	popj
	.long	popj
	.long	rd1
	.long	rdmac
	.long	rdstr
	.long	rd2
	.long	rd3
	.long	rd4
	.long	rdsh
rdparo:
	incl	rdprd
	rsb
rdparf:
	sobgeq	rdprd,rdparfret
	movl	$0,rdprd
rdparfret:
	rsb
rdmac:
	jsb	asciii
	movl	r7,r2
	jsb	apply
	movl	$5,r3
	rsb
rdstr:
	movl	$0,r2
rdstr1:
	jsb	getch
	cmpl	$11,r3
	jeql	rdstr3
rdstr2:
	movl	r2,r0
	movb	r4,*$bufat[r0]
	incl	r2
	cmpl	r2,$maxat*4
	jlss	rdstr1
	movl	$2,r1
	jmp	erlec
rdstr3:
	jsb	getch
	cmpl	$11,r3
	jeql	rdstr2
	movl	r4,ringur
rdstr5:
	movl	r2,r10
	moval	bufat,r0
	jsb	crastrg
rdstr6:
	movl	$5,r3
	rsb
rd2:
	movl	$0,r2
rd21:
	movl	r2,r0
	movb	r4,*$bufat[r0]
	incl	r2
	cmpl	r2,$maxat
	jgeq	erlec3
	jsb	getcv
	cmpl	$8,r3
	jeql	rd21
	cmpl	$4,r3
	jeql	rd21
	movl	r4,ringur
	movl	r7,r1
	movl	r2,r10
	moval	bufat,r0
	jsb	tryatom
	movl	$5,r3
	rsb
rd3:
	movl	$0,r2
rd31:
	jsb	getch
	cmpl	$13,r3
	jeql	rd33
rd32:
	movl	r2,r0
	movb	r4,*$bufat[r0]
	incl	r2
	cmpl	r2,$maxat
	jlss	rd31
	movl	$9,r1
	jmp	erlec
rd33:
	jsb	getch
	cmpl	$13,r3
	jeql	rd32
	movl	r4,ringur
	movl	r7,r1
	cmpl	r2,$0
	jeql	rd35
	movl	r2,r10
	moval	bufat,r0
	jsb	tryatom
rd34:
	movl	$5,r3
	bisb2	$0x80,ptype(r1)
	rsb
rd35:
	movl	.void,r1
	jmp	rd34
rd4:
	jsb	asciii
	movl	$5,r3
	rsb
rdsh:
	movl	$10,r1
	jmp	erlec
	.data
.cquote:
	.long	0
	.set	._cquote,subr0
	.text
	.globl	cquote
cquote:
	jsb	readi
	cmpl	r5,r7
	jneq	.2
	jsb	gc
.2:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r7,cdr(r1)
	cmpl	r5,r7
	jneq	.3
	jsb	gc
.3:
	movl	r5,r0
	movl	.quote,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	rsb
	.data
.carrob:
	.long	0
	.set	._carrob,subr0
	.text
	.globl	carrob
carrob:
	jsb	readi
	jmp	evala1
	.data
.dmc:
	.long	0
	.set	._dmc,subrf
	.text
	.globl	dmc
dmc:
	jsb	de
	pushl	r1
	movl	$10,r2
	jsb	typech
	movl	(r14)+,r1
	rsb
readi:
	jsb	rd1
read0:
	movl	readt1[r3],r0
	jmp	(r0)
readt1:
	.long	read2
	.long	erlec4
	.long	read1
	.long	erlec4
	.long	erlec4
	.long	popj
read1:
	jsb	rd1
	cmpl	$3,r3
	jeql	false
	movl	r7,r2
	cmpl	r5,r7
	jneq	.4
	jsb	gc
.4:
	movl	r5,r0
	movl	$mk_read,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
	pushl	r2
	pushl	r2
	jmp	read31
read2:
	jsb	rd1
	cmpl	$1,r3
	jeql	false
	jsb	read0
	cmpl	r5,r7
	jneq	.5
	jsb	gc
.5:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r7,cdr(r1)
	pushl	r1
read3:
	pushl	r1
	jsb	rd1
read31:
	movl	readt2[r3],r0
	jmp	(r0)
readt2:
	.long	read5
	.long	read7
	.long	read6
	.long	read8
	.long	read9
	.long	read4
read4:
	cmpl	r5,r7
	jneq	.6
	jsb	gc
.6:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r7,cdr(r1)
	movl	(r14)+,r2
	movl	r1,cdr(r2)
	jmp	read3
read5:
	pushal	read4
	jmp	read2
read6:
	pushal	read4
	jmp	read1
read7:
	movl	(r14)+,r1
read71:
	movl	(r14)+,r1
	movl	car(r1),r2
	cmpl	$mk_read,r2
	jneq	popj
	movl	$5,r1
	jmp	erlec
read8:
	movl	(r14)+,r1
	movl	(r14)+,r1
	movl	car(r1),r2
	cmpl	$mk_read,r2
	jneq	erlec6
	movl	.list,car(r1)
	rsb
read9:
	jsb	readi
	pushl	r1
	jsb	rd1
	movl	(r14)+,r1
	movl	(r14)+,r2
	movl	readt3[r3],r0
	jmp	(r0)
readt3:
	.long	erlec7
	.long	read91
	.long	erlec7
	.long	read92
	.long	erlec7
	.long	erlec7
read91:
	movl	r1,cdr(r2)
	jmp	read71
read92:
	cmpl	r5,r7
	jneq	.7
	jsb	gc
.7:
	movl	r1,car(r5)
	movl	r5,r1
	movl	cdr(r5),r5
	movl	r7,cdr(r1)
	movl	r1,cdr(r2)
	movl	(r14)+,r1
	movl	car(r1),r3
	cmpl	$mk_read,r3
	jneq	erlec8
	movl	cdr(r1),r3
	cmpl	r2,r3
	jeql	read93
	movl	.mcons,car(r1)
	rsb
read93:
	movl	.fcons,car(r1)
	rsb
erlec1:
	movl	$1,r1
	jmp	erlec
erlec2:
	movl	$2,r1
	jmp	erlec
erlec3:
	movl	$3,r1
	jmp	erlec
erlec4:
	movl	$4,r1
	jmp	erlec
erlec6:
	movl	$6,r1
	jmp	erlec
erlec7:
	movl	$7,r1
	jmp	erlec
erlec8:
	movl	$8,r1
	jmp	erlec
erlec9:
	movl	$9,r1
	nop
erlec:
	cmpl	r7,impli
	jneq	erlecc1
	movl	.lread,r2
	jmp	erlecc2
erlecc1:
	movl	.implode,r2
	movl	r7,impli
erlecc2:
	movl	r7,istream
	jmp	errsxt
	.data
.lread:
	.long	0
	.set	._lread,subr0
	.text
	.globl	lread
lread:
	jsb	rd1
	cmpl	$1,r3
	jeql	lread
	jmp	read0
	.data
.implode:
	.long	0
	.set	._implode,subr1
	.text
	.globl	implode
implode:
	movl	r1,impld
	movl	.t,impli
	jsb	lread
	movl	r7,impli
	rsb
	.data
.readch:
	.long	0
	.set	._readch,subr0
	.text
	.globl	readch
readch:
	pushal	asciii
	jmp	getch
	.data
.readcod:
	.long	0
	.set	._readcod,subr0
	.text
	.globl	readcod
readcod:
	jsb	getch
	movl	r4,r1
	rsb
	.data
.reread:
	.long	0
	.set	._reread,subr1
	.text
	.globl	reread
reread:
	cmpl	r9,r1
	jgtr	rereade
	movl	r1,ringur
	rsb
rereade:
	movl	.reread,r2
	jmp	errnla
	.data
.teread:
	.long	0
	.set	._teread,subr0
	.text
	.globl	teread
teread:
	jsb	getch
	cmpl	$0x0a,r4
	jneq	teread
	jmp	false
	.data
.peekch:
	.long	0
	.set	._peekch,subr0
	.text
	.globl	peekch
peekch:
	jsb	getch
	movl	r4,ringur
	jmp	asciii
	nop
	.data
.peekcn:
	.long	0
	.set	._peekcn,subr0
	.text
	.globl	peekcn
peekcn:
	jsb	getch
	movl	r4,ringur
	movl	r4,r1
	rsb
	.data
.readline:
	.long	0
	.set	._readline,subr0
	.text
	.globl	readline
readline:
	movl	r7,r1
readl2:
	pushl	r1
	jsb	getch
	movl	(r14)+,r1
	cmpl	$26,r4
	jeql	readl8
	cmpl	$13,r4
	jeql	readl5
	cmpl	r4,$32
	jlss	readl2
	cmpl	r5,r7
	jneq	.8
	jsb	gc
.8:
	movl	r5,r0
	movl	r4,car(r5)
	movl	cdr(r5),r5
	movl	r1,cdr(r0)
	movl	r0,r1
	jmp	readl2
readl5:
	jmp	readl7
readl6:
	movl	cdr(r1),r1
readl7:
	cmpl	r9,r1
	jgtr	readl9
	movl	car(r1),r3
	cmpl	$32,r3
	jeql	readl6
	jmp	nreverse
readl8:
	movl	r4,r1
readl9:
	rsb
asciii:
	movl	r4,r1
	.data
.fascii:
	.long	0
	.set	._fascii,subr1
	.text
	.globl	fascii
fascii:
	cmpl	r6,r1
	jleq	ascierr
	movl	$0,r4
	movl	r4,r0
	movb	r1,*$bufat[r0]
	incl	r4
	movl	r4,r0
	movb	$0,*$bufat[r0]
	movl	$1,r10
	moval	bufat,r0
	jsb	tryatom
	rsb
ascierr:
	movl	.fascii,r2
	jmp	errnna
	.data
.cascii:
	.long	0
	.set	._cascii,subr1
	.text
	.globl	cascii
cascii:
	cmpl	r9,r1
	jleq	cascier
	moval	bufat,r0
	clrl	r10
	jsb	getpnam
	movl	r11,r1
	movl	$0,r2
	movzbl	*$bufat[r2],r1
	rsb
cascier:
	movl	.cascii,r2
	jmp	errnca
	.data
.uppercase:
	.long	0
	.set	._uppercase,subr1
	.text
	.globl	uppercase
uppercase:
	cmpl	r6,r1
	jleq	upper9
	cmpl	r1,$0x61
	jlss	.9
	cmpl	r1,$0x7a
	jgtr	.9
	subl2	$0x20,r1
.9:
	rsb
upper9:
	movl	.uppercase,r2
	jmp	errnna
	.data
.lowercase:
	.long	0
	.set	._lowercase,subr1
	.text
	.globl	lowercase
lowercase:
	cmpl	r6,r1
	jleq	lower9
	cmpl	r1,$0x41
	jlss	.10
	cmpl	r1,$0x5a
	jgtr	.10
	addl2	$0x20,r1
.10:
	rsb
lower9:
	movl	.lowercase,r2
	jmp	errnna
	.data
.digitp:
	.long	0
	.set	._digitp,subr1
	.text
	.globl	digitp
digitp:
	cmpl	r6,r1
	jleq	digitpn
	cmpl	r1,$0x30
	jlss	digitpn
	cmpl	r1,$0x39
	jleq	digitpt
digitpn:
	movl	r7,r1
digitpt:
	rsb
	.data
.typech:
	.long	0
	.set	._typech,subrv2
	.text
	.globl	typech
typech:
	jsb	cascii
	cmpl	r7,r2
	jeql	typech1
	movl	r1,r0
	movb	r2,*$tabch[r0]
typech1:
	movzbl	*$tabch[r1],r1
	rsb
	.data
.typecod:
	.long	0
	.set	._typecod,subrv2
	.text
	.globl	typecod
typecod:
	cmpl	r7,r2
	jeql	typeco1
	movl	r1,r0
	movb	r2,*$tabch[r0]
typeco1:
	movzbl	*$tabch[r1],r1
	rsb
tabchini:
	.byte	0
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	2
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	14
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	9
	.byte	12
	.byte	11
	.byte	15
	.byte	12
	.byte	12
	.byte	12
	.byte	10
	.byte	4
	.byte	5
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	8
	.byte	3
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	1
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	10
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	6
	.byte	12
	.byte	7
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	13
	.byte	12
	.byte	12
	.byte	0
