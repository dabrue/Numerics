subroutine SmxInv (a,n)
!	computes in-place inverse of symmetric matrix
!
!	using only lower half of matrix a
!
!	===Input===
!     n         -- size of matrix to be inverted
!     a(i,j)    -- matrix to be inverted
!
!	===Output==:
!     a(i,j)    -- the inverted matrix of a 
!
implicit none
integer :: n, info, ipiv(n)
double precision :: a(n,n), ui(n,n), work(n*n)

ui=0.d0
do info=1,n
    ui(info,info)=1.d0
enddo
info=0

call dsysv ('l', n, n, a, n, ipiv, ui, n, work, n*n, info)

if(info .ne. 0) then
    print*,"Error occurred in SmxInv", info
    Stop "Error occurred in SmxInv"
end if

a=ui
end
