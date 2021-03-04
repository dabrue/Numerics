program rootmat
use numeric_kinds
implicit none

integer :: i,j,k,l
integer, parameter :: N=5
integer, parameter :: npts=10000
integer :: npp1
character(len=3) :: cn
character(len=20) :: matoutfmt
real(kind=dp_kind), parameter :: xmin=-1.d0
real(kind=dp_kind), parameter :: xmax=1.d0

real(kind=dp_kind) :: Smatd0(n,n)
real(kind=dp_kind) :: Smatd1(n,n)
real(kind=dp_kind) :: Smatd2(n,n)
real(kind=dp_kind) :: x(0:npts),dx
real(kind=dp_kind) :: fd0(0:npts,n)
real(kind=dp_kind) :: fd1(0:npts,n)
real(kind=dp_kind) :: fd2(0:npts,n)

real(kind=dp_kind) :: lobatX(n),lobatW(n)

open(unit=10,file="lobat5.dat")

write(cn,"(I3)") n

matoutfmt="("//cn//"(ES20.13,2x))"

do i=1,n
    read(10,*) lobatX(i),lobatW(i)
enddo

dx=(xmax-xmin)/npts
do i=0,npts
    x(i)=xmin+i*dx
enddo

do i=1,n
    do j=0,npts
        call lip(x(j),n,i,LobatX,fd0(j,i))
        call lipd1(x(j),n,i,LobatX,fd1(j,i))
        call lipd2(x(j),n,i,LobatX,fd2(j,i))
    enddo
enddo

npp1=npts+1

do i=1,n
    do j=1,n
        call integrate(fd0(:,i),fd0(:,j),npp1,dx,smatd0(i,j))
        call integrate(fd0(:,i),fd1(:,j),npp1,dx,smatd1(i,j))
        call integrate(fd0(:,i),fd2(:,j),npp1,dx,smatd2(i,j))
    enddo
enddo

open(unit=11,file="smatd0.dat")
open(unit=12,file="smatd1.dat")
open(unit=13,file="smatd2.dat")

do i=1,n
    write(unit=11,fmt=matoutfmt) (smatd0(i,j),j=1,n)
    write(unit=12,fmt=matoutfmt) (smatd1(i,j),j=1,n)
    write(unit=13,fmt=matoutfmt) (smatd2(i,j),j=1,n)
enddo

! I now have a symmetric matrix that is not represented in an orthonormal basis. 
! I will diagonalize this and try to get the square root of the matrix

end program rootmat
