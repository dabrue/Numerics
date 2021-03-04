*DECK DBSK0E
      DOUBLE PRECISION FUNCTION DBSK0E (X)
C***BEGIN PROLOGUE  DBSK0E
C***PURPOSE  Compute the exponentially scaled modified (hyperbolic)
C            Bessel function of the third kind of order zero.
C***LIBRARY   SLATEC (FNLIB)
C***CATEGORY  C10B1
C***TYPE      DOUBLE PRECISION (BESK0E-S, DBSK0E-D)
C***KEYWORDS  EXPONENTIALLY SCALED, FNLIB, HYPERBOLIC BESSEL FUNCTION,
C             MODIFIED BESSEL FUNCTION, ORDER ZERO, SPECIAL FUNCTIONS,
C             THIRD KIND
C***AUTHOR  Fullerton, W., (LANL)
C***DESCRIPTION
C
C DBSK0E(X) computes the double precision exponentially scaled
C modified (hyperbolic) Bessel function of the third kind of
C order zero for positive double precision argument X.
C
C Series for BK0        on the interval  0.          to  4.00000E+00
C                                        with weighted error   3.08E-33
C                                         log weighted error  32.51
C                               significant figures required  32.05
C                                    decimal places required  33.11
C
C Series for AK0        on the interval  1.25000E-01 to  5.00000E-01
C                                        with weighted error   2.85E-32
C                                         log weighted error  31.54
C                               significant figures required  30.19
C                                    decimal places required  32.33
C
C Series for AK02       on the interval  0.          to  1.25000E-01
C                                        with weighted error   2.30E-32
C                                         log weighted error  31.64
C                               significant figures required  29.68
C                                    decimal places required  32.40
C
C***REFERENCES  (NONE)
C***ROUTINES CALLED  D1MACH, DBESI0, DCSEVL, INITDS, ZErMsg
C***REVISION HISTORY  (YYMMDD)
C   770701  DATE WRITTEN
C   890531  Changed all specific intrinsics to generic.  (WRB)
C   890531  REVISION DATE from Version 3.2
C   891214  Prologue converted to Version 4.0 format.  (BAB)
C   900315  CALLs to XERROR changed to CALLs to ZErMsg.  (THJ)
C***END PROLOGUE  DBSK0E
      DOUBLE PRECISION X, BK0CS(16), AK0CS(38), AK02CS(33),
     1  XSML, Y, D1MACH, DCSEVL, DBESI0
      LOGICAL FIRST
      SAVE BK0CS, AK0CS, AK02CS, NTK0, NTAK0, NTAK02, XSML, FIRST
      DATA BK0CS(  1) / -.3532739323 3902768720 1140060063 153 D-1    /
      DATA BK0CS(  2) / +.3442898999 2462848688 6344927529 213 D+0    /
      DATA BK0CS(  3) / +.3597993651 5361501626 5721303687 231 D-1    /
      DATA BK0CS(  4) / +.1264615411 4469259233 8479508673 447 D-2    /
      DATA BK0CS(  5) / +.2286212103 1194517860 8269830297 585 D-4    /
      DATA BK0CS(  6) / +.2534791079 0261494573 0790013428 354 D-6    /
      DATA BK0CS(  7) / +.1904516377 2202088589 7214059381 366 D-8    /
      DATA BK0CS(  8) / +.1034969525 7633624585 1008317853 089 D-10   /
      DATA BK0CS(  9) / +.4259816142 7910825765 2445327170 133 D-13   /
      DATA BK0CS( 10) / +.1374465435 8807508969 4238325440 000 D-15   /
      DATA BK0CS( 11) / +.3570896528 5083735909 9688597333 333 D-18   /
      DATA BK0CS( 12) / +.7631643660 1164373766 7498666666 666 D-21   /
      DATA BK0CS( 13) / +.1365424988 4407818590 8053333333 333 D-23   /
      DATA BK0CS( 14) / +.2075275266 9066680831 9999999999 999 D-26   /
      DATA BK0CS( 15) / +.2712814218 0729856000 0000000000 000 D-29   /
      DATA BK0CS( 16) / +.3082593887 9146666666 6666666666 666 D-32   /
      DATA AK0CS(  1) / -.7643947903 3279414240 8297827008 8 D-1      /
      DATA AK0CS(  2) / -.2235652605 6998190520 2309555079 1 D-1      /
      DATA AK0CS(  3) / +.7734181154 6938582353 0061817404 7 D-3      /
      DATA AK0CS(  4) / -.4281006688 8860994644 5214643541 6 D-4      /
      DATA AK0CS(  5) / +.3081700173 8629747436 5001482666 0 D-5      /
      DATA AK0CS(  6) / -.2639367222 0096649740 6744889272 3 D-6      /
      DATA AK0CS(  7) / +.2563713036 4034692062 9408826574 2 D-7      /
      DATA AK0CS(  8) / -.2742705549 9002012638 5721191524 4 D-8      /
      DATA AK0CS(  9) / +.3169429658 0974995920 8083287340 3 D-9      /
      DATA AK0CS( 10) / -.3902353286 9621841416 0106571796 2 D-10     /
      DATA AK0CS( 11) / +.5068040698 1885754020 5009212728 6 D-11     /
      DATA AK0CS( 12) / -.6889574741 0078706795 4171355798 4 D-12     /
      DATA AK0CS( 13) / +.9744978497 8259176913 8820133683 1 D-13     /
      DATA AK0CS( 14) / -.1427332841 8845485053 8985534012 2 D-13     /
      DATA AK0CS( 15) / +.2156412571 0214630395 5806297652 7 D-14     /
      DATA AK0CS( 16) / -.3349654255 1495627721 8878205853 0 D-15     /
      DATA AK0CS( 17) / +.5335260216 9529116921 4528039260 1 D-16     /
      DATA AK0CS( 18) / -.8693669980 8907538076 3962237883 7 D-17     /
      DATA AK0CS( 19) / +.1446404347 8622122278 8776344234 6 D-17     /
      DATA AK0CS( 20) / -.2452889825 5001296824 0467875157 3 D-18     /
      DATA AK0CS( 21) / +.4233754526 2321715728 2170634240 0 D-19     /
      DATA AK0CS( 22) / -.7427946526 4544641956 9534129493 3 D-20     /
      DATA AK0CS( 23) / +.1323150529 3926668662 7796746240 0 D-20     /
      DATA AK0CS( 24) / -.2390587164 7396494513 3598146559 9 D-21     /
      DATA AK0CS( 25) / +.4376827585 9232261401 6571255466 6 D-22     /
      DATA AK0CS( 26) / -.8113700607 3451180593 3901141333 3 D-23     /
      DATA AK0CS( 27) / +.1521819913 8321729583 1037815466 6 D-23     /
      DATA AK0CS( 28) / -.2886041941 4833977702 3595861333 3 D-24     /
      DATA AK0CS( 29) / +.5530620667 0547179799 9261013333 3 D-25     /
      DATA AK0CS( 30) / -.1070377329 2498987285 9163306666 6 D-25     /
      DATA AK0CS( 31) / +.2091086893 1423843002 9632853333 3 D-26     /
      DATA AK0CS( 32) / -.4121713723 6462038274 1026133333 3 D-27     /
      DATA AK0CS( 33) / +.8193483971 1213076401 3568000000 0 D-28     /
      DATA AK0CS( 34) / -.1642000275 4592977267 8075733333 3 D-28     /
      DATA AK0CS( 35) / +.3316143281 4802271958 9034666666 6 D-29     /
      DATA AK0CS( 36) / -.6746863644 1452959410 8586666666 6 D-30     /
      DATA AK0CS( 37) / +.1382429146 3184246776 3541333333 3 D-30     /
      DATA AK0CS( 38) / -.2851874167 3598325708 1173333333 3 D-31     /
      DATA AK02CS(  1) / -.1201869826 3075922398 3934621245 2 D-1      /
      DATA AK02CS(  2) / -.9174852691 0256953106 5256107571 3 D-2      /
      DATA AK02CS(  3) / +.1444550931 7750058210 4884387805 7 D-3      /
      DATA AK02CS(  4) / -.4013614175 4357097286 7102107787 9 D-5      /
      DATA AK02CS(  5) / +.1567831810 8523106725 9034899033 3 D-6      /
      DATA AK02CS(  6) / -.7770110438 5217377103 1579975446 0 D-8      /
      DATA AK02CS(  7) / +.4611182576 1797178825 3313052958 6 D-9      /
      DATA AK02CS(  8) / -.3158592997 8605657705 2666580330 9 D-10     /
      DATA AK02CS(  9) / +.2435018039 3650411278 3588781432 9 D-11     /
      DATA AK02CS( 10) / -.2074331387 3983478977 0985337350 6 D-12     /
      DATA AK02CS( 11) / +.1925787280 5899170847 4273650469 3 D-13     /
      DATA AK02CS( 12) / -.1927554805 8389561036 0034718221 8 D-14     /
      DATA AK02CS( 13) / +.2062198029 1978182782 8523786964 4 D-15     /
      DATA AK02CS( 14) / -.2341685117 5792424026 0364019507 1 D-16     /
      DATA AK02CS( 15) / +.2805902810 6430422468 1517882845 8 D-17     /
      DATA AK02CS( 16) / -.3530507631 1618079458 1548246357 3 D-18     /
      DATA AK02CS( 17) / +.4645295422 9351082674 2421633706 6 D-19     /
      DATA AK02CS( 18) / -.6368625941 3442664739 2205346133 3 D-20     /
      DATA AK02CS( 19) / +.9069521310 9865155676 2234880000 0 D-21     /
      DATA AK02CS( 20) / -.1337974785 4236907398 4500531199 9 D-21     /
      DATA AK02CS( 21) / +.2039836021 8599523155 2208896000 0 D-22     /
      DATA AK02CS( 22) / -.3207027481 3678405000 6086997333 3 D-23     /
      DATA AK02CS( 23) / +.5189744413 6623099636 2635946666 6 D-24     /
      DATA AK02CS( 24) / -.8629501497 5405721929 6460799999 9 D-25     /
      DATA AK02CS( 25) / +.1472161183 1025598552 0803840000 0 D-25     /
      DATA AK02CS( 26) / -.2573069023 8670112838 1235199999 9 D-26     /
      DATA AK02CS( 27) / +.4601774086 6435165873 7664000000 0 D-27     /
      DATA AK02CS( 28) / -.8411555324 2010937371 3066666666 6 D-28     /
      DATA AK02CS( 29) / +.1569806306 6353689393 0154666666 6 D-28     /
      DATA AK02CS( 30) / -.2988226453 0057577889 7919999999 9 D-29     /
      DATA AK02CS( 31) / +.5796831375 2168365206 1866666666 6 D-30     /
      DATA AK02CS( 32) / -.1145035994 3476813321 5573333333 3 D-30     /
      DATA AK02CS( 33) / +.2301266594 2496828020 0533333333 3 D-31     /
      DATA FIRST /.TRUE./
