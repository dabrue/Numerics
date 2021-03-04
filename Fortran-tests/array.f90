module constants
integer, parameter :: zero=0
end module constants
program array
use constants
implicit none
integer :: A(0:4), B(4), C(4), E
integer :: array3
integer :: i

A=5
!B=A(:,2)


do i=0,4
A(i)=i*2
enddo


print*, A(0)
print*, A(1)
print*, A(2)
print*, A(3)
print*, A(4)


!Now play with array limits

print*,A(1:3)

end program array

