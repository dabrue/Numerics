subroutine hermite(x,n,npt,h)
use numeric_kinds_module
!=======================================================================
! October 2005 Daniel Brue
! Returns value of Hermite Polynomial of order n at point x
implicit none

integer :: i, j
integer :: n     ! ORDER OF HERMITE POLYNOMIAL
integer :: npt   ! DIMENSION OF ARRAY X
real(kind=dp) :: x(npt) !ARRAY CONTAINING X VALUES 
real(kind=dp) :: h(npt) !ARRAY CONTAINING HERMITE POLYNOMIAL VALUES AT X
real(kind=dp) :: h1(npt), h2(npt) ! WORK ARRAYS

h1=1.d0
h2=2.d0*x

if (n == 0 ) then
   h=h1
else if (n == 1) then
   h=h2
else if (n > 1) then
   do i=2,n
         h=2.d0*x*h2-2.d0*(i-1)*h1
      if(i /= n ) then 
         h1=h2
         h2=h
      endif
   enddo
endif


end subroutine hermite 
