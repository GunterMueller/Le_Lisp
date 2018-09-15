  nolist 
  xrefoff
 ttl 'fast floating point float to ascii (ffpfpa)'
***************************************
* (c) copyright 1980 by motorola inc. *
***************************************
 
*******************************************************
*                     ffpfpa                          *
*                 float to ascii                      *
*                                                     *
*    input:  d7 - floating point number               *
*                                                     *
*    output: d7 - the base ten exponent in binary     *
*                 for the returned format             *
*            sp - decremented by 14 and               *
*                 pointing to the converted           *
*                 number in ascii format              *
*                                                     *
*            all other registers unaffected           *
*                                                     *
*    condition codes:                                 *
*            n - set if the result is negative        *
*            z - set if the result is zero            *
*            v - cleared                              *
*            c - cleared                              *
*            x - undefined                            *
*                                                     *
*   code size: 192 bytes   stack work area: 42 bytes  *
*                                                     *
*                                                     *
*            {s}{'.'}{dddddddd}{'e'}{s}{dd}           *
*            <     fraction   >< exponent >           *
*                                                     *
*        where  s - sign of mantissa or exponent      *
*                   ('+' or '-')                      *
*               d - decimal digit                     *
*                                                     *
*        stack offset of result  s.ddddddddesdd       *
*        after return            00000000001111       *
*                                01234567890123       *
*                                                     *
*                                                     *
*        examples   +.12000000e+03  120               *
*                   +.31415927e+01  pi                *
*                   +.10000000e-01  one-hundredth     *
*                   -.12000000e+03  minus 120         *
*                                                     *
*     notes:                                          *
*       1) the binary base 10 exponent is returned    *
*          in d7 to facilitate conversions to         *
*          other formats.                             *
*       2) even though eight digits are returned, the *
*          precision available is only 7.167 digits.  *
*          rounding should be performed when less     *
*          than eight digits are actually utilized    *
*          in the mantissa.                           *
*       3) the stack is lowered by 14 bytes by this   *
*          routine.  the return address to the caller *
*          is replaced by a portion of the results.   *
*                                                     *
*  time: (8mhz no wait states assumed)                *
*        330 microseconds converting the sample float *
*        value of 55.55 to ascii.                     *
*                                                     *
*******************************************************


*ffpfpa   idnt      1,1  ffp float to ascii
 
 
 entry      ffpfpa    entry point
 extern       ffp10tbl,ffpcpyrt  power of ten table
 
* stack definition
stkold   equ       48       previous callers stack pointer
stkexp   equ       46       exponent
stkexps  equ       45       exponents sign
stkltre  equ       44       'e'
stkmant  equ       36       mantissa
stkper   equ       35       '.'
stkmans  equ       34       mantissa's sign
stknewrt equ       30       new return position
stkrtcc  equ       28       return condition code
stksave  equ       0         register save area
 
 
ffpfpa   lea       0-10(a7),a7 set stack to new location
	 move.l    10(a7),-(a7)   save return
         tst.b     d7        test value
         move.w    sr,-(a7)  save for return code
         movem.l   d2-d6/a0/a1,-(a7)  save work address register
 
* adjust for zero value
         bne.s     fpfnot0   branch no zero input
	 move.l    #$41,d7   setup psuedo integer exponent
**       move.l    #$42,d7   #bz:  .345 e01  -->  3.45 e00
 
* setup mantissa's sign
fpfnot0  move.w    #' .',stkmans(a7) insert plus and decimal
         move.b    d7,d6     copy sign+exponent
         bpl.s     fpfpls    branch if plus
	 move.b    #'-',stkmans(a7) change plus to minus
 
