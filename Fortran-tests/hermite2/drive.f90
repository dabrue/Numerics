program drive
use numeric_kinds_module
implicit none

integer :: i, j, k, l, nx, n 
real(dp) :: xmin
real(dp) :: xmax
real(dp) :: dx
real(dp), allocatable :: x(:)
real(dp), allocatable :: h(:)



n=100
nx=303
xmin=-100.d0
xmax=100.d0
dx=(xmax-xmin)/(nx-1)

allocate(x(nx),h(nx))

do i=1,nx
   x(i)=xmin+dx*(i-1)
enddo


do i=1,100
call hermite(x,n,nx,h)
enddo

print*,h
end






