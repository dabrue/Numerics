program test1
use bspline
implicit none

! the purpose of this test is to see if there is any difference
! in the accuracy of the product of two functions if they 
! are splined first and then multiplied, or splined after 
! multiplication. 
!
integer :: i, j ,k
integer, parameter :: dp=selected_real_kind(14,300)
integer :: npts ! number of given points
integer :: nsp  ! number of spline points
real(dp) :: ave
real(dp) :: xmin, xmax, dx, ds, pi, twopi
real(dp), allocatable :: x(:), xk(:), xs(:), xsk(:)
real(dp), allocatable :: f(:), g(:), h(:)
real(dp), allocatable :: fc(:), gc(:), hc(:)
real(dp), allocatable :: fs(:), gs(:), hs(:)
real(dp), allocatable :: exact(:), err1(:), err2(:)
real(dp), allocatable :: sig1(:), sig2(:)

pi=4.d0*atan(1.d0)
twopi=2.d0*pi
npts=61
nsp=514
xmin=0.d0
xmax=30.d0

dx=(xmax-xmin)/(1.d0*npts-1.d0)
ds=(xmax-xmin)/(1.d0*nsp-1.d0)
   

allocate(x(npts), xk(npts+3), f(npts), g(npts))
allocate(h(npts), fc(npts), gc(npts), hc(npts))
allocate(fs(nsp), gs(nsp), hs(nsp), xsk(nsp+3))
allocate(exact(nsp), err1(nsp), err2(nsp), xs(nsp))
allocate(sig1(nsp), sig2(nsp))

do i=1,npts
   x(i)=xmin+(i-1)*dx
enddo
do i=1,nsp
   xs(i)=xmin+(i-1)*ds
enddo

! define f and g function
do i=1,npts
   f(i)=10.d0*cos(5.d0*x(i)/twopi)
   g(i)=exp(-x(i)/10.d0)
   h(i)=f(i)*g(i)
enddo

open(unit=15,file="ex.dbdat")
open(unit=17,file="sig2.dbdat")
! get answers
do i=1,nsp
   exact(i)=10.d0*exp(-xs(i)/10.d0)*cos(5.d0*xs(i)/twopi)
   write(15,*) xs(i), exact(i)
enddo

call dbsnak(npts,x,3,xk)
call dbsnak(nsp,xs,3,xsk)
call dbsint(npts,x,f,3,xk,fc)
call dbsint(npts,x,g,3,xk,gc)
call dbsint(npts,x,h,3,xk,hc)


open(unit=13,file="m1.dbdat")
open(unit=16,file="sig1.dbdat")
print*,"About to do test1"
! method 1, spline first, then multiply...
do i=1,nsp
   fs(i)=dbsval(xs(i),3,xk,npts,fc)
   gs(i)=dbsval(xs(i),3,xk,npts,gc)
   hs(i)=fs(i)*gs(i)
   err1(i)=abs(exact(i)-hs(i))
   sig1(i)=-log(err1(i))/log(10.d0)
   write(13,*) xs(i), hs(i)
enddo


open(unit=14,file="m2.dbdat")
print*,"About to do test2"
! method 2, multiply first, then spline...
do i=1,nsp
   hs(i)=dbsval(xs(i),3,xk,npts,hc)
   err2(i)=abs(exact(i)-hs(i))
   sig2(i)=-log(err2(i))/log(10.d0)
   write(14,*) xs(i), hs(i)
enddo

open(unit=11,file="err1")
open(unit=12,file="err2")
open(unit=18,file="sigdif.dbdat")

ave=0.d0
do i=2,nsp-1
   ave=ave+sig2(i)-sig1(i)
enddo
ave=ave/(1.d0*nsp)

do i=1,nsp
   write(11,*) xs(i), err1(i)
   write(12,*) xs(i), err2(i)
   write(16,*) xs(i), sig1(i)
   write(17,*) xs(i), sig2(i)
   write(18,*) xs(i), sig2(i)-sig1(i)
enddo
print*,ave

end



