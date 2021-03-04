program bess0test
implicit none

integer :: i, j, k

integer :: nfun=1, nerr

integer, parameter :: dp=selected_real_kind(14,300)

real(kind=dp) :: x
real(kind=dp) :: bess1(0:10000)
real(kind=dp) :: bess2(0:10000)
real(kind=dp) :: Pi, xmin, xmax

real(kind=dp) :: bessJ(10), bessY(10)


xmin=0.d0
xmax=100.d0



do i=0,10000
    x=xmin+i*1.d-2
    call dbesJ ( x, 0.5d0, nfun, bessJ, nerr )
    call dbesY ( x, 0.5d0, nfun, bessY )
    bess1(i)=sqrt(Pi/(x*8.d0))*bessJ(0)+sqrt(x)*( sin(Pi/2.d0-x)-cos(Pi/2.d0-x)/(2.d0*x) )/sqrt(x) 
    bess2(i)=Cos(x)


    write(10,*) x, bess1(i), bess2(i)
enddo


end

