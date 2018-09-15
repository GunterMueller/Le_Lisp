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
	.globl	gc
	.globl	hashmax
	.globl	hashtab
	.globl	errnaa
	.globl	errnna
	.globl	errnla
	.globl	errnva
	.globl	evalcar
	.globl	evala1
	.globl	savep
	.globl	apply
	.globl	member
	.globl	.undef
	.globl	.t
	.globl	.void
	.globl	.quote
	.globl	.internal
	.globl	addprop
	.globl	getprop
	.globl	putprop
	.globl	remprop
	.globl	ini_ctl
	.globl	.de
	.globl	.df
	.globl	.dm
ini_ctl:
	.data
.lff:
	.long	0
	.text
	movl	csymb,r0
	movl	r0,.lff
	movl	r0,r12
	movl	r0,(r0)+
	movl	r7,(r0)+
	clrl	(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.word	0
	.word	16
	.ascii	"loaded-from-file"
	movl	.lff,r1
	movl	r7,cval(r1)
	movl	csymb,r0
	movl	r0,.de
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	de,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._de
	.byte	0
	.word	5
	.ascii	"defun"
	movl	csymb,r0
	movl	r0,.de
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	de,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._de
	.byte	0
	.word	2
	.ascii	"de"
	movl	csymb,r0
	movl	r0,.df
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	df,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._df
	.byte	0
	.word	2
	.ascii	"df"
	movl	csymb,r0
	movl	r0,.dm
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	dm,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._dm
	.byte	0
	.word	2
	.ascii	"dm"
	movl	csymb,r0
	movl	r0,.rde
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	rde,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._rde
	.byte	0
	.word	3
	.ascii	"rde"
	movl	csymb,r0
	movl	r0,.rdf
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	rdf,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._rdf
	.byte	0
	.word	3
	.ascii	"rdf"
	movl	csymb,r0
	movl	r0,.rdm
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	rdm,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._rdm
	.byte	0
	.word	3
	.ascii	"rdm"
	movl	csymb,r0
	movl	r0,.revert
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	revert,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._revert
	.byte	0
	.word	6
	.ascii	"revert"
	movl	csymb,r0
	movl	r0,.if
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	if,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._if
	.byte	0
	.word	2
	.ascii	"if"
	movl	csymb,r0
	movl	r0,.ifn
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	ifn,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._ifn
	.byte	0
	.word	3
	.ascii	"ifn"
	movl	csymb,r0
	movl	r0,.when
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	when,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._when
	.byte	0
	.word	4
	.ascii	"when"
	movl	csymb,r0
	movl	r0,.unless
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	unless,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._unless
	.byte	0
	.word	6
	.ascii	"unless"
	movl	csymb,r0
	movl	r0,.cond
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	cond,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._cond
	.byte	0
	.word	4
	.ascii	"cond"
	movl	csymb,r0
	movl	r0,.or
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	or,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._or
	.byte	0
	.word	2
	.ascii	"or"
	movl	csymb,r0
	movl	r0,.and
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	and,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._and
	.byte	0
	.word	3
	.ascii	"and"
	movl	csymb,r0
	movl	r0,.while
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	while,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._while
	.byte	0
	.word	5
	.ascii	"while"
	movl	csymb,r0
	movl	r0,.until
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	until,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._until
	.byte	0
	.word	5
	.ascii	"until"
	movl	csymb,r0
	movl	r0,.frepeat
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	frepeat,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._frepeat
	.byte	0
	.word	6
	.ascii	"repeat"
	movl	csymb,r0
	movl	r0,.selectq
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	selectq,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._selectq
	.byte	0
	.word	7
	.ascii	"selectq"
	movl	csymb,r0
	movl	r0,.map
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	map,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._map
	.byte	0
	.word	3
	.ascii	"map"
	movl	csymb,r0
	movl	r0,.mapc
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	mapc,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._mapc
	.byte	0
	.word	4
	.ascii	"mapc"
	movl	csymb,r0
	movl	r0,.mapoblist
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	mapoblist,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._mapoblist
	.byte	0
	.word	9
	.ascii	"mapoblist"
false:
	movl	r7,r1
popj:
	rsb
true:
	movl	.t,r1
	rsb
progna3:
	movl	r3,r1
progn:
	cmpl	r9,r1
	jleq	progn2
	jmp	false
progn1:
	pushl	r2
	jsb	evalcar
	movl	(r14)+,r1
progn2:
	movl	cdr(r1),r2
	cmpl	r9,r2
	jleq	progn1
	jmp	evalcar
rdef:
	pushl	r1
	movl	car(r1),r1
	movl	fval(r1),r2
	cmpl	r5,r7
	jneq	.1
	jsb	gc
.1:
	movl	r2,car(r5)
	movl	r5,r2
	movl	cdr(r5),r5
	movl	r7,cdr(r2)
	movzbl	ftype(r1),r3
	cmpl	r5,r7
	jneq	.2
	jsb	gc
.2:
	movl	r5,r0
	movl	r3,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
	movl	.internal,r3
	jsb	addprop
	movl	(r14)+,r1
def:
	movl	cdr(r1),r2
	movl	car(r1),r1
	movb	r3,ftype(r1)
	movl	r2,fval(r1)
	movl	.lff,r3
	movl	cval(r3),r2
	cmpl	r7,r2
	jeql	popj
	jmp	putprop
	.data
.de:
	.long	0
	.set	._de,subrf
	.text
	.globl	de
de:
	movl	$expr,r3
	jmp	def
	.data
.df:
	.long	0
	.set	._df,subrf
	.text
	.globl	df
df:
	movl	$fexpr,r3
	jmp	def
	.data
.dm:
	.long	0
	.set	._dm,subrf
	.text
	.globl	dm
dm:
	movl	$macro,r3
	jmp	def
	.data
.rde:
	.long	0
	.set	._rde,subrf
	.text
	.globl	rde
rde:
	movl	$expr,r3
	jmp	rdef
	.data
.rdf:
	.long	0
	.set	._rdf,subrf
	.text
	.globl	rdf
rdf:
	movl	$fexpr,r3
	jmp	rdef
	.data
.rdm:
	.long	0
	.set	._rdm,subrf
	.text
	.globl	rdm
rdm:
	movl	$macro,r3
	jmp	rdef
	.data
.revert:
	.long	0
	.set	._revert,subr1
	.text
	.globl	revert
revert:
	pushl	r1
	movl	.internal,r2
	jsb	getprop
	movl	(r14)+,r3
	cmpl	r7,r1
	jeql	popj
	movl	car(r1),r4
	movl	r4,ftype(r3)
	movl	cdr(r1),r4
	movl	car(r4),r4
	movl	r4,fval(r3)
	jmp	remprop
	.data
.if:
	.long	0
	.set	._if,subrf
	.text
	.globl	if
if:
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14)+,r2
	movl	cdr(r2),r3
	cmpl	r7,r1
	jeql	progna3
	movl	car(r2),r1
	jmp	evala1
	.data
