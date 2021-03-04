      subroutine SmxInv (a,n)
c
c
c >>> SmxInv    -- computes in-place inverse of symmetric matrix
c
c *** Calling Sequence:   call SmxInv ( a,n )
c
c === Latest Revision:  |  |  set upper half too
c                       | 921104 at 21:14:57 |  lifted from GAP routine
c     revised by rbw
c --- on entry the calling routine supplies --
c
c     n         -- size of matrix to be inverted
c     a(i,j)    -- matrix to be inverted
c
c --- on exit the routine returns --
c
c     a(i,j)    -- the inverted matrix
c     nfp       -- the number of floating point operations performed
c
c --- information from the following common blocks is used --
c
c
c
c----------------------------- local declarations 
c
      implicit none
c
      integer           n
      integer		nfp
c
      real*8            a(n,n)
c
      integer           i, im1, j, np1, k, kp1, ii, ip1
      integer		ifp
      real*8            den, fac, c
c
c---------------------------- execution begins here --------------------
c
      IF (n.eq.1) THEN
         a(1,1) = 1d0/a(1,1)
         RETURN
      END IF
      ifp = 0
c
c       --- this code from GAP routine of same name ---
c  -- construct upper half of symmetric matrix from the lower---
      

          do 10 i = 2, n
            im1 = i-1
            do 10 j = 1, im1
              a(i,j) = a(j,i)
   10    continue
c
c  -- begin inversion
c
         np1 = n + 1
         do 40 k = 1, n
           kp1  = k + 1
           den  = 1d0/a(k,k)
           a(k,k) = 1d0
	   ifp	= ifp + 1

           do 20 j = 1,n
             a(j,k) = a(j,k)*den
   20      continue
           ifp = ifp + n
           if (k.eq.n) go to 40

           do 30 i = kp1, n
             fac = a(k,i)
             a(k,i) = 0d0
             do 31 j = 1,n
               a(j,i) = a(j,i) - fac*a(j,k)
   31        continue
             ifp	= ifp + n
   30      continue
           
   40    continue
c
         do 60 ii = 2, n
           i = np1 - ii
           ip1 = i+1
           do 61 j = 1, i
             c = a(j,i)
             do 50 k = ip1, n
               c = c - a(k,i)*a(j,k)
   50        continue
             a(j,i) = c
	     ifp = ifp + n - i
   61      continue
   60    continue
c
c  -- construct lower half of inverted symmetrix matrix from upper--
c
         do 70 j = 2, n
           do 70 i = 1, j-1
             a(j,i) = a(i,j)
   70    continue
c
      nfp	= ifp
      return
      end
