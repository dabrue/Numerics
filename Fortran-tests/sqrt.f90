program sqrtt
implicit none

real :: x(2)
real :: y(2)
real :: z(2)

x(1)=4
x(2)=25

y=sqrt(x)
print*,y

z=x*y

print*,z
end
