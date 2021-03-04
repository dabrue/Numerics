*DECK DBSK1E
      DOUBLE PRECISION FUNCTION DBSK1E (X)
C***BEGIN PROLOGUE  DBSK1E
C***PURPOSE  Compute the exponentially scaled modified (hyperbolic)
C            Bessel function of the third kind of order one.
C***LIBRARY   SLATEC (FNLIB)
C***CATEGORY  C10B1
C***TYPE      DOUBLE PRECISION (BESK1E-S, DBSK1E-D)
C***KEYWORDS  EXPONENTIALLY SCALED, FNLIB, HYPERBOLIC BESSEL FUNCTION,
C             MODIFIED BESSEL FUNCTION, ORDER ONE, SPECIAL FUNCTIONS,
C             THIRD KIND
C***AUTHOR  Fullerton, W., (LANL)
C***DESCRIPTION
C
C DBSK1E(S) computes the double precision exponentially scaled
C modified (hyperbolic) Bessel function of the third kind of order
C one for positive double precision argument X.
C
C Series for BK1        on the interval  0.          to  4.00000E+00
C                                        with weighted error   9.16E-32
C                                         log weighted error  31.04
C                               significant figures required  30.61
C                                    decimal places required  31.64
C
C Series for AK1        on the interval  1.25000E-01 to  5.00000E-01
C                                        with weighted error   3.07E-32
C                                         log weighted error  31.51
C                               significant figures required  30.71
C                                    decimal places required  32.30
C
C Series for AK12       on the interval  0.          to  1.25000E-01
C                                        with weighted error   2.41E-32
C                                         log weighted error  31.62
C                               significant figures required  30.25
C                                    decimal places required  32.38
C
C***REFERENCES  (NONE)
C***ROUTINES CALLED  D1MACH, DBESI1, DCSEVL, INITDS, ZErMsg
C***REVISION HISTORY  (YYMMDD)
C   770701  DATE WRITTEN
C   890531  Changed all specific intrinsics to generic.  (WRB)
C   890531  REVISION DATE from Version 3.2
C   891214  Prologue converted to Version 4.0 format.  (BAB)
C   900315  CALLs to XERROR changed to CALLs to ZErMsg.  (THJ)
C***END PROLOGUE  DBSK1E
      DOUBLE PRECISION X, BK1CS(16), AK1CS(38), AK12CS(33), XMIN,
     1  XSML, Y, D1MACH, DCSEVL, DBESI1
      LOGICAL FIRST
      SAVE BK1CS, AK1CS, AK12CS, NTK1, NTAK1, NTAK12, XMIN, XSML,
     1  FIRST
      DATA BK1CS(  1) / +.2530022733 8947770532 5311208685 33 D-1     /
      DATA BK1CS(  2) / -.3531559607 7654487566 7238316918 01 D+0     /
      DATA BK1CS(  3) / -.1226111808 2265714823 4790679300 42 D+0     /
      DATA BK1CS(  4) / -.6975723859 6398643501 8129202960 83 D-2     /
      DATA BK1CS(  5) / -.1730288957 5130520630 1765073689 79 D-3     /
      DATA BK1CS(  6) / -.2433406141 5659682349 6007350301 64 D-5     /
      DATA BK1CS(  7) / -.2213387630 7347258558 3152525451 26 D-7     /
      DATA BK1CS(  8) / -.1411488392 6335277610 9583302126 08 D-9     /
      DATA BK1CS(  9) / -.6666901694 1993290060 8537512643 73 D-12    /
      DATA BK1CS( 10) / -.2427449850 5193659339 2631968648 53 D-14    /
      DATA BK1CS( 11) / -.7023863479 3862875971 7837971200 00 D-17    /
      DATA BK1CS( 12) / -.1654327515 5100994675 4910293333 33 D-19    /
      DATA BK1CS( 13) / -.3233834745 9944491991 8933333333 33 D-22    /
      DATA BK1CS( 14) / -.5331275052 9265274999 4666666666 66 D-25    /
      DATA BK1CS( 15) / -.7513040716 2157226666 6666666666 66 D-28    /
      DATA BK1CS( 16) / -.9155085717 6541866666 6666666666 66 D-31    /
      DATA AK1CS(  1) / +.2744313406 9738829695 2576662272 66 D+0     /
      DATA AK1CS(  2) / +.7571989953 1993678170 8923781492 90 D-1     /
      DATA AK1CS(  3) / -.1441051556 4754061229 8531161756 25 D-2     /
      DATA AK1CS(  4) / +.6650116955 1257479394 2513854770 36 D-4     /
      DATA AK1CS(  5) / -.4369984709 5201407660 5808450891 67 D-5     /
      DATA AK1CS(  6) / +.3540277499 7630526799 4171390085 34 D-6     /
      DATA AK1CS(  7) / -.3311163779 2932920208 9826882457 04 D-7     /
      DATA AK1CS(  8) / +.3445977581 9010534532 3114997709 92 D-8     /
      DATA AK1CS(  9) / -.3898932347 4754271048 9819374927 58 D-9     /
      DATA AK1CS( 10) / +.4720819750 4658356400 9474493390 05 D-10    /
      DATA AK1CS( 11) / -.6047835662 8753562345 3735915628 90 D-11    /
      DATA AK1CS( 12) / +.8128494874 8658747888 1938379856 63 D-12    /
      DATA AK1CS( 13) / -.1138694574 7147891428 9239159510 42 D-12    /
      DATA AK1CS( 14) / +.1654035840 8462282325 9729482050 90 D-13    /
      DATA AK1CS( 15) / -.2480902567 7068848221 5160104405 33 D-14    /
      DATA AK1CS( 16) / +.3829237890 7024096948 4292272991 57 D-15    /
      DATA AK1CS( 17) / -.6064734104 0012418187 7682103773 86 D-16    /
      DATA AK1CS( 18) / +.9832425623 2648616038 1940046506 66 D-17    /
      DATA AK1CS( 19) / -.1628416873 8284380035 6666201156 26 D-17    /
      DATA AK1CS( 20) / +.2750153649 6752623718 2841203370 66 D-18    /
      DATA AK1CS( 21) / -.4728966646 3953250924 2810695680 00 D-19    /
      DATA AK1CS( 22) / +.8268150002 8109932722 3920503466 66 D-20    /
      DATA AK1CS( 23) / -.1468140513 6624956337 1939648853 33 D-20    /
      DATA AK1CS( 24) / +.2644763926 9208245978 0858948266 66 D-21    /
      DATA AK1CS( 25) / -.4829015756 4856387897 9698688000 00 D-22    /
      DATA AK1CS( 26) / +.8929302074 3610130180 6563327999 99 D-23    /
      DATA AK1CS( 27) / -.1670839716 8972517176 9977514666 66 D-23    /
      DATA AK1CS( 28) / +.3161645603 4040694931 3686186666 66 D-24    /
      DATA AK1CS( 29) / -.6046205531 2274989106 5064106666 66 D-25    /
      DATA AK1CS( 30) / +.1167879894 2042732700 7184213333 33 D-25    /
      DATA AK1CS( 31) / -.2277374158 2653996232 8678400000 00 D-26    /
      DATA AK1CS( 32) / +.4481109730 0773675795 3058133333 33 D-27    /
      DATA AK1CS( 33) / -.8893288476 9020194062 3360000000 00 D-28    /
      DATA AK1CS( 34) / +.1779468001 8850275131 3920000000 00 D-28    /
      DATA AK1CS( 35) / -.3588455596 7329095821 9946666666 66 D-29    /
      DATA AK1CS( 36) / +.7290629049 2694257991 6799999999 99 D-30    /
      DATA AK1CS( 37) / -.1491844984 5546227073 0240000000 00 D-30    /
      DATA AK1CS( 38) / +.3073657387 2934276300 7999999999 99 D-31    /
      DATA AK12CS(  1) / +.6379308343 7390010366 0048853410 2 D-1      /
      DATA AK12CS(  2) / +.2832887813 0497209358 3503028470 8 D-1      /
      DATA AK12CS(  3) / -.2475370673 9052503454 1454556673 2 D-3      /
      DATA AK12CS(  4) / +.5771972451 6072488204 7097662576 3 D-5      /
      DATA AK12CS(  5) / -.2068939219 5365483027 4553319655 2 D-6      /
      DATA AK12CS(  6) / +.9739983441 3818041803 0921309788 7 D-8      /
      DATA AK12CS(  7) / -.5585336140 3806249846 8889551112 9 D-9      /
      DATA AK12CS(  8) / +.3732996634 0461852402 2121285473 1 D-10     /
      DATA AK12CS(  9) / -.2825051961 0232254451 3506575492 8 D-11     /
      DATA AK12CS( 10) / +.2372019002 4841441736 4349695548 6 D-12     /
      DATA AK12CS( 11) / -.2176677387 9917539792 6830166793 8 D-13     /
      DATA AK12CS( 12) / +.2157914161 6160324539 3956268970 6 D-14     /
      DATA AK12CS( 13) / -.2290196930 7182692759 9155133815 4 D-15     /
      DATA AK12CS( 14) / +.2582885729 8232749619 1993956522 6 D-16     /
      DATA AK12CS( 15) / -.3076752641 2684631876 2109817344 0 D-17     /
      DATA AK12CS( 16) / +.3851487721 2804915970 9489684479 9 D-18     /
      DATA AK12CS( 17) / -.5044794897 6415289771 1728250880 0 D-19     /
      DATA AK12CS( 18) / +.6888673850 4185442370 1829222399 9 D-20     /
      DATA AK12CS( 19) / -.9775041541 9501183030 0213248000 0 D-21     /
      DATA AK12CS( 20) / +.1437416218 5238364610 0165973333 3 D-21     /
      DATA AK12CS( 21) / -.2185059497 3443473734 9973333333 3 D-22     /
      DATA AK12CS( 22) / +.3426245621 8092206316 4538880000 0 D-23     /
      DATA AK12CS( 23) / -.5531064394 2464082325 0124800000 0 D-24     /
      DATA AK12CS( 24) / +.9176601505 6859954037 8282666666 6 D-25     /
      DATA AK12CS( 25) / -.1562287203 6180249114 4874666666 6 D-25     /
      DATA AK12CS( 26) / +.2725419375 4843331323 4943999999 9 D-26     /
      DATA AK12CS( 27) / -.4865674910 0748279923 7802666666 6 D-27     /
      DATA AK12CS( 28) / +.8879388552 7235025873 5786666666 6 D-28     /
      DATA AK12CS( 29) / -.1654585918 0392575489 3653333333 3 D-28     /
      DATA AK12CS( 30) / +.3145111321 3578486743 0399999999 9 D-29     /
      DATA AK12CS( 31) / -.6092998312 1931276124 1600000000 0 D-30     /
      DATA AK12CS( 32) / +.1202021939 3698158346 2399999999 9 D-30     /
      DATA AK12CS( 33) / -.2412930801 4594088413 8666666666 6 D-31     /
      DATA FIRST /.TRUE./
