program besselders
! Bessel Derivatives by two methods
! 
! Method 1:
! dJ(n,x)/dx=(1/2)*(J(n-1,x)-J(n+1,x))
!
! Method 2:
! dJ(n,x)/dx=J(n-1,x)-(n/x)J(n,x)
!
implicit none


integer, parameter :: dp=selected_real_kind(14,300)
integer :: i, j, k, l

integer :: n, m
integer :: nerr
integer, parameter :: nfun=15
integer, parameter:: npts=1000


real(dp) :: x, x_e, E
real(dp) :: xmin, xmax, dx

real(dp) :: alpha

real(dp) :: bessJ(0:nfun)
real(dp) :: bessY(0:nfun)

real(dp) :: dbessJ1
real(dp) :: dbessJ2
real(dp) :: dbessY1
real(dp) :: dbessY2

real(dp) :: pi

real(dp) :: a(npts),b(npts),a_e(npts),b_e(npts)

pi=4.d0*atan(1.d0)

n=6

E=8.d0

open(unit=111,file="bessJ_int")
open(unit=112,file="bessY_int")

open(unit=121,file="dbessJ1_int")
open(unit=122,file="dbessY1_int")

open(unit=131,file="dbessJ2_int")
open(unit=132,file="dbessY2_int")


open(unit=211,file="bessJ_halfint")
open(unit=212,file="bessY_halfint")

open(unit=221,file="dbessJ1_halfint")
open(unit=222,file="dbessY1_halfint")

open(unit=231,file="dbessJ2_halfint")
open(unit=232,file="dbessY2_halfint")


open(unit=311,file="RiccJ")
open(unit=312,file="RiccY")

open(unit=321,file="dRiccJ")
open(unit=322,file="dRiccY")

open(unit=331,file="dbessJ2_halfint")
open(unit=332,file="dbessY2_halfint")

xmin=0.d0
xmax=10.d0
dx=(xmax-xmin)/(npts*1.d0)

! do integers first
alpha=0.d0
do i=0,npts
    x=xmin+i*dx
    call dbesj(x,alpha,nfun,bessJ,nerr)
    call dbesy(x,alpha,nfun,bessY)
    write(111,*) x, bessJ(n)
    write(112,*) x, bessY(n)
    if(n<1) stop "N too small"
    dbessJ1=5.0d-1*(bessJ(n-1)-bessJ(n+1))
    dbessY1=5.0d-1*(bessY(n-1)-bessY(n+1))
    dbessJ2=bessJ(n-1)-(n+1)*bessJ(n)/x
    dbessY2=bessY(n-1)-(n+1)*bessY(n)/x

    write(121,*) x, dbessJ1
    write(122,*) x, dbessY1
    write(131,*) x, dbessJ2
    write(132,*) x, dbessY2
enddo
    
alpha=5.d-1
do i=0,npts
    x=xmin+i*dx
    call dbesj(x,alpha,nfun,bessJ,nerr)
    call dbesy(x,alpha,nfun,bessY)
    write(211,*) x, bessJ(n)
    write(212,*) x, bessY(n)
    if(n<1) stop "N too small"
    dbessJ1=5.0d-1*(bessJ(n-1)-bessJ(n+1))
    dbessY1=5.0d-1*(bessY(n-1)-bessY(n+1))
    dbessJ2=bessJ(n-1)-(n+1)*bessJ(n)/x
    dbessY2=bessY(n-1)-(n+1)*bessY(n)/x

    write(221,*) x, dbessJ1
    write(222,*) x, dbessY1
    write(231,*) x, dbessJ2
    write(232,*) x, dbessY2
enddo

do i=1,npts
    x=(xmin+i*dx)*E
    x_e=(xmin+i*dx)
    call dbesJ ( x, alpha, nfun, bessJ, nerr )
    call dbesY ( x, alpha, nfun, bessY )

    a(i)=Sqrt(Pi*x/2.d0)*bessJ(n)
    b(i)=Sqrt(Pi*x/2.d0)*bessY(n)
    if (n==0) then  ! J(l-1) term DNE
        a_e(i)=Cos(x)
        b_e(i)=Sin(x)
    else  ! J(l-1) term exists
        a_e(i)=sqrt(Pi/(x*8.d0))*bessJ(n)
        a_e(i)=a_e(i)+sqrt(x*Pi/8.d0)*(bessJ(n-1)-bessJ(n+1))
        b_e(i)=sqrt(Pi/(x*8.d0))*bessY(n)
        b_e(i)=b_e(i)+sqrt(x*Pi/8.d0)*(bessY(n-1)-bessY(n+1))
    endif
    write(311,*) x, a(i), a_e(i)
    write(312,*) x, b(i), b_e(i)
    !write(321,*) x, a_e(i)
    !write(322,*) x, b_e(i)
enddo


end