* start search for magnitude in base 10 power table
fpfpls   add.b     d6,d6     sign out of picture
         move.b    #$80,d7   set rouding factor for search
         eor.b     d7,d6     convert exponent to binary
         ext.w     d6        exponent to word
         asr.w     #1,d6     back from sign extractment
         move.l    #1,d3     start base ten computation
         lea       ffp10tbl,a0 start at ten to the zero
         cmp.w     (a0),d6   compare to table
         blt.s     fpfmin    branch minus exponent
         bgt.s     fpfplu    branch plus exponent
fpfeqe   cmp.l     2(a0),d7  equal so compare mantissa's
         bcc.s     fpffnd    branch if input greater or equal than table
fpfbck   adda.w     #6,a0     to next lower entry in table
         subi.w     #1,d3     decrement base 10 exponent
         bra.s     fpffnd    branch power of ten found
 
* exponent is higher than table
fpfplu   lea       0-6(a0),a0 to next higher entry
         addi.w     #1,d3     increment power of ten
         cmp.w     (a0),d6   test new magnitude
         bgt.s     fpfplu    loop if still greater
         beq.s     fpfeqe    branch equal exponent
         bra.s     fpfbck    back to lower and found
 
* exponent is lower than table
fpfmin   lea       6(a0),a0  to next lower entry
         subi.w     #1,d3     decrement power of ten by one
         cmp.w     (a0),d6   test new magnitude
         blt.s     fpfmin    loop if still less than
         beq.s     fpfeqe    branch equal exponent
 
* convert the exponent to ascii
fpffnd   move.l    #'e+00',stkltre(a7) setup exponent pattern
	 move.w  d3,d2     Q exponent positive
** subq.w #1,d2                 #bz:  .345 e01  -->  3.45 e00
	 tst  d2
         bpl.s     fpfpex    branch if so
         neg.w     d2        absolutize
         addi.b     #2,stkexps(a7) turn to minus sign
fpfpex   cmpi.w     #10,d2    Q ten or greater
         bcs.s     fpfgen    branch if not
         addi.b     #1,stkexp(a7) change zero to a one
         subi.w     #10,d2    adjust to decimal
fpfgen   or.b      d2,stkexp+1(a7) fill in low digit
 
* generate the mantissa in ascii a0->table  d7=binary mantissa
* d5 - mantissa from table       d6.w = binary exponent
* d4 - shift and digit builder   d2 = dbra mantissa digit count
* a1->mantissa stack position
         move.l    #7,d2     count for eight digits
         lea       stkmant(a7),a1 point to mantissa start
         tst.l     d7        Q zero to convert
         bpl.s     fpfzro    branch if so to not round
         tst.b     5(a0)     Q 24 bit precise in table
         bne.s     fpfnxi    branch if no trailing zeroes
fpfzro   clr.b     d7        clear adjustment for .5 lsb precision
fpfnxi   move.w    d6,d4     copy binary exponent
         sub.w     (a0)+,d4  find normalization factor
         move.l    (a0)+,d5  load mantissa from table
         lsr.l     d4,d5     adjust to same exponent
         move.l    #9,d4     start at nine and count down
fpfinc   sub.l     d5,d7     subtract for another count
         dbcs      d4,fpfinc decrement and branch if over
         bcs.s     fpfnim    branch no imprecision
         clr.b     d4        correct rare underflow due to table imprecision
fpfnim   add.l     d5,d7     make up for over subtraction
         subi.b     #9,d4     correct value
         neg.b     d4        to between 0 and 9 binary
         ori.b      #'0',d4   convert to ascii
         move.b    d4,(a1)+  insert into ascii mantissa pattern
         dbra      d2,fpfnxi branch if more digits to go

*   #bz:  .345 e01  -->  3.45 e00
**  move.b  stkper+1(a7),stkper(a7)
**  move.b  #'.',stkper+1(a7)

 
* return with base ten exponent binary in d7
         move.w    d3,d7     to d7
         ext.l     d7        to full word
         movem.l   (a7)+,d2-d6/a0/a1 restore work registers
         rtr       return with proper condition code
 
 
         end
 
