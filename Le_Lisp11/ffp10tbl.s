  nolist 
  xrefoff
 ttl 'fast floating point power of ten table (ffp10tbl)'
************************************
* (c) copyright 1980 motorla inc.  *
************************************
 
 
*****************************************
*         power of ten table            *
*                                       *
*  each entry corresponds to a floating *
*  point power of ten with a 16 bit     *
*  exponent and 32 bit mantissa.        *
*  this table is used to insure         *
*  precise conversions to and from      *
*  floating point and external formats. *
*  ths is used in routines "ffpdbf" and *
*  "ffpfasc".                           *
*                                       *
*          code size: 288 bytes         *
*                                       *
*****************************************


*ffp10tbl idnt    1,1  ffp power of ten table
 
 entry      ffp10tbl    entry point
 extern      ffpcpyrt    copyright notice
 
 
         dc.w      64        10**19
         dc.l      $8ac72305
         dc.w      60        10**18
         dc.l      $de0b6b3a
         dc.w      57        10**17
         dc.l      $16345785<<3+7
         dc.w      54        10**16
         dc.l      $2386f26f<<2+3
         dc.w      50        10**15
         dc.l      $38d7ea4c<<2+2
         dc.w      47        10**14
         dc.l      $5af3107a<<1+1
         dc.w      44        10**13
         dc.l      $9184e72a
         dc.w      40        10**12
         dc.l      $e8d4a510
         dc.w      37        10**11
         dc.l      $174876e8<<3
         dc.w      34        10**10
         dc.l      $2540be40<<2
         dc.w      30        10**9
         dc.l      1000000000<<2
         dc.w      27        10**8
         dc.l      100000000<<5
         dc.w      24        10**7
         dc.l      10000000<<8
         dc.w      20        10**6
         dc.l      1000000<<12
         dc.w      17        10**5
         dc.l      100000<<15
         dc.w      14        10**4
         dc.l      10000<<18
         dc.w      10        10**3
         dc.l      1000<<22
         dc.w      7         10**2
         dc.l      100<<25
         dc.w      4         10**1
         dc.l      10<<28
ffp10tbl dc.w      1         10**0
         dc.l      1<<31
         dc.w      0-3        10**-1
         dc.l      $cccccccd
         dc.w      0-6        10**-2
         dc.l      $a3d70a3d
         dc.w      0-9        10**-3
         dc.l      $83126e98
         dc.w      0-13       10**-4
         dc.l      $d1b71759
         dc.w      0-16       10**-5
         dc.l      $a7c5ac47
         dc.w      0-19       10**-6
         dc.l      $8637bd06
         dc.w      0-23       10**-7
         dc.l      $d6bf94d6
         dc.w      0-26       10**-8
         dc.l      $abcc7712
         dc.w      0-29       10**-9
         dc.l      $89705f41
         dc.w      0-33       10**-10
         dc.l      $dbe6fecf
         dc.w      0-36       10**-11
         dc.l      $afebff0c
         dc.w      0-39       10**-12
         dc.l      $8cbccc09
         dc.w      0-43       10**-13
         dc.l      $e12e1342
         dc.w      0-46       10**-14
         dc.l      $b424dc35
         dc.w      0-49       10**-15
         dc.l      $901d7cf7
         dc.w      0-53       10**-16
         dc.l      $e69594bf
         dc.w      0-56       10**-17
         dc.l      $b877aa32
         dc.w      0-59       10**-18
         dc.l      $9392ee8f
         dc.w      0-63       10**-19
         dc.l      $ec1e4a7e
         dc.w      0-66       10**-20
         dc.l      $bce50865
         dc.w      0-69       10**-21
         dc.l      $971da050
         dc.w      0-73       10**-22
         dc.l      $f1c90081
         dc.w      0-76       10**-23
         dc.l      $c16d9a01
         dc.w      0-79       10**-24
         dc.l      $9abe14cd
         dc.w      0-83       10**-25
         dc.l      $f79687ae
         dc.w      0-86       10**-26
         dc.l      $c6120625
         dc.w      0-89       10**-27
         dc.l      $9e74d1b8
         dc.w      0-93       10**-28
         dc.l      $fd87b5f3
 
         end
