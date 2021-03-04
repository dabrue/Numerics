program bitwise_tests
! Playing with bitwise operators, etc. 
implicit none

integer :: a, b
integer :: i, j, k, l


print*,'Enter two integers'
print*,'a=?'
read*,a
print*,'b=?'
read*,b

! and
k=and(a,b)
print*,' and = ', k
k=or(a,b)
print*,' or  = ', k
k=xor(a,b)
print*,' xor = ', k


print*,' lshifting 4 by 8 bits'
a=4
b=8
k=lshift(a,b)
print*,k
end
