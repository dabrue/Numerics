subroutine smxinv2(A,n)
use numeric_kinds_module
implicit none
!=========================================================================================
! DANIEL BRUE 2005
! THIS ROUTINE RETURNS THE IN-PLACE INVERSE OF A GIVEN SYMMETRIC MATRIX A
! USING THE LAPACK ROUTINES
! 
! INPUT:
! A : matrix to be inverted
! n : dimension of matrix a
!=========================================================================================

integer :: n ! order of the matrix
integer :: info  ! returns 0 if calls are successful
integer :: lwork
real(kind=dp) :: A(n,n)
real(kind=dp) :: ipiv(n,n)
real(kind=dp),allocatable :: work(:)

! FIRST DO AN L/U FACTORIZATION OF THE MATRIX

lwork=2*n

allocate(work(lwork))
work=0.d0
call dsytrf('L', n, A, n, ipiv, work, lwork, info)
if (info.ne.0) print*,'smxinv failed'
! A NOW CONTAINS THE LOWER TRIANGULAR FACTOR 
info=0

call dsytri('L', n, A, n, ipiv, work, info)

if (info == 0) then
     ! matrix inversion successful
elseif (info < 0 ) then
     print*,'smxinv: the call to dsytri failed, wrong parameter at place ', info
     return
elseif (info > 0 ) then
     print*,'smxinv: the inversion could not be completed'
     return
endif

end subroutine smxinv2
