program namelisttest_write

implicit none

integer :: a, b, c, d
integer :: h(3)
character(len=6) :: n

integer :: i

namelist / nametest1 / a, b, c, d, h
namelist / nametest2 / i , n

i = 5

n="Mollie"

a=1
b=2
c=3
d=4
h=(/ 11, 12, 13 /)

! SO LONG AS THE VARIABLE NAMES IN THE NAMELIST HERE MATCHE THE VARIABLE NAMES
! GIVEN IN THE FILE ASSOCIATED WITH THE NAMELIST, IT DOES NOT MATTER WHAT ORDER
! THE DATA IN THE FILE IS IN. 

open (unit=12, file='namelist.nml')
write(12,nml=nametest1)
write(12,nml=nametest2)
close(12)

end program
