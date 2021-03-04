subroutine SimpExtInt(f,n,h,val)
use numeric_kinds_module
! This subroutine performs integration over the 
! function f using Simpson's Extended Integration Formula
! (see Abramowitz and Stegun)
!
! INPUT:
! f - real*8 array of dimension n (n must be odd!)
! n - the (odd!) dimension of f
! h - the step size (steps must be uniform)
!
! OUTPUT: 
! val - the value of the integral
implicit none

integer :: i

integer, intent(in) :: n
real(kind=dp), intent(in) :: f(n)
real(kind=dp), intent(in) :: h 
real(kind=dp), intent(out) :: val


val=0.d0
do i=2,n-1,2
   val=val+4.d0*f(i)
enddo

do i=3,n-2,2
   val=val+2.d0*f(i)
enddo

val=val+f(1)+f(n)

val=val*h/3.d0

end subroutine SimpExtInt
   
