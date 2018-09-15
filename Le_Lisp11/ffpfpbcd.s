  nolist 
  xrefoff
 ttl 'fast floating point float to bcd (ffpfpbcd)'
***************************************
* (c) copyright 1980 by motorola inc. *
***************************************
 
*******************************************************
*                   ffpfpbcd                          *
*                 float to bcd                        *
*                                                     *
*    input:  d7 - floating point number               *
*                                                     *
*    output: sp - decremented by 8 and                *
*                 pointing to the converted           *
*                 number in bcd format as described   *
*                 below -                             *
*                                                     *
*                mmmm s e s b                         *
*                                                     *
*        where  m - four bytes of bcd, each with two  *
*                   digits of the mantissa (8 digits) *
*               s - sign of mantissa ($00 +, $ff -)   *
*               e - bcd byte for two digit exponent   *
*               s - sign of exponent ($00 +, $ff -)   *
*               b - one byte binary 2's complement    *
*                   representation of the exponent    *
*                                                     *
*        stack offset of result  mmmmsesb             *
*        after return            00000000             *
*                                01234567             *
*                                                     *
*                    m m m m s e s b                  *
*        examples  $1200000000030003 +120             *
*                  $3141592700010001 3.14159          *
*                  $12000000ff030003 -120             *
*                  $10000000ff10000a -1,000,000,000   *
*                  $100000000002fffe .001 (.1e-2)     *
*                    m m m m s e s b                  *
*                                                     *
*    condition codes:                                 *
*            n - set if the result is negative        *
*            z - set if the result is zero            *
*            v - cleared                              *
*            c - cleared                              *
*            x - undefined                            *
*                                                     *
*    all registers are transparent                    *
*                                                     *
*    code size: 168 bytes     stack work: 72 bytes    *
*                                                     *
*     notes:                                          *
*       1) even though eight digits are returned, the *
*          precision available is only 7.167 digits.  *
*          rounding should be performed when less     *
*          than the full eight digits are actually    *
*          used in the mantissa.                      *
*       2) the stack is lowered by 8 bytes by this    *
*          routine.  the return address to the caller *
*          is replaced by a portion of the results.   *
*       3) the binary base 10 exponent is returned    *
*          to facilitate conversions to other formats *
*                                                     *
*   time: (8mhz no wait states assumed)               *
*        approximately 330 microseconds converting    *
*        the float value 55.55 to bcd.                *
*                                                     *
*******************************************************


*ffpfpbcd idnt      1,1  ffp float to bcd
 
 entry      ffpfpbcd            entry point
 extern      ffp10tbl,ffpcpyrt power of ten table
 
* ?          opt       pcs
 
 
* stack definition
stkold   equ       46        previous callers stack pointer
stkbexp  equ       45        exponent in binary
stkexps  equ       44        exponents sign
stkexp   equ       43        exponent in bcd
stkmans  equ       42        mantissa's sign
stkmant  equ       38        mantissa in bcd
stknewrt equ       34        new return position
stkrtcc  equ       32        return condition code
stksave  equ       0         register save area
 
 
ffpfpbcd lea       0-4(a7),a7 set stack to new location
	 move.l    4(a7),-(a7)   save return
         tst.b     d7        test value
         move.w    sr,-(a7)  save for return code
         movem.l   d2-d7/a0/a1,-(a7)  save work address register
 
* adjust for zero value
         bne.s     fpfnot0   branch no zero input
         move.l    #$41,d7   setup psuedo integer exponent
 
* setup mantissa's sign
fpfnot0  move.b    d7,d6     copy sign+exponent
         smi     stkmans(a7) set results sign
 
* start search for magnitude in base 10 power table
         add.b     d6,d6     sign out of picture
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
 
* convert the exponent to bcd
fpffnd   move.b    d3,stkbexp(a7) fill in binary exponent
         smi     stkexps(a7) and set exponents sign
         bpl.s     fpfpex    branch if positive
         neg.w     d3        absolutize
fpfpex   clr.b     d2        create a zeroter
         add.b     d2,d2     clear x bit
         abcd    d3,d2     convert to bcd
         move.b    d2,stkexp(a7) return exponent in bcd
 
* generate the mantissa in ascii a0->table  d7=binary mantissa
* d5 - mantissa from table       d6.w = binary exponent
* d4 - shift and digit builder   d2 = dbra mantissa digit count
* a1->mantissa stack position
         move.l    #7,d2     count for eight digits
         move.l    #0,d3     zero bcd longword build value
         tst.l     d7        Q zero to convert
         bpl.s     fpfzro    branch if so to not round
         tst.b     5(a0)     Q 24 bit precise in table
         bne.s     fpfnxi    branch if no trailing zeroes
fpfzro   clr.b     d7        clear adjustment for .5 lsb precision
fpfnxi   asl.l     #4,d3     shift for next digit generation
         move.w    d6,d4     copy binary exponent
         sub.w     (a0)+,d4  find normalization factor
         move.l    (a0)+,d5  load mantissa from table
         lsr.l     d4,d5     adjust to same exponent
         move.l    #9,d4     start at nine and count down
fpfinc   sub.l     d5,d7     subtract for another count
         dbcs      d4,fpfinc decrement and branch if over
         bcs.s     fpfnir    branch proper execution
         clr.b     d4        correct rare error due to table imprecision
fpfnir   add.l     d5,d7     make up for over subtraction
         subi.b     #9,d4     correct value
         neg.b     d4        to between 0 and 9 binary
         or.b      d4,d3     insert as next digit
         dbra      d2,fpfnxi branch if more digits to go
         move.l    d3,stkmant(a7) store mantissa bcd result
 
* return
         movem.l   (a7)+,d2-d7/a0/a1 restore work registers
         rtr       return with proper condition code
 
 
         end
 
