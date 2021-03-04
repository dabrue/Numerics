program ceilfloor
implicit none


integer :: f, c

double precision :: a


a=-5.547d0


c=ceiling(a)
f=floor(a)

print*,'a=',a
print*,'f=',f
print*,'c=',c


end
