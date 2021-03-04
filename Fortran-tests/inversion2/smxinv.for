
      subroutine SmxInv (a,n)
cccccccccccccccccccccccccccccccccccccccccccccccccccccc 
c    computes in-place inverse of symmetric matrix
c
c    using only lower half of matrix a
c
c    ===Input===
c     n         -- size of matrix to be inverted
c     a(i,j)    -- matrix to be inverted
c
c    ===Output==:
c     a(i,j)    -- the inverted matrix of a 
c
      implicit none
      integer           n, info, ipiv(n)
    real*8            a(n,n), ui(n,n), work(n*n)
    call unit(n, ui)
    call dsysv ('l', n, n, a, n, ipiv, ui, n, work, n*n, info)
    if(info .ne. 0) then
        print*,"Error occurred in SmxInv", info
        print*,"n=",n
        Stop "Error occurred in SmxInv"
    end if
    a=ui
      end
