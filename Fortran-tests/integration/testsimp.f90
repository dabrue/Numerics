program testsimp
use numeric_kinds_module
implicit none
! this code tests the Simpson's rule integrator.

integer :: n1, n2, n
integer :: i, j, k, l

real(dp) :: pi
real(dp), allocatable :: f(:), f1(:), f2(:)

real(dp) :: x, xmin, xmax, xswitch, dx1, dx2, dx
real(dp) :: val, val1, val2

pi=4.d0*atan(1.d0)

! n1 and n2 must be even
n1=30
n2=30
n=n1+n2

allocate(f(0:n), f1(0:n1), f2(0:n2))

xmin=0.d0
xswitch=2.d0*pi-2.d-1
xmax=4.d0*pi

dx=(xmax-xmin)/(n)
dx1=(xswitch-xmin)/n1
dx2=(xmax-xswitch)/n2

do i=0,n
   x=xmin+dx*i
   f(i)=2.d0+sin(x)
enddo

do i=0,n1
   x=xmin+dx1*i
   f1(i)=2.d0+sin(x)
enddo

do i=0,n2
   x=xswitch+i*dx2
   f2(i)=2.d0+sin(x)
enddo

call SimpExtInt(f,n+1,dx,val)
call SimpExtInt(f1,n1+1,dx1,val1)
call SimpExtInt(f2,n2+1,dx2,val2)

print*,val, val1+val2
print*,dx**5, dx1**5, dx2**5

end