C***FIRST EXECUTABLE STATEMENT  DBSK0E
      IF (FIRST) THEN
         ETA = 0.1*REAL(D1MACH(3))
         NTK0 = INITDS (BK0CS, 16, ETA)
         NTAK0 = INITDS (AK0CS, 38, ETA)
         NTAK02 = INITDS (AK02CS, 33, ETA)
         XSML = SQRT(4.0D0*D1MACH(3))
      ENDIF
      FIRST = .FALSE.
C
      IF (X .LE. 0.D0) CALL ZErMsg ('SLATEC', 'DBSK0E',
     +   'X IS ZERO OR NEGATIVE', 2, 2)
      IF (X.GT.2.0D0) GO TO 20
C
      Y = 0.D0
      IF (X.GT.XSML) Y = X*X
      DBSK0E = EXP(X)*(-LOG(0.5D0*X)*DBESI0(X) - 0.25D0 +
     1  DCSEVL (.5D0*Y-1.D0, BK0CS, NTK0))
      RETURN
C
 20   IF (X.LE.8.D0) DBSK0E = (1.25D0 + DCSEVL ((16.D0/X-5.D0)/3.D0,
     1  AK0CS, NTAK0))/SQRT(X)
      IF (X.GT.8.D0) DBSK0E = (1.25D0 +
     1  DCSEVL (16.D0/X-1.D0, AK02CS, NTAK02))/SQRT(X)
C
      RETURN
      END
