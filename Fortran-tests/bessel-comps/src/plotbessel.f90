program plotbessel
use numeric_kinds
implicit none

integer :: nz, i
integer :: l, m, p, q
integer :: N_Mathe_pts=10000
integer, parameter :: npts=1000
integer, parameter :: nfun=13
real(kind=dp), parameter :: alpha=0.d0
real(kind=dp), allocatable :: bessJ(:)
real(kind=dp), allocatable :: diff(:)
real(kind=dp), allocatable :: Mathes(:,:)
real(kind=dp) :: x, J(20)
real(kind=dp) :: sl(100,0:npts), cl(100,0:npts)

real(kind=dp) :: pi

character(len=30) :: format6='(7(E18.12, 3X))'

pi=4.d0*atan(1.d0)

allocate(Mathes(0:N_Mathe_pts,4))

allocate(bessJ(nfun), diff(4))

    

open(unit=11,file="Mathe_Bessels/bess04.dat")
open(unit=12,file="Mathe_Bessels/bess06.dat")
open(unit=13,file="Mathe_Bessels/bess10.dat")
open(unit=14,file="Mathe_Bessels/bess12.dat")
open(unit=15,file="plots04")
open(unit=16,file="plots06")
open(unit=17,file="plots10")
open(unit=18,file="plots12")
open(unit=21,file="comp04")
open(unit=22,file="comp06")
open(unit=23,file="comp10")
open(unit=24,file="comp12")



do i=1,N_Mathe_pts
    read(11,*) x, Mathes(i,1)
    read(12,*) x, Mathes(i,2)
    read(13,*) x, Mathes(i,3)
    read(14,*) x, Mathes(i,4)
    call dbesj(x,alpha,nfun,bessJ,nz)
    write(15,*) x, bessj(5), Mathes(i,1)
    write(16,*) x, bessj(7), Mathes(i,2)
    write(17,*) x, bessj(11), Mathes(i,3)
    write(18,*) x, bessj(13), Mathes(i,4)
    diff(1)=Mathes(i,1)-bessJ(5)
    diff(2)=Mathes(i,2)-bessJ(7)
    diff(3)=Mathes(i,3)-bessJ(11)
    diff(4)=Mathes(i,4)-bessJ(13)
    write(21,*) x, diff(1)
    write(22,*) x, diff(2)
    write(23,*) x, diff(3)
    write(24,*) x, diff(4)
enddo
    
open(unit=100,file="dbessJ4.dat")

do i=0,10000
   x=0.d0+i*1.d-2
   call dbesj(x,0.d0,1,J,nz)
   write(100,*) x, J(5)
enddo

end




