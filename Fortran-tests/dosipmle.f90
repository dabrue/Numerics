program dosimple

implicit none

integer :: i, j, k, l, m, n, o, p
integer, parameter :: start = 1
integer, parameter :: finish= 10
integer, parameter :: increment=2
integer :: s
integer :: r

integer*8 :: long

real :: a
real :: array1(start:finish) 
real, allocatable :: array2(:,:)

double precision :: Pi
double precision :: b

a=4.0/3.0
b=a
print*,'a=',a
print*,'b=',b



pi=4.d0*atan(1.d0) 


do i=start,finish,increment

    print*,i
    

enddo

print*,i

end program
