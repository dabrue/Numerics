program Polyfit
!=========================================================================================
! This program is a test to get a Polynomial expansion for a given set of data points, 
! most notably, a potential energy surface. 
!
! This program will use the Linear-Least-Squares routines provided by MKL
!
! D. A. Brue 2011
!=========================================================================================

use numeric_kinds

implicit none

integer, parameter :: PolyMin=6
integer, parameter :: PolyMax=15
integer, parameter :: nr = 1001

integer :: i, j, k, l, m, n 
integer :: info, lwork, lda, ldb, nrhs
integer :: Npts

integer, allocatable :: PolyOrders(:)

integer :: nPoly, order, nReducedPts

real(wp_kind) :: dummy1, dummy2
real(wp_kind) :: dr, ri, v

real(wp_kind), allocatable :: A(:,:)  !  Will hold the Polynomial values
real(wp_kind), allocatable :: B(:)    !  Holds given data
real(wp_kind), allocatable :: X(:)    !  Holds calculated coefficients
real(wp_kind), allocatable :: R(:)    !  Holds internuclear distances (or absciassas, etc.)
real(wp_kind), allocatable :: work(:)

real(wp_kind), allocatable :: RReduced(:), BReduced(:)

character(len=1), parameter :: trans = "N" 

real(wp_kind) :: rmin, rmax

nPoly = PolyMax - PolyMin + 1  ! this is one less than the number that will be included

allocate(PolyOrders(nPoly))

do i=1, nPoly
    PolyOrders(i)=PolyMin + i - 1
enddo


open(unit=10,file="input.data",status="old")
! Count the number of data points
nPts=0
do 
    read(10,*,iostat=k) dummy1, dummy2
    if (k /= 0) then
        exit
    else
        nPts=nPts+1
    endif
enddo

! Allocate matrices
allocate(A(nPts,nPoly))
allocate(B(nPts))
allocate(X(nPoly))
allocate(R(nPts))


! rewind data file, and this time read in the data
rewind(10)
do i=1,nPts
    read(10,*) R(i), B(i)
enddo
close(10)

if (.True.) then
    ! Reduce the space of points by looking for maximal second derivatives first, 
    ! and then maximal first derivatives
    nReducedPts=2*nPoly
    allocate(RReduced(nReducedPts))
    allocate(BReduced(nReducedPts))
    call reduce_points(nPts,nReducedPts,R,B,RReduced,BReduced)
    deallocate(R)
    deallocate(B)
    nPts=nReducedPts
    allocate(R(nPts))
    allocate(B(nPts))
    R=RReduced
    B=BReduced
    deallocate(RReduced,BReduced)
endif


lda=nPts
ldb=nPts
m=nPts
n=nPoly
nrhs=1

! populate the A array with polynomial info
do i=1,nPoly+1
    order = PolyMin + i - 1
    do j = 1, nPts
        A(j, i) = R(j)**(-order)
    enddo
enddo

lwork=-1
allocate(work(1))
call dgels(trans, m, n, nrhs, a, lda, b, ldb, work, lwork, info)
if (info /= 0) then
    print*,"workspace calculation failed with info=",info
    stop 1
endif
lwork=int(work(1))
deallocate(work)
allocate(work(lwork))
call dgels(trans, m, n, nrhs, a, lda, b, ldb, work, lwork, info)

do i=1,nPoly
    print*, B(i)
enddo

open(unit=11,file="out_test")
rmin=R(1)
rmax=R(nPts)
dr=(rmax-rmin)/(nr-1)
do i=1,nr
    ri=rmin+dr*(i-1)
    v = 0
    do j = PolyMin, PolyMax
        v=v+B(j)*one/ri**(j)
    enddo
    write(11,*) ri, v
enddo
    
    

end program
