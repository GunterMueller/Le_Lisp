  nolist 
  xrefoff
 ttl 'fast floating point multiply (ffpmul)'
*******************************************
* (c)  copyright 1980 by motorola inc.    *
*******************************************
 
********************************************
*          ffpmul  subroutine              *
*                                          *
* input:                                   *
*          d6 - floating point multiplier  *
*          d7 - floating point multiplican *
*                                          *
* output:                                  *
*          d7 - floating point result      *
*                                          *
*                                          *
* condition codes:                         *
*          n - set if result negative      *
*          z - set if result is zero       *
*          v - set if overflow occurred    *
*          c - undefined                   *
*          x - undefined                   *
*                                          *
* registers d3 thru d5 are volatile        *
*                                          *
* size: 122 bytes    stack work: 0 bytes   *
*                                          *
* notes:                                   *
*   1) multipier unaltered (d6).           *
*   2) underflows return zero with no      *
*      indicator set.                      *
*   3) overflows will return the maximum   *
*      value with the proper sign and the  *
*      'v' bit set in the ccr.             *
*   4) this version of the multiply has a  *
*      slight error due to truncation      *
*      of .00390625 in the least signific- *
*      ant bit.  this amounts to an average*
*      of 1 incorrect least  significant   *
*      bit result for every 512 multiplies.*
*                                          *
*  times: (8mhz no wait states assumed)    *
* arg1 zero            5.750 microseconds  *
* arg2 zero            3.750 microseconds  *
* minimum time others 38.000 microseconds  *
* maximum time others 51.750 microseconds  *
* average others      44.125 microseconds  *
*                                          *
********************************************


*ffpmul idnt  1,1  ffp multiply
 
 entry   ffpmul     entry point
 extern  ffpcpyrt   copyright notice
 
 
* ffpmul subroutine entry point
ffpmul move.b d7,d5     prepare sign/exponent work       4
       beq.s  ffmrtn    return if result already zero    8/10
       move.b d6,d4     copy arg1 sign/exponent          4
       beq.s  ffmrt0    return zero if arg1=0            8/10
       add.w  d5,d5     shift left by one                4
       add.w  d4,d4     shift left by one                4
       moveq  #$80,d3  prepare exponent modifier ($80)  4
       eor.b  d3,d4     adjust arg1 exponent to binary   4
       eor.b  d3,d5     adjust arg2 exponent to binary   4
       add.b  d4,d5     add exponents                    4
       bvs.s  ffmouf    branch if overflow/underflow     8/10
       move.b d3,d4     overlay $80 constant into d4     4
       eor.w  d4,d5     d5 now has sign and exponent     4
       ror.w  #1,d5     move to low 8 bits               8
       clr.b  d7        clear s+exp out of arg2          4
       move.l d7,d3     prepare arg2 for multiply        4
       swap d3        use top two significant bytes    4
       move.l d6,d4     copy arg1                        4
       clr.b  d4        clear low byte (s+exp)           4
       mulu d4,d3     a3 x b1b2                        38-54 (46)
       swap d4        to arg1 high two bytes           4
       mulu d7,d4     b3 x a1a2                        38-54 (46)
       add.l  d3,d4     add partial products r3r4r5      8
       clr.w  d4        clear low end runoff             4
       addx.b d4,d4     shift in carry if any            4
       swap d4        put carry into high word         4
       swap d7        now top of arg2                  4
       swap d6        and top of arg1                  4
       mulu d6,d7     a1a2 x b1b2                      40-70 (54)
       swap d6        restore arg1                     4 
       add.l  d4,d7     add partial products             8
       bpl.s  ffmnor    branch if must normalize         8/10
ffmcon addi.l  #$80,d7   round up (cannot overflow)       16
       move.b d5,d7     insert sign and exponent         4
       beq.s  ffmrt0    return zero if zero exponent     8/10
ffmrtn rts              return to caller                 16
 
* must normalize result
ffmnor subi.b   #1,d5    bump exponent down by one        4
       bvs.s   ffmrt0   return zero if underflow         8/10
       bcs.s   ffmrt0   return zero if sign inverted     8/10
       moveq   #$40,d4  rounding factor                  4
       add.l   d4,d7    add in rounding factor           8
       add.l   d7,d7    shift to normalize               8
       bcc.s   ffmcln   return normalized number         8/10
       roxr.l  #1,d7    rounding forced carry in top bit 10
       addi.b   #1,d5    undo normalize attempt           4
ffmcln move.b  d5,d7    insert sign and exponent         4
       beq.s   ffmrt0   return zero if exponent zero     8/10
       rts              return to caller                 16
 
* arg1 zero
ffmrt0 move.l #0,d7     return zero                      4
       rts              return to caller                 16
 
* overflow or underflow exponent
ffmouf bpl.s  ffmrt0    branch if underflow to give zero 8/10
       eor.b  d6,d7     calculate proper sign            4
       ori.l   #$ffffff7f,d7 force highest value possible 16
       tst.b  d7        set sign in return code
*        ori.b   #$02,ccr                            set overflow bit
       dc.l   $003c0002 ****sick assembler****           20
       rts              return to caller                 16
 
       end
