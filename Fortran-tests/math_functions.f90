program math_functions
implicit none

integer :: i, j, k, l

double precision :: a, b, c, d


a=1.d0
b=2.d0

c=-Tanh(a)
! FORTRAN DOES NOT HAVE HYPERBOLIC SECANT
!d=-Sech(a)
d=-1/(Cosh(a))  ! same thing

end program math_functions
