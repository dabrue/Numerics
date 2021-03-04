program test
use numeric_kinds_module
implicit none

character(len=8) :: basis

integer :: i, j, k, l
integer :: npts, nfunc
real(dp) :: dfactorial, ifac

real(kind=dp):: xmin, xmax, dx
real(kind=dp) :: pi

real(kind=dp), allocatable :: A(:,:)
real(kind=dp), allocatable :: x(:), h(:)

namelist / complete / npts, nfunc, basis, xmin, xmax

pi=4.d0*atan(1.d0)

open(unit=20,file='complete.data')
read(20,nml=complete)
allocate(A(nfunc,npts))
allocate(x(npts), h(npts))

dx=(xmax-xmin)/(1.d0*(npts-1))

do i=1,npts
   x(i)=xmin+(i-1)*dx
enddo

print*,'basis =',basis
if (basis=='hermite ') then
    do i=1,nfunc
       ifac=dfactorial(i-1)
       !print*,'factorial is', i-1,ifac
       call hermite(x,i-1,npts,h)
       do j=1,npts
          A(i,j)=h(j)*exp(-x(j)*x(j))/(sqrt(2.d0**(i-1)))
          A(i,j)=A(i,j)/(sqrt(ifac*sqrt(pi)))
          write(21,*) x(j), A(i,j)
          !write(31,*) i, 2**(i-1), A(i,j)
          !write(31,*) x(j), A(i,j)
       enddo
       write(21,*) "&"
    enddo
endif

! A MATRIX IS NOW FULL

call chkcomplete(A,nfunc,npts,x)


end
