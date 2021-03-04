program matadd
implicit none

! it is possible to multiply a whole array by a factor, this
! program tests if I can add a number to a whole array and have
! it affect every element

real :: x(4)
real :: q


x=0.e0
q=5.e0


x=x+q


print*,x(1)
print*,x(2)
print*,x(3)
print*,x(4)


end
