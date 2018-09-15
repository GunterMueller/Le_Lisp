  nolist 
  xrefoff
 ttl 'fast floating point dual-binary float (ffpdbf)'
************************************
* (c) copyright 1980 motorla inc.  *
************************************
 
***********************************************************
*                                                         *
*          fast floating point dual-binary to float       *
*                                                         *
*      input:  d6 bit #16 - represents sign (0=positive)  *
*                                           (1=negative)  *
*              d6.w - represents base ten exponent        *
*                     considering d7 a binary integer     *
*              d7 -   binary integer mantissa             *
*                                                         *
*      output: d7 - fast floating point equivalent        *
*                                                         *
*      condition codes:                                   *
*                n - set if result is negative            *
*                z - set if result is zero                *
*                v - set if result overflowed             *
*                c - cleared                              *
*                x - undefined                            *
*                                                         *
*      registers d3 thru d6 destroyed                     *
*                                                         *
*      code size: 164 bytes     stack work area: 4 bytes  *
*                                                         *
*                                                         *
*      floating point range:                              *
*                                                         *
*          fast floating point supports the value zero    *
*          and non-zero values within the following       *
*          bounds -                                       *
*                                                         *
* base 10                                                 *
*                  18                             -20     *
*   9.22337177 x 10   > +number >  5.42101070 x 10        *
*                                                         *
*                  18                             -20     *
*  -9.22337177 x 10   > -number > -2.71050535 x 10        *
*                                                         *
* base 2                                                  *
*                   63                            -63     *
*      .ffffff  x  2   > +number >  .ffffff  x  2         *
*                                                         *
*                   63                            -64     *
*     -.ffffff  x  2   > -number > -.ffffff  x  2         *
*                                                         *
*      precision:                                         *
*                                                         *
*          this conversion results in a 24 bit precision  *
*          with guaranteed error less than or equal to    *
*          one-half least significant bit.                *
*                                                         *
*                                                         *
*      notes:                                             *
*          1) the input formats have been designed for    *
*             ease of parsing text for conversion to      *
*             floating point.  see ffpasf for comments    *
*             describing the method for setup to this     *
*             routine.                                    *
*          2) underflows return a zero without any        *
*             indicators set.                             *
*          3) overflows will return the maximum value     *
*             possible with proper sign and the 'v' bit   *
*             set in the ccr register.                    *
*                                                         *
***********************************************************


*ffpdbf idnt    1,1  ffp dual-binary to float
 
* ?       opt     pcs
 
 entry    ffpdbf      entry point
 
 extern    ffp10tbl     power of ten table
 
 
* normalize the input binary mantissa
ffpdbf   move.l    #32,d5    setup base 2 exponent max
         tst.l     d7        Q test for zero
         beq       fpdrtn    return, no conversion needed
         bmi.s     fpdinm    branch input already normalized
         move.l    #31,d5    prepare for normalize loop
fpdnmi   add.l     d7,d7     shift up by one
         dbmi      d5,fpdnmi decrement and loop if not yet
 
* insure input 10 power index not way off base
fpdinm   cmpi.w     #18,d6    Q way too large
	 bgt       fpdovf    branch overflow
         cmpi.w     #-28,d6   Q way too small
         blt.s     fpdrt0    return zero if underflow
         move.w    d6,d4     copy 10 power index
         neg.w     d4        invert to go proper direction
         muls    #6,d4     times four for index
         move.l    a0,-(a7)  save work address register
         lea       ffp10tbl,a0 load table address
         add.w     0(a0,d4.w),d5 add exponents for multiply
         move.w    d5,d6     save result exponent in d6.w
 
* now perform 32 bit multiply of input with power of ten table
         move.l    2(a0,d4.w),d3 load table mantissa value
         move.l    (a7),a0   restore work register
         move.l    d3,(a7)   now save table mantissa on stack
         move.w    d7,d5     copy input value
         mulu    d3,d5     tablelow x inputlow
         clr.w     d5        low end no longer takes affect
         swap    d5        save intermediate sum
         move.l    #0,d4     create a zero for double precision
         swap    d3        to high table word
         mulu    d7,d3     inputlow x tablehigh
         add.l     d3,d5     add another partial sum
         addx.b    d4,d4     create carry if any
         swap    d7        now to input high
         move.w    d7,d3     copy to work register
         mulu    2(a7),d3  tablelow x inputhigh
         add.l     d3,d5     add another partial
         bcc.s     fpdnoc    branch no carry
         addi.b     #1,d4     add another carry
fpdnoc   move.w    d4,d5     concat high work with low
         swap    d5        and correct positions
         mulu    (a7),d7   tablehigh x inputhigh
         lea       4(a7),a7  clean up stack
         add.l     d5,d7     final partial product
         bmi.s     fpdnon    branch if no need to normalize
         add.l     d7,d7     normalize
         subi.w     #1,d6     adjust exponent
fpdnon   addi.l     #$80,d7   round result to 24 bits
         bcc.s     fpdrok    branch round did not overflow
         roxr.l    #1,d7     adjust back
         addi.w     #1,d6     and increment exponent
fpdrok   moveq     #9,d3     prepare to finalize exponent to 7 bits
         move.w    d6,d4     save sign of exponent
         asl.w     d3,d6     force 7 bit precision
         bvs.s     fpdxov    branch exponent overflow
         eori.w     #$8000,d6 exponent back from 2's-complement
         lsr.l     d3,d6     place into low byte with sign
         move.b    d6,d7     insert into result
         beq.s     fpdrt0    return zero if exponent zero
fpdrtn   rts                 return to caller
 
* return zero for underflow
fpdrt0   moveq     #0,d7     return zero
         rts                 return to caller
 
* exponent overflow/underflow
fpdxov   tst.w     d4        test original sign
         bmi.s     fpdrt0    branch underflow to return zero
fpdovf   moveq     #-1,d7    create all ones
         swap    d6        sign to low bit
         roxr.b    #1,d6     sign to x bit
         roxr.b    #1,d7     sign into highest possible result
         tst.b     d7        clear carry bit
*        or.w      #$0002,ccr set overflow on
         dc.l      $003c0002 ****assembler error****
         rts                 return to caller with overflow
 
 
         end
 
