program TestSort
!=========================================================================================
! Test the merge sort routine
use numeric_kinds
use MergeSort

implicit none

integer, parameter :: N=5

integer :: i, j
integer :: time1
integer :: time(3)
real :: sec

real(wp_kind) :: ar(N,N)
integer :: ai(N,N)


call itime(time)
time1=sum(time)
sec=rand(time1)

forall(j=1:N,i=1:N) ai(i,j)=floor(rand()*20)
forall(j=1:N,i=1:N) ar(i,j)=rand()*20

print*, "Integer, Before"
do i=1,N
    write(6,"(20(I2,2X))") (ai(i,j),j=1,N)
enddo
call Merge_Sort(N,N,ai)
print*, "Integer, After"
do i=1,N
    write(6,"(20(I2,2X))") (ai(i,j),j=1,N)
enddo

print*,"Real, Before"
do i=1,N
    write(6,"(20(ES21.13e3,2X))") (ar(i,j),j=1,N)
enddo
call Merge_Sort(N,N,ar)
print*, "Real, After"
do i=1,N
    write(6,"(20(ES21.13e3,2X))") (ar(i,j),j=1,N)
enddo



end 
