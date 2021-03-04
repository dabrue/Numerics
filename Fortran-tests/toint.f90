program toint
implicit none

! doulbe precision to integer

double precision :: x
integer :: k


x = 22.4d0

k = floor(x) 
print*,k
end
