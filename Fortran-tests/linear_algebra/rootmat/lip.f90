subroutine lip(x,n,j,xabs,y)
use numeric_kinds
! This routine calculates the Lagrange Interpolating Polynomials (LIP)
! functions. These functions are defined by a set of abscissas given in the
! array xabs and the single abscissa for which the polynomial is 1, as defined by
! the index j. The value of the polynomial at a given value x is returned in y.
implicit none

integer :: i

! INPUT: n : This is the number of points defining the LIP
integer, intent(in) :: n
! INPUT: j : the index of xabs for which the function is 1, not zero. 
integer, intent(in) :: j

real(kind=dp_kind), intent(in) :: x  ! x value for which the function is desired. 

real(kind=dp_kind), intent(in) :: xabs(n) ! array of abscissas that define the LIP
real(kind=dp_kind), intent(out) :: y ! value of LIP at x


if (j < 1 .or. j > n) then
    print*,"Error in LIP, j out of bounds"
endif

y=1.d0
do i=1,n
    if (i==j) cycle
    y=y*(xabs(i)-x)/(xabs(i)-xabs(j))
!    print*,i,y
enddo

end subroutine LIP



