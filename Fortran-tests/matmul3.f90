program matmul3
implicit none

real :: a(1,3)
real :: b(3)
real :: c(3)


a(1,1)=1
a(1,2)=2
a(1,3)=3

b(1)=2
b(2)=2
b(3)=2

c=matmul(a,b)

print*,c(1)
print*,c(2)
print*,c(3)
end
