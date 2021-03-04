program findtiny
implicit none


real :: r
double precision :: d


r = tiny(1.0)
d = tiny(1.d0)

print*,r,d

end
