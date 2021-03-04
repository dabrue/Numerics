program drive2
use numeric_kinds_module
implicit none

integer :: a, i
real(dp) :: x
real(dp) :: h

a=20
x=3.1909932017815

call hermite(x,a,1,h)
print*,h

end