C***FIRST EXECUTABLE STATEMENT  DBSK1E
      IF (FIRST) THEN
         ETA = 0.1*REAL(D1MACH(3))
         NTK1 = INITDS (BK1CS, 16, ETA)
         NTAK1 = INITDS (AK1CS, 38, ETA)
         NTAK12 = INITDS (AK12CS, 33, ETA)
C
         XMIN = EXP (MAX(LOG(D1MACH(1)), -LOG(D1MACH(2))) + 0.01D0)
         XSML = SQRT(4.0D0*D1MACH(3))
      ENDIF
      FIRST = .FALSE.
C
      IF (X .LE. 0.D0) CALL ZErMsg ('SLATEC', 'DBSK1E',
     +   'X IS ZERO OR NEGATIVE', 2, 2)
      IF (X.GT.2.0D0) GO TO 20
C
      IF (X .LT. XMIN) CALL ZErMsg ('SLATEC', 'DBSK1E',
     +   'X SO SMALL K1 OVERFLOWS', 3, 2)
      Y = 0.D0
      IF (X.GT.XSML) Y = X*X
      DBSK1E = EXP(X)*(LOG(0.5D0*X)*DBESI1(X) + (0.75D0 +
     1  DCSEVL (0.5D0*Y-1.D0, BK1CS, NTK1))/X )
      RETURN
C
 20   IF (X.LE.8.D0) DBSK1E = (1.25D0 + DCSEVL ((16.D0/X-5.D0)/3.D0,
     1  AK1CS, NTAK1))/SQRT(X)
      IF (X.GT.8.D0) DBSK1E = (1.25D0 +
     1  DCSEVL (16.D0/X-1.D0, AK12CS, NTAK12))/SQRT(X)
C
      RETURN
      END
