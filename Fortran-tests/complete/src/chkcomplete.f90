subroutine chkcomplete(A,n,m,x)
use numeric_kinds_module
implicit none

! THIS SUBROUTINE CHECKS COMPLETENESS OF A TRUNCATED BASIS SET
! BY COMPARING IT TO THE IDENTITY MATRIX 

! THESE MATRICES COULD BE LARGE, SO THIS HAS BEEN WRITTEN TO CONSERVE MEMORY

!Given an n x m input matrix A with matrix elements defined as the nth
! basis function evaluated at the mth grid poisition, this calcuates
! Transpose(A)*A and checks how close it is to the unit matrix.
!
! A=
! b1(x1)  b1(x2)  b1(x3) ...
! b2(x1)  b2(x2)  b2(x3) ...
! b3(x1)  b3(x2)  b3(x3) ...

! x is the array of x points

integer :: i, j, k, l
integer :: n, m

real(kind=dp) :: A(n, m), x(m)
real(kind=dp) :: ajj, akl
real(kind=dp) :: limit = 1d-6
A=A*10.0d3
! CHECK DIAGONAL ELEMENTS. THESE SHOULD COME OUT TO BE VERY LARGE
do j=1,m
   ajj=0.d0
   do i=1,n
      ajj=ajj+A(i,j)*A(i,j)!*exp(-x(j)*x(j))
   enddo
   print*,"n=",n,"j=",j,"ajj=",ajj
enddo

! check off diagonal elements
do i=1,m
do k=1,i
print*,'checking points:',x(i),x(k)
akl=0.d0
do l=1,n
akl=akl+A(l,i)*A(l,k)
enddo
if (i /= k .and. akl > limit ) print*, 'i=',i,'k=',k,'too big',akl
if (i /= k ) print*, 'i=',i,'k=',k,'too big',akl
if (i == k ) print*, 'i==k',akl
enddo
enddo

end subroutine chkcomplete

