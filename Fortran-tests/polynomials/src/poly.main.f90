program poly
use numeric_kinds_module
use functions_module
! THIS PROGRAM IS TO TEST THE PROPERTIES OF ORTHOGONAL 
! POLYNOMIALS
implicit none

integer :: n, npts
integer :: i, j, k
real(kind=dp),allocatable :: x(:)
real(kind=dp),allocatable :: T(:)
real(kind=dp) :: xmin, xmax, dx


xmin=-1.d0
xmax=1.d0
npts=1000
n=5
dx=(xmax-xmin)/(npts+1)



do i=1,npts
x(i)=xmin+(i-1)*dx   
enddo

do k=1,n
call chebyshev1(x,k,npts,T)

do i=1,npts
   write(17,*) x(i), T(i)
enddo
write(17,*) "&"

enddo

end
