program matorder
implicit none

real :: u(5,4)
real :: v(4,5)
real :: t(5,5)
real :: w(4,4)

u=4.0
v=3.0

t=matmul(u,v)
w=matmul(v,u)

print*,t

end
