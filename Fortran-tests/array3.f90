program array3
implicit none

! The intent of this is to test array declarations

integer :: i


integer :: a(4) = (/ 1, 2, 3, 4 /)

integer :: b(4)


b=(/ 4, 3, 2, 1 /)

do i = 1, 4

print*,a(i), b(i)
enddo

end
