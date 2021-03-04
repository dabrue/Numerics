program test
implicit none
real :: x, y, z
read*,x
read*,y
call sub(x, y, z)
print*,z
end program test

subroutine sub(x,y,z)
z=x+y
end subroutine sub
