program namelisttest_read
implicit none

integer :: a, b, c, d
integer :: h(3)
character(len=6) :: n

integer :: i

namelist / nametest1 / a, b, c, d, h
namelist / nametest2 / i , n

! SO LONG AS THE VARIABLE NAMES IN THE NAMELIST HERE MATCHE THE VARIABLE NAMES
! GIVEN IN THE FILE ASSOCIATED WITH THE NAMELIST, IT DOES NOT MATTER WHAT ORDER
! THE DATA IN THE FILE IS IN. 

open (unit=12, file='namelist.nml')


! Try reading them out of order -- doesn't work, the namelists must be read in order


read(12,nml=nametest2)
read(12,nml=nametest1)

print*, i, n
print*, a, b, c, d
print*, h

close(12)

end program
