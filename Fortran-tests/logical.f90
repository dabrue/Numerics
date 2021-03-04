program logic
implicit none
! testing of the intrinsic logical function

logical :: chk
logical :: A, B

integer :: i, j, k
!chk=.true.
chk=.false.

if(chk) then
print*, "It's true!"
else
print*, "It's False!"
endif


i=1
k=2
B=.true.

A=B .and. (i<k)

print*,a

A=.True.
B=.False.
print*,' Multiplication works like .and.'
print*,'F * F = ', B*B
print*,'F * T = ', B*A
print*,'T * F =',  A*B
print*,'T * T = ', A*A
print*,' Addition works like xor'
print*,'F + F = ', B+B
print*,'F + T = ', B+A
print*,'T + F =',  A+B
print*,'T + T = ', A+A



end program logic
