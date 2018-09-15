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
	.globl	gc
	.globl	tryatom
	.globl	errnla
	.globl	errnna
	.globl	errnaa
	.globl	errios
	.globl	iread
	.globl	.ctrlz
	.globl	evala1
	.globl	apply
	.globl	de
	.globl	popj
	.globl	false
	.globl	true
	.globl	reenter
	.globl	ini_pio
	.globl	inputi
	.globl	istream
	.globl	ostream
	.globl	inphy
	.text
ini_pio:
	movl	$0,pbuftty
	movl	$0,r1
	movl	r1,r0
	movb	$0,*$ligne[r0]
	movl	$0,polig
	movl	r7,istream
	movl	r7,ostream
	movl	csymb,r0
	movl	r0,.tyi
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	tyi,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._tyi
	.byte	0
	.word	3
	.ascii	"tyi"
	movl	csymb,r0
	movl	r0,.tyo
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	tyo,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._tyo
	.byte	0
	.word	3
	.ascii	"tyo"
	movl	csymb,r0
	movl	r0,.tyol
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	tyol,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._tyol
	.byte	0
	.word	4
	.ascii	"tyol"
	movl	csymb,r0
	movl	r0,.tyflush
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	tyflush,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._tyflush
	.byte	0
	.word	7
	.ascii	"tyflush"
	movl	csymb,r0
	movl	r0,.input
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	input,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._input
	.byte	0
	.word	5
	.ascii	"input"
	movl	csymb,r0
	movl	r0,.inchan
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	inchan,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._inchan
	.byte	0
	.word	6
	.ascii	"inchan"
	movl	csymb,r0
	movl	r0,.outchan
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	outchan,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._outchan
	.byte	0
	.word	7
	.ascii	"outchan"
	movl	csymb,r0
	movl	r0,.load
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	load,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._load
	.byte	0
	.word	4
	.ascii	"load"
	movl	csymb,r0
	movl	r0,.loadfile
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	loadfile,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._loadfile
	.byte	0
	.word	8
	.ascii	"loadfile"
	movl	csymb,r0
	movl	r0,.output
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	output,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._output
	.byte	0
	.word	6
	.ascii	"output"
	movl	csymb,r0
	movl	r0,.lclose
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	lclose,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._lclose
	.byte	0
	.word	5
	.ascii	"close"
	movl	csymb,r0
	movl	r0,.deletfi
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	deletfi,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._deletfi
	.byte	0
	.word	10
	.ascii	"deletefile"
	movl	csymb,r0
	movl	r0,.renamfi
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	renamfi,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._renamfi
	.byte	0
	.word	10
	.ascii	"renamefile"
	movl	csymb,r0
	movl	r0,.savecor
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	savecor,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._savecor
	.byte	0
	.word	9
	.ascii	"save-core"
	movl	csymb,r0
	movl	r0,.restcor
	movl	r0,r12
	movl	r6,(r0)+
	movl	r7,(r0)+
	moval	restcor,r1
	movl	r1,(r0)+
	movl	.void,(r0)+
	jsb	buildat
	.byte	._restcor
	.byte	0
	.word	12
	.ascii	"restore-core"
	rsb
ltrue:
	jmp	true
	.data
.tyi:
	.long	0
	.set	._tyi,subr0
	.text
	.globl	tyi
tyi:
	movl	pbuftty,r10
	moval	buftty,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r2
	movl	$0,pbuftty
	.globl	ll_ttyi
	jsb	ll_ttyi
	movl	r10,r1
	movl	r0,r2
	cmpl	$0,r2
	jneq	tyierr
	rsb
tyierr:
	movl	$0,pbuftty
	movl	r2,r1
	movl	.tyi,r2
	jmp	errios
	.data
.tyo:
	.long	0
	.set	._tyo,subr1
	.text
	.globl	tyo
tyo:
	cmpl	r6,r1
	jleq	tyoerr
tyoi:
	movl	pbuftty,r4
	cmpl	r4,$500
	jlss	tyo1
	movl	r4,r10
	moval	buftty,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r2
	movl	$0,r4
