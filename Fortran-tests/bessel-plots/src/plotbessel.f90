program plotbessel
use numeric_kinds
implicit none

integer :: l, m, p, q
integer :: nz
integer, parameter :: npts=1000
integer, parameter :: nfun=14
real(kind=dp), parameter :: alpha=0.d0
real(kind=dp), parameter :: xmin=0.d0
real(kind=dp), parameter :: xmax=10.d0
real(kind=dp) :: J(nfun,0:npts)
real(kind=dp) :: Y(nfun,0:npts)
real(kind=dp) :: K(nfun,0:npts)
real(kind=dp) :: I(nfun,0:npts)

real(kind=dp) :: x, dx, btemp(nfun)
real(kind=dp) :: r(0:npts)
real(kind=dp) :: sl(100,0:npts), cl(100,0:npts)

real(kind=dp) :: pi

character(len=30) :: format6='(7(E18.12, 3X))'

pi=4.d0*atan(1.d0)


open(unit=11,file="besselJ")
open(unit=12,file="besselY")
open(unit=13,file="besselK")
open(unit=14,file="besselI")
open(unit=21,file="sbesselJ")
open(unit=22,file="sbesselY")
open(unit=23,file="sbesselK")
open(unit=24,file="sbesselI")

dx=(xmax-xmin)/npts

do l=0,npts
   x=xmin+l*dx
   call dbesj(x,alpha,nfun,J(0,l),nz)
   call dbesy(x,alpha,nfun,Y(0,l))
   call dbesk(x,alpha,1,nfun,K(0,l),nz)
   call dbesi(x,alpha,1,nfun,I(0,l),nz)

   write(11,fmt=format6) x, (J(m,l), m=0,nfun-1)
   write(12,fmt=format6) x, Y(6,l)!, m=0,nfun-1)
   write(13,fmt=format6) x, (K(m,l), m=0,nfun-1)
   write(14,fmt=format6) x, (I(m,l), m=0,nfun-1)

enddo

do l=0,npts
   x=xmin+l*dx
   r(l)=x
   call dbesj(x,alpha+0.5d0,nfun,J(0,l),nz)
   call dbesy(x,alpha+0.5d0,nfun,Y(0,l))
   call dbesk(x,alpha+0.5d0,1,nfun,K(0,l),nz)
   call dbesi(x,alpha+0.5d0,1,nfun,I(0,l),nz)

J=J*sqrt(x*pi/(2.d0))
Y=-Y*sqrt(x*pi/2.d0)

   write(21,fmt=format6) x, (J(m,l), m=0,nfun-1)
   write(22,fmt=format6) x, (Y(m,l), m=0,nfun-1)
   write(23,fmt=format6) x, (K(m,l), m=0,nfun-1)
   write(24,fmt=format6) x, (I(m,l), m=0,nfun-1)

enddo

open(unit=80,file="wbessJ")
open(unit=81,file="wbessY")
call bessel(r,npts+1,nfun,sl,cl)
do p=0,npts
   write(80,fmt=format6) r(p), (sl(q,p), q=1,nfun)
   write(81,fmt=format6) r(p), (cl(q,p), q=1,nfun)
enddo

end