.ifn:
	.long	0
	.set	._ifn,subrf
	.text
	.globl	ifn
ifn:
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14)+,r2
	movl	cdr(r2),r3
	cmpl	r7,r1
	jneq	progna3
	movl	car(r2),r1
	jmp	evala1
	.data
.when:
	.long	0
	.set	._when,subrf
	.text
	.globl	when
when:
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14)+,r3
	cmpl	r7,r1
	jneq	progna3
	rsb
	.data
.unless:
	.long	0
	.set	._unless,subrf
	.text
	.globl	unless
unless:
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14)+,r3
	cmpl	r7,r1
	jeql	progna3
	movl	r7,r1
	rsb
	.data
.cond:
	.long	0
	.set	._cond,subrf
	.text
	.globl	cond
cond:
	movl	r1,r2
cond1:
	cmpl	r9,r2
	jgtr	condret
	pushl	cdr(r2)
	movl	car(r2),r1
	cmpl	r9,r1
	jgtr	conder
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14)+,r3
	movl	(r14)+,r2
	cmpl	r7,r1
	jeql	cond1
	cmpl	r7,r3
	jneq	progna3
condret:
	rsb
conder:
	movl	.cond,r2
	jmp	errnla
	.data
.or:
	.long	0
	.set	._or,subrf
	.text
	.globl	or
or:
	cmpl	r9,r1
	jgtr	false
	movl	r1,r2
or1:
	pushl	r2
	jsb	evalcar
	cmpl	r7,r1
	jneq	pret
	movl	(r14)+,r1
	movl	cdr(r1),r2
or2:
	cmpl	r9,r2
	jleq	or1
	jmp	evalcar
	.data
.and:
	.long	0
	.set	._and,subrf
	.text
	.globl	and
and:
	cmpl	r9,r1
	jgtr	true
and1:
	movl	cdr(r1),r2
	cmpl	r9,r2
	jgtr	and2
	pushl	r2
	jsb	evalcar
	cmpl	r7,r1
	jeql	pret
	movl	(r14)+,r1
	jmp	and1
and2:
	jmp	evalcar
pret:
	movl	(r14)+,r2
	rsb
	.data
.while:
	.long	0
	.set	._while,subrf
	.text
	.globl	while
while:
	pushl	r1
	jmp	while2
while1:
	movl	(r14),r1
	movl	cdr(r1),r1
	jsb	progn
while2:
	movl	(r14),r1
	jsb	evalcar
	cmpl	r7,r1
	jneq	while1
	movl	(r14)+,r2
	rsb
	.data
.until:
	.long	0
	.set	._until,subrf
	.text
	.globl	until
until:
	pushl	r1
	jmp	until2
until1:
	movl	(r14),r1
	movl	cdr(r1),r1
	jsb	progn
until2:
	movl	(r14),r1
	jsb	evalcar
	cmpl	r7,r1
	jeql	until1
	movl	(r14)+,r2
	rsb
	.data
.frepeat:
	.long	0
	.set	._frepeat,subrf
	.text
	.globl	frepeat