tyo1:
	rotl	$-8,r1,r3
	bicl2	$0xffffff00,r3
	beql	tyo2
	movl	r4,r0
	movb	r3,*$buftty[r0]
	incl	r4
tyo2:
	movl	r1,r3
	bicl2	$0xffffff00,r3
	jeql	tyo3
	movl	r4,r0
	movb	r3,*$buftty[r0]
	incl	r4
tyo3:
	movl	r4,pbuftty
	rsb
tyoerr:
	movl	.tyo,r2
	jmp	errnna
ttyoerr:
	movl	r2,r1
	movl	.tyo,r2
	jmp	errios
	.data
.tyol:
	.long	0
	.set	._tyol,subr1
	.text
	.globl	tyol
tyol:
	movl	r1,r2
	jmp	tyol2
tyol1:
	movl	car(r2),r1
	movl	cdr(r2),r2
	jsb	tyoi
tyol2:
	cmpl	r9,r2
	jleq	tyol1
	jmp	true
	.data
.tyflush:
	.long	0
	.set	._tyflush,subr0
	.text
	.globl	tyflush
tyflush:
	movl	pbuftty,r10
	moval	buftty,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r2
	movl	$0,pbuftty
	jmp	true
inphy:
	pushl	r3
	movl	polig,r3
	movzbl	*$ligne[r3],r4
	cmpl	$0,r4
	jeql	inphyl
	incl	r3
	movl	r3,polig
	movl	(r14)+,r3
	rsb
inphyl:
	pushl	r2
	pushl	r4
	cmpl	r6,istream
	jgtr	inchf
	movl	pbuftty,r10
	moval	buftty,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r2
	cmpl	$0,r2
	jneq	ttyoerr
	movl	$2,r10
	moval	ptint,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r2
	cmpl	$0,r2
	jneq	ttyoerr
	movl	$0,pbuftty
inphy2:
	movl	$0,r4
inphy3:
	.globl	ll_ttyi
	jsb	ll_ttyi
	movl	r10,r3
	movl	r0,r2
	cmpl	$0,r2
	jneq	tyierr
	movb	r3,bufch
	cmpl	r3,$8
	jeql	inphy6
	cmpl	r3,$0x7f
	jeql	inphy6
	cmpl	r3,$24
	jeql	inphy8
	cmpl	r3,$0x0d
	jeql	inphy9
	cmpl	r3,$32
	jlss	inphy5
	movl	$1,r10
	moval	bufch,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r2
	cmpl	$0,r2
	jneq	ttyoerr
inphy4:
	movl	r4,r0
	movb	r3,*$ligne[r0]
	incl	r4
	jmp	inphy3
inphy5:
	pushl	r3
	addl2	$64,r3
	movb	r3,bufch
	movl	$2,r10
	moval	cntrl,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r2
	cmpl	$0,r2
	jneq	ttyoerr
	movl	(r14)+,r3
	jmp	inphy4
inphy6:
	cmpl	$0,r4
	jeql	inphy3
	decl	r4
	movzbl	*$ligne[r4],r3
	cmpl	r3,$32
	jlss	inphy7
	movl	$3,r10
	moval	ptrub,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r2
	cmpl	$0,r2
	jneq	ttyoerr
	jmp	inphy3
inphy7:
	movl	$6,r10
	moval	ptrub,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r2
	cmpl	$0,r2
	jneq	ttyoerr
	jmp	inphy3
inphy8:
	movl	$5,r10
	moval	ptcrx,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r2
	cmpl	$0,r2
	jneq	ttyoerr
	jmp	inphy2
inphy9:
	movl	$2,r10
	moval	ptcrlf,r0
	.globl	ll_ttyo
	jsb	ll_ttyo
	movl	r0,r2
	cmpl	$0,r2
	jneq	ttyoerr
inphyc:
	movl	r4,r0
	movb	r3,*$ligne[r0]
	incl	r4
	movl	r4,r0
	movb	$0x0a,*$ligne[r0]
	incl	r4
	movl	r4,r0
	movb	$0,*$ligne[r0]
	movl	(r14)+,r4
	movl	(r14)+,r2
	movl	(r14)+,r3
	movl	$0,r4
