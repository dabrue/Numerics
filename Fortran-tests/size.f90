program determinesize
implicit none

real :: a(4,3)
integer :: k

k=size(a)
print*,k
k=size(a,1)
print*,k
k=size(a,2)
print*,k

end 
