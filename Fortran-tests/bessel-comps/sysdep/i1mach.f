      INTEGER FUNCTION I1MACH(I)
      INTEGER IMACH(16),OUTPUT
      EQUIVALENCE (IMACH(4),OUTPUT)
      DATA IMACH(1) /    5 /
      DATA IMACH(2) /    6 /
      DATA IMACH(3) /    6 /
      DATA IMACH(4) /    6 /
      DATA IMACH(5) /   32 /
      DATA IMACH(6) /    4 /
      DATA IMACH(7) /    2 /
      DATA IMACH(8) /   31 /
      DATA IMACH(9) /2147483647 /
      DATA IMACH(10)/    2 /
      DATA IMACH(11)/   24 /
      DATA IMACH(12)/ -125 /
      DATA IMACH(13)/  128 /
      DATA IMACH(14)/   53 /
      DATA IMACH(15)/ -1021 /
      DATA IMACH(16)/  1024 /
      IF (I .LT. 1  .OR.  I .GT. 16) THEN
        write ( OUTPUT, * ) ' !! Illegal argument value to I1MACH'
        STOP
      END IF
      I1MACH = IMACH(I)
      RETURN
      END
