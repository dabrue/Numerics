program array4
implicit none

real :: a1(5)
double precision :: a2(5)
integer :: i



a1 = (/ 1.0, 2.0, 3.0, 4.0, 5.0/)
a2 = (/ 10.d0, 20.d0, 30.d0, 40.d0, 50.d0 /)

do i=1,5
    print*,a1(i), a2(i)
enddo

end
