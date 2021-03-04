implicit none
integer :: x, y, z
real :: a,b,c
read*,a
read*,b

!z=x/y
!print*,z
!z=modulo(x,y)
!print*,z

c=modulo(a,b)
print*,c

read*,x
read*,y

z=mod(x,y)
print*,z

end