inphyend:
	movzbl	*$ligne[r4],r4
	movl	$1,polig
	rsb
	.globl	inchf
inchf:
	movl	istream,r11
	moval	ligne,r0
	.globl	ll_ibc
	jsb	ll_ibc
	movl	r10,r4
	movl	r0,r3
	cmpl	$0,r3
	jeql	inchf1
	movl	r4,r0
	movb	$26,*$ligne[r0]
	incl	r4
inchf1:
	movl	$0x0d,r3
	jmp	inphyc
	.data
.input:
	.long	0
	.set	._input,subrv1
	.text
	.globl	input
input:
	cmpl	r6,r1
	jgtr	input0
	cmpl	r7,r1
	jleq	input0
	movl	val(r1),r1
input0:
	cmpl	r7,r1
	jgtr	inputer
	cmpl	r9,r1
	jleq	inputer
	cmpl	$0,istream
	jneq	inputi
	movl	$0,r11
	.globl	ll_clo
	jsb	ll_clo
	movl	r0,r3
	cmpl	$0,r3
	jneq	input7
inputi:
	cmpl	r7,r1
	jneq	input2
	movl	r7,istream
	jmp	true
input2:
	movl	$0,r11
	movzwl	plen(r1),r10
	moval	pname(r1),r0
	.globl	ll_opi
	jsb	ll_opi
	movl	r0,r1
	cmpl	$0,r1
	jneq	input8
	movl	$0,istream
	jmp	true
input7:
	movl	r3,r1
input8:
	movl	.input,r2
	jmp	errios
inputer:
	movl	.input,r2
	jmp	errnaa
	.data
.load:
	.long	0
	.set	._load,subrf
	.text
	.globl	load
load:
	cmpl	$1,istream
	jeql	librar8
	movl	car(r1),r1
	cmpl	r6,r1
	jgtr	load0
	cmpl	r7,r1
	jleq	load0
	movl	val(r1),r1
load0:
	cmpl	r7,r1
	jgtr	loader
	cmpl	r9,r1
	jleq	loader
	movl	$1,r11
	movzwl	plen(r1),r10
	moval	pname(r1),r0
	.globl	ll_opi
	jsb	ll_opi
	movl	r0,r1
	cmpl	$0,r1
	jneq	librar8
	pushl	istream
	movl	$1,istream
librar1:
	jsb	iread
	cmpl	.ctrlz,r1
	jeql	librar2
	jsb	evala1
	jmp	librar1
librar2:
	movl	$1,r11
	.globl	ll_clo
	jsb	ll_clo
	movl	r0,r1
	movl	(r14)+,istream
	cmpl	$0,r1
	jeql	ltrue
librar8:
	movl	.load,r2
	jmp	errios
loader:
	movl	.load,r2
	jmp	errnaa
	.data
.loadfile:
	.long	0
	.set	._loadfile,subr1
	.text
	.globl	loadfile
loadfile:
	cmpl	$1,istream
	jeql	librar8
	cmpl	r6,r1
	jgtr	loadf0
	cmpl	r7,r1
	jleq	loadf0
	movl	val(r1),r1
loadf0:
	cmpl	r7,r1
	jgtr	.1
	cmpl	r9,r1
	jgtr	load0
.1:
	movl	.loadfile,r2
	jmp	errnaa
	.data
.output:
	.long	0
	.set	._output,subrv1
	.text
	.globl	output
output:
	cmpl	r6,r1
	jgtr	ouput0
	cmpl	r7,r1
	jleq	ouput0
	movl	val(r1),r1
ouput0:
	cmpl	r7,r1
	jgtr	outper
	cmpl	r9,r1
	jleq	outper
	cmpl	$0,ostream
	jneq	ouput1
	movl	$3,r11
	.globl	ll_clo
	jsb	ll_clo
	movl	r0,r3
	cmpl	$0,r3
	jneq	ouput7
ouput1:
	cmpl	r7,r1
	jneq	ouput2
	movl	r7,ostream
	jmp	true
ouput2:
	movl	$3,r11
	movzwl	plen(r1),r10
	moval	pname(r1),r0
	.globl	ll_opo
	jsb	ll_opo
	movl	r0,r1
	cmpl	$0,r1
	jneq	ouput8
	movl	$0,ostream
	jmp	true