frepeat:
	pushl	cdr(r1)
	jsb	evalcar
	movl	r1,r2
	movl	(r14)+,r1
	cmpl	r6,r2
	jgtr	repeat2
	movl	r2,r1
	movl	.frepeat,r2
	jmp	errnna
repeat1:
	pushl	r1
	pushl	r2
	jsb	progn
	movl	(r14)+,r2
	movl	(r14)+,r1
repeat2:
	sobgeq	r2,repeat1
	jmp	true
	.data
.selectq:
	.long	0
	.set	._selectq,subrf
	.text
	.globl	selectq
selectq:
	pushl	cdr(r1)
	jsb	evalcar
	movl	(r14)+,r3
	jmp	selec4
selec2:
	cmpl	r1,r4
	jeql	progna3
	cmpl	.t,r4
	jeql	progna3
selec3:
	movl	r2,r3
selec4:
	cmpl	r9,r3
	jgtr	false
	movl	cdr(r3),r2
	movl	car(r3),r3
	cmpl	r9,r3
	jgtr	selecer
	movl	car(r3),r4
	movl	cdr(r3),r3
	cmpl	r9,r4
	jgtr	selec2
	pushl	r1
	pushl	r2
	pushl	r3
	movl	r4,r2
	jsb	member
	movl	(r14)+,r3
	movl	(r14)+,r2
	cmpl	r7,r1
	jeql	selec5
	movl	(r14)+,r1
	jmp	progna3
selec5:
	movl	(r14)+,r1
	jmp	selec3
selecer:
	movl	r3,r1
	movl	.selectq,r2
	jmp	errnla
	.data
.mapc:
	.long	0
	.set	._mapc,subrn
	.text
	.globl	mapc
mapc:
	pushl	car(r1)
	pushl	$mk_map
	jmp	mapc11
mapc1:
	pushl	car(r1)
mapc11:
	movl	cdr(r1),r1
	cmpl	r9,r1
	jleq	mapc1
mapc2:
	movl	r14,savep
	movl	r7,r2
	movl	r7,r3
	jmp	mapc6
mapc3:
	cmpl	r9,r4
	jleq	mapc4
	cmpl	r5,r7
	jneq	.3
	jsb	gc
.3:
	movl	r5,r0
	movl	r4,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
	jmp	mapc5
mapc4:
	movl	r4,r3
	movl	car(r4),r1
	cmpl	r5,r7
	jneq	.4
	jsb	gc
.4:
	movl	r5,r0
	movl	r1,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
	movl	cdr(r4),r4
mapc5:
	movl	(r14),r0
	movl	r4,(r14)
	movl	r0,r4
	movl	(r14)+,r4
mapc6:
	movl	(r14),r4
	cmpl	$mk_map,r4
	jneq	mapc3
	movl	(r14)+,r4
	movl	(r14)+,r1
	cmpl	r7,r3
	jeql	false
	movl	savep,r14
	jsb	apply
	jmp	mapc2
	.data
.map:
	.long	0
	.set	._map,subrn
	.text
	.globl	map
map:
	pushl	car(r1)
	pushl	$mk_map
	jmp	map11
map1:
	pushl	car(r1)
map11:
	movl	cdr(r1),r1
	cmpl	r9,r1
	jleq	map1
map2:
	movl	r14,savep
	movl	r7,r2
	movl	r7,r3
	jmp	map6
map3:
	cmpl	r9,r4
	jleq	map4
	cmpl	r5,r7
	jneq	.5
	jsb	gc
.5:
	movl	r5,r0
	movl	r4,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
	jmp	map5
map4:
	movl	r4,r3
	cmpl	r5,r7
	jneq	.6
	jsb	gc
.6:
	movl	r5,r0
	movl	r4,car(r5)
	movl	cdr(r5),r5
	movl	r2,cdr(r0)
	movl	r0,r2
	movl	cdr(r4),r4
map5:
	movl	(r14),r0
	movl	r4,(r14)
	movl	r0,r4
	movl	(r14)+,r4
map6:
	movl	(r14),r4
	cmpl	$mk_map,r4
	jneq	map3
	movl	(r14)+,r4
	movl	(r14)+,r1
	cmpl	r7,r3
	jeql	false
	movl	savep,r14
	jsb	apply
	jmp	map2
	.data
.mapoblist:
	.long	0
	.set	._mapoblist,subr1
	.text
	.globl	mapoblist
mapoblist:
	movl	hashmax,r3
mapob0:
	movl	*$hashtab[r3],r2
	jmp	mapob3
mapob1:
	cmpl	.undef,r2
	jeql	mapob2
	pushl	r3
	pushl	r2
	cmpl	r5,r7
	jneq	.7
	jsb	gc
.7:
	movl	r2,car(r5)
	movl	r5,r2
	movl	cdr(r5),r5
	movl	r7,cdr(r2)
	pushl	r1
	jsb	apply
	movl	(r14)+,r1
	movl	(r14)+,r2
	movl	(r14)+,r3
mapob2:
	movl	alink(r2),r2
mapob3:
	cmpl	r7,r2
	jgtr	.8
	cmpl	r9,r2
	jgtr	mapob1
.8:
	sobgeq	r3,mapob0
	jmp	true
