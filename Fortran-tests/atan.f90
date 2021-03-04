program atan_test
implicit none
real :: A, B, X
print*,"y?"
read*,A
print*,"x?"
read*,B
x=atan2(A,B)
print*,x
end