ouput7:
	movl	r3,r1
ouput8:
	movl	.output,r2
	jmp	errios
outper:
	movl	.output,r2
	jmp	errnaa
	.data
.inchan:
	.long	0
	.set	._inchan,subr0
	.text
	.globl	inchan
inchan:
	movl	istream,r1
	rsb
	.data
.outchan:
	.long	0
	.set	._outchan,subr0
	.text
	.globl	outchan
outchan:
	movl	ostream,r1
	rsb
	.data
.lclose:
	.long	0
	.set	._lclose,subr1
	.text
	.globl	lclose
lclose:
	cmpl	r6,r1
	jleq	closer1
	movl	r1,r11
	.globl	ll_clo
	jsb	ll_clo
	movl	r0,r1
	cmpl	$0,r1
	jeql	ltrue
	movl	.lclose,r2
	jmp	errios
closer1:
	movl	.lclose,r2
	jmp	errnna
	.data
.deletfi:
	.long	0
	.set	._deletfi,subr1
	.text
	.globl	deletfi
deletfi:
	cmpl	r6,r1
	jgtr	deletf1
	cmpl	r7,r1
	jleq	deletf1
	movl	val(r1),r1
deletf1:
	cmpl	r7,r1
	jgtr	deleter1
	cmpl	r9,r1
	jleq	deleter1
	clrl	r1
	cmpl	$0,r1
	jeql	ltrue
	movl	.deletfi,r2
	jmp	errios
deleter1:
	movl	.deletfi,r2
	jmp	errnaa
	.data
.renamfi:
	.long	0
	.set	._renamfi,subr2
	.text
	.globl	renamfi
renamfi:
	cmpl	r6,r1
	jgtr	renamf1
	cmpl	r7,r1
	jleq	renamf1
	movl	val(r1),r1
renamf1:
	cmpl	r7,r1
	jgtr	renamer2
	cmpl	r9,r1
	jleq	renamer2
	cmpl	r6,r1
	jgtr	renamf2
	cmpl	r7,r1
	jleq	renamf2
	movl	val(r2),r2
renamf2:
	cmpl	r7,r2
	jgtr	renamer1
	cmpl	r9,r2
	jleq	renamer1
	clrl	r1
	cmpl	$0,r1
	jeql	ltrue
	movl	.renamfi,r2
	jmp	errios
renamer1:
	movl	r2,r1
renamer2:
	movl	.renamfi,r2
	jmp	errnaa
	.data
.savecor:
	.long	0
	.set	._savecor,subr1
	.text
	.globl	savecor
savecor:
	cmpl	r7,r1
	jgtr	savecerr
	cmpl	r9,r1
	jleq	savecerr
	clrl	r1
	cmpl	$0,r1
	jeql	ltrue
	movl	.savecor,r2
	jmp	errios
savecerr:
	movl	.savecor,r2
	jmp	errnna
	.data
.restcor:
	.long	0
	.set	._restcor,subr1
	.text
	.globl	restcor
restcor:
	cmpl	r7,r1
	jgtr	restcerr
	cmpl	r9,r1
	jleq	restcerr
	clrl	r1
	cmpl	$0,r1
	jeql	ltrue
	movl	.restcor,r2
	jmp	errios
restcerr:
	movl	.restcor,r2
	jmp	errnna
ptint:
	.ascii	"? "
ptcrx:
	.byte
	.byte	0x5c
	.byte	0x0d
	.byte	0x0a
	.byte	0x3f
	.byte	0x20
	.byte	0x00
ptcrlf:
	.byte	0x0d
	.byte	0x0a
ptrub:
	.byte	0x08
	.byte	0x20
	.byte	0x08
	.byte	0x08
	.byte	0x20
	.byte	0x08
	.data
istream:
	.long	0
ostream:
	.long	0
pbuftty:
	.long	0
buftty:
	.space	512
cntrl:
	.byte	0x5e
bufch:
	.byte	0
	.globl	ligne
ligne:
	.space	128
polig:
	.long	0
